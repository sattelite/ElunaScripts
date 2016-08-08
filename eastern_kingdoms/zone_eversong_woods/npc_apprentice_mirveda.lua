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
require("eluna_globals")

-- variable definitions
local NPC_APPRENTICE_MIRVEDA = 15402
local NPC_GHARSUL_THE_REMORSELESS = 15958
local NPC_ANGERSHADE = 15656
local killCount = 0
local playerGUID = 0

-- function definitions
local function QuestAccept() end
local function SpawnCreatures() end
local function IsQuestComplete() end
local function Reset() end
local function Died() end
local function JustSummoned() end
local function SummonedDespawn() end

QuestAccept = function (event, player, creature, quest)
    if (quest:GetId() == 8488) then
        playerGUID = player:GetGUIDLow()
        creature:RegisterEvent(SpawnCreatures, 1200, 1)
        creature:RegisterEvent(IsQuestComplete, 1000, 0)
    end
end

SpawnCreatures = function (event, delay, pCall, creature)
    creature:SpawnCreature(NPC_GHARSUL_THE_REMORSELESS, 8725, -7153.93, 35.23, 0, 2, 4000)
    creature:SpawnCreature(NPC_ANGERSHADE, 8725, -7153.93, 35.23, 0, 2, 4000)
    creature:SpawnCreature(NPC_ANGERSHADE, 8725, -7153.93, 35.23, 0, 2, 4000)
end

IsQuestComplete = function (event, delay, pCall, creature)
    if (killCount >= 3 and playerGUID > 0) then
        creature:RemoveEventById(event)
        local player = GetPlayerByGUID(playerGUID)
        if (player ~= nil) then
            player:CompleteQuest(8488)
        end
    end
end

Reset = function ()
    killCount = 0
    playerGUID = 0
end

Died = function (event, creature, killer)
    creature:RemoveEvents()
    if (playerGUID > 0) then
        local player = GetPlayerByGUID(playerGUID)
        if (player ~= nil) then
            player:FailQuest(8488)
        end
    end
end

JustSummoned = function (event, creature, summoned)
    summoned:AttackStart(creature)
    summoned:MoveChase(creature)
end

SummonedDespawn = function (event, creature, summoned)
    killCount = killCount + 1
end

RegisterCreatureEvent(NPC_APPRENTICE_MIRVEDA, CREATURE_EVENT_ON_DIED, Died)
RegisterCreatureEvent(NPC_APPRENTICE_MIRVEDA, CREATURE_EVENT_ON_JUST_SUMMONED_CREATURE, JustSummoned)
RegisterCreatureEvent(NPC_APPRENTICE_MIRVEDA, CREATURE_EVENT_ON_SUMMONED_CREATURE_DESPAWN, SummonedDespawn)
RegisterCreatureEvent(NPC_APPRENTICE_MIRVEDA, CREATURE_EVENT_ON_RESET, Reset)
RegisterCreatureEvent(NPC_APPRENTICE_MIRVEDA, CREATURE_EVENT_ON_QUEST_ACCEPT, OnQuestAccept)

