--[[
    EmuDevs <http://emudevs.com/forum.php>
    Eluna Lua Engine <https://github.com/ElunaLuaEngine/Eluna>
    Eluna Scripts <https://github.com/ElunaLuaEngine/Scripts>
    Eluna Wiki <http://wiki.emudevs.com/doku.php?id=eluna>

    -= Script Information =-
    * Script Type: Trash Mob
    * Npc: Ragefire Shaman <11319>
--]]

local NPC_RAGEFIRE_SHAMAN = 11319
local SPELL_LIGHTNING_BOLT = 9532
local SPELL_HEALING_WAVE = 11986

function OnEnterCombat(event, creature, target)
    creature:RegisterEvent(CastLightningBolt, 0, 1)
    creature:RegisterEvent(CastHealingWave, 1000, 1)
end

function CastLightningBolt(event, delay, pCall, creature)
    creature:CastSpell(creature:GetVictim(), SPELL_LIGHTNING_BOLT)
    creature:RegisterEvent(CastLightningBolt, math.random(3800, 4800), 1)
end

function CastHealingWave(event, delay, pCall, creature)
    local creatures = creature:GetFriendlyUnitsInRange(330)
    for i in pairs(creatures) do
        if creatures[i]:GetHealthPct() < 40 then
            creature:CastSpell(creatures[i], SPELL_HEALING_WAVE)
            creature:RegisterEvent(CastHealingWave, 23800, 1)
            return
        end
    end

    -- no target found
    creature:RegisterEvent(CastHealingWave, 1000, 1)
end

function Reset(event, creature)
    creature:RemoveEvents()
end

RegisterCreatureEvent(NPC_RAGEFIRE_SHAMAN, 1, OnEnterCombat)
RegisterCreatureEvent(NPC_RAGEFIRE_SHAMAN, 2, Reset) -- OnLeaveCombat
RegisterCreatureEvent(NPC_RAGEFIRE_SHAMAN, 4, Reset) -- OnDied
