-- SpellCreator generated.

-- =============== COMBAT VARS ===============
-- Areas/Combat for 400ms
local combat4_Brush = createCombatObject()
setCombatParam(combat4_Brush, COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
setCombatParam(combat4_Brush, COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
setCombatArea(combat4_Brush,createCombatArea({{0, 1, 0, 1, 0},
{1, 1, 0, 1, 1},
{0, 0, 2, 0, 0},
{1, 1, 0, 1, 1},
{0, 1, 0, 1, 0}}))
setCombatFormula(combat4_Brush, COMBAT_FORMULA_LEVELMAGIC, 5, 10, 5, 10)

-- Areas/Combat for 200ms
local combat2_Brush = createCombatObject()
setCombatParam(combat2_Brush, COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
setCombatParam(combat2_Brush, COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
setCombatArea(combat2_Brush,createCombatArea({{1},
{1},
{2},
{1},
{1}}))
setCombatFormula(combat2_Brush, COMBAT_FORMULA_LEVELMAGIC, 5, 10, 5, 10)

-- Areas/Combat for 0ms
local combat0_Brush = createCombatObject()
setCombatParam(combat0_Brush, COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
setCombatParam(combat0_Brush, COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
setCombatArea(combat0_Brush,createCombatArea({{1, 1, 2, 1, 1}}))
setCombatFormula(combat0_Brush, COMBAT_FORMULA_LEVELMAGIC, 5, 10, 5, 10)

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
	addEvent(RunPart,200,combat2_Brush,cid,var)
	RunPart(combat0_Brush,cid,var)
	return true
end