--[[
    EmuDevs <http://emudevs.com/forum.php>
    Eluna Lua Engine <https://github.com/ElunaLuaEngine/Eluna>
    Eluna Scripts <https://github.com/ElunaLuaEngine/Scripts>
    Eluna Wiki <http://wiki.emudevs.com/doku.php?id=eluna>

    -= Script Information =-
    * Script Type: Boss Fight
    * Npc: Kruul <18338>
--]]

local NPC_KRUUL = 18338
local SPELL_CAPTURE_SOUL = 21054
local SPELL_SHADOW_VOLLEY = 21341
local SPELL_CLEAVE = 20677
local SPELL_THUNDERCLAP = 23931
local SPELL_TWISTED_REFLECTION = 21063
local SPELL_VOID_BOLT = 21066
local SPELL_RAGE = 21340
local CREATURE_INFERNAL_HOUND = 19207


function OnEnterCombat(event, creature, target)
    creature:RegisterEvent(CastShadowVolley, 10000, 0)
    creature:RegisterEvent(CastCleave, 14000, 0)
    creature:RegisterEvent(CastThunderClap, 20000, 0)
    creature:RegisterEvent(CastTwistedReflection, 25000, 0)
    creature:RegisterEvent(CastVoidBolt, 30000, 0)
    creature:RegisterEvent(CastRage, 60000, 0)
    creature:RegisterEvent(SpawnHounds, 8000, 1)
end

function OnKilledTarget(event, creature, victim)
    creature:CastSpell(creature, SPELL_CAPTURE_SOUL)
end

function CastShadowVolley(event, delay, pCall, creature)
    creature:CastSpell(creature:GetVictim(), SPELL_SHADOW_VOLLEY)
end

function CastCleave(event, delay, pCall, creature)
    creature:CastSpell(creature:GetVictim(), SPELL_CLEAVE)
end

function CastThunderClap(event, delay, pCall, creature)
    creature:CastSpell(creature:GetVictim(), SPELL_THUNDERCLAP)
end

function CastTwistedReflection(event, delay, pCall, creature)
    creature:CastSpell(creature:GetVictim(), SPELL_TWISTED_REFLECTION)
end

function CastVoidBolt(event, delay, pCall, creature)
    creature:CastSpell(creature:GetVictim(), SPELL_VOID_BOLT)
end

function CastRage(event, delay, pCall, creature)
    creature:CastSpell(creature, SPELL_RAGE)
end

function SummonHound(creature, target)
    local x, y, z = GetRelativePoint(math.random()*9, math.random()*math.pi*2)
    local hound = creature:SpawnCreature(CREATURE_INFERNAL_HOUND, x, y, z, 0, 2, 300000)
    if (hound) then
        hound:AttackStart(target)
    end
end

function SpawnHounds(event, delay, pCall, creature)
    SummonHound(creature, creature:GetVictim())
    SummonHound(creature, creature:GetVictim())
    SummonHound(creature, creature:GetVictim())
    creature:RegisterEvent(SpawnHounds, 45000, 0)
end

function Reset(event, creature)
    creature:RemoveEvents()
end

RegisterCreatureEvent(NPC_KRUUL, 1, OnEnterCombat) -- onEnterCombat
RegisterCreatureEvent(NPC_KRUUL, 2, Reset) -- onLeaveCombat
RegisterCreatureEvent(NPC_KRUUL, 3, OnKilledTarget) -- onTargetDied
RegisterCreatureEvent(NPC_KRUUL, 4, Reset) -- onDied
