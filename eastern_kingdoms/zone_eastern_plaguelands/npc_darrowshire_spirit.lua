--[[
    EmuDevs <http://emudevs.com/forum.php>
    Eluna Lua Engine <https://github.com/ElunaLuaEngine/Eluna>
    Eluna Scripts <https://github.com/ElunaLuaEngine/Scripts>
    Eluna Wiki <http://wiki.emudevs.com/doku.php?id=eluna>

    -= Script Information =-
    * Zone: Eastern Plaugelands
    * Script Type: Gossip & Quest
    * Npc: Darrowshire Spirit <11064> 
--]]
require("eluna_globals")

-- variable definitions
local NPC_DARROWSHIRE_SPIRIT = 11064
local NPC_CANNIBAL_GHOUL = 8530
local NPC_GIBBERING_GHOUL = 8531
local NPC_DISEASED_FLAYER = 8532
local NPC_DARROWSHIRE_SPIRIT = 11064
local SPELL_SPIRIT_SPAWN_IN = 17321

-- function definitions
local function GossipHello() end
local function Reset() end
local function Died() end

-- Darrowshire Spirit
GossipHello = function (event, player, creature)
    player:GossipSendMenu(3873, creature)
    player:TalkedToCreature(creature:GetEntry(), creature)
    creature:SetFlag(59, 33554432)
end

Reset = function (event, creature)
    creature:CastSpell(creature, SPELL_SPIRIT_SPAWN_IN)
    creature:RemoveFlag(59, 33554432)
end

RegisterCreatureGossipEvent(NPC_DARROWSHIRE_SPIRIT, GOSSIP_EVENT_ON_HELLO, GossipHello)
RegisterCreatureEvent(NPC_DARROWSHIRE_SPIRIT, CREATURE_EVENT_ON_RESET, Reset)

-- Ghoul/Flayer
Died = function (event, creature, killer)
    if (killer:GetUnitType() == "Player") then
        creature:SpawnCreature(NPC_DARROWSHIRE_SPIRIT, 0, 0, 0, 0, 3, 60000)
    end
end

RegisterCreatureEvent(NPC_CANNIBAL_GHOUL,  CREATURE_EVENT_ON_DIED, Died)
RegisterCreatureEvent(NPC_GIBBERING_GHOUL, CREATURE_EVENT_ON_DIED, Died)
RegisterCreatureEvent(NPC_DISEASED_FLAYER, CREATURE_EVENT_ON_DIED, Died)

