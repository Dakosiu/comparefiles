#include "otpch.h"

#include "player.h"
#include "monsters.h"
#include "items.h"
#include "game.h"

// NOTE! SQL query has to be executed
// ALTER TABLE `players` ADD `tasks` BLOB NULL DEFAULT NULL AFTER `conditions`;

//	[1] = {
//		className = "TROLLS",
//		monsters = { "Troll", "Island Troll", "Swamp Troll", "Frost Troll" },
//		bossName = "Big Boss Trolliver",
//		experience = 6000,
//		count = 200,
//		storageId = 5001,
//		classOutfit = { type = 15 },
//		rewards = { 2148, 4, 2152, 4, 2160, 1 }
//	},

extern Monsters g_monsters;
extern Game g_game;

static constexpr auto MAXIMUM_TASKS_AT_ONCE = 3;

bool PlayerTasksData::load()
{
	lua_State* L = luaL_newstate();
	if (!L) {
		throw std::runtime_error("Failed to allocate memory in PlayerTasksData");
	}

	if (luaL_dofile(L, "data/LUA/tasks.lua")) {
		std::cout << "[Error - PlayerTasksData] " << lua_tostring(L, -1) << std::endl;
		lua_close(L);
		return false;
	}

	lua_getglobal(L, "TASKS");
	for (uint16_t i = 1; ; i++) {
		lua_rawgeti(L, -1, i);
		if (lua_isnil(L, -1)) {
			lua_pop(L, 1);
			break;
		}

		TaskData taskData;
		lua_getfield(L, -1, "className");
		if (!lua_isstring(L, -1)) {
			std::cout << "[Warning - PlayerTasksData::load] Missing className property." << std::endl;
			return false;
		}
		taskData.className = lua_tostring(L, -1);
		lua_pop(L, 1);

		lua_getfield(L, -1, "bossName");
		if (!lua_isstring(L, -1)) {
			std::cout << "[Warning - PlayerTasksData::load] Missing bossName property." << std::endl;
			return false;
		}
		taskData.bossName = lua_tostring(L, -1);
		lua_pop(L, 1);

		lua_getfield(L, -1, "experience");
		if (!lua_isnumber(L, -1)) {
			std::cout << "[Warning - PlayerTasksData::load] Missing experience property." << std::endl;
			return false;
		}
		taskData.experience = lua_tonumber(L, -1);
		lua_pop(L, 1);

		lua_getfield(L, -1, "count");
		if (!lua_isnumber(L, -1)) {
			std::cout << "[Warning - PlayerTasksData::load] Missing count property." << std::endl;
			return false;
		}
		taskData.count = lua_tonumber(L, -1);
		lua_pop(L, 1);

		lua_getfield(L, -1, "storageId");
		if (!lua_isnumber(L, -1)) {
			std::cout << "[Warning - PlayerTasksData::load] Missing storageId property." << std::endl;
			return false;
		}
		taskData.storageId = lua_tonumber(L, -1);
		lua_pop(L, 1);

		lua_getfield(L, -1, "classOutfit");
		if (!lua_istable(L, -1)) {
			std::cout << "[Warning - PlayerTasksData::load] Missing classOutfit property." << std::endl;
			return false;
		}

		{
			lua_getfield(L, -1, "type");
			taskData.classOutfit.lookType = lua_tonumber(L, -1);
			lua_pop(L, 1);

			lua_getfield(L, -1, "head");
			taskData.classOutfit.lookHead = lua_tonumber(L, -1);
			lua_pop(L, 1);

			lua_getfield(L, -1, "body");
			taskData.classOutfit.lookBody = lua_tonumber(L, -1);
			lua_pop(L, 1);

			lua_getfield(L, -1, "legs");
			taskData.classOutfit.lookLegs = lua_tonumber(L, -1);
			lua_pop(L, 1);

			lua_getfield(L, -1, "feet");
			taskData.classOutfit.lookFeet = lua_tonumber(L, -1);
			lua_pop(L, 1);

			lua_getfield(L, -1, "addons");
			taskData.classOutfit.lookAddons = lua_tonumber(L, -1);
			lua_pop(L, 1);

			lua_getfield(L, -1, "mount");
			taskData.classOutfit.lookMount = lua_tonumber(L, -1);
			lua_pop(L, 1);
		}
		lua_pop(L, 1);

		lua_getfield(L, -1, "monsters");
		if (!lua_istable(L, -1)) {
			std::cout << "[Warning - PlayerTasksData::load] Missing monsters property." << std::endl;
			return false;
		}

		{
			lua_pushnil(L);
			while (lua_next(L, -2)) {
				const std::string name = lua_tostring(L, -1);
				MonsterType* mType = g_monsters.getMonsterType(name);
				if (!mType) {
					std::cout << "[Warning - PlayerTasksData::load] Invalid monster's name '" << name << "'." << std::endl;
					return false;
				}

				taskData.monsters.emplace(name, Outfit_t(mType->info.outfit));
				lua_pop(L, 1);
			}
		}
		lua_pop(L, 1);

		lua_getfield(L, -1, "rewards");
		if (!lua_istable(L, -1)) {
			std::cout << "[Warning - PlayerTasksData::load] Missing rewards property." << std::endl;
			return false;
		}

		{
			lua_pushnil(L);
			size_t index = 0;
			uint16_t itemId = 0, clientId = 0;
			while (lua_next(L, -2)) {
				if (index % 2 == 0) {
					// ItemId
					itemId = lua_tonumber(L, -1);
					const ItemType& it = Item::items[itemId];
					if (it.id == 0) {
						std::cout << "[Warning - PlayerTasksData::load] Invalid item ID '" << itemId << "'." << std::endl;
						return false;
					}

					//clientId = it.clientId;
					clientId = it.id;
				}
				else if (index % 2 == 1) {
					// Count
					taskData.rewards.push_back({itemId, clientId, lua_tonumber(L, -1) });
				}

				index++;
				lua_pop(L, 1);
			}
		}

		lua_pop(L, 1);

		m_playerTasks.emplace(taskData.className, taskData);
		lua_pop(L, 1);
	}

	lua_close(L);
	return true;
}

