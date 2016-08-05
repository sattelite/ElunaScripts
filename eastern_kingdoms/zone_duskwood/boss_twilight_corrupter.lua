--[[
    EmuDevs <http://emudevs.com/forum.php>
    Eluna Lua Engine <https://github.com/ElunaLuaEngine/Eluna>
    Eluna Scripts <https://github.com/ElunaLuaEngine/Scripts>
    Eluna Wiki <http://wiki.emudevs.com/doku.php?id=eluna>

    -= Script Information =-
    * Zone: Duskwood
    * ItemId: 21149
    * AreaTrigger: Twilight Grove
    * Script Type: AreaTrigger & Boss Fight
    * Npc: Twilight Corrupter <15625>
--]]

local NPC_TWILIGHT_CORRUPTER = 15625
local SPELL_LEVEL_UP = 24312
local SPELL_CORRUPTION = 25805
local SPELL_CREATURE_OF_NIGHTMARE = 25806

local killCount = 0
local corrupter = nil

function OnTrigger(event, player, triggerId)
    if (triggerId == 4017 and player:HasQuestForItem(21149) and corrupter == nil) then
        corrupter = player:SpawnCreature(NPC_TWILIGHT_CORRUPTER, -10328.16, -489.57, 49.95, 0, 1, 60000)
        if (corrupter ~= nil) then
            corrupter:SetFaction(14)
            corrupter:SetMaxHealth(832750)
            corrupter:SendCreatureTalk(0, player:GetGUID())
        end
    end
end

function Reset(event, creature)
    creature:RemoveEvents()
    killCount = 0
end

function OnEnterCombat(event, creature, target)
    creature:RegisterEvent(CastSoulCorruption, math.random(4000) + 15000, 0)
    creature:RegisterEvent(CastCreatureOfNightmare, 45000, 0)
end

function OnKilledUnit(event, creature, victim)
    if (victim:GetUnitType() == "Player") then
        killCount = killCount + 1
        creature:SendCreatureTalk(2, victim:GetGUID())
        if (killCount == 3) then
            creature:CastSpell(creature, SPELL_LEVEL_UP, true)
            killCount = 0
        end
    end
end

function OnDied(event, creature, killer)
    creature:RemoveEvents()
    corrupter = nil
end

function CastSoulCorruption(event, delay, pCall, creature)
    creature:CastSpell(creature:GetVictim(), SPELL_CORRUPTION)
end

function CastCreatureOfNightmare(event, delay, pCall, creature)
    creature:CastSpell(creature:GetVictim(), SPELL_CREATURE_OF_NIGHTMARE)
end

RegisterServerEvent(24, OnTrigger)
RegisterCreatureEvent(NPC_TWILIGHT_CORRUPTER, 1, OnEnterCombat)
RegisterCreatureEvent(NPC_TWILIGHT_CORRUPTER, 3, OnKilledUnit)
RegisterCreatureEvent(NPC_TWILIGHT_CORRUPTER, 4, OnDied)
RegisterCreatureEvent(NPC_TWILIGHT_CORRUPTER, 23, Reset)
