-- SpellCreator generated.

-- =============== COMBAT VARS ===============
-- Areas/Combat for 200ms
local combat2_firearea = createCombatObject()
setCombatParam(combat2_firearea, COMBAT_PARAM_EFFECT, CONST_ME_FIREAREA)
setCombatParam(combat2_firearea, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
setCombatArea(combat2_firearea,createCombatArea({{0, 0, 0, 1, 0, 0, 0},
{0, 0, 1, 1, 1, 0, 0},
{0, 1, 0, 0, 0, 1, 0},
{1, 1, 0, 2, 0, 1, 1},
{0, 1, 0, 0, 0, 1, 0},
{0, 0, 1, 1, 1, 0, 0},
{0, 0, 0, 1, 0, 0, 0}}))
setCombatFormula(combat2_firearea, COMBAT_FORMULA_SKILL, 5, 10, 5, 10)

-- Areas/Combat for 0ms
local combat0_firearea = createCombatObject()
setCombatParam(combat0_firearea, COMBAT_PARAM_EFFECT, CONST_ME_FIREAREA)
setCombatParam(combat0_firearea, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
setCombatArea(combat0_firearea,createCombatArea({{1, 1, 1},
{1, 2, 1},
{1, 1, 1}}))
setCombatFormula(combat0_firearea, COMBAT_FORMULA_SKILL, 5, 10, 5, 10)

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
	addEvent(RunPart,200,combat2_firearea,cid,var)
	RunPart(combat0_firearea,cid,var)
	return true
end