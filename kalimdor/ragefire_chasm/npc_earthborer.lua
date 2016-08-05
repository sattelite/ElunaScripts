--[[
    EmuDevs <http://emudevs.com/forum.php>
    Eluna Lua Engine <https://github.com/ElunaLuaEngine/Eluna>
    Eluna Scripts <https://github.com/ElunaLuaEngine/Scripts>
    Eluna Wiki <http://wiki.emudevs.com/doku.php?id=eluna>

    -= Script Information =-
    * Script Type: Trash Mob
    * Npc: Earthborer <11320>
--]]

local NPC_EARTHBORER = 11320
local SPELL_EARTHBORER_ACID = 18070

function OnEnterCombat(event, creature, target)
    creature:RegisterEvent(CastEarthborerAcid, 6000, 0)
end

function CastEarthborerAcid(event, delay, pCall, creature)
    if (math.random(1, 100) <= 70) then
        creature:CastSpell(creature:GetVictim(), SPELL_EARTHBORER_ACID)
    end
end

function Reset(event, creature)
    creature:RemoveEvents()
end

RegisterCreatureEvent(NPC_EARTHBORER, 1, OnEnterCombat) -- OnEnterCombat
RegisterCreatureEvent(NPC_EARTHBORER, 2, Reset) -- OnLeaveCombat
RegisterCreatureEvent(NPC_EARTHBORER, 4, Reset) -- OnDied
