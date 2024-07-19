MONSTER_STORAGE = MONSTER_STORAGE or {}

function Monster.setStorageValue(self, key, value)
    local cid = self:getId()
    
    if not cid then
        return
    end
    
    if type(key) ~= "string" and type(key) ~= "number" then
        error("Key must be a string or a number")
    end

    local storageMap = MONSTER_STORAGE[cid]
    if not storageMap then
        MONSTER_STORAGE[cid] = {[key] = value}
        return
    end

    storageMap[key] = value
end

function Monster.getStorageValue(self, key)
    local cid = self:getId()
    
    if not cid then
        return -1
    end
    
    if type(key) ~= "string" and type(key) ~= "number" then
        error("Key must be a string or a number")
    end

    local storageMap = MONSTER_STORAGE[cid]
    if not storageMap then
        return -1
    end

    return storageMap[key] or -1
end

function Monster.getStorage(self, key)
	return self:getStorageValue(key)
end

function Monster.setStorage(self, key, value)
	return self:setStorageValue(key, value)
end

if not hpCompartilhada then
	hpCompartilhada = {[0] = {hp = 0, monsters = {}}}
end

function Monster.beginSharedLife(self, hpid)
	if not self:isMonster() then
		return false
	end
	if not hpCompartilhada[hpid] then
		hpCompartilhada[hpid] = {hp = self:getMaxHealth(), monsters = {}}
	end
	table.insert(hpCompartilhada[hpid].monsters, self:getId())
	self:setStorageValue("shared_storage", hpid)
end

function Monster.inSharedLife(self)
	if not self:isMonster() then
		return false
	end
	local storage = self:getStorageValue("shared_storage")
	if storage < 1 then
		return false
	end
	for id, pid in pairs(hpCompartilhada) do
		if(storage == id) then
			for _id, mid in pairs(pid.monsters) do
				local mtemp = Monster(mid)
				if(mtemp and mtemp:getId() == self:getId())then
					return true
				end
			end
		end
	end
	return false
end

function updateMonstersSharedLife(hpid, amount, orign, _type, kill)
	if not hpCompartilhada[hpid] then
		return false
	end
	if(_type == "healing") then
		hpCompartilhada[hpid].hp = hpCompartilhada[hpid].hp + amount
	else
		hpCompartilhada[hpid].hp = hpCompartilhada[hpid].hp - amount
	end
	if(hpCompartilhada[hpid].hp < 0)then
		hpCompartilhada[hpid].hp = 0
	end
	for _, monster in pairs(hpCompartilhada[hpid].monsters)do
		local mt = Monster(monster)
		if mt and mt:getId() ~= orign then
			if kill then
				mt:addHealth(-mt:getHealth())
			else
				mt:setHealth(hpCompartilhada[hpid].hp)
			end
		end
	end
	return true
end

function Monster.onReceivDamageSL(self, damage, tp, killer)
	if not self:inSharedLife() then
		return true
	end
	local storage = self:getStorageValue("shared_storage")
	if storage < 1 then
		return false
	end
	updateMonstersSharedLife(storage, damage, self:getId(), tp, killer)
	return true
end

function Monster.setFiendish(self, position, player)
	if not self then
		player:sendCancelMessage("Only allowed monsters can be fiendish.")
		return false
	end

	local monsterType = self:getType()
	local fiendishMonster = Monster(ForgeMonster:pickFiendish())
	if monsterType then
		if not monsterType:isForgeCreature() then
			player:sendCancelMessage("Only allowed monsters can be fiendish.")
			return false
		end
	end
	if fiendishMonster and fiendishMonster:getId() == self:getId() then
		player:sendCancelMessage("This monster is already fiendish.")
		return false
	end
	position:sendMagicEffect(CONST_ME_MAGIC_RED)
	self:clearFiendishStatus()
	local success
	if fiendishMonster then
		Game.removeFiendishMonster(fiendishMonster:getId())
	end
	if Game.makeFiendishMonster(self:getId(), true) ~= 0 then
		success = "set sucessfully a new fiendish monster"
	else
		success = "have error to set fiendish monster"
		player:sendCancelMessage("This monster is not forgeable, fiendish not added.")
	end

	Spdlog.info(string.format("Player %s %s with name %s and id %d on position [x = %d, y = %d, z = %d]", player:getName(), success, self:getName(), self:getId(), self:getPosition().x, self:getPosition().y, self:getPosition().z))
	return true
end
