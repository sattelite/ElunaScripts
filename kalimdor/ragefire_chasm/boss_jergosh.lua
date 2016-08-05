--[[
    EmuDevs <http://emudevs.com/forum.php>
    Eluna Lua Engine <https://github.com/ElunaLuaEngine/Eluna>
    Eluna Scripts <https://github.com/ElunaLuaEngine/Scripts>
    Eluna Wiki <http://wiki.emudevs.com/doku.php?id=eluna>

    -= Script Information =-
    * Script Type: Boss Fight
    * Npc: Jergosh the Invoker <11518>
--]]

local BOSS_JERGOSH = 11518
local SPELL_IMMOLATE = 20800
local SPELL_CURSE_OF_WEAKNESS = 11980

function OnEnterCombat(event, creature, target)
    creature:RegisterEvent(CastImmolate, 12000, 0)
    creature:RegisterEvent(CastCurseOfWeakness, 30000, 0)
end

function CastImmolate(event, delay, pCall, creature)
    if (math.random(1, 100) <= 85) then
        creature:CastSpell(creature:GetVictim(), SPELL_IMMOLATE)
    end
end

function CastCurseOfWeakness(event, delay, pCall, creature)
    if (math.random(1, 100) <= 75) then
        local players = creature:GetPlayersInRange()
        creature:CastSpell(players[math.random(1, #players)], SPELL_CURSE_OF_WEAKNESS)
    end
end

function Reset(event, creature)
    creature:RemoveEvents()
end

RegisterCreatureEvent(BOSS_JERGOSH, 1, OnEnterCombat) -- OnEnterCombat
RegisterCreatureEvent(BOSS_JERGOSH, 2, Reset) -- OnLeaveCombat
RegisterCreatureEvent(BOSS_JERGOSH, 4, Reset) -- OnDied
