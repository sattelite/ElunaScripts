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
require("eluna_globals")

-- variable definitions
local NPC_TWILIGHT_CORRUPTER = 15625
local SPELL_LEVEL_UP = 24312
local SPELL_CORRUPTION = 25805
local SPELL_CREATURE_OF_NIGHTMARE = 25806
local killCount = 0
local corrupter = nil

-- function definitions
local function Trigger() end
local function EnterCombat() end
local function Reset() end
local function Died() end
local function CastSoulCorruption() end

Trigger = function (event, player, triggerId)
    if (triggerId == 4017 and player:HasQuestForItem(21149) and corrupter == nil) then
        corrupter = player:SpawnCreature(NPC_TWILIGHT_CORRUPTER, -10328.16, -489.57, 49.95, 0, 1, 60000)
        if (corrupter ~= nil) then
            corrupter:SetFaction(14)
            corrupter:SetMaxHealth(832750)
            corrupter:SendCreatureTalk(0, player:GetGUID())
        end
    end
end


EnterCombat = function (event, creature, target)
    creature:RegisterEvent(CastSoulCorruption, math.random(15000, 19000), 1)
    creature:RegisterEvent(function (event, delay, pCall, creature)
        creature:CastSpell(creature:GetVictim(), SPELL_CREATURE_OF_NIGHTMARE)
    end, 45000, 0)
end

KilledUnit = function (event, creature, victim)
    if (victim:GetUnitType() == "Player") then
        killCount = killCount + 1
        creature:SendCreatureTalk(2, victim:GetGUID())
        if (killCount == 3) then
            creature:CastSpell(creature, SPELL_LEVEL_UP, true)
            killCount = 0
        end
    end
end

CastSoulCorruption = function (event, delay, pCall, creature)
    creature:CastSpell(creature:GetVictim(), SPELL_CORRUPTION)
    creature:RegisterEvent(CastSoulCorruption, math.random(15000, 19000), 1)
end

Died = function (event, creature, killer)
    creature:RemoveEvents()
    corrupter = nil
end

Reset = function (event, creature)
    creature:RemoveEvents()
    killCount = 0
end

RegisterServerEvent(TRIGGER_EVENT_ON_TRIGGER, Trigger)
RegisterCreatureEvent(NPC_TWILIGHT_CORRUPTER, CREATURE_EVENT_ON_ENTER_COMBAT, EnterCombat)
RegisterCreatureEvent(NPC_TWILIGHT_CORRUPTER, CREATURE_EVENT_ON_TARGET_DIED, KilledUnit)
RegisterCreatureEvent(NPC_TWILIGHT_CORRUPTER, CREATURE_EVENT_ON_DIED, Died)
RegisterCreatureEvent(NPC_TWILIGHT_CORRUPTER, CREATURE_EVENT_ON_RESET, Reset)
