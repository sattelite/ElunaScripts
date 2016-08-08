--[[
    EmuDevs <http://emudevs.com/forum.php>
    Eluna Lua Engine <https://github.com/ElunaLuaEngine/Eluna>
    Eluna Scripts <https://github.com/ElunaLuaEngine/Scripts>
    Eluna Wiki <http://wiki.emudevs.com/doku.php?id=eluna>

    -= Script Information =-
    * Script Type: Trash Mob
    * Npc: Ragefire Shaman <11319>
--]]
require("eluna_globals")

-- variable definitions
local NPC_RAGEFIRE_SHAMAN = 11319
local SPELL_LIGHTNING_BOLT = 9532
local SPELL_HEALING_WAVE = 11986

-- function definitions
local function EnterCombat() end
local function CastHealingWave() end
local function CastLightningBolt() end
local function Reset() end

EnterCombat = function (event, creature, target)
    creature:RegisterEvent(CastLightningBolt, 0, 1)
    creature:RegisterEvent(CastHealingWave, 1000, 1)
end

CastLightningBolt = function (event, delay, pCall, creature)
    creature:CastSpell(creature:GetVictim(), SPELL_LIGHTNING_BOLT)
    creature:RegisterEvent(CastLightningBolt, math.random(3800, 4800), 1)
end

CastHealingWave = function (event, delay, pCall, creature)
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

Reset = function (event, creature)
    creature:RemoveEvents()
end

RegisterCreatureEvent(NPC_RAGEFIRE_SHAMAN, CREATURE_EVENT_ON_ENTER_COMBAT, EnterCombat)
RegisterCreatureEvent(NPC_RAGEFIRE_SHAMAN, CREATURE_EVENT_ON_LEAVE_COMBAT, Reset)
RegisterCreatureEvent(NPC_RAGEFIRE_SHAMAN, CREATURE_EVENT_ON_DIED, Reset)
