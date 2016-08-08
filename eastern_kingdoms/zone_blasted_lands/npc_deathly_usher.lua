--[[
    EmuDevs <http://emudevs.com/forum.php>
    Eluna Lua Engine <https://github.com/ElunaLuaEngine/Eluna>
    Eluna Scripts <https://github.com/ElunaLuaEngine/Scripts>
    Eluna Wiki <http://wiki.emudevs.com/doku.php?id=eluna>

    -= Script Information =-
    * Zone: Blasted Lands
    * QuestId: 3628 <GetQuestStatus>
    * Script Type: Quest Gossip
    * Npc: Deathly Usher <8816>
--]]
require("eluna_globals")

-- variable definitions
local NPC_DEATHLY_USHER = 8816
local ITEM_WARD_OF_THE_DEFILER = 10757
local SPELL_TELEPORT_TO_RAZELIKH = 12885

-- function definitions
local function GossipHello() end 
local function GossipSelect() end 

GossipHello = function (event, player, creature)
    if (player:GetQuestStatus(3628) == 3 and player:HasItem(ITEM_WARD_OF_THE_DEFILER)) then
        player:GossipMenuAddItem(0, "I wish to visit the Rise of the Defiler.", 0, 1)
    end
    player:GossipSendMenu(player:GetGossipTextId(creature), creature)
end

GossipSelect = function (event, player, creature, sender, intid, code)
    player:GossipClearMenu()
    if (intid == 1) then
        player:GossipComplete()
        -- cast teleport to razelikh -- channeled
        creature:CastSpell(player, SPELL_TELEPORT_TO_RAZELIKH, true)
    end
end

RegisterCreatureGossipEvent(NPC_DEATHLY_USHER, GOSSIP_EVENT_ON_HELLO, GossipHello)
RegisterCreatureGossipEvent(NPC_DEATHLY_USHER, GOSSIP_EVENT_ON_SELECT, GossipSelect)
