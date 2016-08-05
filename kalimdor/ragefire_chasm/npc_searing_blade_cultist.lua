--[[
    EmuDevs <http://emudevs.com/forum.php>
    Eluna Lua Engine <https://github.com/ElunaLuaEngine/Eluna>
    Eluna Scripts <https://github.com/ElunaLuaEngine/Scripts>
    Eluna Wiki <http://wiki.emudevs.com/doku.php?id=eluna>

    -= Script Information =-
    * Script Type: Trash Mob
    * Npc: Searing Blade Cultist <11322>
--]]

local NPC_SEARING_BLADE_CULTIST = 11322
local SPELL_CURSE_OF_AGONY = 18266

function OnEnterCombat(event, creature, target)
    creature:RegisterEvent(CastCurseofAgony, 12000, 0)
end

function CastCurseOfAgony(event, delay, pCall, creature)
    if (math.random(1, 100) <= 85) then
        local players = creature:GetPlayersInRange()
        creature:CastSpell(players[math.random(1, #players)], SPELL_CURSE_OF_AGONY)
    end
end

function Reset(event, creature)
    creature:RemoveEvents()
end

RegisterCreatureEvent(NPC_SEARING_BLADE_CULTIST, 1, OnEnterCombat) -- OnEnterCombat
RegisterCreatureEvent(NPC_SEARING_BLADE_CULTIST, 2, Reset) -- OnLeaveCombat
RegisterCreatureEvent(NPC_SEARING_BLADE_CULTIST, 4, Reset) -- OnDied
