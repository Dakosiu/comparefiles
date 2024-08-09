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

#include "npc.h"
#include "game.h"
#include "tools.h"
#include "position.h"
#include "player.h"
#include "spawn.h"
#include "script.h"
#include "behaviourdatabase.h"

extern Game g_game;

uint32_t Npc::npcAutoID = 0x80000000;

void Npcs::loadNpcs()
{
	std::cout << ">> Loading npcs..." << std::endl;

	std::vector<boost::filesystem::path> files;
	getFilesInDirectory("data/npc/", ".npc", files);
	for (auto file : files)
	{
		std::string npcName = file.filename().string();
		int32_t end = npcName.find_first_of('/');
		npcName = npcName.substr(end + 1, npcName.length() - end);
		end = npcName.find_first_of('.');
		npcName = npcName.substr(0, end);

		Npc* npc = Npc::createNpc(npcName);
		if (!npc) {
			return;
		}

		if (npc->getClientVersion() <= g_game.getClientVersion()) {
			g_game.placeCreature(npc, npc->getMasterPos(), false, true);
		}
	}
}

void Npcs::reload()
{
	const std::map<uint32_t, Npc*>& npcs = g_game.getNpcs();

	for (const auto& it : npcs) {
		it.second->closeAllShopWindows();
	}

	for (const auto& it : npcs) {
		it.second->reload();
	}
}

Npc* Npc::createNpc(const std::string& name)
{
	std::unique_ptr<Npc> npc(new Npc(name));
	npc->filename = "data/npc/" + name + ".npc";
	if (!npc->load()) {
		return nullptr;
	}

	return npc.release();
}

Npc::Npc(const std::string& name) :
	Creature(),
	filename("data/npc/" + name + ".npc"),
	masterRadius(0),
	staticMovementTime(0),
	loaded(false),
	behaviourDatabase(nullptr)
{
	baseSpeed = 5;
	reset();
}

Npc::~Npc()
{
	reset();
}

void Npc::addList()
{
	g_game.addNpc(this);
}

void Npc::removeList()
{
	g_game.removeNpc(this);
}

bool Npc::load()
{
	if (loaded) {
		return true;
	}

	reset();

	ScriptReader script;
	if (!script.open(filename)) {
		return false;
	}

	while (true) {
		script.nextToken();

		if (script.Token == ENDOFFILE) {
			break;
		}

		if (script.Token != IDENTIFIER) {
			script.error("identifier expected");
			return false;
		}

		std::string ident = script.getIdentifier();
		script.readSymbol('=');

		if (ident == "name") {
			name = script.readString();
		} else if (ident == "outfit") {
			script.readSymbol('(');
			uint8_t* c;
			currentOutfit.lookType = script.readNumber();
			script.readSymbol(',');
			if (currentOutfit.lookType > 0) {
				c = script.readBytesequence();
				currentOutfit.lookHead = c[0];
				currentOutfit.lookBody = c[1];
				currentOutfit.lookLegs = c[2];
				currentOutfit.lookFeet = c[3];
				currentOutfit.lookAddons = c[4];
			} else {
				currentOutfit.lookTypeEx = script.readNumber();
			}
			script.readSymbol(')');
		} else if (ident == "home") {
			script.readCoordinate(masterPos.x, masterPos.y, masterPos.z);
		} else if (ident == "radius") {
			masterRadius = script.readNumber();
		}
		else if (ident == "clientversion") {
			clientVersion = script.readNumber();
		} else if (ident == "shop") {
			script.readSymbol('{');
			while (true) {
				script.nextToken();
				if (script.Token == SPECIAL) {
					if (script.getSpecial() == '}') {
						break;
					}

					if (script.getSpecial() == ',') {
						continue;
					}

					if (script.getSpecial() != '(') {
						script.error("expected '(' shop entry");
						return false;
					}

					int32_t id = script.readNumber();

					script.readSymbol(',');

					int32_t buyPrice = script.readNumber();

					script.readSymbol(',');

					int32_t sellPrice = script.readNumber();

					script.readSymbol(',');

					std::string name = script.readString();

					script.readSymbol(')');

					ShopInfo info;
					info.buyPrice = buyPrice;
					info.itemId = id;
					info.sellPrice = sellPrice;
					info.subType = 0;
					info.realName = name;
					if (name.empty()) {
						info.realName = Item::items.getItemType(id).name;
					}
					cipShopList.push_back(info);
				} else
				{
					script.error("unexpected token");
					return false;
				}
			}
		} else if (ident == "behaviour") {
			if (behaviourDatabase) {
				script.error("behaviour database already defined");
				return false;
			}

			behaviourDatabase = new BehaviourDatabase(this);
			if (!behaviourDatabase->loadDatabase(script)) {
				return false;
			}
		}
	}

	behaviourDatabase->parseShop();

	script.close();
	return true;
}

