function Trig_SoloMode_CountingWinLose takes nothing returns nothing
    if udg_GIB_PlayerScoreForSolo[0] >= 3 and udg_GIB_PlayerScoreForSolo[0] >= udg_GIB_PlayerScoreForSolo[1] + 2 then
        call BroadcastMessage("|cFFFF0000Hakurei scored more than 3 points and beat Moriya by 2 points. Hakurei won.|r")
        set udg_GIB_PlayerScoreForSolo[0] = 0
        set udg_GIB_PlayerScoreForSolo[1] = 0
        call KillUnit(udg_BaseB[0])
    endif
    if udg_GIB_PlayerScoreForSolo[1] >= 3 and udg_GIB_PlayerScoreForSolo[1] >= udg_GIB_PlayerScoreForSolo[0] + 2 then
        call BroadcastMessage("|cFF00FF00Moriya scored more than 3 points and beat Hakurei by 2 points. Moriya won.|r")
        set udg_GIB_PlayerScoreForSolo[0] = 0
        set udg_GIB_PlayerScoreForSolo[1] = 0
        call KillUnit(udg_BaseA[0])
    endif
    if udg_GIB_PlayerScoreForSolo[0] == 5 then
        call BroadcastMessage("|cFFFF0000Hakurei scored 5 points first and won.|r")
        set udg_GIB_PlayerScoreForSolo[0] = 0
        set udg_GIB_PlayerScoreForSolo[1] = 0
        call KillUnit(udg_BaseB[0])
    endif
    if udg_GIB_PlayerScoreForSolo[1] == 5 then
        call BroadcastMessage("|cFF00FF00Moriya scored 5 points first and won.|r")
        set udg_GIB_PlayerScoreForSolo[0] = 0
        set udg_GIB_PlayerScoreForSolo[1] = 0
        call KillUnit(udg_BaseA[0])
    endif
endfunction

function Trig_SoloMode_Actions takes nothing returns nothing
    if udg_GameMode / 100 == 2 then
        call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS, 60.0, "|cffffcc00Single player mode rules: |r\r\nVictory conditions: \r\n* Reach 3 points or more and 2 points more than your enemy\r\n* Reach 5 points\r\nScoring conditions: \r\n* One point for killing an enemy girl\r\n* One point for destroying a tower\r\n* One point for the player who reaches level 11 first")
    endif
endfunction

function InitTrig_SoloMode takes nothing returns nothing
    set gg_trg_SoloMode = CreateTrigger()
    call TriggerAddAction(gg_trg_SoloMode, function Trig_SoloMode_Actions)
endfunction