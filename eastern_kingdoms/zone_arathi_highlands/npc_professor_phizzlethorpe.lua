--[[
    EmuDevs <http://emudevs.com/forum.php>
    Eluna Lua Engine <https://github.com/ElunaLuaEngine/Eluna>
    Eluna Scripts <https://github.com/ElunaLuaEngine/Scripts>
    Eluna Wiki <http://wiki.emudevs.com/doku.php?id=eluna>

    -= Script Information =-
    * Zone: Arathi Highlands
    * QuestId: 665
    * Script Type: Quest Escort
    * Npc: Professor Phizzlethorpe <2768>
--]]
require("eluna_globals")

-- variable definitions
local NPC_PROFESSOR_PHIZZLETHORPE = 2768
local waypoints =
{
    { 1, 1, -2073.519, -2123.502, 18.433033 },
    { 4, 5, -2073.519, -2123.502, 18.433033 },
    { 5, 6, -2074.780, -2089.530, 8.972266 },
    { 6, 7, -2074.940, -2089.247, 8.911692 },
    { 8, 8, -2066.248, -2086.332, 9.009366 }
}
local escortPlayer = nil
local currentWP = 0

-- function definitions
local function OnQuestAccept() end
local function EnterCombat() end
local function WaypointReached() end
local function JustSummoned() end
local function Move() end
local function MoveForward() end
local function Summon() end
local function AlmostDone() end
local function Finish() end

OnQuestAccept = function (event, player, creature, quest)
    if (quest:GetId() == 665) then
        escortPlayer = player
        currentWP = 0
        creature:SendCreatureTalk(0, player:GetGUIDLow())
        creature:SetWalk(true)
        creature:MoveTo(0, -2077.985, -2093.242, 10.001955)
        creature:SetFaction(35)
    end
end

EnterCombat = function (event, creature, target)
    creature:SendCreatureTalk(4, 0)
end

WaypointReached = function (event, creature, pointType, waypointId)
    currentWP = waypointId + 1
    local delay = 0

    if (currentWP == 1) then
        delay = 1000
    elseif (currentWP == 2) then
        creature:SendCreatureTalk(1, escortPlayer:GetGUIDLow())
        creature:RegisterEvent(MoveForward, 3500, 1)
    elseif (currentWP == 3) then
        creature:SendCreatureTalk(3, 0)
        creature:RegisterEvent(Summon, 8000, 1)
        creature:RegisterEvent(AlmostDone, 15000, 1)
        creature:RegisterEvent(Finish, 22000, 1)
    elseif (currentWP == 4) then
        delay = 1000
        creature:SendCreatureTalk(7, escortPlayer:GetGUIDLow())
    elseif (currentWP == 6) then
        delay = 2000
    elseif (currentWP == 8) then
        delay = 1000
    elseif (currentWP == 9) then
        creature:RemoveEvents()
        creature:SendCreatureTalk(8, 0)
        creature:SendCreatureTalk(9, escortPlayer:GetGUIDLow())
        escortPlayer:GroupEventHappens(665, creature)
        creature:Despawn(3000)
        escortPlayer = nil
        currentWP = 0
    end
    if (delay > 0) then
        creature:RegisterEvent(Move, delay, 1)
    end
end

JustSummoned = function (event, creature, summoned)
    summoned:AttackStart(escortPlayer)
end

Move = function (event, delay, pCall, creature)
    for k in pairs(waypoints) do
        if (waypoints[k][1] == currentWP) then
            creature:MoveTo(waypoints[k][2], waypoints[k][3], waypoints[k][4], waypoints[k][5])
        end
    end
end

MoveForward = function (event, delay, pCall, creature)
    creature:SendCreatureTalk(2, escortPlayer:GetGUIDLow())
    creature:MoveTo(currentWP, -2043.243, -2154.018, 20.232119)
end

Summon = function (event, delay, pCall, creature)
    creature:SpawnCreature(2776, -2052.96, -2142.49, 20.15, 1.0, 5, 0)
    creature:SpawnCreature(2776, -2052.96, -2142.49, 20.15, 1.0, 5, 0)
end

AlmostDone = function (event, delay, pCall, creature)
    creature:SendCreatureTalk(5, escortPlayer:GetGUIDLow())
end

Finish = function (event, delay, pCall, creature)
    creature:SendCreatureTalk(6, escortPlayer:GetGUIDLow())
    creature:SetWalk(false)
    creature:MoveTo(currentWP, -2070.117, -2126.960, 19.514397)
end

RegisterCreatureEvent(NPC_PROFESSOR_PHIZZLETHORPE, CREATURE_EVENT_ON_ENTER_COMBAT,  EnterCombat)
RegisterCreatureEvent(NPC_PROFESSOR_PHIZZLETHORPE, CREATURE_EVENT_ON_REACH_WP,  WaypointReached)
RegisterCreatureEvent(NPC_PROFESSOR_PHIZZLETHORPE, CREATURE_EVENT_ON_JUST_SUMMONED_CREATURE, JustSummoned)
RegisterCreatureEvent(NPC_PROFESSOR_PHIZZLETHORPE, CREATURE_EVENT_ON_QUEST_ACCEPT, OnQuestAccept)
