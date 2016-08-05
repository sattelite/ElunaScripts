--[[
    EmuDevs <http://emudevs.com/forum.php>
    Eluna Lua Engine <https://github.com/ElunaLuaEngine/Eluna>
    Eluna Scripts <https://github.com/ElunaLuaEngine/Scripts>
    Eluna Wiki <http://wiki.emudevs.com/doku.php?id=eluna>

    -= Script Information =-
    * Zone: Eastern Plaugelands
    * QuestId: 5742
    * Script Type: Gossip
    * Npc: Tirion Fordring <1855>
--]]

NPC_TIRION_FORDRING = 1855

function OnGossipHello(event, player, creature)
    if (creature:IsQuestGiver()) then
        player:GossipAddQuests(creature)
    end

    if (player:GetQuestStatus(5742) == 3 and player:GetStandState() == 1) then
        player:GossipMenuAddItem(0, "I am ready to hear your tale, Tirion.", 0, 1)
    end
    player:GossipSendMenu(player:GetGossipTextId(creature), creature)
end

function OnGossipSelect(event, player, creature, sender, intid, code)
    player:GossipClearMenu()
    if (intid == 1) then
        player:GossipMenuAddItem(0, "Thank you, Tirion.  What of your identity?", 0, 2)
        player:GossipSendMenu(4493, creature)
    elseif (intid == 2) then
        player:GossipMenuAddItem(0, "That is terrible.", 0, 3)
        player:GossipSendMenu(4494, creature)
    elseif (intid == 3) then
        player:GossipMenuAddItem(0, "I will, Tirion.", 0, 4)
        player:GossipSendMenu(4495, creature)
    elseif (intid == 3) then
        player:GossipComplete()
        player:AreaExploredOrEventHappens(5742)
    end
end

RegisterCreatureGossipEvent(NPC_TIRION_FORDRING, 1, OnGossipHello)
RegisterCreatureGossipEvent(NPC_TIRION_FORDRING, 2, OnGossipSelect)
