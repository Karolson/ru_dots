function PlayerVictory takes nothing returns nothing
    call CustomVictoryBJ(GetEnumPlayer(), true, true)
endfunction

function HakureiDefeatAnnouncement takes nothing returns nothing
    call CustomDefeatBJ(GetEnumPlayer(), "Defeat!")
endfunction

function MoriyaDefeatAnnouncement takes nothing returns nothing
    call CustomDefeatBJ(GetEnumPlayer(), "Defeat!")
endfunction

function Trig_Victory_Actions takes nothing returns nothing
    local unit v = GetTriggerUnit()
    local real x = GetUnitX(v)
    local real y = GetUnitY(v)
    local unit u
    call DestroyTrigger(GetTriggeringTrigger())
    set u = CreateUnit(Player(15), 'n01J', x, y, 0.0)
    call SetUnitScale(u, 4.0, 4.0, 4.0)
    set u = CreateUnit(Player(15), 'n01J', x, y, 90.0)
    call SetUnitScale(u, 4.0, 4.0, 4.0)
    set u = CreateUnit(Player(15), 'n01J', x, y, 180.0)
    call SetUnitScale(u, 4.0, 4.0, 4.0)
    set u = CreateUnit(Player(15), 'n01J', x, y, 270.0)
    call SetUnitScale(u, 4.0, 4.0, 4.0)
    call DestroyEffect(AddSpecialEffect("Objects\\Spawnmodels\\Undead\\UDeathMedium\\UDeath.mdl", x, y))
    call DestroyEffect(AddSpecialEffect("Objects\\Spawnmodels\\Undead\\UDeathMedium\\UDeath.mdl", x, y))
    call DestroyEffect(AddSpecialEffect("Objects\\Spawnmodels\\Undead\\UDeathSmall\\UDeathSmall.mdl", x, y))
    call DestroyEffect(AddSpecialEffect("Objects\\Spawnmodels\\Undead\\UDeathSmall\\UDeathSmall.mdl", x, y))
    if GetTriggerUnit() == udg_BaseB[0] then
        call BroadcastMessage("|cFFFF0000Hakurei Shrine|r |cffffcc00Wins!|r")
    else
        call BroadcastMessage("|cFF33CC00Moriya Shrine|r |cffffcc00Wins!|r")
    endif
    call TriggerSleepAction(5.0)
    if udg_SK_Nazirin != null then
        call RemoveUnit(udg_SK_Nazirin)
    else
    endif
    call PauseGame(true)
    if GetTriggerUnit() == udg_BaseB[0] then
        call ForForce(udg_TeamA, function PlayerVictory)
        call ForForce(udg_TeamB, function MoriyaDefeatAnnouncement)
    else
        call ForForce(udg_TeamB, function PlayerVictory)
        call ForForce(udg_TeamA, function HakureiDefeatAnnouncement)
    endif
    call ForForce(udg_TeamOB, function PlayerVictory)
    set u = null
    set v = null
endfunction

function InitTrig_Victory takes nothing returns nothing
    set gg_trg_Victory = CreateTrigger()
    call TriggerAddAction(gg_trg_Victory, function Trig_Victory_Actions)
endfunction