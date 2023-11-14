-- SpellCreator generated.

-- =============== COMBAT VARS ===============
-- Areas/Combat for 600ms
local combat6_fire_demage_ml = createCombatObject()
setCombatParam(combat6_fire_demage_ml, COMBAT_PARAM_EFFECT, CONST_ME_HOLYDAMAGE)
setCombatParam(combat6_fire_demage_ml, COMBAT_PARAM_TYPE, CONST_ME_HOLYDAMAGE)
setCombatArea(combat6_fire_demage_ml,createCombatArea({{0, 1, 0},
{1, 2, 1},
{0, 1, 0}}))
setCombatFormula(combat6_fire_demage_ml, COMBAT_FORMULA_SKILL, 5, 10, 5, 10)

-- Areas/Combat for 400ms
local combat4_fire_demage_ml = createCombatObject()
setCombatParam(combat4_fire_demage_ml, COMBAT_PARAM_EFFECT, CONST_ME_HOLYDAMAGE)
setCombatParam(combat4_fire_demage_ml, COMBAT_PARAM_TYPE, CONST_ME_HOLYDAMAGE)
setCombatArea(combat4_fire_demage_ml,createCombatArea({{0, 0, 1, 0, 0},
{0, 0, 0, 0, 0},
{1, 0, 2, 0, 1},
{0, 0, 0, 0, 0},
{0, 0, 1, 0, 0}}))
setCombatFormula(combat4_fire_demage_ml, COMBAT_FORMULA_SKILL, 5, 10, 5, 10)

-- Areas/Combat for 100ms
local combat1_distance1 = createCombatObject()
setCombatParam(combat1_distance1, COMBAT_PARAM_EFFECT, CONST_ME_HITAREA)
setCombatParam(combat1_distance1, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatArea(combat1_distance1,createCombatArea({{0, 0, 0, 1, 0, 0, 0},
{0, 1, 0, 0, 0, 1, 0},
{0, 0, 0, 0, 0, 0, 0},
{1, 0, 0, 2, 0, 0, 1},
{0, 0, 0, 0, 0, 0, 0},
{0, 1, 0, 0, 0, 1, 0},
{0, 0, 0, 1, 0, 0, 0}}))
setCombatFormula(combat1_distance1, COMBAT_FORMULA_SKILL, 5, 10, 5, 10)
local dfcombat1_distance1 = {CONST_ANI_SPEAR,2,2,3,0,2,-2,0,3,-2,2,-3,0,-2,-2,0,-3}

-- Areas/Combat for 0ms
local combat0_drawblood_ml = createCombatObject()
setCombatParam(combat0_drawblood_ml, COMBAT_PARAM_EFFECT, CONST_ME_DRAWBLOOD)
setCombatParam(combat0_drawblood_ml, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatArea(combat0_drawblood_ml,createCombatArea({{0, 0, 0, 1, 0, 0, 0},
{0, 1, 0, 0, 0, 1, 0},
{0, 0, 0, 0, 0, 0, 0},
{1, 0, 0, 2, 0, 0, 1},
{0, 0, 0, 0, 0, 0, 0},
{0, 1, 0, 0, 0, 1, 0},
{0, 0, 0, 1, 0, 0, 0}}))
setCombatFormula(combat0_drawblood_ml, COMBAT_FORMULA_SKILL, 5, 10, 5, 10)

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
	addEvent(RunPart,600,combat6_fire_demage_ml,cid,var)
	addEvent(RunPart,400,combat4_fire_demage_ml,cid,var)
	addEvent(RunPart,100,combat1_distance1,cid,var,dfcombat1_distance1,startPos)
	RunPart(combat0_drawblood_ml,cid,var)
	return true
end