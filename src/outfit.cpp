// Copyright 2022 The Forgotten Server Authors. All rights reserved.
// Use of this source code is governed by the GPL-2.0 License that can be found in the LICENSE file.

#include "otpch.h"

#include "outfit.h"

#include "pugicast.h"
#include "tools.h"

bool Outfits::loadFromXml()
{
	pugi::xml_document doc;
	pugi::xml_parse_result result = doc.load_file("data/XML/outfits.xml");
	if (!result) {
		printXMLError("Error - Outfits::loadFromXml", "data/XML/outfits.xml", result);
		return false;
	}

	for (auto outfitNode : doc.child("outfits").children()) {
		pugi::xml_attribute attr;
		if ((attr = outfitNode.attribute("enabled")) && !attr.as_bool()) {
			continue;
		}

		if (!(attr = outfitNode.attribute("vocationId"))) {
			std::cout << "[Warning - Outfits::loadFromXml] Missing outfit vocation id." << std::endl;
			continue;
		}

		uint16_t vocationId = pugi::cast<uint16_t>(attr.value());
		if (vocationId > 4) {
			std::cout << "[Warning - Outfits::loadFromXml] Invalid outfit vocation id: " << vocationId << "." << std::endl;
			continue;
		}

		pugi::xml_attribute lookTypeAttribute = outfitNode.attribute("looktype");
		if (!lookTypeAttribute) {
			std::cout << "[Warning - Outfits::loadFromXml] Missing looktype on outfit." << std::endl;
			continue;
		}
        
		uint16_t addon1 = 0;
		uint16_t addon2 = 0;
		uint16_t addon3 = 0;
		uint16_t basicAttack = 0;
		
		pugi::xml_attribute xmlAddon1 = outfitNode.attribute("addon1");
		if (xmlAddon1) {
			addon1 = pugi::cast<uint16_t>(xmlAddon1.value());
		}
		
		pugi::xml_attribute xmlAddon2 = outfitNode.attribute("addon2");
		if (xmlAddon2) {
			addon2 = pugi::cast<uint16_t>(xmlAddon2.value());
		}	

		pugi::xml_attribute xmlAddon3 = outfitNode.attribute("addon3");
		if (xmlAddon3) {
			addon3 = pugi::cast<uint16_t>(xmlAddon3.value());
		}			

		pugi::xml_attribute xmlBasicAttack = outfitNode.attribute("basicattack");
		if (xmlBasicAttack) {
			basicAttack = pugi::cast<uint16_t>(xmlBasicAttack.value());
		}		
		
		outfits[vocationId].emplace_back(
			outfitNode.attribute("name").as_string(),
			pugi::cast<uint16_t>(lookTypeAttribute.value()),
			outfitNode.attribute("premium").as_bool(),
			outfitNode.attribute("unlocked").as_bool(true),
			addon1,
			addon2,
			addon3,
			basicAttack
		);
	}
	return true;
}

const Outfit* Outfits::getOutfitByLookType(uint16_t vocationId, uint16_t lookType) const
{
	for (const Outfit& outfit : outfits[vocationId]) {
		if (outfit.lookType == lookType) {
			return &outfit;
		}
	}
	return nullptr;
}

const Outfit* Outfits::getOutfitByAddon(uint16_t vocationId, uint16_t lookType) const
{
	for (const Outfit& outfit : outfits[vocationId]) {
		if ((outfit.addon1 == lookType) || (outfit.addon2 == lookType) || (outfit.addon3 == lookType)) {
			return &outfit;
		}
	}
	return nullptr;
}

const Outfit* Outfits::getOutfitByLookType(uint16_t lookType) const
{
	for (uint8_t vocationId = 1; vocationId <= 4; vocationId++) {
		for (const Outfit& outfit : outfits[vocationId]) {
			if (outfit.lookType == lookType) {
				return &outfit;
			}
		}
	}
	return nullptr;
}
