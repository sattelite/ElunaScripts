--[[
    EmuDevs <http://emudevs.com/forum.php>
    Eluna Lua Engine <https://github.com/ElunaLuaEngine/Eluna>
    Eluna Scripts <https://github.com/ElunaLuaEngine/Scripts>
    Eluna Wiki <http://wiki.emudevs.com/doku.php?id=eluna>

    -= Script Information =-
    * Script Type: Boss Fight
    * Npc: Bazzalan <11519>
--]]
require("eluna_globals")

-- variable definitions
local BOSS_BAZZALAN = 11519
local SPELL_POISON = 744
local SPELL_SINISTER_STRIKE = 14873

-- function definitions
local function EnterCombat() end
local function CastPoison() end
local function Reset() end

EnterCombat = function(event, creature, target)
    -- cast poison
    creature:RegisterEvent(CastPoison, math.random(3000, 5000), 1)

    -- cast sinister strike
    creature:RegisterEvent( function(event, delay, pCall, creature)
        if (math.random(1, 100) <= 85) then
            creature:CastSpell(creature:GetVictim(), SPELL_SINISTER_STRIKE)
        end
    end, 8000, 0)
end

CastPoison = function( event, delay, pCall, creature) 
    if (math.random(1, 100) <= 75) then
        creature:CastSpell(creature:GetVictim(), SPELL_POISON)
    end
    creature:RegisterEvent(CastPoison, math.random(3000,5000), 1)
end

Reset = function (event, creature)
    creature:RemoveEvents()
end

RegisterCreatureEvent(BOSS_BAZZALAN, CREATURE_EVENT_ON_ENTER_COMBAT, EnterCombat)
RegisterCreatureEvent(BOSS_BAZZALAN, CREATURE_EVENT_ON_LEAVE_COMBAT, Reset)
RegisterCreatureEvent(BOSS_BAZZALAN, CREATURE_EVENT_ON_DIED, Reset)
