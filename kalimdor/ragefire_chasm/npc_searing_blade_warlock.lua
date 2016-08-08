--[[
    EmuDevs <http://emudevs.com/forum.php>
    Eluna Lua Engine <https://github.com/ElunaLuaEngine/Eluna>
    Eluna Scripts <https://github.com/ElunaLuaEngine/Scripts>
    Eluna Wiki <http://wiki.emudevs.com/doku.php?id=eluna>

    -= Script Information =-
    * Script Type: Trash Mob
    * Npc: Searing Blade Warlock <11324>
--]]
require("eluna_globals")

-- variable definitions
local NPC_SEARING_BLADE_WARLOCK = 11324
local SPELL_SUMMON_VOIDWALKER = 12746
local SPELL_SHADOWBOLT = 20791

-- function definitions
local function EnterCombat() end 
local function CastShadowBolt() end 
local function CastSummonVoidwalker() end 
local function Reset() end 

EnterCombat = function (event, creature, target)
    creature:RegisterEvent(CastShadowBolt, 0, 1)
end

CastShadowBolt = function (event, delay, pCall, creature)
    creature:CastSpell(creature:GetVictim(), SPELL_SHADOWBOLT)
    creature:RegisterEvent(CastShadowBolt, math.random(3300,4900), 1)
end

CastSummonVoidwalker = function (event, creature)
    -- cast summon void walker -- channeled
    creature:RegisterEvent(function(event, delay, pCall, creature) 
        creature:CastSpell(creature, SPELL_SUMMON_VOIDWALKER, true)
    end, 1000, 1)
end

Reset = function (event, creature)
    creature:RemoveEvents()
end

RegisterCreatureEvent(NPC_SEARING_BLADE_WARLOCK, CREATURE_EVENT_ON_ENTER_COMBAT, EnterCombat)
RegisterCreatureEvent(NPC_SEARING_BLADE_WARLOCK, CREATURE_EVENT_ON_LEAVE_COMBAT, Reset)
RegisterCreatureEvent(NPC_SEARING_BLADE_WARLOCK, CREATURE_EVENT_ON_DIED, Reset)
RegisterCreatureEvent(NPC_SEARING_BLADE_WARLOCK, CREATURE_EVENT_ON_SPAWN, CastSummonVoidwalker)
RegisterCreatureEvent(NPC_SEARING_BLADE_WARLOCK, CREATURE_EVENT_ON_REACH_HOME, CastSummonVoidwalker)
