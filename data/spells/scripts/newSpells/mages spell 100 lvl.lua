-- SpellCreator generated.

-- =============== COMBAT VARS ===============
-- Areas/Combat for 100ms
local combat1_energy_1_ml = createCombatObject()
setCombatParam(combat1_energy_1_ml, COMBAT_PARAM_EFFECT, CONST_ME_ENERGYAREA)
setCombatParam(combat1_energy_1_ml, COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
setCombatArea(combat1_energy_1_ml,createCombatArea({{2},
{1}}))
setCombatFormula(combat1_energy_1_ml, COMBAT_FORMULA_LEVELMAGIC, 25, 100, 50, 200)
local dfcombat1_energy_1_ml = {CONST_ANI_ENERGY,0,1}

-- Areas/Combat for 0ms
local combat0_energy_1_ml = createCombatObject()
setCombatParam(combat0_energy_1_ml, COMBAT_PARAM_EFFECT, CONST_ME_ENERGYAREA)
setCombatParam(combat0_energy_1_ml, COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
setCombatArea(combat0_energy_1_ml,createCombatArea({{2, 0},
{0, 1}}))
setCombatFormula(combat0_energy_1_ml, COMBAT_FORMULA_LEVELMAGIC, 25, 100, 50, 200)
local dfcombat0_energy_1_ml = {CONST_ANI_ENERGY,1,1}

-- Areas/Combat for 200ms
local combat2_energy_1_ml = createCombatObject()
setCombatParam(combat2_energy_1_ml, COMBAT_PARAM_EFFECT, CONST_ME_ENERGYAREA)
setCombatParam(combat2_energy_1_ml, COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
setCombatArea(combat2_energy_1_ml,createCombatArea({{0, 2},
{1, 0}}))
setCombatFormula(combat2_energy_1_ml, COMBAT_FORMULA_LEVELMAGIC, 25, 100, 50, 200)
local dfcombat2_energy_1_ml = {CONST_ANI_ENERGY,-1,1}

-- Areas/Combat for 300ms
local combat3_energy_1_ml = createCombatObject()
setCombatParam(combat3_energy_1_ml, COMBAT_PARAM_EFFECT, CONST_ME_ENERGYAREA)
setCombatParam(combat3_energy_1_ml, COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
setCombatArea(combat3_energy_1_ml,createCombatArea({{1, 2}}))
setCombatFormula(combat3_energy_1_ml, COMBAT_FORMULA_LEVELMAGIC, 25, 100, 50, 200)
local dfcombat3_energy_1_ml = {CONST_ANI_ENERGY,-1,0}

-- Areas/Combat for 400ms
local combat4_energy_1_ml = createCombatObject()
setCombatParam(combat4_energy_1_ml, COMBAT_PARAM_EFFECT, CONST_ME_ENERGYAREA)
setCombatParam(combat4_energy_1_ml, COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
setCombatArea(combat4_energy_1_ml,createCombatArea({{1, 0},
{0, 2}}))
setCombatFormula(combat4_energy_1_ml, COMBAT_FORMULA_LEVELMAGIC, 25, 100, 50, 200)
local dfcombat4_energy_1_ml = {CONST_ANI_ENERGY,-1,-1}

-- Areas/Combat for 500ms
local combat5_energy_1_ml = createCombatObject()
setCombatParam(combat5_energy_1_ml, COMBAT_PARAM_EFFECT, CONST_ME_ENERGYAREA)
setCombatParam(combat5_energy_1_ml, COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
setCombatArea(combat5_energy_1_ml,createCombatArea({{1},
{2}}))
setCombatFormula(combat5_energy_1_ml, COMBAT_FORMULA_LEVELMAGIC, 25, 100, 50, 200)
local dfcombat5_energy_1_ml = {CONST_ANI_ENERGY,0,-1}

-- Areas/Combat for 600ms
local combat6_energy_1_ml = createCombatObject()
setCombatParam(combat6_energy_1_ml, COMBAT_PARAM_EFFECT, CONST_ME_ENERGYAREA)
setCombatParam(combat6_energy_1_ml, COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
setCombatArea(combat6_energy_1_ml,createCombatArea({{0, 1},
{2, 0}}))
setCombatFormula(combat6_energy_1_ml, COMBAT_FORMULA_LEVELMAGIC, 25, 100, 50, 200)
local dfcombat6_energy_1_ml = {CONST_ANI_ENERGY,1,-1}

-- Areas/Combat for 700ms
local combat7_energy_1_ml = createCombatObject()
setCombatParam(combat7_energy_1_ml, COMBAT_PARAM_EFFECT, CONST_ME_ENERGYAREA)
setCombatParam(combat7_energy_1_ml, COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
setCombatArea(combat7_energy_1_ml,createCombatArea({{2, 1}}))
setCombatFormula(combat7_energy_1_ml, COMBAT_FORMULA_LEVELMAGIC, 25, 100, 50, 200)
local dfcombat7_energy_1_ml = {CONST_ANI_ENERGY,1,0}local combat7_Brush = createCombatObject()
setCombatParam(combat7_Brush, COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
setCombatParam(combat7_Brush, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatArea(combat7_Brush,createCombatArea({{0, 0, 1, 0, 1, 0, 0},
{0, 1, 1, 1, 1, 1, 0},
{1, 1, 0, 0, 0, 1, 1},
{0, 1, 0, 2, 0, 1, 0},
{1, 1, 0, 0, 0, 1, 1},
{0, 1, 1, 1, 1, 1, 0},
{0, 0, 1, 0, 1, 0, 0}}))
setCombatFormula(combat7_Brush, COMBAT_FORMULA_LEVELMAGIC, 25, 100, 50, 200)

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
	addEvent(RunPart,100,combat1_energy_1_ml,cid,var,dfcombat1_energy_1_ml,startPos)
	RunPart(combat0_energy_1_ml,cid,var,dfcombat0_energy_1_ml,startPos)
	addEvent(RunPart,200,combat2_energy_1_ml,cid,var,dfcombat2_energy_1_ml,startPos)
	addEvent(RunPart,300,combat3_energy_1_ml,cid,var,dfcombat3_energy_1_ml,startPos)
	addEvent(RunPart,400,combat4_energy_1_ml,cid,var,dfcombat4_energy_1_ml,startPos)
	addEvent(RunPart,500,combat5_energy_1_ml,cid,var,dfcombat5_energy_1_ml,startPos)
	addEvent(RunPart,600,combat6_energy_1_ml,cid,var,dfcombat6_energy_1_ml,startPos)
	addEvent(RunPart,700,combat7_energy_1_ml,cid,var,dfcombat7_energy_1_ml,startPos)
	addEvent(RunPart,700,combat7_Brush,cid,var)
	return true
end