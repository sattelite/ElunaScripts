--[[
    EmuDevs <http://emudevs.com/forum.php>
    Eluna Lua Engine <https://github.com/ElunaLuaEngine/Eluna>
    Eluna Scripts <https://github.com/ElunaLuaEngine/Scripts>
    Eluna Wiki <http://wiki.emudevs.com/doku.php?id=eluna>

    -= Script Information =-
    * Script Type: Trash Mob
    * Npc: Searing Blade Enforcer <11323>
--]]
require("eluna_globals")

-- variable definitions
local NPC_SEARING_BLADE_ENFORCER = 11323
local SPELL_SHIELD_SLAM = 8242

-- function definitions
local function EnterCombat() end 
local function Reset() end 

EnterCombat = function (event, creature, target)
    -- cast shield slam
    creature:RegisterEvent(function (event, delay, pCall, creature)
        if (math.random(1, 100) <= 75) then
            creature:CastSpell(creature:GetVictim(), SPELL_SHIELD_SLAM)
        end
    end, 8000, 0)
end

Reset = function (event, creature)
    creature:RemoveEvents()
end

RegisterCreatureEvent(NPC_SEARING_BLADE_ENFORCER, CREATURE_EVENT_ON_ENTER_COMBAT, EnterCombat)
RegisterCreatureEvent(NPC_SEARING_BLADE_ENFORCER, CREATURE_EVENT_ON_LEAVE_COMBAT, Reset)
RegisterCreatureEvent(NPC_SEARING_BLADE_ENFORCER, CREATURE_EVENT_ON_DIED, Reset)
