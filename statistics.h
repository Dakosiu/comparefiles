#pragma once

#include "luascript.h"

enum StatisticAttribute_t {
	ATTRIBUTE_HEALTH = 1,
	ATTRIBUTE_FIRST = ATTRIBUTE_HEALTH,
	ATTRIBUTE_MANA = 2,
	ATTRIBUTE_CAP = 3,
	ATTRIBUTE_MELEE_SKILLS = 4,
	ATTRIBUTE_MAGIC_LEVEL = 5,
	ATTRIBUTE_DISTANCE_SKILL = 6,
	ATTRIBUTE_SHIELD_SKILL = 7,
	ATTRIBUTE_MOVEMENT_SPEED = 8,
	ATTRIBUTE_ATTACK_SPEED = 9,
	ATTRIBUTE_MAGIC_DAMAGE = 10,
	ATTRIBUTE_CRITICAL_DAMAGE = 11,
	ATTRIBUTE_CRITICAL_CHANCE = 12,
	ATTRIBUTE_PHYSICAL_DAMAGE = 13,
	ATTRIBUTE_LAST = ATTRIBUTE_PHYSICAL_DAMAGE
};

struct StatisticLevelPoints {
	uint32_t fromLevel = 0;
	uint32_t toLevel = 0;
	uint16_t points = 0;
};

struct StatisticSkills {
	uint16_t getValue(StatisticAttribute_t id) const {
		const auto& it = skills.find(id);
		if (it == skills.end()) {
			return 0;
		}
		return it->second;
	}
	
	double getValuePercent(StatisticAttribute_t id) const {
		const auto& it = skills.find(id);
		if (it == skills.end()) {
			return 0;
		}
		return it->second;
	}

	uint16_t getHealth() const {
		return getValue(ATTRIBUTE_HEALTH);
	}
	uint16_t getMana() const {
		return getValue(ATTRIBUTE_MANA);
	}
	uint16_t getCapacity() const {
		return getValue(ATTRIBUTE_CAP);
	}
	uint16_t getMeleeSkill() const {
		return getValue(ATTRIBUTE_MELEE_SKILLS);
	}
	uint16_t getMagicLevel() const {
		return getValue(ATTRIBUTE_MAGIC_LEVEL);
	}
	uint16_t getDistanceSkill() const {
		return getValue(ATTRIBUTE_DISTANCE_SKILL);
	}
	uint16_t getShieldSkill() const {
		return getValue(ATTRIBUTE_SHIELD_SKILL);
	}
	uint16_t getSpeed() const {
		return getValue(ATTRIBUTE_MOVEMENT_SPEED);
	}
	uint16_t getAttackSpeed() const {
		return getValue(ATTRIBUTE_ATTACK_SPEED);
	}
	
	double getCriticalDamage() const {
		return getValuePercent(ATTRIBUTE_CRITICAL_DAMAGE);
	}
	
	double getCriticalChance() const {
		return getValuePercent(ATTRIBUTE_CRITICAL_CHANCE);
	}
	
	double getSpellDamage() const {
		return getValuePercent(ATTRIBUTE_MAGIC_DAMAGE);
	}

	std::map<StatisticAttribute_t, double> skills;
};

class PlayerStatistics
{
	public:
		static PlayerStatistics& getInstance()
		{
			static PlayerStatistics instance;
			return instance;
		}

		bool load();

		const StatisticSkills& getStatisticsBySkillId(const Statistics_t statisticId) const;

		const std::vector<StatisticLevelPoints>& getLevels() const { return m_levels; }
		
	private:
		void registerEnum(lua_State* L, const char* name, lua_Number value);
		
		std::vector<StatisticLevelPoints> m_levels;
		std::map<Statistics_t, StatisticSkills> m_skills;
};
