-- Core API functions implemented in Lua
dofile('data/lib/core/core.lua')

-- Compatibility library for our old Lua API
dofile('data/lib/compat/compat.lua')

-- Debugging helper function for Lua developers
dofile('data/lib/debugging/dump.lua')
dofile('data/lib/debugging/lua_version.lua')

-- Keep load order database/core/scripts/modules

--DATABASE--
dofile('data/InSaiyan_Database_Spells.lua')
dofile('data/gamestore.lua')


--CORE--
dofile('data/lib/InSaiyan_Core_Spells.lua')



--Niide Spells v.2.0
dofile('data/Niide Spell System.lua')

--Niide lib
dofile("data/lib/niide lib.lua")