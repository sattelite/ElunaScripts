--[[
    EmuDevs <http://emudevs.com/forum.php>
    Eluna Lua Engine <https://github.com/ElunaLuaEngine/Eluna>
    Eluna Scripts <https://github.com/ElunaLuaEngine/Scripts>
    Eluna Wiki <http://wiki.emudevs.com/doku.php?id=eluna>

    -= Script Information =-
    * Zone: Eastern Plaugelands
    * QuestId: 6164
    * Script Type: Quest
    * Npc: Augustus the Touched <12384>
--]]
require("eluna_globals")

-- variable definitions
local NPC_AUGUSTUS_THE_TOUCHED = 12384

-- function definitions
local function GossipHello() end
local function GossipSelect() end

GossipHello = function (event, player, creature)
    if (creature:IsQuestGiver()) then
        player:GossipAddQuests(creature)
    end

    if (creature:IsVendor() and player:GetQuestRewardStatus(6164)) then
        player:GossipMenuAddItem(0, "I'd like to browse your goods.", 0, 1)
    end
    player:GossipSendMenu(player:GetGossipTextId(creature), creature)
end

GossipSelect = function (event, player, creature, sender, intid, code)
    player:GossipClearMenu()
    if (intid == 1) then
        player:SendListInventory(creature)
    end
end

RegisterCreatureGossipEvent(NPC_AUGUSTUS_THE_TOUCHED, GOSSIP_EVENT_ON_HELLO, GossipHello)
RegisterCreatureGossipEvent(NPC_AUGUSTUS_THE_TOUCHED, GOSSIP_EVENT_ON_SELECT, GossipSelect)
