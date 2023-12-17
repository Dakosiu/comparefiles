-- SpellCreator generated.

-- =============== COMBAT VARS ===============
-- Areas/Combat for 800ms
local combat8_fire_demage_ml = createCombatObject()
setCombatParam(combat8_fire_demage_ml, COMBAT_PARAM_EFFECT, CONST_ME_HOLYDAMAGE)
setCombatParam(combat8_fire_demage_ml, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
setCombatArea(combat8_fire_demage_ml,createCombatArea({{2, 0, 0},
{0, 1, 0},
{0, 0, 1}}))
setCombatFormula(combat8_fire_demage_ml, COMBAT_FORMULA_SKILL, 5, 10, 5, 10)

-- Areas/Combat for 700ms
local combat7_distance_2 = createCombatObject()
setCombatParam(combat7_distance_2, COMBAT_PARAM_EFFECT, CONST_ME_POFF)
setCombatParam(combat7_distance_2, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatArea(combat7_distance_2,createCombatArea({{2, 0, 0},
{0, 1, 0},
{0, 0, 1}}))
setCombatFormula(combat7_distance_2, COMBAT_FORMULA_SKILL, 5, 10, 5, 10)
local dfcombat7_distance_2 = {CONST_ANI_THROWINGSTAR,1,1,2,2}local combat7_fire_demage_ml = createCombatObject()
setCombatParam(combat7_fire_demage_ml, COMBAT_PARAM_EFFECT, CONST_ME_HOLYDAMAGE)
setCombatParam(combat7_fire_demage_ml, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
setCombatArea(combat7_fire_demage_ml,createCombatArea({{2, 1, 1}}))
setCombatFormula(combat7_fire_demage_ml, COMBAT_FORMULA_SKILL, 5, 10, 5, 10)

-- Areas/Combat for 600ms
local combat6_distance_2 = createCombatObject()
setCombatParam(combat6_distance_2, COMBAT_PARAM_EFFECT, CONST_ME_POFF)
setCombatParam(combat6_distance_2, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatArea(combat6_distance_2,createCombatArea({{2, 1, 1}}))
setCombatFormula(combat6_distance_2, COMBAT_FORMULA_SKILL, 5, 10, 5, 10)
local dfcombat6_distance_2 = {CONST_ANI_THROWINGSTAR,1,0,2,0}local combat6_fire_demage_ml = createCombatObject()
setCombatParam(combat6_fire_demage_ml, COMBAT_PARAM_EFFECT, CONST_ME_HOLYDAMAGE)
setCombatParam(combat6_fire_demage_ml, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
setCombatArea(combat6_fire_demage_ml,createCombatArea({{0, 0, 1},
{0, 1, 0},
{2, 0, 0}}))
setCombatFormula(combat6_fire_demage_ml, COMBAT_FORMULA_SKILL, 5, 10, 5, 10)

-- Areas/Combat for 500ms
local combat5_distance_2 = createCombatObject()
setCombatParam(combat5_distance_2, COMBAT_PARAM_EFFECT, CONST_ME_POFF)
setCombatParam(combat5_distance_2, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatArea(combat5_distance_2,createCombatArea({{0, 0, 1},
{0, 1, 0},
{2, 0, 0}}))
setCombatFormula(combat5_distance_2, COMBAT_FORMULA_SKILL, 5, 10, 5, 10)
local dfcombat5_distance_2 = {CONST_ANI_THROWINGSTAR,1,-1,2,-2}local combat5_fire_demage_ml = createCombatObject()
setCombatParam(combat5_fire_demage_ml, COMBAT_PARAM_EFFECT, CONST_ME_HOLYDAMAGE)
setCombatParam(combat5_fire_demage_ml, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
setCombatArea(combat5_fire_demage_ml,createCombatArea({{1},
{1},
{2}}))
setCombatFormula(combat5_fire_demage_ml, COMBAT_FORMULA_SKILL, 5, 10, 5, 10)

-- Areas/Combat for 400ms
local combat4_distance_2 = createCombatObject()
setCombatParam(combat4_distance_2, COMBAT_PARAM_EFFECT, CONST_ME_POFF)
setCombatParam(combat4_distance_2, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatArea(combat4_distance_2,createCombatArea({{1},
{1},
{2}}))
setCombatFormula(combat4_distance_2, COMBAT_FORMULA_SKILL, 5, 10, 5, 10)
local dfcombat4_distance_2 = {CONST_ANI_THROWINGSTAR,0,-1,0,-2}local combat4_fire_demage_ml = createCombatObject()
setCombatParam(combat4_fire_demage_ml, COMBAT_PARAM_EFFECT, CONST_ME_HOLYDAMAGE)
setCombatParam(combat4_fire_demage_ml, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
setCombatArea(combat4_fire_demage_ml,createCombatArea({{1, 0, 0},
{0, 1, 0},
{0, 0, 2}}))
setCombatFormula(combat4_fire_demage_ml, COMBAT_FORMULA_SKILL, 5, 10, 5, 10)

-- Areas/Combat for 300ms
local combat3_distance_2 = createCombatObject()
setCombatParam(combat3_distance_2, COMBAT_PARAM_EFFECT, CONST_ME_POFF)
setCombatParam(combat3_distance_2, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatArea(combat3_distance_2,createCombatArea({{1, 0, 0},
{0, 1, 0},
{0, 0, 2}}))
setCombatFormula(combat3_distance_2, COMBAT_FORMULA_SKILL, 5, 10, 5, 10)
local dfcombat3_distance_2 = {CONST_ANI_THROWINGSTAR,-1,-1,-2,-2}local combat3_fire_demage_ml = createCombatObject()
setCombatParam(combat3_fire_demage_ml, COMBAT_PARAM_EFFECT, CONST_ME_HOLYDAMAGE)
setCombatParam(combat3_fire_demage_ml, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
setCombatArea(combat3_fire_demage_ml,createCombatArea({{1, 1, 2}}))
setCombatFormula(combat3_fire_demage_ml, COMBAT_FORMULA_SKILL, 5, 10, 5, 10)

-- Areas/Combat for 200ms
local combat2_distance_2 = createCombatObject()
setCombatParam(combat2_distance_2, COMBAT_PARAM_EFFECT, CONST_ME_POFF)
setCombatParam(combat2_distance_2, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatArea(combat2_distance_2,createCombatArea({{1, 1, 2}}))
setCombatFormula(combat2_distance_2, COMBAT_FORMULA_SKILL, 5, 10, 5, 10)
local dfcombat2_distance_2 = {CONST_ANI_THROWINGSTAR,-1,0,-2,0}local combat2_fire_demage_ml = createCombatObject()
setCombatParam(combat2_fire_demage_ml, COMBAT_PARAM_EFFECT, CONST_ME_HOLYDAMAGE)
setCombatParam(combat2_fire_demage_ml, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
setCombatArea(combat2_fire_demage_ml,createCombatArea({{0, 0, 2},
{0, 1, 0},
{1, 0, 0}}))
setCombatFormula(combat2_fire_demage_ml, COMBAT_FORMULA_SKILL, 5, 10, 5, 10)

-- Areas/Combat for 100ms
local combat1_distance_2 = createCombatObject()
setCombatParam(combat1_distance_2, COMBAT_PARAM_EFFECT, CONST_ME_POFF)
setCombatParam(combat1_distance_2, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatArea(combat1_distance_2,createCombatArea({{0, 0, 2},
{0, 1, 0},
{1, 0, 0}}))
setCombatFormula(combat1_distance_2, COMBAT_FORMULA_SKILL, 5, 10, 5, 10)
local dfcombat1_distance_2 = {CONST_ANI_THROWINGSTAR,-1,1,-2,2}local combat1_fire_demage_ml = createCombatObject()
setCombatParam(combat1_fire_demage_ml, COMBAT_PARAM_EFFECT, CONST_ME_HOLYDAMAGE)
setCombatParam(combat1_fire_demage_ml, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
setCombatArea(combat1_fire_demage_ml,createCombatArea({{2},
{1},
{1}}))
setCombatFormula(combat1_fire_demage_ml, COMBAT_FORMULA_SKILL, 5, 10, 5, 10)

-- Areas/Combat for 0ms
local combat0_distance_2 = createCombatObject()
setCombatParam(combat0_distance_2, COMBAT_PARAM_EFFECT, CONST_ME_POFF)
setCombatParam(combat0_distance_2, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatArea(combat0_distance_2,createCombatArea({{2},
{1},
{1}}))
setCombatFormula(combat0_distance_2, COMBAT_FORMULA_SKILL, 5, 10, 5, 10)
local dfcombat0_distance_2 = {CONST_ANI_THROWINGSTAR,0,1,0,2}

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
	addEvent(RunPart,800,combat8_fire_demage_ml,cid,var)
	addEvent(RunPart,700,combat7_distance_2,cid,var,dfcombat7_distance_2,startPos)
	addEvent(RunPart,700,combat7_fire_demage_ml,cid,var)
	addEvent(RunPart,600,combat6_distance_2,cid,var,dfcombat6_distance_2,startPos)
	addEvent(RunPart,600,combat6_fire_demage_ml,cid,var)
	addEvent(RunPart,500,combat5_distance_2,cid,var,dfcombat5_distance_2,startPos)
	addEvent(RunPart,500,combat5_fire_demage_ml,cid,var)
	addEvent(RunPart,400,combat4_distance_2,cid,var,dfcombat4_distance_2,startPos)
	addEvent(RunPart,400,combat4_fire_demage_ml,cid,var)
	addEvent(RunPart,300,combat3_distance_2,cid,var,dfcombat3_distance_2,startPos)
	addEvent(RunPart,300,combat3_fire_demage_ml,cid,var)
	addEvent(RunPart,200,combat2_distance_2,cid,var,dfcombat2_distance_2,startPos)
	addEvent(RunPart,200,combat2_fire_demage_ml,cid,var)
	addEvent(RunPart,100,combat1_distance_2,cid,var,dfcombat1_distance_2,startPos)
	addEvent(RunPart,100,combat1_fire_demage_ml,cid,var)
	RunPart(combat0_distance_2,cid,var,dfcombat0_distance_2,startPos)
	return true
end