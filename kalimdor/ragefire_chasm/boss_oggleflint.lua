--[[
    EmuDevs <http://emudevs.com/forum.php>
    Eluna Lua Engine <https://github.com/ElunaLuaEngine/Eluna>
    Eluna Scripts <https://github.com/ElunaLuaEngine/Scripts>
    Eluna Wiki <http://wiki.emudevs.com/doku.php?id=eluna>

    -= Script Information =-
    * Script Type: Boss Fight
    * Npc: Oggleflint <11517>
--]]
require("eluna_globals")

-- variable definitions
local BOSS_OGGLEFLINT = 11517
local SPELL_CLEAVE = 40505

-- function definitions
local function EnterCombat() end
local function Reset() end

EnterCombat = function(event, creature, target)
    -- cast cleave
    creature:RegisterEvent(function(event, delay, pCall, creature)
        if (math.random(1, 100) <= 70) then
            creature:CastSpell(creature:GetVictim(), SPELL_CLEAVE)
        end
    end, 8000, 0)
end

Reset = function (event, creature)
    creature:RemoveEvents()
end

RegisterCreatureEvent(BOSS_OGGLEFLINT, CREATURE_EVENT_ON_ENTER_COMBAT, EnterCombat)
RegisterCreatureEvent(BOSS_OGGLEFLINT, CREATURE_EVENT_ON_LEAVE_COMBAT, Reset)
RegisterCreatureEvent(BOSS_OGGLEFLINT, CREATURE_EVENT_ON_DIED, Reset)
