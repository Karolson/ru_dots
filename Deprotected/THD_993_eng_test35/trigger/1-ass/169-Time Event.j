function UpdateMultiboardTitleText_WW takes nothing returns nothing
    call MultiboardSetTitleText(udg_GIB, udg_TimeStringReviveTimer + udg_TimeStringAfterBattleBegin)
endfunction

function UpdateGameClock takes nothing returns nothing
    local string str
    local integer seconds = udg_GameTime - udg_Game_BattleBeginTime
    local multiboarditem i = null
    if seconds >= 0 then
        set udg_TimeStringAfterBattleBegin = "Game time: " + GetTimeString_h_mM_SS_WW(seconds)
    else
        set udg_TimeStringAfterBattleBegin = "Game time: " + GetTimeString_h_mM_SS_WW(-seconds)
    endif
    call MultiboardSetTitleText(udg_GIB, udg_TimeStringReviveTimer + udg_TimeStringAfterBattleBegin)
    set str = "|cffff6600Hakurei:    " + "|r" + I2S(udg_ScoreSpirit[5])
    set i = MultiboardGetItem(udg_GIB, udg_GIB_PlayerRow[0], 1)
    call MultiboardSetItemValue(i, str)
    call MultiboardReleaseItem(i)
    set i = null
    set str = "|cff00ff66Moriya:    " + "|r" + I2S(udg_ScoreSpirit[11])
    set i = MultiboardGetItem(udg_GIB, udg_GIB_PlayerRow[0], 2)
    call MultiboardSetItemValue(i, str)
    call MultiboardReleaseItem(i)
    set i = null
endfunction

function IncreaseGold takes nothing returns nothing
    local integer gold_10sec = udg_GameSetting_Gold_B
    local player p = GetEnumPlayer()
    local integer i = GetPlayerId(p)
    local integer gold_2sec
    if IsPlayerInForce(p, udg_TeamA) then
        set gold_10sec = udg_GameSetting_Gold_A
    endif
    if udg_GameMode / 100 == 3 then
        set gold_10sec = gold_10sec * 2
    endif
    if udg_GameModeIsTurbo then
        set gold_10sec = gold_10sec * 2
    endif
    set gold_2sec = gold_10sec / 5
    set udg_Player_GoldRemnant[i] = udg_Player_GoldRemnant[i] + gold_10sec - gold_2sec * 5
    if udg_Player_GoldRemnant[i] >= 5 then
        set gold_2sec = gold_2sec + 1
        set udg_Player_GoldRemnant[i] = udg_Player_GoldRemnant[i] - 5
    endif
    call SetPlayerState(p, PLAYER_STATE_GOLD_GATHERED, GetPlayerState(p, PLAYER_STATE_GOLD_GATHERED) + gold_2sec)
    call SetPlayerState(p, PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(p, PLAYER_STATE_RESOURCE_GOLD) + gold_2sec)
    set p = null
endfunction

function Trig_Time_Event_SyncPower takes nothing returns nothing
    local player p = GetEnumPlayer()
    call SetPlayerState(p, PLAYER_STATE_RESOURCE_FOOD_USED, udg_PlayerPower[GetPlayerId(p) + 1])
    call SetPlayerState(p, PLAYER_STATE_RESOURCE_FOOD_CAP, 30)
    set p = null
endfunction

function Trig_Time_Event_Actions takes nothing returns boolean
    set udg_GameTime = udg_GameTime + 1
    call UpdateGameClock()
    if udg_GameTime / 2 * 2 == udg_GameTime and udg_GameTime > 60 then
        call ForForce(udg_OnlinePlayers, function IncreaseGold)
    endif
    if udg_GameTime / 60 * 60 == udg_GameTime then
        if udg_GameMode / 100 == 3 then
            call THD_AddSpirit(udg_PlayerA[0], udg_GameSetting_Spirit[3] * 2)
            call THD_AddSpirit(udg_PlayerB[0], udg_GameSetting_Spirit[4] * 2)
        else
            call THD_AddSpirit(udg_PlayerA[0], udg_GameSetting_Spirit[3])
            call THD_AddSpirit(udg_PlayerB[0], udg_GameSetting_Spirit[4])
        endif
        if udg_GameModeIsTurbo then
            call THD_AddSpirit(udg_PlayerA[0], udg_GameSetting_Spirit[3])
            call THD_AddSpirit(udg_PlayerB[0], udg_GameSetting_Spirit[4])
        endif
        if udg_ScoreSpirit[5] == 99999 then
            call DisplayTextToForce(udg_TeamA, "Faith is full")
        endif
        if udg_ScoreSpirit[1] == 99999 then
            call DisplayTextToForce(udg_TeamB, "Faith is full")
        endif
    endif
    call ForForce(udg_OnlinePlayers, function Trig_Time_Event_SyncPower)
    return false
endfunction

function InitTrig_Time_Event takes nothing returns nothing
    set gg_trg_Time_Event = CreateTrigger()
    call TriggerAddCondition(gg_trg_Time_Event, Condition(function Trig_Time_Event_Actions))
endfunction