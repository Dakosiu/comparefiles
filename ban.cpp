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

#include "ban.h"
#include "database.h"
#include "databasetasks.h"
#include "tools.h"

bool Ban::acceptConnection(uint32_t clientip)
{
	/*
	 * With haproxy, IP of client is known after establishing TCP connection.
	 * In moment of connection (acceptConnection), each client has IP 127.0.0.1,
	 * so we cannot limit number of connections per IP here.
	 *
	 * Anyway, use iptables (on haproxy servers) to limit number of connections per IP, it's much more efficient.
	 */
	return true;
}

bool IOBan::isAccountBanned(uint32_t accountId, BanInfo& banInfo)
{
	Database* db = Database::getInstance();

	std::ostringstream query;
	query << "SELECT `reason`, `expires_at`, `banned_at`, `banned_by`, (SELECT `name` FROM `players` WHERE `id` = `banned_by`) AS `name` FROM `account_bans` WHERE `account_id` = " << accountId;

	DBResult_ptr result = db->storeQuery(query.str());
	if (!result) {
		return false;
	}

	int64_t expiresAt = result->getNumber<int64_t>("expires_at");
	if (expiresAt != 0 && time(nullptr) > expiresAt) {
		// Move the ban to history if it has expired
		query.str(std::string());
		query << "INSERT INTO `account_ban_history` (`account_id`, `reason`, `banned_at`, `expired_at`, `banned_by`) VALUES (" << accountId << ',' << db->escapeString(result->getString("reason")) << ',' << result->getNumber<time_t>("banned_at") << ',' << expiresAt << ',' << result->getNumber<uint32_t>("banned_by") << ')';
		g_databaseTasks.addTask(query.str());

		query.str(std::string());
		query << "DELETE FROM `account_bans` WHERE `account_id` = " << accountId;
		g_databaseTasks.addTask(query.str());
		return false;
	}

	banInfo.expiresAt = expiresAt;
	banInfo.reason = result->getString("reason");
	banInfo.bannedBy = result->getString("name");
	return true;
}

bool IOBan::isIpBanned(uint32_t clientip, BanInfo& banInfo)
{
	if (clientip == 0) {
		return false;
	}

	Database* db = Database::getInstance();

	std::ostringstream query;
	query << "SELECT `reason`, `expires_at`, (SELECT `name` FROM `players` WHERE `id` = `banned_by`) AS `name` FROM `ip_bans` WHERE `ip` = " << clientip;

	DBResult_ptr result = db->storeQuery(query.str());
	if (!result) {
		return false;
	}

	int64_t expiresAt = result->getNumber<int64_t>("expires_at");
	if (expiresAt != 0 && time(nullptr) > expiresAt) {
		query.str(std::string());
		query << "DELETE FROM `ip_bans` WHERE `ip` = " << clientip;
		g_databaseTasks.addTask(query.str());
		return false;
	}

	banInfo.expiresAt = expiresAt;
	banInfo.reason = result->getString("reason");
	banInfo.bannedBy = result->getString("name");
	return true;
}

bool IOBan::isPlayerNamelocked(uint32_t playerId)
{
	std::ostringstream query;
	query << "SELECT 1 FROM `player_namelocks` WHERE `player_id` = " << playerId;
	return Database::getInstance()->storeQuery(query.str()).get() != nullptr;
}
