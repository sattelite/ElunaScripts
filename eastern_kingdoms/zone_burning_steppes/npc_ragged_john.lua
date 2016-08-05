--[[
    EmuDevs <http://emudevs.com/forum.php>
    Eluna Lua Engine <https://github.com/ElunaLuaEngine/Eluna>
    Eluna Scripts <https://github.com/ElunaLuaEngine/Scripts>
    Eluna Wiki <http://wiki.emudevs.com/doku.php?id=eluna>

    -= Script Information =-
    * Zone: Burning Steppes
    * QuestId: 4224 / 4866
    * Script Type: Quest Gossip
    * Npc: Ragged John <9563>
--]]

local NPC_RAGGED_JOHN = 9563
local SPELL_MOTHERS_MILK = 16468
local SPELL_WICKED_MILKING = 16472

local Gossip =
{
    { 1, 2, "So what did you do?", 2714 },
    { 2, 3,  "Start making sense, dwarf. I don't want to have anything to do with your cracker, your pappy, or any sort of 'discreditin'.", 2715 },
    { 3, 4,  "Ironfoe?", 2716 },
    { 4, 5,  "Interesting... continue John.", 2717 },
    { 5, 6,  "So that's how Windsor died...", 2718 },
    { 6, 7,  "So how did he die?", 2719 },
    { 7, 8,  "Ok so where the hell is he? Wait a minute! Are you drunk?", 2720 },
    { 8, 9,  "WHY is he in Blackrock Depths?", 2721 },
    { 9, 10,  "300? So the Dark Irons killed him and dragged him into the Depths?", 2722 },
    { 10, 11,  "Ahh... Ironfoe", 2723 },
    { 11, 12,  "Thanks, Ragged John. Your story was very uplifting and informative", 2725 }
}

function OnGossipHello(event, player, creature)
    if (creature:IsQuestGiver()) then
        player:GossipAddQuests(creature)
    end

    if (player:GetQuestStatus(4224) == 3) then
        player:GossipMenuAddItem(0, "Official buisness, John. I need some information about Marsha Windsor. Tell me about the last time you saw him.", 0, 1)
    end
    player:GossipSendMenu(2713, creature)
end

function OnGossipSelect(event, player, creature, sender, intid, code)
    player:GossipClearMenu()
    if (intid == 12) then
        player:GossipComplete()
        player:AreaExploredOrEventHappens(4224)
        return
    end

    if (intid == Gossip[intid][1]) then
        player:GossipMenuAddItem(0, Gossip[intid][3], 0, Gossip[intid][2])
        player:GossipSendMenu(Gossip[intid][4], creature)
    end
end

function OnMoveInLOS(event, creature, unit)
    if (unit:HasAura(SPELL_MOTHERS_MILK)) then
        if (unit:GetUnitType() == "Player" and creature:IsWithinDistInMap(unit, 15) and unit:IsInAccessiblePlaceFor(creature)) then
            creature:CastSpell(unit, SPELL_WICKED_MILKING)
            unit:AreaExploredOrEventHappens(4866)
        end
    end
end

RegisterCreatureGossipEvent(NPC_RAGGED_JOHN, 1, OnGossipHello)
RegisterCreatureGossipEvent(NPC_RAGGED_JOHN, 2, OnGossipSelect)
RegisterCreatureEvent(NPC_RAGGED_JOHN, 27, OnMoveInLOS)
