/**
 * The Forgotten Server - a free and open-source MMORPG server emulator
 * Copyright (C) 2016  Mark Samman <mark.samman@gmail.com>
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

#include "events.h"
#include "tools.h"
#include "item.h"
#include "player.h"

#include <set>

Events::Events() :
	scriptInterface("Event Interface")
{
	scriptInterface.initState();
}

bool Events::load()
{
	pugi::xml_document doc;
	pugi::xml_parse_result result = doc.load_file("data/events/events.xml");
	if (!result) {
		printXMLError("Error - Events::load", "data/events/events.xml", result);
		return false;
	}

	info = {};

	std::set<std::string> classes;
	for (auto eventNode : doc.child("events").children()) {
		if (!eventNode.attribute("enabled").as_bool()) {
			continue;
		}

		const std::string& className = eventNode.attribute("class").as_string();
		auto res = classes.insert(className);
		if (res.second) {
			const std::string& lowercase = asLowerCaseString(className);
			if (scriptInterface.loadFile("data/events/scripts/" + lowercase + ".lua") != 0) {
				std::cout << "[Warning - Events::load] Can not load script: " << lowercase << ".lua" << std::endl;
				std::cout << scriptInterface.getLastLuaError() << std::endl;
			}
		}

		const std::string& methodName = eventNode.attribute("method").as_string();
		const int32_t event = scriptInterface.getMetaEvent(className, methodName);
		if (className == "Creature") {
			if (methodName == "onChangeOutfit") {
				info.creatureOnChangeOutfit = event;
			} else if (methodName == "onAreaCombat") {
				info.creatureOnAreaCombat = event;
			} else if (methodName == "onTargetCombat") {
				info.creatureOnTargetCombat = event;
			} else {
				std::cout << "[Warning - Events::load] Unknown creature method: " << methodName << std::endl;
			}
		} else if (className == "Party") {
			if (methodName == "onJoin") {
				info.partyOnJoin = event;
			} else if (methodName == "onLeave") {
				info.partyOnLeave = event;
			} else if (methodName == "onDisband") {
				info.partyOnDisband = event;
			} else {
				std::cout << "[Warning - Events::load] Unknown party method: " << methodName << std::endl;
			}
		} else if (className == "Player") {
			if (methodName == "onTradeRequest") {
				info.playerOnTradeRequest = event;
			} else if (methodName == "onTradeAccept") {
				info.playerOnTradeAccept = event;
			} else if (methodName == "onLook") {
				info.playerOnLook = event;
			} else if (methodName == "onMoveItem") {
				info.playerOnMoveItem = event;
			} else if (methodName == "onItemMoved") {
				info.playerOnItemMoved = event;
			} else if (methodName == "onMoveCreature") {
				info.playerOnMoveCreature = event;
			} else if (methodName == "onTurn") {
				info.playerOnTurn = event;
			} else if (methodName == "onCastSpell") {
				info.playerOnCastSpell = event;
			} else if (methodName == "onGainExperience") {
				info.playerOnGainExperience = event;
			} else if (methodName == "onLoseExperience") {
				info.playerOnLoseExperience = event;
			} else if (methodName == "onRemoveCount") {
				info.playerOnRemoveCount = event;
			} else if (methodName == "onUseItem") {
				info.playerOnUseItem = event;
			} else {
				std::cout << "[Warning - Events::load] Unknown player method: " << methodName << std::endl;
			}
		} else {
			std::cout << "[Warning - Events::load] Unknown class: " << className << std::endl;
		}
	}
	return true;
}

// Creature
bool Events::eventCreatureOnChangeOutfit(Creature* creature, const Outfit_t& outfit)
{
	// Creature:onChangeOutfit(outfit) or Creature.onChangeOutfit(self, outfit)
	if (info.creatureOnChangeOutfit == -1) {
		return true;
	}

	if (!scriptInterface.reserveScriptEnv()) {
		std::cout << "[Error - Events::eventCreatureOnChangeOutfit] Call stack overflow" << std::endl;
		return false;
	}

	ScriptEnvironment* env = scriptInterface.getScriptEnv();
	env->setScriptId(info.creatureOnChangeOutfit, &scriptInterface);

	lua_State* L = scriptInterface.getLuaState();
	scriptInterface.pushFunction(info.creatureOnChangeOutfit);

	LuaScriptInterface::pushUserdata<Creature>(L, creature);
	LuaScriptInterface::setCreatureMetatable(L, -1, creature);

	LuaScriptInterface::pushOutfit(L, outfit);

	return scriptInterface.callFunction(2);
}

ReturnValue Events::eventCreatureOnAreaCombat(Creature* creature, Tile* tile, bool aggressive)
{
	// Creature:onAreaCombat(tile, aggressive) or Creature.onAreaCombat(self, tile, aggressive)
	if (info.creatureOnAreaCombat == -1) {
		return RETURNVALUE_NOERROR;
	}

	if (!scriptInterface.reserveScriptEnv()) {
		std::cout << "[Error - Events::eventCreatureOnAreaCombat] Call stack overflow" << std::endl;
		return RETURNVALUE_NOTPOSSIBLE;
	}

	ScriptEnvironment* env = scriptInterface.getScriptEnv();
	env->setScriptId(info.creatureOnAreaCombat, &scriptInterface);

	lua_State* L = scriptInterface.getLuaState();
	scriptInterface.pushFunction(info.creatureOnAreaCombat);

	if (creature) {
		LuaScriptInterface::pushUserdata<Creature>(L, creature);
		LuaScriptInterface::setCreatureMetatable(L, -1, creature);
	} else {
		lua_pushnil(L);
	}

	LuaScriptInterface::pushUserdata<Tile>(L, tile);
	LuaScriptInterface::setMetatable(L, -1, "Tile");

	LuaScriptInterface::pushBoolean(L, aggressive);

	ReturnValue returnValue;
	if (scriptInterface.protectedCall(L, 3, 1) != 0) {
		returnValue = RETURNVALUE_NOTPOSSIBLE;
		LuaScriptInterface::reportError(nullptr, LuaScriptInterface::popString(L));
	} else {
		returnValue = LuaScriptInterface::getNumber<ReturnValue>(L, -1);
		lua_pop(L, 1);
	}

	scriptInterface.resetScriptEnv();
	return returnValue;
}

ReturnValue Events::eventCreatureOnTargetCombat(Creature* creature, Creature* target)
{
	// Creature:onTargetCombat(target) or Creature.onTargetCombat(self, target)
	if (info.creatureOnTargetCombat == -1) {
		return RETURNVALUE_NOERROR;
	}

	if (!scriptInterface.reserveScriptEnv()) {
		std::cout << "[Error - Events::eventCreatureOnTargetCombat] Call stack overflow" << std::endl;
		return RETURNVALUE_NOTPOSSIBLE;
	}

	ScriptEnvironment* env = scriptInterface.getScriptEnv();
	env->setScriptId(info.creatureOnTargetCombat, &scriptInterface);

	lua_State* L = scriptInterface.getLuaState();
	scriptInterface.pushFunction(info.creatureOnTargetCombat);

	if (creature) {
		LuaScriptInterface::pushUserdata<Creature>(L, creature);
		LuaScriptInterface::setCreatureMetatable(L, -1, creature);
	} else {
		lua_pushnil(L);
	}

	LuaScriptInterface::pushUserdata<Creature>(L, target);
	LuaScriptInterface::setCreatureMetatable(L, -1, target);

	ReturnValue returnValue;
	if (scriptInterface.protectedCall(L, 2, 1) != 0) {
		returnValue = RETURNVALUE_NOTPOSSIBLE;
		LuaScriptInterface::reportError(nullptr, LuaScriptInterface::popString(L));
	} else {
		returnValue = LuaScriptInterface::getNumber<ReturnValue>(L, -1);
		lua_pop(L, 1);
	}

	scriptInterface.resetScriptEnv();
	return returnValue;
}

// Party
bool Events::eventPartyOnJoin(Party* party, Player* player)
{
	// Party:onJoin(player) or Party.onJoin(self, player)
	if (info.partyOnJoin == -1) {
		return true;
	}

	if (!scriptInterface.reserveScriptEnv()) {
		std::cout << "[Error - Events::eventPartyOnJoin] Call stack overflow" << std::endl;
		return false;
	}

	ScriptEnvironment* env = scriptInterface.getScriptEnv();
	env->setScriptId(info.partyOnJoin, &scriptInterface);

	lua_State* L = scriptInterface.getLuaState();
	scriptInterface.pushFunction(info.partyOnJoin);

	LuaScriptInterface::pushUserdata<Party>(L, party);
	LuaScriptInterface::setMetatable(L, -1, "Party");

	LuaScriptInterface::pushUserdata<Player>(L, player);
	LuaScriptInterface::setMetatable(L, -1, "Player");

	return scriptInterface.callFunction(2);
}

bool Events::eventPartyOnLeave(Party* party, Player* player)
{
	// Party:onLeave(player) or Party.onLeave(self, player)
	if (info.partyOnLeave == -1) {
		return true;
	}

	if (!scriptInterface.reserveScriptEnv()) {
		std::cout << "[Error - Events::eventPartyOnLeave] Call stack overflow" << std::endl;
		return false;
	}

	ScriptEnvironment* env = scriptInterface.getScriptEnv();
	env->setScriptId(info.partyOnLeave, &scriptInterface);

	lua_State* L = scriptInterface.getLuaState();
	scriptInterface.pushFunction(info.partyOnLeave);

	LuaScriptInterface::pushUserdata<Party>(L, party);
	LuaScriptInterface::setMetatable(L, -1, "Party");

	LuaScriptInterface::pushUserdata<Player>(L, player);
	LuaScriptInterface::setMetatable(L, -1, "Player");

	return scriptInterface.callFunction(2);
}

bool Events::eventPartyOnDisband(Party* party)
{
	// Party:onDisband() or Party.onDisband(self)
	if (info.partyOnDisband == -1) {
		return true;
	}

	if (!scriptInterface.reserveScriptEnv()) {
		std::cout << "[Error - Events::eventPartyOnDisband] Call stack overflow" << std::endl;
		return false;
	}

	ScriptEnvironment* env = scriptInterface.getScriptEnv();
	env->setScriptId(info.partyOnDisband, &scriptInterface);

	lua_State* L = scriptInterface.getLuaState();
	scriptInterface.pushFunction(info.partyOnDisband);

	LuaScriptInterface::pushUserdata<Party>(L, party);
	LuaScriptInterface::setMetatable(L, -1, "Party");

	return scriptInterface.callFunction(1);
}

// Player
bool Events::eventPlayerOnMoveItem(Player* player, Item* item, uint16_t count, const Position& fromPosition, const Position& toPosition, Cylinder* fromCylinder, Cylinder* toCylinder)
{
	// Player:onMoveItem(item, count, fromPosition, toPosition) or Player.onMoveItem(self, item, count, fromPosition, toPosition, fromCylinder, toCylinder)
	if (info.playerOnMoveItem == -1) {
		return true;
	}

	if (!scriptInterface.reserveScriptEnv()) {
		std::cout << "[Error - Events::eventPlayerOnMoveItem] Call stack overflow" << std::endl;
		return false;
	}

	ScriptEnvironment* env = scriptInterface.getScriptEnv();
	env->setScriptId(info.playerOnMoveItem, &scriptInterface);

	lua_State* L = scriptInterface.getLuaState();
	scriptInterface.pushFunction(info.playerOnMoveItem);

	LuaScriptInterface::pushUserdata<Player>(L, player);
	LuaScriptInterface::setMetatable(L, -1, "Player");

	LuaScriptInterface::pushUserdata<Item>(L, item);
	LuaScriptInterface::setItemMetatable(L, -1, item);

	lua_pushnumber(L, count);
	LuaScriptInterface::pushPosition(L, fromPosition);
	LuaScriptInterface::pushPosition(L, toPosition);

	LuaScriptInterface::pushCylinder(L, fromCylinder);
	LuaScriptInterface::pushCylinder(L, toCylinder);

	return scriptInterface.callFunction(7);
}

void Events::eventPlayerOnItemMoved(Player* player, Item* item, uint16_t count, const Position& fromPosition, const Position& toPosition, Cylinder* fromCylinder, Cylinder* toCylinder)
{
	// Player:onItemMoved(item, count, fromPosition, toPosition) or Player.onItemMoved(self, item, count, fromPosition, toPosition, fromCylinder, toCylinder)
	if (info.playerOnItemMoved == -1) {
		return;
	}

	if (!scriptInterface.reserveScriptEnv()) {
		std::cout << "[Error - Events::eventPlayerOnItemMoved] Call stack overflow" << std::endl;
		return;
	}

	ScriptEnvironment* env = scriptInterface.getScriptEnv();
	env->setScriptId(info.playerOnItemMoved, &scriptInterface);

	lua_State* L = scriptInterface.getLuaState();
	scriptInterface.pushFunction(info.playerOnItemMoved);

	LuaScriptInterface::pushUserdata<Player>(L, player);
	LuaScriptInterface::setMetatable(L, -1, "Player");

	LuaScriptInterface::pushUserdata<Item>(L, item);
	LuaScriptInterface::setItemMetatable(L, -1, item);

	lua_pushnumber(L, count);
	LuaScriptInterface::pushPosition(L, fromPosition);
	LuaScriptInterface::pushPosition(L, toPosition);

	LuaScriptInterface::pushCylinder(L, fromCylinder);
	LuaScriptInterface::pushCylinder(L, toCylinder);

	scriptInterface.callVoidFunction(7);
}

bool Events::eventPlayerOnMoveCreature(Player* player, Creature* creature, const Position& fromPosition, const Position& toPosition)
{
	// Player:onMoveCreature(creature, fromPosition, toPosition) or Player.onMoveCreature(self, creature, fromPosition, toPosition)
	if (info.playerOnMoveCreature == -1) {
		return true;
	}

	if (!scriptInterface.reserveScriptEnv()) {
		std::cout << "[Error - Events::eventPlayerOnMoveCreature] Call stack overflow" << std::endl;
		return false;
	}

	ScriptEnvironment* env = scriptInterface.getScriptEnv();
	env->setScriptId(info.playerOnMoveCreature, &scriptInterface);

	lua_State* L = scriptInterface.getLuaState();
	scriptInterface.pushFunction(info.playerOnMoveCreature);

	LuaScriptInterface::pushUserdata<Player>(L, player);
	LuaScriptInterface::setMetatable(L, -1, "Player");

	LuaScriptInterface::pushUserdata<Creature>(L, creature);
	LuaScriptInterface::setCreatureMetatable(L, -1, creature);

	LuaScriptInterface::pushPosition(L, fromPosition);
	LuaScriptInterface::pushPosition(L, toPosition);

	return scriptInterface.callFunction(4);
}

bool Events::eventPlayerOnTurn(Player* player, Direction direction)
{
	// Player:onTurn(direction) or Player.onTurn(self, direction)
	if (info.playerOnTurn == -1) {
		return true;
	}

	if (!scriptInterface.reserveScriptEnv()) {
		std::cout << "[Error - Events::eventPlayerOnTurn] Call stack overflow" << std::endl;
		return false;
	}

	ScriptEnvironment* env = scriptInterface.getScriptEnv();
	env->setScriptId(info.playerOnTurn, &scriptInterface);

	lua_State* L = scriptInterface.getLuaState();
	scriptInterface.pushFunction(info.playerOnTurn);

	LuaScriptInterface::pushUserdata<Player>(L, player);
	LuaScriptInterface::setMetatable(L, -1, "Player");

	lua_pushnumber(L, direction);

	return scriptInterface.callFunction(2);
}

bool Events::eventPlayerOnCastSpell(Player* player, const std::string& spellName)
{
	// Player:onCastSpell(spellName) or Player.onCastSpell(self, spellName)
	if (info.playerOnCastSpell == -1) {
		return true;
	}

	if (!scriptInterface.reserveScriptEnv()) {
		std::cout << "[Error - Events::eventPlayerOnCastSpell] Call stack overflow" << std::endl;
		return false;
	}

	ScriptEnvironment* env = scriptInterface.getScriptEnv();
	env->setScriptId(info.playerOnCastSpell, &scriptInterface);

	lua_State* L = scriptInterface.getLuaState();
	scriptInterface.pushFunction(info.playerOnCastSpell);

	LuaScriptInterface::pushUserdata<Player>(L, player);
	LuaScriptInterface::setMetatable(L, -1, "Player");

	LuaScriptInterface::pushString(L, spellName);

	return scriptInterface.callFunction(2);
}

bool Events::eventPlayerOnRemoveCount(Player* player, Item* item, uint16_t count)
{
	// Player:onMove()
	if (info.playerOnRemoveCount == -1) {
		return true;
	}

	if (!scriptInterface.reserveScriptEnv()) {
		std::cout << "[Error - Events::eventPlayerOnMove"
				<< " Player "
				<< player->getName()
				<< " item "
				<< item->getName()
				<< "] Call stack overflow. Too many lua script calls being nested."
				<< std::endl;
		return false;
	}

	ScriptEnvironment* env = scriptInterface.getScriptEnv();
	env->setScriptId(info.playerOnRemoveCount, &scriptInterface);

	lua_State* L = scriptInterface.getLuaState();
	scriptInterface.pushFunction(info.playerOnRemoveCount);

	LuaScriptInterface::pushUserdata<Player>(L, player);
	LuaScriptInterface::setMetatable(L, -1, "Player");

	LuaScriptInterface::pushUserdata<Item>(L, item);
	LuaScriptInterface::setItemMetatable(L, -1, item);
	
	lua_pushnumber(L, count);
	
	return scriptInterface.callFunction(3);
}

bool Events::eventPlayerOnUseItem(Player* player, Item* item, Thing* target)
{
	// Player:onUseItem(item)
	if (info.playerOnUseItem == -1) {
		return true;
	}

	if (!scriptInterface.reserveScriptEnv()) {
		std::cout << "[Error - Events::eventPlayerOnUseItem] Call stack overflow" << std::endl;
		return false;
	}

	ScriptEnvironment* env = scriptInterface.getScriptEnv();
	env->setScriptId(info.playerOnUseItem, &scriptInterface);

	lua_State* L = scriptInterface.getLuaState();
	scriptInterface.pushFunction(info.playerOnUseItem);

	LuaScriptInterface::pushUserdata<Player>(L, player);
	LuaScriptInterface::setMetatable(L, -1, "Player");

	LuaScriptInterface::pushUserdata<Item>(L, item);
	LuaScriptInterface::setItemMetatable(L, -1, item);
	
	if (target != nullptr) {
		if (Creature* xCreature = target->getCreature()) {
			LuaScriptInterface::pushUserdata<Creature>(L, xCreature);
			LuaScriptInterface::setCreatureMetatable(L, -1, xCreature);
		} else if (Item* xItem = target->getItem()) {
			LuaScriptInterface::pushUserdata<Item>(L, xItem);
			LuaScriptInterface::setItemMetatable(L, -1, xItem);
		} else {
			lua_pushnil(L);
		}
	} else {
		lua_pushnil(L);
	}
	
return scriptInterface.callFunction(3);
}

bool Events::eventPlayerOnTradeRequest(Player* player, Player* target, Item* item)
{
	// Player:onTradeRequest(target, item)
	if (info.playerOnTradeRequest == -1) {
		return true;
	}

	if (!scriptInterface.reserveScriptEnv()) {
		std::cout << "[Error - Events::eventPlayerOnTradeRequest] Call stack overflow" << std::endl;
		return false;
	}

	ScriptEnvironment* env = scriptInterface.getScriptEnv();
	env->setScriptId(info.playerOnTradeRequest, &scriptInterface);

	lua_State* L = scriptInterface.getLuaState();
	scriptInterface.pushFunction(info.playerOnTradeRequest);

	LuaScriptInterface::pushUserdata<Player>(L, player);
	LuaScriptInterface::setMetatable(L, -1, "Player");

	LuaScriptInterface::pushUserdata<Player>(L, target);
	LuaScriptInterface::setMetatable(L, -1, "Player");

	LuaScriptInterface::pushUserdata<Item>(L, item);
	LuaScriptInterface::setItemMetatable(L, -1, item);

	return scriptInterface.callFunction(3);
}

bool Events::eventPlayerOnTradeAccept(Player* player, Player* target, Item* item, Item* targetItem)
{
	// Player:onTradeAccept(target, item, targetItem)
	if (info.playerOnTradeAccept == -1) {
		return true;
	}

	if (!scriptInterface.reserveScriptEnv()) {
		std::cout << "[Error - Events::eventPlayerOnTradeAccept] Call stack overflow" << std::endl;
		return false;
	}

	ScriptEnvironment* env = scriptInterface.getScriptEnv();
	env->setScriptId(info.playerOnTradeAccept, &scriptInterface);

	lua_State* L = scriptInterface.getLuaState();
	scriptInterface.pushFunction(info.playerOnTradeAccept);

	LuaScriptInterface::pushUserdata<Player>(L, player);
	LuaScriptInterface::setMetatable(L, -1, "Player");

	LuaScriptInterface::pushUserdata<Player>(L, target);
	LuaScriptInterface::setMetatable(L, -1, "Player");

	LuaScriptInterface::pushUserdata<Item>(L, item);
	LuaScriptInterface::setItemMetatable(L, -1, item);

	LuaScriptInterface::pushUserdata<Item>(L, targetItem);
	LuaScriptInterface::setItemMetatable(L, -1, targetItem);

	return scriptInterface.callFunction(4);
}

void Events::eventPlayerOnGainExperience(Player* player, uint64_t& exp)
{
	// Player:onGainExperience(exp)
	if (info.playerOnGainExperience == -1) {
		return;
	}

	if (!scriptInterface.reserveScriptEnv()) {
		std::cout << "[Error - Events::eventPlayerOnGainExperience] Call stack overflow" << std::endl;
		return;
	}

	ScriptEnvironment* env = scriptInterface.getScriptEnv();
	env->setScriptId(info.playerOnGainExperience, &scriptInterface);

	lua_State* L = scriptInterface.getLuaState();
	scriptInterface.pushFunction(info.playerOnGainExperience);

	LuaScriptInterface::pushUserdata<Player>(L, player);
	LuaScriptInterface::setMetatable(L, -1, "Player");

	lua_pushnumber(L, exp);

	if (scriptInterface.protectedCall(L, 2, 1) != 0) {
		LuaScriptInterface::reportError(nullptr, LuaScriptInterface::popString(L));
	} else {
		exp = LuaScriptInterface::getNumber<uint64_t>(L, -1);
		lua_pop(L, 1);
	}

	scriptInterface.resetScriptEnv();
}

void Events::eventPlayerOnLoseExperience(Player* player, uint64_t& exp)
{
	// Player:onLoseExperience(exp)
	if (info.playerOnLoseExperience == -1) {
		return;
	}

	if (!scriptInterface.reserveScriptEnv()) {
		std::cout << "[Error - Events::eventPlayerOnLoseExperience] Call stack overflow" << std::endl;
		return;
	}

	ScriptEnvironment* env = scriptInterface.getScriptEnv();
	env->setScriptId(info.playerOnLoseExperience, &scriptInterface);

	lua_State* L = scriptInterface.getLuaState();
	scriptInterface.pushFunction(info.playerOnLoseExperience);

	LuaScriptInterface::pushUserdata<Player>(L, player);
	LuaScriptInterface::setMetatable(L, -1, "Player");

	lua_pushnumber(L, exp);

	if (scriptInterface.protectedCall(L, 2, 1) != 0) {
		LuaScriptInterface::reportError(nullptr, LuaScriptInterface::popString(L));
	} else {
		exp = LuaScriptInterface::getNumber<uint64_t>(L, -1);
		lua_pop(L, 1);
	}

	scriptInterface.resetScriptEnv();
}

void Events::eventPlayerOnLook(Player* player, const Position& position, Thing* thing, uint8_t stackpos, int32_t lookDistance)
{
	// Player:onLook(thing, position, distance) or Player.onLook(self, thing, position, distance)
	if (info.playerOnLook == -1) {
		return;
	}

	if (!scriptInterface.reserveScriptEnv()) {
		std::cout << "[Error - Events::eventPlayerOnLook] Call stack overflow" << std::endl;
		return;
	}

	ScriptEnvironment* env = scriptInterface.getScriptEnv();
	env->setScriptId(info.playerOnLook, &scriptInterface);

	lua_State* L = scriptInterface.getLuaState();
	scriptInterface.pushFunction(info.playerOnLook);

	LuaScriptInterface::pushUserdata<Player>(L, player);
	LuaScriptInterface::setMetatable(L, -1, "Player");

	if (Creature* creature = thing->getCreature()) {
		LuaScriptInterface::pushUserdata<Creature>(L, creature);
		LuaScriptInterface::setCreatureMetatable(L, -1, creature);
	} else if (Item* item = thing->getItem()) {
		LuaScriptInterface::pushUserdata<Item>(L, item);
		LuaScriptInterface::setItemMetatable(L, -1, item);
	} else {
		lua_pushnil(L);
	}

	LuaScriptInterface::pushPosition(L, position, stackpos);
	lua_pushnumber(L, lookDistance);

	scriptInterface.callVoidFunction(4);
}