void Npc::reset()
{
	loaded = false;
	focusCreature = 0;
	conversationEndTime = 0;
	shopPlayerSet.clear();

	if (behaviourDatabase) {
		delete behaviourDatabase;
		behaviourDatabase = nullptr;
	}
}

void Npc::reload()
{
	loaded = false;

	reset();
	load();

	if (baseSpeed > 0) {
		addEventWalk();
	}
}

bool Npc::canSee(const Position& pos) const
{
	if (pos.z != getPosition().z) {
		return false;
	}
	return Creature::canSee(getPosition(), pos, 3, 3);
}

std::string Npc::getDescription(int32_t) const
{
	std::string descr;
	descr.reserve(name.length() + 1);
	descr.assign(name);
	descr.push_back('.');
	return descr;
}

void Npc::onCreatureAppear(Creature* creature, bool isLogin)
{
	Creature::onCreatureAppear(creature, isLogin);

	if (creature == this) {
		if (baseSpeed > 0) {
			addEventWalk();
		}
	} else if (Player* player = creature->getPlayer()) {
		spectators.insert(player);
		updateIdleStatus();
	}
}

void Npc::onRemoveCreature(Creature* creature, bool isLogout)
{
	Creature::onRemoveCreature(creature, isLogout);

	if (!behaviourDatabase) {
		return;
	}

	if (creature == this) {
		closeAllShopWindows();
	}

	Player* player = creature->getPlayer();
	if (player) {
		if (player->getID() == focusCreature) {
			behaviourDatabase->react(SITUATION_VANISH, player, "");
		}

		spectators.erase(player);
		updateIdleStatus();
	}
}

void Npc::onCreatureMove(Creature* creature, const Tile* newTile, const Position& newPos,
                         const Tile* oldTile, const Position& oldPos, bool teleport)
{
	Creature::onCreatureMove(creature, newTile, newPos, oldTile, oldPos, teleport);

	if (!behaviourDatabase) {
		return;
	}

	Player* player = creature->getPlayer();
	if (player && player->getID() == focusCreature) {
		if (!Position::areInRange<3, 3, 0>(creature->getPosition(), getPosition())) {
			behaviourDatabase->react(SITUATION_VANISH, player, "");
		}
	}

	if (creature != this) {
		if (player) {
			if (player->canSee(position)) {
				spectators.insert(player);
			} else {
				spectators.erase(player);
			}

			updateIdleStatus();
		}
	}
}

