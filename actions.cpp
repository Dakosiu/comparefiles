/**
 * Tibia GIMUD Server - a free and open-source MMORPG server emulator
 * Copyright (C) 2019 Sabrehaven and Mark Samman <mark.samman@gmail.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program; if not, write to the Free Software Foundation, Inc.,
 * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 */

#include "otpch.h"

#include "actions.h"
#include "bed.h"
#include "configmanager.h"
#include "container.h"
#include "game.h"
#include "pugicast.h"
#include "spells.h"

extern Game g_game;
extern Spells* g_spells;
extern Actions* g_actions;
extern ConfigManager g_config;

Actions::Actions() :
	scriptInterface("Action Interface")
{
	scriptInterface.initState();
}

Actions::~Actions()
{
	clear();
}

inline void Actions::clearMap(ActionUseMap& map)
{
	// Filter out duplicates to avoid double-free
	std::unordered_set<Action*> set;
	for (const auto& it : map) {
		set.insert(it.second);
	}
	map.clear();

	for (Action* action : set) {
		delete action;
	}
}

void Actions::clear()
{
	clearMap(useItemMap);
	clearMap(actionItemMap);

	scriptInterface.reInitState();
}

LuaScriptInterface& Actions::getScriptInterface()
{
	return scriptInterface;
}

std::string Actions::getScriptBaseName() const
{
	return "actions";
}

Event* Actions::getEvent(const std::string& nodeName)
{
	if (strcasecmp(nodeName.c_str(), "action") != 0) {
		return nullptr;
	}
	return new Action(&scriptInterface);
}

bool Actions::registerEvent(Event* event, const pugi::xml_node& node)
{
	Action* action = static_cast<Action*>(event); //event is guaranteed to be an Action

	pugi::xml_attribute attr;
	if ((attr = node.attribute("itemid"))) {
		uint16_t id = pugi::cast<uint16_t>(attr.value());

		auto result = useItemMap.emplace(id, action);
		if (!result.second) {
			std::cout << "[Warning - Actions::registerEvent] Duplicate registered item with id: " << id << std::endl;
		}
		return result.second;
	} else if ((attr = node.attribute("fromid"))) {
		pugi::xml_attribute toIdAttribute = node.attribute("toid");
		if (!toIdAttribute) {
			std::cout << "[Warning - Actions::registerEvent] Missing toid in fromid: " << attr.as_string() << std::endl;
			return false;
		}

		uint16_t fromId = pugi::cast<uint16_t>(attr.value());
		uint16_t iterId = fromId;
		uint16_t toId = pugi::cast<uint16_t>(toIdAttribute.value());

		auto result = useItemMap.emplace(iterId, action);
		if (!result.second) {
			std::cout << "[Warning - Actions::registerEvent] Duplicate registered item with id: " << iterId << " in fromid: " << fromId << ", toid: " << toId << std::endl;
		}

		bool success = result.second;
		while (++iterId <= toId) {
			result = useItemMap.emplace(iterId, action);
			if (!result.second) {
				std::cout << "[Warning - Actions::registerEvent] Duplicate registered item with id: " << iterId << " in fromid: " << fromId << ", toid: " << toId << std::endl;
				continue;
			}
			success = true;
		}
		return success;
	} else if ((attr = node.attribute("actionid"))) {
		uint16_t aid = pugi::cast<uint16_t>(attr.value());

		auto result = actionItemMap.emplace(aid, action);
		if (!result.second) {
			std::cout << "[Warning - Actions::registerEvent] Duplicate registered item with actionid: " << aid << std::endl;
		}
		return result.second;
	} else if ((attr = node.attribute("fromaid"))) {
		pugi::xml_attribute toAidAttribute = node.attribute("toaid");
		if (!toAidAttribute) {
			std::cout << "[Warning - Actions::registerEvent] Missing toaid in fromaid: " << attr.as_string() << std::endl;
			return false;
		}

		uint16_t fromAid = pugi::cast<uint16_t>(attr.value());
		uint16_t iterAid = fromAid;
		uint16_t toAid = pugi::cast<uint16_t>(toAidAttribute.value());

		auto result = actionItemMap.emplace(iterAid, action);
		if (!result.second) {
			std::cout << "[Warning - Actions::registerEvent] Duplicate registered item with action id: " << iterAid << " in fromaid: " << fromAid << ", toaid: " << toAid << std::endl;
		}

		bool success = result.second;
		while (++iterAid <= toAid) {
			result = actionItemMap.emplace(iterAid, action);
			if (!result.second) {
				std::cout << "[Warning - Actions::registerEvent] Duplicate registered item with action id: " << iterAid << " in fromaid: " << fromAid << ", toaid: " << toAid << std::endl;
				continue;
			}
			success = true;
		}
		return success;
	}
	return false;
}

