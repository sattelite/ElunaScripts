--[[
    EmuDevs <http://emudevs.com/forum.php>
    Eluna Lua Engine <https://github.com/ElunaLuaEngine/Eluna>
    Eluna Scripts <https://github.com/ElunaLuaEngine/Scripts>
    Eluna Wiki <http://wiki.emudevs.com/doku.php?id=eluna>

    -= Script Information =-
    * Script Type: Trash Mob
    * Npc: Ragefire Trogg <11318>
--]]

local NPC_RAGEFIRE_TROGG = 11318
local SPELL_STRIKE = 11976

function OnEnterCombat(event, creature, target)
    creature:RegisterEvent(CastStrike, 5000, 0)
end

function CastStrike(event, delay, pCall, creature)
    creature:CastSpell(creature:GetVictim(), SPELL_STRIKE)
end

function Reset(event, creature)
    creature:RemoveEvents()
end

RegisterCreatureEvent(NPC_RAGEFIRE_TROGG, 1, OnEnterCombat)
RegisterCreatureEvent(NPC_RAGEFIRE_TROGG, 2, Reset) -- OnLeaveCombat
RegisterCreatureEvent(NPC_RAGEFIRE_TROGG, 4, Reset) -- OnDied
