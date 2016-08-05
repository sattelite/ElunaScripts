--[[
    EmuDevs <http://emudevs.com/forum.php>
    Eluna Lua Engine <https://github.com/ElunaLuaEngine/Eluna>
    Eluna Scripts <https://github.com/ElunaLuaEngine/Scripts>
    Eluna Wiki <http://wiki.emudevs.com/doku.php?id=eluna>

    -= Script Information =-
    * Script Type: Boss Fight
    * Npc: Oggleflint <11517>
--]]

local BOSS_OFFLEFLINT = 11517
local SPELL_CLEAVE = 40505

function OnEnterCombat(event, creature, target)
    creature:RegisterEvent(CastCleave, 8000, 0)
end

function CastCleave(event, delay, pCall, creature)
    if (math.random(1, 100) <= 70) then
        creature:CastSpell(creature:GetVictim(), SPELL_CLEAVE)
    end
end

function Reset(event, creature)
    creature:RemoveEvents()
end

RegisterCreatureEvent(BOSS_OFFLEFLINT, 1, OnEnterCombat) -- OnEnterCombat
RegisterCreatureEvent(BOSS_OFFLEFLINT, 2, Reset) -- OnLeaveCombat
RegisterCreatureEvent(BOSS_OFFLEFLINT, 4, Reset) -- OnDied