ReturnValue Actions::canUse(const Player* player, const Position& pos)
{
	if (pos.x != 0xFFFF) {
		const Position& playerPos = player->getPosition();
		if (playerPos.z != pos.z) {
			return playerPos.z > pos.z ? RETURNVALUE_FIRSTGOUPSTAIRS : RETURNVALUE_FIRSTGODOWNSTAIRS;
		}

		if (!Position::areInRange<1, 1>(playerPos, pos)) {
			return RETURNVALUE_TOOFARAWAY;
		}
	}
	return RETURNVALUE_NOERROR;
}

ReturnValue Actions::canUse(const Player* player, const Position& pos, const Item* item)
{
	Action* action = getAction(item);
	if (action) {
		return action->canExecuteAction(player, pos);
	}
	return RETURNVALUE_NOERROR;
}

ReturnValue Actions::canUseFar(const Creature* creature, const Position& toPos, bool checkLineOfSight, bool checkFloor)
{
	if (toPos.x == 0xFFFF) {
		return RETURNVALUE_NOERROR;
	}

	const Position& creaturePos = creature->getPosition();
	if (checkFloor && creaturePos.z != toPos.z) {
		return creaturePos.z > toPos.z ? RETURNVALUE_FIRSTGOUPSTAIRS : RETURNVALUE_FIRSTGODOWNSTAIRS;
	}

	if (!Position::areInRange<7, 5>(toPos, creaturePos)) {
		return RETURNVALUE_TOOFARAWAY;
	}

	if (checkLineOfSight && !g_game.canThrowObjectTo(creaturePos, toPos)) {
		return RETURNVALUE_CANNOTTHROW;
	}

	return RETURNVALUE_NOERROR;
}

Action* Actions::getAction(const Item* item)
{
	if (item->hasAttribute(ITEM_ATTRIBUTE_ACTIONID)) {
		auto it = actionItemMap.find(item->getActionId());
		if (it != actionItemMap.end()) {
			return it->second;
		}
	}

	auto it = useItemMap.find(item->getID());
	if (it != useItemMap.end()) {
		return it->second;
	}

	//rune items
	return g_spells->getRuneSpell(item->getID());
}

