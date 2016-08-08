--[[
    EmuDevs <http://emudevs.com/forum.php>
    Eluna Lua Engine <https://github.com/ElunaLuaEngine/Eluna>
    Eluna Scripts <https://github.com/ElunaLuaEngine/Scripts>
    Eluna Wiki <http://wiki.emudevs.com/doku.php?id=eluna>

    -= Script Information =-
    * Script Type: Boss Fight
    * Npc: Taragaman the Hungerer <11520>
--]]
require("eluna_globals")

-- variable definitions
local BOSS_TARAGAMAN = 11520
local SPELL_UPPERCUT = 18072
local SPEL_FIRE_NOVA = 11970

-- function definitions
local function EnterCombat() end
local function Reset() end

EnterCombat = function (event, creature, target)
    -- cast uppercut
    creature:RegisterEvent(function (event, delay, pCall, creature)
        if (math.random(1, 100) <= 85) then
            creature:CastSpell(creature:GetVictim(), SPELL_UPPERCUT)
        end
    end, 5000, 0)
    -- cast fire nova
    creature:RegisterEvent(function (event, delay, pCall, creature)
        if (math.random(1, 100) <= 75) then
            creature:CastSpell(creature:GetVictim(), SPEL_FIRE_NOVA)
        end
    end, 8000, 0)
end

Reset = function (event, creature)
    creature:RemoveEvents()
end

RegisterCreatureEvent(BOSS_TARAGAMAN, CREATURE_EVENT_ON_ENTER_COMBAT, EnterCombat)
RegisterCreatureEvent(BOSS_TARAGAMAN, CREATURE_EVENT_ON_LEAVE_COMBAT, Reset)
RegisterCreatureEvent(BOSS_TARAGAMAN, CREATURE_EVENT_ON_DIED, Reset)
