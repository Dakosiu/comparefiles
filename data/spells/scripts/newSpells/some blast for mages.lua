-- SpellCreator generated.

-- =============== COMBAT VARS ===============
-- Areas/Combat for 300ms
local combat3_fire_demage_ml = createCombatObject()
setCombatParam(combat3_fire_demage_ml, COMBAT_PARAM_EFFECT, CONST_ME_HOLYDAMAGE)
setCombatParam(combat3_fire_demage_ml, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
setCombatArea(combat3_fire_demage_ml,createCombatArea({{0, 1, 0, 0, 0, 0, 0, 1, 0},
{1, 0, 1, 0, 1, 0, 1, 0, 1},
{0, 1, 0, 1, 1, 1, 0, 1, 0},
{0, 0, 1, 1, 2, 1, 1, 0, 0},
{0, 0, 1, 1, 1, 1, 1, 0, 0},
{0, 1, 0, 1, 1, 1, 0, 1, 0},
{1, 0, 1, 0, 1, 0, 1, 0, 1},
{0, 1, 0, 0, 0, 0, 0, 1, 0}}))
setCombatFormula(combat3_fire_demage_ml, COMBAT_FORMULA_SKILL, 5, 10, 5, 10)

-- Areas/Combat for 100ms
local combat1_fire_test = createCombatObject()
setCombatParam(combat1_fire_test, COMBAT_PARAM_EFFECT, CONST_ME_HITBYFIRE)
setCombatParam(combat1_fire_test, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
setCombatArea(combat1_fire_test,createCombatArea({{1, 0, 0, 0, 1},
{0, 0, 2, 0, 0},
{0, 0, 0, 0, 0},
{1, 0, 0, 0, 1}}))
setCombatFormula(combat1_fire_test, COMBAT_FORMULA_LEVELMAGIC, 5, 10, 5, 10)
local dfcombat1_fire_test = {CONST_ANI_FIRE,2,-1,-2,-1,-2,2,2,2}

-- Areas/Combat for 0ms
local combat0_fire_test = createCombatObject()
setCombatParam(combat0_fire_test, COMBAT_PARAM_EFFECT, CONST_ME_HITBYFIRE)
setCombatParam(combat0_fire_test, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
setCombatArea(combat0_fire_test,createCombatArea({{1, 0, 0, 0, 0, 0, 1},
{0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 2, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0},
{1, 0, 0, 0, 0, 0, 1}}))
setCombatFormula(combat0_fire_test, COMBAT_FORMULA_LEVELMAGIC, 5, 10, 5, 10)
local dfcombat0_fire_test = {CONST_ANI_FIRE,3,3,-3,3,-3,-2,3,-2}

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
	addEvent(RunPart,300,combat3_fire_demage_ml,cid,var)
	addEvent(RunPart,100,combat1_fire_test,cid,var,dfcombat1_fire_test,startPos)
	RunPart(combat0_fire_test,cid,var,dfcombat0_fire_test,startPos)
	return true
end