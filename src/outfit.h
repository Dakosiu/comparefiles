// Copyright 2022 The Forgotten Server Authors. All rights reserved.
// Use of this source code is governed by the GPL-2.0 License that can be found in the LICENSE file.

#ifndef FS_OUTFIT_H_C56E7A707E3F422C8C93D9BE09916AA3
#define FS_OUTFIT_H_C56E7A707E3F422C8C93D9BE09916AA3

#include "enums.h"

struct Outfit {
	Outfit(std::string name, uint16_t lookType, bool premium, bool unlocked, uint16_t addon1, uint16_t addon2, uint16_t addon3, uint16_t basicAttack) :
		name(std::move(name)), lookType(lookType), premium(premium), unlocked(unlocked), addon1(addon1), addon2(addon2), addon3(addon3), basicAttack(basicAttack) {}

	bool operator==(const Outfit& otherOutfit) const
	{
		return name == otherOutfit.name && lookType == otherOutfit.lookType && premium == otherOutfit.premium && unlocked == otherOutfit.unlocked;
	}

	std::string name;
	uint16_t lookType;
	bool premium;
	bool unlocked;
	uint16_t addon1;
	uint16_t addon2;
	uint16_t addon3;
	uint16_t basicAttack;
};

struct ProtocolOutfit {
	ProtocolOutfit(const std::string& name, uint16_t lookType, uint8_t addons, uint16_t addon1, uint16_t addon2, uint16_t addon3) :
		name(name), lookType(lookType), addons(addons), addon1(addon1), addon2(addon2), addon3(addon3) {}

	const std::string& name;
	uint16_t lookType;
	uint8_t addons;
	uint16_t addon1;
	uint16_t addon2;
	uint16_t addon3;
};

class Outfits
{
	public:
		static Outfits& getInstance() {
			static Outfits instance;
			return instance;
		}

		bool loadFromXml();

		const Outfit* getOutfitByLookType(uint16_t vocationId, uint16_t lookType) const;
		const Outfit* getOutfitByLookType(uint16_t lookType) const;
		const Outfit* getOutfitByAddon(uint16_t vocationId, uint16_t lookType) const;
		const std::vector<Outfit>& getOutfits(uint16_t vocationId) const {
			return outfits[vocationId];
		}

	private:
		std::vector<Outfit> outfits[4 + 1];
};

#endif