bool PlayerTasksData::reload()
{
	m_playerTasks.clear();
	return load();
}

TaskData* PlayerTasksData::getTaskByName(const std::string& taskName)
{
	auto itTask = m_playerTasks.find(taskName);
	if (itTask == m_playerTasks.end()) {
		std::cout << "[Warning - PlayerTasksData::getTaskByName] - Task name '" << taskName << "' does not exist.\n";
		return nullptr;
	}

	return &itTask->second;
}

const char* PlayerTasksData::getReturnMessage(ReturnTaskMessages ret) const
{
	switch (ret) {
		case RET_TASK_ALREADY_TAKEN:
			return "Task is already taken.";
		case RET_TASK_IS_NOT_ACTIVE:
			return "You cannot cancel this task because it is not taken.";
		case RET_TASK_IS_COMPLETED:
			return "You cannot cancel this task because it is alredy completed.";
		case RET_TASK_IS_NOT_COMPLETED:
			return "You cannot claim rewards because this task is not completed yet.";
		case RET_TASK_LIMIT_HAS_BEEN_REACHED:
			return "You cannot select this task because the limit has been reached.";
		default:
			return "";
	}
}

ReturnTaskMessages PlayerTasks::manageTask(Player* player, uint8_t id, const std::string& name)
{
	switch (id) {
		case 1: {
			// Claim rewards
			if (!hasActiveTask(name)) {
				return RET_TASK_IS_NOT_ACTIVE;
			}

			TaskData* task = getTask(name);
			if (!task || task->kills < task->count) {
				return RET_TASK_IS_NOT_COMPLETED;
			}

			Item* mailItem = nullptr;
			for (auto& [itemId, clientId, itemCount] : task->rewards) {
				uint16_t count = itemCount;
				while (count > 0) {
					if (!mailItem) {
						mailItem = Item::CreateItem(ITEM_PARCEL, 1);
					}

					uint16_t stackAmount = std::min<uint16_t>(100, count);
					g_game.internalAddItem(mailItem->getContainer(), Item::CreateItem(itemId, stackAmount));
					count -= stackAmount;
				}
			}

			player->onGainExperience(task->experience, nullptr);
			player->addStorageValue(task->storageId, 1);
			if (mailItem) {
				g_game.internalAddItem(player, mailItem, INDEX_WHEREEVER, FLAG_NOLIMIT);
			}

			removeTask(name);
			break;
		}
		case 2: {
			// Select task
			if (!canTakeTask()) {
				return RET_TASK_LIMIT_HAS_BEEN_REACHED;
			}

			if (hasActiveTask(name)) {
				return RET_TASK_ALREADY_TAKEN;
			}

			addTask(PlayerTasksData::getInstance()->getTaskByName(name), 0);
			break;
		}
		case 3: {
			// Cancel task
			if (!hasActiveTask(name)) {
				return RET_TASK_IS_NOT_ACTIVE;
			}

			TaskData* task = getTask(name);
			if (!task || task->kills == task->count) {
				return RET_TASK_IS_COMPLETED;
			}

			removeTask(name);
			break;
		}
		default:
			break;
	}

	return RET_TASK_NO_ERROR;
}

void PlayerTasks::removeTask(const std::string& name)
{
	m_activeTasks.erase(m_activeTasks.find(name));
}

void PlayerTasks::addTask(const TaskData* data, uint32_t kills)
{
	m_activeTasks.emplace(data->className, TaskData(data, kills));
}

void PlayerTasks::addTask(const std::string name, uint32_t kills)
{
	addTask(PlayerTasksData::getInstance()->getTaskByName(name), kills);
}

void PlayerTasks::updateTask(Player* player, const std::string& name)
{
	for (auto& [className, taskData] : m_activeTasks) {
		if (taskData.kills == taskData.count) {
			// Task is already finished
			continue;
		}

		if (taskData.monsters.find(name) == taskData.monsters.end()) {
			// This monster does not belong to this task
			continue;
		}

		taskData.kills++;
		if (taskData.kills < taskData.count) {
			// Task is not finished yet
			continue;
		}

		// Task is finished, yey!
		break;
	}
}

bool PlayerTasks::isActive()
{
	if (m_active) {
		return false;
	}

	m_active = true;
	return true;
}

bool PlayerTasks::canTakeTask() const
{
	return m_activeTasks.size() < MAXIMUM_TASKS_AT_ONCE;
}

bool PlayerTasks::hasActiveTask(const std::string& name) const
{
	return m_activeTasks.find(name) != m_activeTasks.end();
}

TaskData* PlayerTasks::getTask(const std::string& name)
{
	auto itTask = m_activeTasks.find(name);
	if (itTask == m_activeTasks.end()) {
		std::cout << "[Warning - PlayerTasksData::getTaskByName] - Task name '" << name << "' does not exist.\n";
		return nullptr;
	}

	return &itTask->second;
}

uint32_t PlayerTasks::getTaskKills(const std::string& name) const
{
	auto itTask = m_activeTasks.find(name);
	if (itTask == m_activeTasks.end()) {
		return 0;
	}

	return itTask->second.kills;
}