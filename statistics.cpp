#include "otpch.h"
#include "statistics.h"

#define REGISTER_ENUM(L, e) registerEnum(L, #e, e)

void PlayerStatistics::registerEnum(lua_State* L, const char* name, lua_Number value)
{
	std::string enumName = name;
	lua_pushnumber(L, value);
	lua_setglobal(L, enumName.substr(enumName.find_last_of(':') + 1).c_str());
}

bool PlayerStatistics::load()
{
	lua_State* L = luaL_newstate();
	if (!L) {
		throw std::runtime_error("Failed to allocate memory in PlayerStatistics");
	}

	luaL_openlibs(L);

	REGISTER_ENUM(L, STATISTIC_STRENGTH);
	REGISTER_ENUM(L, STATISTIC_MAGIC);
	REGISTER_ENUM(L, STATISTIC_DEXTERITY);
	REGISTER_ENUM(L, STATISTIC_DEFENCE);
	REGISTER_ENUM(L, STATISTIC_ENDURANCE);
	REGISTER_ENUM(L, STATISTIC_MAGICDAMAGE);
    REGISTER_ENUM(L, STATISTIC_PHYSICALDAMAGE);
	
	
	if (luaL_dofile(L, "data/LUA/statistics.lua")) {
		std::cout << "[Error - PlayerStatistics] " << lua_tostring(L, -1) << std::endl;
		lua_close(L);
		return false;
	}

	lua_getglobal(L, "STATISTICS_LEVEL_POINTS");
	for (uint16_t i = 1; ; i++) {
		lua_rawgeti(L, -1, i);
		if (lua_isnil(L, -1)) {
			lua_pop(L, 1);
			break;
		}

		StatisticLevelPoints statisticLevelPoints;
		lua_getfield(L, -1, "points");
		if (!lua_isnumber(L, -1)) {
			std::cout << "[Warning - PlayerStatistics::loadModifiers] Missing points property." << std::endl;
			return false;
		}
		statisticLevelPoints.points = lua_tonumber(L, -1);
		lua_pop(L, 1);

		lua_getfield(L, -1, "fromLevel");
		if (!lua_isnumber(L, -1)) {
			std::cout << "[Warning - PlayerStatistics::loadModifiers] Missing fromId property." << std::endl;
			return false;
		}

		statisticLevelPoints.fromLevel = lua_tonumber(L, -1);
		lua_pop(L, 1);

		lua_getfield(L, -1, "toLevel");
		if (lua_isnumber(L, -1)) {
			statisticLevelPoints.toLevel = lua_tonumber(L, -1);
		}
		lua_pop(L, 1);

		m_levels.push_back(statisticLevelPoints);
		lua_pop(L, 1);
	}

	lua_getglobal(L, "STATISTICS_SKILLS");
	for (uint16_t i = 1; ; i++) {
		lua_rawgeti(L, -1, i);
		if (lua_isnil(L, -1)) {
			lua_pop(L, 1);
			break;
		}

		lua_getfield(L, -1, "id");
		if (!lua_isnumber(L, -1)) {
			std::cout << "[Warning - PlayerStatistics::loadModifiers] Missing id property." << std::endl;
			return false;
		}

		const static std::map<const char*, StatisticAttribute_t> m_StatisticAttributes = {
			{"mana", ATTRIBUTE_MANA},
			{"health", ATTRIBUTE_HEALTH},
			{"capacity", ATTRIBUTE_CAP},
			{"meleeSkill", ATTRIBUTE_MELEE_SKILLS},
			{"magicLevel", ATTRIBUTE_MAGIC_LEVEL},
			{"distanceSkill", ATTRIBUTE_DISTANCE_SKILL},
			{"shieldSkill", ATTRIBUTE_SHIELD_SKILL},
			{"speed", ATTRIBUTE_MOVEMENT_SPEED},
			{"attackSpeed", ATTRIBUTE_ATTACK_SPEED},
			{"magicDamage", ATTRIBUTE_MAGIC_DAMAGE},
			{"criticalDamage", ATTRIBUTE_CRITICAL_DAMAGE},
			{"criticalChance", ATTRIBUTE_CRITICAL_CHANCE},
			{"physicalDamage", ATTRIBUTE_PHYSICAL_DAMAGE},
		};

		Statistics_t id = static_cast<Statistics_t>(lua_tonumber(L, -1));
		StatisticSkills statisticSkills;
		lua_pop(L, 1);

		for (auto& [stringNode, statisticId] : m_StatisticAttributes) {
			lua_getfield(L, -1, stringNode);
			if (lua_isnumber(L, -1)) {
				//std::cout << "Value: " << lua_tonumber(L, -1) << std::endl;
				statisticSkills.skills.emplace(statisticId, lua_tonumber(L, -1));
			}
			lua_pop(L, 1);
		}

		m_skills.emplace(id, statisticSkills);
		lua_pop(L, 1);
	}

	lua_close(L);
	return true;
}

const StatisticSkills& PlayerStatistics::getStatisticsBySkillId(const Statistics_t statisticId) const
{
	const auto itStatistic = m_skills.find(statisticId);
	if (itStatistic == m_skills.end()) {
		const static StatisticSkills m_defaultStatisticSkills;
		return m_defaultStatisticSkills;
	}

	return itStatistic->second;
}
