-- SpellCreator generated.

-- =============== COMBAT VARS ===============
-- Areas/Combat for 200ms
local combat2_fire_demage_ml = createCombatObject()
setCombatParam(combat2_fire_demage_ml, COMBAT_PARAM_EFFECT, CONST_ME_HOLYDAMAGE)
setCombatParam(combat2_fire_demage_ml, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
setCombatArea(combat2_fire_demage_ml,createCombatArea({{0, 0, 0, 0, 1, 1, 1},
{0, 0, 0, 0, 0, 1, 1},
{0, 0, 0, 0, 1, 0, 1},
{0, 0, 0, 2, 0, 0, 0},
{1, 0, 1, 0, 0, 0, 0},
{1, 1, 0, 0, 0, 0, 0},
{1, 1, 1, 0, 0, 0, 0}}))
setCombatFormula(combat2_fire_demage_ml, COMBAT_FORMULA_SKILL, 5, 10, 5, 10)

-- Areas/Combat for 0ms
local combat0_fire_demage_ml = createCombatObject()
setCombatParam(combat0_fire_demage_ml, COMBAT_PARAM_EFFECT, CONST_ME_HOLYDAMAGE)
setCombatParam(combat0_fire_demage_ml, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
setCombatArea(combat0_fire_demage_ml,createCombatArea({{1, 0, 0, 0, 0},
{0, 1, 1, 0, 0},
{0, 1, 2, 1, 0},
{0, 0, 1, 1, 0},
{0, 0, 0, 0, 1}}))
setCombatFormula(combat0_fire_demage_ml, COMBAT_FORMULA_SKILL, 5, 10, 5, 10)

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
	addEvent(RunPart,200,combat2_fire_demage_ml,cid,var)
	RunPart(combat0_fire_demage_ml,cid,var)
	return true
end