-- SpellCreator generated.

-- =============== COMBAT VARS ===============
-- Areas/Combat for 400ms
local combat4_Brush = createCombatObject()
setCombatParam(combat4_Brush, COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
setCombatParam(combat4_Brush, COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
setCombatArea(combat4_Brush,createCombatArea({{0, 1, 0},
{1, 1, 1},
{0, 1, 0},
{0, 2, 0},
{0, 1, 0},
{1, 1, 1},
{0, 1, 0}}))
setCombatFormula(combat4_Brush, COMBAT_FORMULA_LEVELMAGIC, 5, 10, 5, 10)

-- Areas/Combat for 300ms
local combat3_energy_1_ml = createCombatObject()
setCombatParam(combat3_energy_1_ml, COMBAT_PARAM_EFFECT, CONST_ME_ENERGYAREA)
setCombatParam(combat3_energy_1_ml, COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
setCombatArea(combat3_energy_1_ml,createCombatArea({{1, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 2, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 1}}))
setCombatFormula(combat3_energy_1_ml, COMBAT_FORMULA_SKILL, 5, 10, 5, 10)
local dfcombat3_energy_1_ml = {CONST_ANI_ENERGY,3,3,-3,-3}

-- Areas/Combat for 200ms
local combat2_energy_1_ml = createCombatObject()
setCombatParam(combat2_energy_1_ml, COMBAT_PARAM_EFFECT, CONST_ME_ENERGYAREA)
setCombatParam(combat2_energy_1_ml, COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
setCombatArea(combat2_energy_1_ml,createCombatArea({{1, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 2, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 1}}))
setCombatFormula(combat2_energy_1_ml, COMBAT_FORMULA_SKILL, 5, 10, 5, 10)
local dfcombat2_energy_1_ml = {CONST_ANI_ENERGY,3,1,-3,-1}

-- Areas/Combat for 100ms
local combat1_energy_1_ml = createCombatObject()
setCombatParam(combat1_energy_1_ml, COMBAT_PARAM_EFFECT, CONST_ME_ENERGYAREA)
setCombatParam(combat1_energy_1_ml, COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
setCombatArea(combat1_energy_1_ml,createCombatArea({{0, 0, 0, 0, 0, 0, 1},
{0, 0, 0, 2, 0, 0, 0},
{1, 0, 0, 0, 0, 0, 0}}))
setCombatFormula(combat1_energy_1_ml, COMBAT_FORMULA_SKILL, 5, 10, 5, 10)
local dfcombat1_energy_1_ml = {CONST_ANI_ENERGY,3,-1,-3,1}

-- Areas/Combat for 0ms
local combat0_energy_1_ml = createCombatObject()
setCombatParam(combat0_energy_1_ml, COMBAT_PARAM_EFFECT, CONST_ME_ENERGYAREA)
setCombatParam(combat0_energy_1_ml, COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
setCombatArea(combat0_energy_1_ml,createCombatArea({{0, 0, 0, 0, 0, 0, 1},
{0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 2, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0},
{1, 0, 0, 0, 0, 0, 0}}))
setCombatFormula(combat0_energy_1_ml, COMBAT_FORMULA_SKILL, 5, 10, 5, 10)
local dfcombat0_energy_1_ml = {CONST_ANI_ENERGY,-3,3,3,-3}

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
	addEvent(RunPart,400,combat4_Brush,cid,var)
	addEvent(RunPart,300,combat3_energy_1_ml,cid,var,dfcombat3_energy_1_ml,startPos)
	addEvent(RunPart,200,combat2_energy_1_ml,cid,var,dfcombat2_energy_1_ml,startPos)
	addEvent(RunPart,100,combat1_energy_1_ml,cid,var,dfcombat1_energy_1_ml,startPos)
	RunPart(combat0_energy_1_ml,cid,var,dfcombat0_energy_1_ml,startPos)
	return true
end