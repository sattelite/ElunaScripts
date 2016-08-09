# ![logo](https://github.com/ElunaLuaEngine/Eluna/raw/master/docs/Eluna.png)

## Content

This repo is a fork of the [official Eluna repo](https://github.com/ElunaLuaEngine/Scripts) and contains refactored scripts for Eluna. The changes will be submitted to the [official Eluna repo](https://github.com/ElunaLuaEngine/Scripts) whenever they seem to work flawless.

Feel free to use anything within this repo as you please, and commit your own scripts
for review and possible acceptance into the repo and/or the [official Eluna repo](https://github.com/ElunaLuaEngine/Scripts)


## Coding Style
### Indention
For Indention use 4 spaces.

### Naming
#### File naming
**Filenames** shall be **lowercase snake\_case**. The files shall have a prefix *npc\_* for NPCs and *boss\_* for boss-NPCs,

#### Variable naming
* Local **variabales** and objects shall be **camelCase**. 
* **Immutable variables** shall be **ALL\_CAPS** and have a prefix *SPELL\_*, *BOSS\_*, *NPC\_*, etc respective to which ID they are releated to. 
* **Functions** shall be **PascalCase**.

Example:

    local BOSS_RANDOM_NAME = 12345
    local SPELL_RANDOM_NAME = 54321
    function Myfunction(event, creature)
        local isChanneled = true
        creature:CastSpell(BOSS_RANDOM_NAME, SPELL_RANDOM_NAME, isChanneled)
    end


### Directory structure
Sort the files into their respective zones. Every instance and zone shall have a own subdirectory. Zones shall have the prefix *zone\_*.

## Links

[Eluna Source](https://github.com/ElunaLuaEngine/Eluna)

[Eluna Wiki](http://wiki.emudevs.com/doku.php?id=eluna)

[Eluna Support Forum](http://emudevs.com)
