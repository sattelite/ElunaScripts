--[[
    EmuDevs <http://emudevs.com/forum.php>
    Eluna Lua Engine <https://github.com/ElunaLuaEngine/Eluna>
    Eluna Scripts <https://github.com/ElunaLuaEngine/Scripts>
    Eluna Wiki <http://wiki.emudevs.com/doku.php?id=eluna>

    -= Script Information =-
    * Script Type: Trash Mob
    * Npc: Searing Blade Cultist <11322>
--]]
require("eluna_globals")

-- variable definitions
local NPC_SEARING_BLADE_CULTIST = 11322
local SPELL_CURSE_OF_AGONY = 18266

-- function definitions
local function EnterCombat() end 
local function Reset() end 

EnterCombat = function (event, creature, target)
    -- cast curse of agony
    creature:RegisterEvent(function (event, delay, pCall, creature)
        if (math.random(1, 100) <= 85) then
            local players = creature:GetPlayersInRange()
            creature:CastSpell(players[math.random(1, #players)], SPELL_CURSE_OF_AGONY)
        end
    end, 12000, 0)
end

Reset= function (event, creature)
    creature:RemoveEvents()
end

RegisterCreatureEvent(NPC_SEARING_BLADE_CULTIST, CREATURE_EVENT_ON_ENTER_COMBAT, EnterCombat)
RegisterCreatureEvent(NPC_SEARING_BLADE_CULTIST, CREATURE_EVENT_ON_LEAVE_COMBAT, Reset)
RegisterCreatureEvent(NPC_SEARING_BLADE_CULTIST, CREATURE_EVENT_ON_DIED, Reset)
