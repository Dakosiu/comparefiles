-- SpellCreator generated.

-- =============== COMBAT VARS ===============
-- Areas/Combat for 0ms
local combat0_effectfiredemage = createCombatObject()
setCombatParam(combat0_effectfiredemage, COMBAT_PARAM_EFFECT, CONST_ME_FIREWORK_RED)
setCombatParam(combat0_effectfiredemage, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
setCombatArea(combat0_effectfiredemage,createCombatArea({{1, 0, 1},
{0, 2, 0},
{1, 0, 1}}))
setCombatFormula(combat0_effectfiredemage, COMBAT_FORMULA_SKILL, 5, 10, 5, 10)
local dfcombat0_effectfiredemage = {CONST_ANI_FIRE,1,1,-1,1,1,-1,-1,-1}

-- Areas/Combat for 300ms
local combat3_firearea = createCombatObject()
setCombatParam(combat3_firearea, COMBAT_PARAM_EFFECT, CONST_ME_FIREAREA)
setCombatParam(combat3_firearea, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
setCombatArea(combat3_firearea,createCombatArea({{0, 0, 1, 0, 0},
{0, 0, 1, 0, 0},
{1, 1, 2, 1, 1},
{0, 0, 1, 0, 0},
{0, 0, 1, 0, 0}}))
setCombatFormula(combat3_firearea, COMBAT_FORMULA_SKILL, 5, 10, 5, 10)

-- =============== CORE FUNCTIONS ===============
local function RunPart(c,cid,var,dirList,dirEmitPos) -- Part
	if (isCreature(cid)) then
		doCombat(cid, c, var)
		if (dirList ~= nil) then -- Emit distance effects
			local i = 2;
			while (i < #dirList) do
				doSendDistanceShoot(dirEmitPos,{x=dirEmitPos.x-dirList[i],y=dirEmitPos.y-dirList[i+1],z=dirEmitPos.z},dirList[1])
				i = i + 2
			end		
		end
	end
end

function onCastSpell(creature, var)
   local cid = creature:getId()
	local startPos = getCreaturePosition(cid)
	RunPart(combat0_effectfiredemage,cid,var,dfcombat0_effectfiredemage,startPos)
	addEvent(RunPart,300,combat3_firearea,cid,var)
	return true
end