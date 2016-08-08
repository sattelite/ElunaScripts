--[[
    EmuDevs <http://emudevs.com/forum.php>
    Eluna Lua Engine <https://github.com/ElunaLuaEngine/Eluna>
    Eluna Scripts <https://github.com/ElunaLuaEngine/Scripts>
    Eluna Wiki <http://wiki.emudevs.com/doku.php?id=eluna>

    -= Script Information =-
    * Script Type: Trash Mob
    * Npc: Earthborer <11320>
--]]
require("eluna_globals")

-- variable definitions
local NPC_EARTHBORER = 11320
local SPELL_EARTHBORER_ACID = 18070

-- function definitions
local function EnterCombat() end
local function Reset() end

EnterCombat = function (event, creature, target)
    creature:RegisterEvent( function (event, delay, pCall, creature)
        if (math.random(1, 100) <= 70) then
            creature:CastSpell(creature:GetVictim(), SPELL_EARTHBORER_ACID)
        end
    end, 6000, 0)
end

Reset = function (event, creature)
    creature:RemoveEvents()
end

RegisterCreatureEvent(NPC_EARTHBORER, CREATURE_EVENT_ON_ENTER_COMBAT, EnterCombat)
RegisterCreatureEvent(NPC_EARTHBORER, CREATURE_EVENT_ON_LEAVE_COMBAT, Reset)
RegisterCreatureEvent(NPC_EARTHBORER, CREATURE_EVENT_ON_DIED, Reset)
