-- SpellCreator generated.

-- =============== COMBAT VARS ===============
-- Areas/Combat for 500ms
local combat5_paladin_holy = createCombatObject()
setCombatParam(combat5_paladin_holy, COMBAT_PARAM_EFFECT, CONST_ME_FIREWORK_YELLOW)
setCombatParam(combat5_paladin_holy, COMBAT_PARAM_TYPE, COMBAT_HOLYDAMAGE)
setCombatArea(combat5_paladin_holy,createCombatArea({{0, 1, 0, 0, 0, 1, 0},
{1, 0, 1, 0, 1, 0, 1},
{0, 1, 0, 1, 0, 1, 0},
{0, 0, 1, 2, 1, 0, 0},
{0, 1, 0, 1, 0, 1, 0},
{1, 0, 1, 0, 1, 0, 1},
{0, 1, 0, 0, 0, 1, 0}}))
setCombatFormula(combat5_paladin_holy, COMBAT_FORMULA_LEVELMAGIC, 5, 10, 5, 10)
local dfcombat5_paladin_holy = {CONST_ANI_HOLY,1,0,0,1,2,1,1,2,2,3,3,2,-1,0,-1,2,-2,1,-3,2,-2,3,0,-1,-1,-2,-2,-1,-3,-2,-2,-3,2,-1,1,-2,2,-3,3,-2}

-- Areas/Combat for 0ms
local combat0_Brush_2 = createCombatObject()
setCombatParam(combat0_Brush_2, COMBAT_PARAM_EFFECT, CONST_ME_HOLYAREA)
setCombatParam(combat0_Brush_2, COMBAT_PARAM_TYPE, COMBAT_HOLYDAMAGE)
setCombatArea(combat0_Brush_2,createCombatArea({{1, 0, 0, 0, 1},
{0, 1, 0, 1, 0},
{0, 0, 2, 0, 0},
{0, 1, 0, 1, 0},
{1, 0, 0, 0, 1}}))
setCombatFormula(combat0_Brush_2, COMBAT_FORMULA_LEVELMAGIC, 5, 10, 5, 10)
local dfcombat0_Brush_2 = {CONST_ANI_SMALLHOLY,1,1,2,2,-1,1,-2,2,-1,-1,-2,-2,1,-1,2,-2}

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
	addEvent(RunPart,500,combat5_paladin_holy,cid,var,dfcombat5_paladin_holy,startPos)
	RunPart(combat0_Brush_2,cid,var,dfcombat0_Brush_2,startPos)
	return true
end