--[[
    EmuDevs <http://emudevs.com/forum.php>
    Eluna Lua Engine <https://github.com/ElunaLuaEngine/Eluna>
    Eluna Scripts <https://github.com/ElunaLuaEngine/Scripts>
    Eluna Wiki <http://wiki.emudevs.com/doku.php?id=eluna>

    -= Script Information =-
    * Script Type: Boss Fight
    * Npc: Taragaman the Hungerer <11520>
--]]

local BOSS_TARAGAMAN = 11520
local SPELL_UPPERCUT = 18072
local SPEL_FIRE_NOVA = 11970


function OnEnterCombat(event, creature, target)
    creature:RegisterEvent(CastUppercut, 5000, 0)
    creature:RegisterEvent(CastFireNova, 8000, 0)
end

function CastUppercut(event, delay, pCall, creature)
    if (math.random(1, 100) <= 85) then
        creature:CastSpell(creature:GetVictim(), SPELL_UPPERCUT)
    end
end

function CastFireNova(event, delay, pCall, creature)
    if (math.random(1, 100) <= 75) then
        creature:CastSpell(creature:GetVictim(), SPEL_FIRE_NOVA)
    end
end

function Reset(event, creature)
    creature:RemoveEvents()
end

RegisterCreatureEvent(BOSS_TARAGAMAN, 1, OnEnterCombat) -- OnEnterCombat
RegisterCreatureEvent(BOSS_TARAGAMAN, 2, Reset) -- OnLeaveCombat
RegisterCreatureEvent(BOSS_TARAGAMAN, 4, Reset) -- OnDied