void Npc::onCreatureSay(Creature* creature, SpeakClasses type, const std::string& text)
{
	if (creature->getID() == id || type != TALKTYPE_SAY || !behaviourDatabase) {
		return;
	}

	Player* player = creature->getPlayer();
	if (player) {
		if (!Position::areInRange<3, 3>(creature->getPosition(), getPosition())) {
			return;
		}

		lastTalkCreature = creature->getID();

		if (focusCreature == 0) {
			behaviourDatabase->react(SITUATION_ADDRESS, player, text);
		} else if (focusCreature != player->getID()) {
			behaviourDatabase->react(SITUATION_BUSY, player, text);
		} else if (focusCreature == player->getID()) {
			if (text.find("trade") != std::string::npos && !cipShopList.empty()) {
				player->setShopOwner(this, 900000001, 900000002);
				player->openShopWindow(this, cipShopList);
				doSay("Of course, just browse through my wares.");
				return;
			}

			behaviourDatabase->react(SITUATION_NONE, player, text);
		}
	}
}

void Npc::addShopPlayer(Player* player)
{
	shopPlayerSet.insert(player);
}

void Npc::removeShopPlayer(Player* player)
{
	shopPlayerSet.erase(player);
}

void Npc::closeAllShopWindows()
{
	while (!shopPlayerSet.empty()) {
		Player* player = *shopPlayerSet.begin();
		if (!player->closeShopWindow()) {
			removeShopPlayer(player);
		}
	}
}

