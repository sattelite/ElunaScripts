--[[
    EmuDevs <http://emudevs.com/forum.php>
    Eluna Lua Engine <https://github.com/ElunaLuaEngine/Eluna>
    Eluna Scripts <https://github.com/ElunaLuaEngine/Scripts>
    Eluna Wiki <http://wiki.emudevs.com/doku.php?id=eluna>

    -= Script Information =-
    * Zone: Eversong Woods
    * QuestId: 8490
    * Script Type: Gossip, CreatureAI and Quest
    * Npc: Infused Crystal <16364>
--]]

local NPC_INFUSED_CRYSTAL = 16364
local NPC_ENRAGED_WRAITH = 17086

local Spawns =
{
    { 8270.68, -7188.53, 139.619 },
    { 8284.27, -7187.78, 139.603 },
    { 8297.43, -7193.53, 139.603 },
    { 8303.5, -7201.96, 139.577 },
    { 8273.22, -7241.82, 139.382 },
    { 8254.89, -7222.12, 139.603 },
    { 8278.51, -7242.13, 139.162 },
    { 8267.97, -7239.17, 139.517 }
}

local completed = false
local started = false
local playerGUID = 0

function OnDied(event, creature, killer)
    creature:RemoveEvents()
    if (playerGUID > 0 and not completed) then
        local player = GetPlayerByGUID(playerGUID)
        if (player ~= nil) then
            player:FailQuest(8490)
        end
    end
end

function OnReset(event, creature)
    playerGUID = 0
    started = false
    completed = false
end

function OnMoveLOS(event, creature, unit)
    if (unit:GetUnitType() == "Player" and creature:IsWithinDistInMap(unit, 10) and not started) then
        if (unit:GetQuestStatus(8490) == 3) then
            playerGUID = unit:GetGUIDLow()
            creature:RegisterEvent(WaveStart, 1000, 1)
            creature:RegisterEvent(Complete, 60000, 1)
            started = true
        end
    end
end

function WaveStart(event, delay, pCall, creature)
    if (started and not completed) then
        local rand1 = math.random(8)
        local rand2 = math.random(8)
        local rand3 = math.random(8)
        creature:SpawnCreature(NPC_ENRAGED_WRAITH, Spawns[rand1][1], Spawns[rand1][2], Spawns[rand1][3], 0, 2, 10000)
        creature:SpawnCreature(NPC_ENRAGED_WRAITH, Spawns[rand2][1], Spawns[rand2][2], Spawns[rand2][3], 0, 2, 10000)
        creature:SpawnCreature(NPC_ENRAGED_WRAITH, Spawns[rand3][1], Spawns[rand3][2], Spawns[rand3][3], 0, 2, 10000)
        creature:RegisterEvent(WaveStart, 30000, 0)
    end
end

function Complete(event, delay, pCall, creature)
    if (started) then
        creature:RemoveEvents()
        creature:SendCreatureTalk(0, playerGUID)
        completed = true
        if (playerGUID > 0) then
            local player = GetPlayerByGUID(playerGUID)
            if (player ~= nil) then
                player:CompleteQuest(8490)
            end
        end
        creature:DealDamage(creature, creature:GetHealth())
        creature:RemoveCorpse()
    end
end

function OnSummoned(event, creature, summoned)
    local player = GetPlayerByGUID(playerGUID)
    if (player ~= nil) then
        summoned:AttackStart(player)
    end
end

RegisterCreatureEvent(NPC_INFUSED_CRYSTAL, 4, OnDied)
RegisterCreatureEvent(NPC_INFUSED_CRYSTAL, 19, OnSummoned)
RegisterCreatureEvent(NPC_INFUSED_CRYSTAL, 23, OnReset)
RegisterCreatureEvent(NPC_INFUSED_CRYSTAL, 27, OnMoveLOS)
