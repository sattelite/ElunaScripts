--[[
    EmuDevs <http://emudevs.com/forum.php>
    Eluna Lua Engine <https://github.com/ElunaLuaEngine/Eluna>
    Eluna Scripts <https://github.com/ElunaLuaEngine/Scripts>
    Eluna Wiki <http://wiki.emudevs.com/doku.php?id=eluna>

    -= Script Information =-
    * Script Type: Trash Mob
    * Npc: Ragefire Trogg <11318>
--]]
require("eluna_globals")

-- variable definitions
local NPC_RAGEFIRE_TROGG = 11318
local SPELL_STRIKE = 11976

-- function definitions
local function EnterCombat() end
local function Reset() end

EnterCombat = function (event, creature, target)
    -- cast strike
    creature:RegisterEvent(function (event, delay, pCall, creature)
        creature:CastSpell(creature:GetVictim(), SPELL_STRIKE)
    end, 5000, 0)
end

Reset = function (event, creature)
    creature:RemoveEvents()
end

RegisterCreatureEvent(NPC_RAGEFIRE_TROGG, CREATURE_EVENT_ON_ENTER_COMBAT, EnterCombat)
RegisterCreatureEvent(NPC_RAGEFIRE_TROGG, CREATURE_EVENT_ON_LEAVE_COMBAT, Reset)
RegisterCreatureEvent(NPC_RAGEFIRE_TROGG, CREATURE_EVENT_ON_DIED, Reset)
