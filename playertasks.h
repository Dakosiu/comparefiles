#pragma once
#include "enums.h"

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

enum ReturnTaskMessages {
	RET_TASK_NO_ERROR,
	RET_TASK_ALREADY_TAKEN,
	RET_TASK_IS_NOT_ACTIVE,
	RET_TASK_IS_COMPLETED,
	RET_TASK_IS_NOT_COMPLETED,
	RET_TASK_LIMIT_HAS_BEEN_REACHED
};

struct TaskData
{
	TaskData() {}
	TaskData(const TaskData* data, uint32_t kills) {
		this->className = data->className;
		this->bossName = data->bossName;
		this->experience = data->experience;
		this->count = data->count;
		this->storageId = data->storageId;
		this->classOutfit = data->classOutfit;
		this->monsters = data->monsters;
		this->rewards = data->rewards;
		this->kills = kills;
	}

	std::string className, bossName;
	std::map<const std::string, Outfit_t> monsters;
	std::vector<std::tuple<uint16_t, uint16_t, uint16_t>> rewards;
	uint32_t experience = 0, kills = 0, count = 0, storageId = 0;
	Outfit_t classOutfit;
};

typedef std::unordered_map<std::string, TaskData> TasksList;

class PlayerTasksData
{
	public:
		static PlayerTasksData* getInstance()
		{
			static PlayerTasksData instance;
			return &instance;
		}

		bool load();
		bool reload();

		const char* getReturnMessage(ReturnTaskMessages ret) const;

		TaskData* getTaskByName(const std::string& name);

		const TasksList& getTasks() const { return m_playerTasks; }

	private:
		TasksList m_playerTasks;
};

class PlayerTasks
{
	public:
		PlayerTasks() {}
		virtual ~PlayerTasks() {}

		void updateTask(Player* player, const std::string& name);
		void addTask(const TaskData* data, uint32_t kills);
		void addTask(const std::string name, uint32_t kills);
		void removeTask(const std::string& name);

		ReturnTaskMessages manageTask(Player* player, uint8_t id, const std::string& name);

		bool canTakeTask() const;
		bool hasActiveTask(const std::string& name) const;
		bool isActive();

		uint32_t getTaskKills(const std::string& name) const;

		TaskData* getTask(const std::string& name);
		const TasksList& getTasks() const { return m_activeTasks; }

	private:
		TasksList m_activeTasks;
		bool m_active = false;
};