void Npc::onPlayerTrade(Player* player, int32_t callback, uint16_t itemId, int32_t count,
	uint8_t amount, bool ignore/* = false*/, bool inBackpacks/* = false*/)
{
	if (callback == 900000001) { // BUY
		ItemType& type = Item::items.getItemType(itemId);
		for (auto& it : cipShopList) {
			if (it.itemId == itemId && ((type.isFluidContainer() && getLiquidColor(it.subType) == count) || it.subType == count || type.isRune()) && it.buyPrice > 0) {
				if (it.buyPrice == 0) {
					doSay("This is an invalid sale on my part. Please report it to a gamemaster.");
					return;
				}

				const ItemType& itItem = Item::items.getItemType(itemId);

                uint64_t totalCost = amount * it.buyPrice;
                if (inBackpacks) {
                    totalCost = itItem.stackable ? totalCost + 20 : totalCost + (std::max(1, static_cast<int>(std::floor(amount / 20))) * 20);
                }

				if (player->getMoney() < totalCost) {
					doSay("You do not have enough money to buy this item.");
					return;
				}

				FILE* file = fopen("data/logs/shoplogs.log", "a");
				if (!file) {
					doSay("Contact a gamemaster. Your sale could not be arranged.");
					return;
				}

				const Position& playerPosition = player->getPosition();
				fprintf(file, "%s BUY (Item:%s,ID:%d,SubType:%d,Amount:%d,Price:%d)\n", player->getName().c_str(), itItem.name.c_str(), itemId, count, amount, totalCost);
				fclose(file);

				static constexpr int32_t MAX_STACK_SIZE = 100;

				if (itItem.charges) {
					count = itItem.charges;
				} else {
					count = it.subType;
				}

				int32_t b = 0;
				int32_t a = 0;

				if (itItem.stackable) {
                    Item* stuff;
                    if (inBackpacks) {
						b = 1;

                        stuff = Item::CreateItem(2854, 1);
                        stuff->getContainer()->addItem(Item::CreateItem(itemId, std::min<int32_t>(MAX_STACK_SIZE, amount)));
                    } else {
                        stuff = Item::CreateItem(itemId, std::min<int32_t>(MAX_STACK_SIZE, amount));
                    }

                    if (g_game.internalPlayerAddItem(player, stuff) != RETURNVALUE_NOERROR) {
						if (ignore)
                    		b = b - 1;
                    } else {
						a = amount;
                    }
				}
				else if (inBackpacks) {
					b = 1;

					Container* container = Item::CreateItem(2854, 1)->getContainer();

					for (int i = 1; i <= amount; i++) {
						container->addItem(Item::CreateItem(itemId, count));
						std::vector<int32_t> list = { (Item::items[2854].maxItems * b), amount };
						if (std::find(list.begin(), list.end(), i) != list.end()) {
							if (g_game.internalPlayerAddItem(player, container) != RETURNVALUE_NOERROR) {
								if (ignore)
									b = b - 1;
								break;
							}

							a = i;
							if (amount > i) {
								container = Item::CreateItem(2854, 1)->getContainer();
								b = b + 1;
							}
						}
					}
                } else {
                    for (int i = 1; i <= amount; i++) {
                        Item* item = Item::CreateItem(itemId, count);
                        if (g_game.internalPlayerAddItem(player, item) != RETURNVALUE_NOERROR) {
							if (ignore)
								b = b - 1;
                            break;
                        }
						a = i;
                    }
                }

				if (a < amount) {
					if (a == 0) {
						doSay("You do not have enough space to purchase all of these objects.");
						break;
					} else {
						doSay("You do not have enough space to purchase most objects.");
					}

					if (a > 0) {
						totalCost = a * (it.buyPrice + (b * 20));

						std::ostringstream ss;
						ss << "You have purchased " << static_cast<int32_t>(amount) << " " << itItem.name << (amount > 1 ? "s" : "") << " for " << totalCost << " gold.";
						player->sendTextMessage(MESSAGE_INFO_DESCR, ss.str());

						g_game.removeMoney(player, totalCost);
					}
				} else {
					totalCost = a * (it.buyPrice + (b * 20));

					std::ostringstream ss;
					ss << "You have purchased " << static_cast<int32_t>(amount) << " " << itItem.name << (amount > 1 ? "s" : "") << " for " << totalCost << " gold.";
					player->sendTextMessage(MESSAGE_INFO_DESCR, ss.str());

					g_game.removeMoney(player, totalCost);
				}
				break;
			}
		}
	}
	else if (callback == 900000002) { // SELL
		for (auto& it : cipShopList) {
			if (it.itemId == itemId && it.sellPrice > 0) {
				const ItemType& itemType = Item::items.getItemType(itemId);
				if (itemType.stackable || !itemType.hasSubType()) {
					count = -1;
				}

				if (player->getItemTypeCount(itemId, count) < amount) {
					doSay("You do not have the asked items.");
					return;
				}

				FILE* file = fopen("data/logs/shoplogs.log", "a");
				if (!file) {
					doSay("Contact a gamemaster. Your sale could not be arranged.");
					return;
				}

				const Position& playerPosition = player->getPosition();
				fprintf(file, "%s SELL (Item:%s,ID:%d,SubType:%d,Amount:%d,Price:%d)\n", player->getName().c_str(), itemType.name.c_str(), itemId, count, amount, (int)it.sellPrice * amount);
				fclose(file);

				if (!player->removeItemOfType(itemId, amount, count, true)) {
					player->removeItemOfType(itemId, amount, count, false);
				}

				g_game.addMoney(player, it.sellPrice * amount);

				std::ostringstream ss;
				ss << "You have sold " << static_cast<int32_t>(amount) << " " << itemType.name << (amount > 1 ? "s" : "") << " for " << it.sellPrice * amount << " gold.";
				player->sendTextMessage(MESSAGE_INFO_DESCR, ss.str());
				break;
			}
		}
	}

	player->sendSaleItemList();
}

void Npc::onPlayerEndTrade(Player* player, int32_t buyCallback, int32_t sellCallback)
{
	removeShopPlayer(player);
}

void Npc::onThink(uint32_t interval)
{
	Creature::onThink(interval);

	if (!isIdle && focusCreature == 0 && baseSpeed > 0 && getTimeSinceLastMove() >= 100 + getStepDuration()) {
		addEventWalk();
	}

	if (!behaviourDatabase) {
		return;
	}

	if (focusCreature) {
		Player* player = g_game.getPlayerByID(focusCreature);
		if (player) {
			turnToCreature(player);

			if (conversationEndTime != 0 && OTSYS_TIME() > conversationEndTime) {
				if (player) {
					behaviourDatabase->react(SITUATION_VANISH, player, "");
				}
			}
		}
	}
}

