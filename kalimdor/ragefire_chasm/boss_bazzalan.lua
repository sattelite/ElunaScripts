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
    creature:RegisterEvent(CastPoison, math.random(3000, 5000), 0)
    creature:RegisterEvent(CastSinisterStrike, 8000, 0)
end

function CastPoison(event, delay, pCall, creature)
    if (math.random(1, 100) <= 75) then
        creature:CastSpell(creature:GetVictim(), SPELL_POISON)
    end
end

function CastSinisterStrike(event, delay, pCall, creature)
    if (math.random(1, 100) <= 85) then
        creature:CastSpell(creature:GetVictim(), SPELL_SINISTER_STRIKE)
    end
end

function Reset(event, creature)
    creature:RemoveEvents()
end

RegisterCreatureEvent(BOSS_BAZZALAN, 1, OnEnterCombat) -- OnEnterCombat
RegisterCreatureEvent(BOSS_BAZZALAN, 2, Reset) -- OnLeaveCombat
RegisterCreatureEvent(BOSS_BAZZALAN, 4, Reset) -- OnDied