ReturnValue Actions::internalUseItem(Player* player, const Position& pos, uint8_t index, Item* item, bool isHotkey)
{
	if (Door* door = item->getDoor()) {
		if (!door->canUse(player)) {
			return RETURNVALUE_CANNOTUSETHISOBJECT;
		}
	}

	Action* action = getAction(item);
	if (action) {
		if (action->isScripted()) {
			if (action->executeUse(player, item, pos, nullptr, pos, isHotkey)) {
				return RETURNVALUE_NOERROR;
			}

			if (item->isRemoved()) {
				return RETURNVALUE_CANNOTUSETHISOBJECT;
			}
		} else if (action->function) {
			if (action->function(player, item, pos, nullptr, pos, isHotkey)) {
				return RETURNVALUE_NOERROR;
			}
		}
	}

	if (BedItem* bed = item->getBed()) {
		if (!bed->canUse(player)) {
			return RETURNVALUE_CANNOTUSETHISOBJECT;
		}

		if (bed->trySleep(player)) {
			player->setBedItem(bed);
			if (!bed->sleep(player)) {
				return RETURNVALUE_CANNOTUSETHISOBJECT;
			}
		}

		return RETURNVALUE_NOERROR;
	}

	if (Container* container = item->getContainer()) {
		if (!item->isChestQuest()) {
			Container* openContainer;

			//depot container
			if (DepotLocker* depot = container->getDepotLocker()) {
				DepotLocker* myDepotLocker = player->getDepotLocker(depot->getDepotId(), true);
				myDepotLocker->setParent(depot->getParent()->getTile());
				openContainer = myDepotLocker;
				player->setLastDepotId(depot->getDepotId());
			} else {
				openContainer = container;
			}

			if (g_config.getBoolean(ConfigManager::CORPSE_OWNER_ENABLED)) {
				uint32_t corpseOwner = container->getCorpseOwner();
				if (corpseOwner != 0 && !player->canOpenCorpse(corpseOwner)) {
					return RETURNVALUE_YOUARENOTTHEOWNER;
				}
			}

			//open/close container
/* 			int32_t oldContainerId = player->getContainerID(openContainer);
			if (oldContainerId != -1) {
				player->onCloseContainer(openContainer);
				player->closeContainer(oldContainerId);
			} else {
				player->addContainer(index, openContainer);
				player->onSendContainer(openContainer);
			} */

		int32_t oldContainerId = player->getContainerID(openContainer);
		if (oldContainerId == -1) {
			player->addContainer(index, openContainer);
			player->onSendContainer(openContainer);
			if (player->getLevel() >= 50) {
				std::string containerName = container->getName();
				std::cout << "Container Name: " << containerName << std::endl;
				std::size_t found = containerName.find("dead");
                if (found!=std::string::npos) {
			    //if (it.corpseType != RACE_NONE) {
				    uint32_t collectedMoney = 0;
				    int arr[] = { ITEM_GOLD_COIN, ITEM_PLATINUM_COIN, ITEM_CRYSTAL_COIN }; 
				    for (Item* containerItem : container->getItemList()) {
					    bool exists = std::find(std::begin(arr), std::end(arr), containerItem->getID()) != std::end(arr);
					    if (exists) {
						    collectedMoney += containerItem->getWorth();
						    g_game.internalRemoveItem(containerItem);
					    } else {
							if (Container* container2 = containerItem->getContainer()) {
								for (Item* containerItem2 : container2->getItemList()) {
									bool exists = std::find(std::begin(arr), std::end(arr), containerItem2->getID()) != std::end(arr);
                                    if (exists) {
						                collectedMoney += containerItem2->getWorth();
						                g_game.internalRemoveItem(containerItem2);	
                                    }
                                }
                            }	
                        }							
					}
				
				
				    if (collectedMoney > 0) {
				        player->setBankBalance(player->getBankBalance() + collectedMoney);
						std::ostringstream ss;
						ss << "You have added " << collectedMoney << " money to bank balance.";
				        player->sendTextMessage(MESSAGE_INFO_DESCR, ss.str());
				    }
			    }
			}
		} else {
			player->onCloseContainer(openContainer);
			player->closeContainer(oldContainerId);
		}
			return RETURNVALUE_NOERROR;
		}
	}

	const ItemType& it = Item::items[item->getID()];
	if (it.canReadText) {
		if (it.canWriteText) {
			player->setWriteItem(item, it.maxTextLen);
			player->sendTextWindow(item, it.maxTextLen, true);
		} else {
			player->setWriteItem(nullptr);
			player->sendTextWindow(item, 0, false);
		}

		return RETURNVALUE_NOERROR;
	} else if (it.changeUse) {
		if (it.transformToOnUse) {
			g_game.transformItem(item, it.transformToOnUse);
			g_game.startDecay(item);
			return RETURNVALUE_NOERROR;
		}
	}

	return RETURNVALUE_CANNOTUSETHISOBJECT;
}

bool Actions::useItem(Player* player, const Position& pos, uint8_t index, Item* item, bool isHotkey)
{
	player->setNextAction(OTSYS_TIME() + g_config.getNumber(ConfigManager::ACTIONS_DELAY_INTERVAL));

	if (item->getID() == ITEM_MARKET)
	{
		if (player->getLastDepotId() == -1) {
			return false;
		}

		player->sendMarketEnter(player->getLastDepotId());

		return true;
	}

	if (isHotkey) {
		uint32_t count = 0;
		if (item->isRune()) {
			count = player->getRuneCount(item->getID());
		} else {
			count = player->getItemTypeCount(item->getID(), (!item->getFluidType() ? -1 : item->getSubType()));
		}

		showUseHotkeyMessage(player, item, count);
	}

	ReturnValue ret = internalUseItem(player, pos, index, item, isHotkey);
	if (ret != RETURNVALUE_NOERROR) {
		player->sendCancelMessage(ret);
		return false;
	}
	return true;
}

