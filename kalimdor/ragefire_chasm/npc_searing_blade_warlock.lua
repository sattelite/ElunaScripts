--[[
    EmuDevs <http://emudevs.com/forum.php>
    Eluna Lua Engine <https://github.com/ElunaLuaEngine/Eluna>
    Eluna Scripts <https://github.com/ElunaLuaEngine/Scripts>
    Eluna Wiki <http://wiki.emudevs.com/doku.php?id=eluna>

    -= Script Information =-
    * Script Type: Trash Mob
    * Npc: Searing Blade Warlock <11324>
--]]

local NPC_SEARING_BLADE_WARLOCK = 11324
local SPELL_SUMMON_VOIDWALKER = 12746
local SPELL_SHADOWBOLT = 20791

function OnEnterCombat(event, creature, target)
    creature:RegisterEvent(CastShadowBolt, 3000, 0)
end

function CastShadowBolt(event, delay, pCall, creature)
    creature:CastSpell(creature:GetVictim(), SPELL_SHADOWBOLT)
end

function OnReachHome(event, creature)
    creature:CastSpell(creature, SPELL_SUMMON_VOIDWALKER, true)
end

function Reset(event, creature)
    creature:RemoveEvents()
end

RegisterCreatureEvent(NPC_SEARING_BLADE_WARLOCK, 1, OnEnterCombat) -- OnEnterCombat
RegisterCreatureEvent(NPC_SEARING_BLADE_WARLOCK, 2, Reset) -- OnLeaveCombat
RegisterCreatureEvent(NPC_SEARING_BLADE_WARLOCK, 4, Reset) -- OnDied
RegisterCreatureEvent(NPC_SEARING_BLADE_WARLOCK, 24, OnReachHome) -- OnReachHome
