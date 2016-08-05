--[[
    EmuDevs <http://emudevs.com/forum.php>
    Eluna Lua Engine <https://github.com/ElunaLuaEngine/Eluna>
    Eluna Scripts <https://github.com/ElunaLuaEngine/Scripts>
    Eluna Wiki <http://wiki.emudevs.com/doku.php?id=eluna>

    -= Script Information =-
    * Script Type: Boss Fight
    * Npc: Bazzalan <11519>
--]]

local BOSS_BAZZALAN = 11519
local SPELL_POISON = 744
local SPELL_SINISTER_STRIKE = 14873

function OnEnterCombat(event, creature, target)
    -- cast spell poison
    creature:RegisterEvent(function (event, delay, pCall, creature)
        creature:SendUnitSay("Time: " .. os.time(), 0)
        if (math.random(1, 100) <= 75) then
            creature:CastSpell(creature:GetVictim(), SPELL_POISON)
        end
    end, math.random(1000, 10000), 0)

    -- cast sinister strike
    creature:RegisterEvent(function(event, delay, pCall, creature)
        if (math.random(1, 100) <= 85) then
            creature:CastSpell(creature:GetVictim(), SPELL_SINISTER_STRIKE)
        end
    end, 8000, 0)
end

function Reset(event, creature)
    creature:RemoveEvents()
end

RegisterCreatureEvent(BOSS_BAZZALAN, 1, OnEnterCombat) -- OnEnterCombat
RegisterCreatureEvent(BOSS_BAZZALAN, 2, Reset) -- OnLeaveCombat
RegisterCreatureEvent(BOSS_BAZZALAN, 4, Reset) -- OnDied
