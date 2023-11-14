-- Core API functions implemented in Lua
dofile('data/lib/core/core.lua')

-- Compatibility library for our old Lua API
dofile('data/lib/compat/compat.lua')

-- Debugging helper function for Lua developers
dofile('data/lib/debugging/dump.lua')
dofile('data/lib/debugging/lua_version.lua')

-- Custom Features
dofile('data/lib/Systems/01-Rookgard.lua')
dofile('data/lib/Systems/02-Flame Event.lua')
dofile('data/lib/Systems/03-Piano Quest.lua')
dofile('data/lib/Systems/04-Skull.lua')
dofile('data/lib/Systems/05-Drop Items.lua')
dofile('data/lib/Systems/06-ExtraLoot.lua')
dofile('data/lib/Systems/07-TaskSystem.lua')

-- Modal Helper
dofile('data/lib/core/modalwindow.lua')

-- Source
dofile('data/lib/source/pedroLib.lua')