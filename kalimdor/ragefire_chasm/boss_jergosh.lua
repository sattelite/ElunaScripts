--[[
    EmuDevs <http://emudevs.com/forum.php>
    Eluna Lua Engine <https://github.com/ElunaLuaEngine/Eluna>
    Eluna Scripts <https://github.com/ElunaLuaEngine/Scripts>
    Eluna Wiki <http://wiki.emudevs.com/doku.php?id=eluna>

    -= Script Information =-
    * Script Type: Boss Fight
    * Npc: Jergosh the Invoker <11518>
--]]
require("eluna_globals")

-- variable definitions
local BOSS_JERGOSH = 11518
local SPELL_IMMOLATE = 20800
local SPELL_CURSE_OF_WEAKNESS = 11980

-- function definitions
local function EnterCombat() end
local function CastCurseOfWeakness() end
local function Reset() end


EnterCombat = function(event, creature, target)
    -- cast immolate
    creature:RegisterEvent(function(event, delay, pCall, creature)
        if (math.random(1, 100) <= 85) then
            creature:CastSpell(creature:GetVictim(), SPELL_IMMOLATE)
        end
    end, 12000, 0)

    -- cast curse of weakness
    creature:RegisterEvent(CastCurseOfWeakness, 30000, 0)
end

CastCurseOfWeakness = function(event, delay, pCall, creature)
    if (math.random(1, 100) <= 75) then
        local players = creature:GetPlayersInRange()
        creature:CastSpell(players[math.random(1, #players)], SPELL_CURSE_OF_WEAKNESS)
    end
end

Reset = function (event, creature)
    creature:RemoveEvents()
end

RegisterCreatureEvent(BOSS_JERGOSH, CREATURE_EVENT_ON_ENTER_COMBAT, EnterCombat)
RegisterCreatureEvent(BOSS_JERGOSH, CREATURE_EVENT_ON_LEAVE_COMBAT, Reset)
RegisterCreatureEvent(BOSS_JERGOSH, CREATURE_EVENT_ON_DIED, Reset)