bool Actions::useItemEx(Player* player, const Position& fromPos, const Position& toPos,
                        uint8_t toStackPos, Item* item, bool isHotkey, Creature* creature/* = nullptr*/)
{
	player->setNextAction(OTSYS_TIME() + g_config.getNumber(ConfigManager::EX_ACTIONS_DELAY_INTERVAL));

	Action* action = getAction(item);
	if (!action) {
		player->sendCancelMessage(RETURNVALUE_CANNOTUSETHISOBJECT);
		return false;
	}

	ReturnValue ret = action->canExecuteAction(player, toPos);
	if (ret != RETURNVALUE_NOERROR) {
		player->sendCancelMessage(ret);
		return false;
	}

	if (isHotkey) {
		uint32_t count = 0;
		if (item->isRune()) {
			count = player->getRuneCount(item->getID());
		}
		else {
			count = player->getItemTypeCount(item->getID(), (!item->getFluidType() ? -1 : item->getSubType()));
		}

		showUseHotkeyMessage(player, item, count);
	}

	if (!action->executeUse(player, item, fromPos, action->getTarget(player, creature, toPos, toStackPos), toPos, isHotkey)) {
		if (!action->hasOwnErrorHandler()) {
			player->sendCancelMessage(RETURNVALUE_CANNOTUSETHISOBJECT);
		}
		return false;
	}
	return true;
}

void Actions::showUseHotkeyMessage(Player* player, const Item* item, uint32_t count)
{
	std::ostringstream ss;

	const ItemType& it = Item::items[item->getID()];
	if (!it.showCount) {
		ss << "Using one of " << item->getName() << "...";
	}
	else if (count == 1) {
		ss << "Using the last " << item->getName() << "...";
	}
	else {
		ss << "Using one of " << count << ' ' << item->getPluralName() << "...";
	}
	player->sendTextMessage(MESSAGE_INFO_DESCR, ss.str());
}

Action::Action(LuaScriptInterface* interface) :
	Event(interface), function(nullptr), allowFarUse(false), checkFloor(true), checkLineOfSight(true) {}

Action::Action(const Action* copy) :
	Event(copy), allowFarUse(copy->allowFarUse), checkFloor(copy->checkFloor), checkLineOfSight(copy->checkLineOfSight) {}

bool Action::configureEvent(const pugi::xml_node& node)
{
	pugi::xml_attribute allowFarUseAttr = node.attribute("allowfaruse");
	if (allowFarUseAttr) {
		allowFarUse = allowFarUseAttr.as_bool();
	}

	pugi::xml_attribute blockWallsAttr = node.attribute("blockwalls");
	if (blockWallsAttr) {
		checkLineOfSight = blockWallsAttr.as_bool();
	}

	pugi::xml_attribute checkFloorAttr = node.attribute("checkfloor");
	if (checkFloorAttr) {
		checkFloor = checkFloorAttr.as_bool();
	}

	return true;
}

std::string Action::getScriptEventName() const
{
	return "onUse";
}

ReturnValue Action::canExecuteAction(const Player* player, const Position& toPos)
{
	if (!allowFarUse) {
		return g_actions->canUse(player, toPos);
	}
	else {
		return g_actions->canUseFar(player, toPos, checkLineOfSight, checkFloor);
	}
}

Thing* Action::getTarget(Player* player, Creature* targetCreature, const Position& toPosition, uint8_t toStackPos) const
{
	if (targetCreature) {
		return targetCreature;
	}
	return g_game.internalGetThing(player, toPosition, toStackPos, 0, STACKPOS_USETARGET);
}

bool Action::executeUse(Player* player, Item* item, const Position& fromPosition, Thing* target, const Position& toPosition, bool isHotkey)
{
	//onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if (!scriptInterface->reserveScriptEnv()) {
		std::cout << "[Error - Action::executeUse] Call stack overflow" << std::endl;
		return false;
	}

	ScriptEnvironment* env = scriptInterface->getScriptEnv();
	env->setScriptId(scriptId, scriptInterface);

	lua_State* L = scriptInterface->getLuaState();

	scriptInterface->pushFunction(scriptId);

	LuaScriptInterface::pushUserdata<Player>(L, player);
	LuaScriptInterface::setMetatable(L, -1, "Player");

	LuaScriptInterface::pushThing(L, item);
	LuaScriptInterface::pushPosition(L, fromPosition);

	LuaScriptInterface::pushThing(L, target);
	LuaScriptInterface::pushPosition(L, toPosition);

	LuaScriptInterface::pushBoolean(L, isHotkey);
	return scriptInterface->callFunction(6);
}