void Npc::doSay(const std::string& text)
{
	if (lastTalkCreature == focusCreature) {
		conversationEndTime = OTSYS_TIME() + 60000;
	}

	g_game.internalCreatureSay(this, TALKTYPE_SAY, text, false);
}

bool Npc::getNextStep(Direction& dir, uint32_t& flags)
{
	if (Creature::getNextStep(dir, flags)) {
		return true;
	}

	if (baseSpeed <= 0) {
		return false;
	}

	if (focusCreature != 0) {
		return false;
	}

	if (OTSYS_TIME() < staticMovementTime) {
		return false;
	}

	if (getTimeSinceLastMove() < 100 + getStepDuration() + getStepSpeed()) {
		return false;
	}

	return getRandomStep(dir);
}

void Npc::setIdle(bool idle)
{
	if (isRemoved() || getHealth() <= 0) {
		return;
	}

	isIdle = idle;

	if (isIdle) {
		onIdleStatus();
	}
}

void Npc::updateIdleStatus()
{
	bool status = spectators.empty();
	if (status != isIdle) {
		setIdle(status);
	}
}

bool Npc::canWalkTo(const Position& fromPos, Direction dir) const
{
	if (masterRadius == 0) {
		return false;
	}

	Position toPos = getNextPosition(dir, fromPos);
	if (!Spawns::isInZone(masterPos, masterRadius, toPos)) {
		return false;
	}

	Tile* tile = g_game.map.getTile(toPos);
	if (!tile || tile->queryAdd(0, *this, 1, 0) != RETURNVALUE_NOERROR) {
		return false;
	}

	if (tile->hasFlag(TILESTATE_BLOCKPATH)) {
		return false;
	}

	if (tile->hasHeight(1)) {
		return false;
	}

	return true;
}

bool Npc::getRandomStep(Direction& dir) const
{
	std::vector<Direction> dirList;
	const Position& creaturePos = getPosition();

	if (canWalkTo(creaturePos, DIRECTION_NORTH)) {
		dirList.push_back(DIRECTION_NORTH);
	}

	if (canWalkTo(creaturePos, DIRECTION_SOUTH)) {
		dirList.push_back(DIRECTION_SOUTH);
	}

	if (canWalkTo(creaturePos, DIRECTION_EAST)) {
		dirList.push_back(DIRECTION_EAST);
	}

	if (canWalkTo(creaturePos, DIRECTION_WEST)) {
		dirList.push_back(DIRECTION_WEST);
	}

	if (dirList.empty()) {
		return false;
	}

	dir = dirList[uniform_random(0, dirList.size() - 1)];
	return true;
}

void Npc::doMoveTo(const Position& target)
{
	std::forward_list<Direction> listDir;
	if (getPathTo(target, listDir, 1, 1, true, true)) {
		startAutoWalk(listDir);
	}
}

void Npc::turnToCreature(Creature* creature)
{
	const Position& creaturePos = creature->getPosition();
	const Position& myPos = getPosition();
	const auto dx = Position::getOffsetX(myPos, creaturePos);
	const auto dy = Position::getOffsetY(myPos, creaturePos);

	float tan;
	if (dx != 0) {
		tan = static_cast<float>(dy) / dx;
	} else {
		tan = 10;
	}

	Direction dir;
	if (std::abs(tan) < 1) {
		if (dx > 0) {
			dir = DIRECTION_WEST;
		} else {
			dir = DIRECTION_EAST;
		}
	} else {
		if (dy > 0) {
			dir = DIRECTION_NORTH;
		} else {
			dir = DIRECTION_SOUTH;
		}
	}
	g_game.internalCreatureTurn(this, dir);
}

void Npc::setCreatureFocus(Creature* creature)
{
	if (creature) {
		focusCreature = creature->getID();
		turnToCreature(creature);
	} else {
		focusCreature = 0;
	}
}