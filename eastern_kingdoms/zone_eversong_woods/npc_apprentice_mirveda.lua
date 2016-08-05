--[[
    EmuDevs <http://emudevs.com/forum.php>
    Eluna Lua Engine <https://github.com/ElunaLuaEngine/Eluna>
    Eluna Scripts <https://github.com/ElunaLuaEngine/Scripts>
    Eluna Wiki <http://wiki.emudevs.com/doku.php?id=eluna>

    -= Script Information =-
    * Zone: Eversong Woods
    * QuestId: 8488
    * Script Type: Gossip, CreatureAI and Quest
    * Npc: Apprentice Mirveda <15402>
--]]

local NPC_APPRENTICE_MIRVEDA = 15402
local NPC_GHARSUL_THE_REMORSELESS = 15958
local NPC_ANGERSHADE = 15656

local killCount = 0
local playerGUID = 0

function OnQuestAccept(event, player, creature, quest)
    if (quest:GetId() == 8488) then
        playerGUID = player:GetGUIDLow()
        creature:RegisterEvent(SpawnCreature, 1200, 1)
        creature:RegisterEvent(QuestComplete, 1000, 0)
    end
end

function SpawnCreature(event, delay, pCall, creature)
    creature:SpawnCreature(NPC_GHARSUL_THE_REMORSELESS, 8725, -7153.93, 35.23, 0, 2, 4000)
    creature:SpawnCreature(NPC_ANGERSHADE, 8725, -7153.93, 35.23, 0, 2, 4000)
    creature:SpawnCreature(NPC_ANGERSHADE, 8725, -7153.93, 35.23, 0, 2, 4000)
end

function QuestComplete(event, delay, pCall, creature)
    if (killCount >= 3 and playerGUID > 0) then
        creature:RemoveEventById(event)
        local player = GetPlayerByGUID(playerGUID)
        if (player ~= nil) then
            player:CompleteQuest(8488)
        end
    end
end

function Reset()
    killCount = 0
    playerGUID = 0
end

function OnDied(event, creature, killer)
    creature:RemoveEvents()
    if (playerGUID > 0) then
        local player = GetPlayerByGUID(playerGUID)
        if (player ~= nil) then
            player:FailQuest(8488)
        end
    end
end

function OnJustSummoned(event, creature, summoned)
    summoned:AttackStart(creature)
    summoned:MoveChase(creature)
end

function OnSummonedDespawn(event, creature, summoned)
    killCount = killCount + 1
end

RegisterCreatureEvent(NPC_APPRENTICE_MIRVEDA, 4, OnDied)
RegisterCreatureEvent(NPC_APPRENTICE_MIRVEDA, 19, OnJustSummoned)
RegisterCreatureEvent(NPC_APPRENTICE_MIRVEDA, 20, OnSummonedDespawn)
RegisterCreatureEvent(NPC_APPRENTICE_MIRVEDA, 23, Reset)
RegisterCreatureEvent(NPC_APPRENTICE_MIRVEDA, 31, OnQuestAccept)

