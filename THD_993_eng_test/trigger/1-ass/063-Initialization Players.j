function Trig_Initialization_Players_Func078Func001C takes nothing returns boolean
    if not (GetPlayerSlotState(GetEnumPlayer()) == PLAYER_SLOT_STATE_PLAYING) then
        return false
    endif
    return true
endfunction

function Trig_Initialization_Players_Func078A takes nothing returns nothing
    if Trig_Initialization_Players_Func078Func001C() then
        call ForceAddPlayer(udg_OnlinePlayers, GetEnumPlayer())
    else
        call DoNothing()
    endif
    call SetPlayerMaxHeroesAllowed(1, GetEnumPlayer())
    call ClearTextMessages()
endfunction

function Trig_Initialization_Players_Func079Func001C takes nothing returns boolean
    if not (GetPlayerSlotState(GetEnumPlayer()) == PLAYER_SLOT_STATE_PLAYING) then
        return false
    endif
    return true
endfunction

function Trig_Initialization_Players_Func079A takes nothing returns nothing
    if Trig_Initialization_Players_Func079Func001C() then
        call ForceAddPlayer(udg_OnlinePlayers, GetEnumPlayer())
    else
        call DoNothing()
    endif
    call SetPlayerMaxHeroesAllowed(1, GetEnumPlayer())
    call ClearTextMessages()
endfunction

function Trig_Initialization_Players_Func080Func001C takes nothing returns boolean
    if not (GetPlayerController(GetEnumPlayer()) == MAP_CONTROL_COMPUTER) then
        return false
    endif
    return true
endfunction

function Trig_Initialization_Players_Func080A takes nothing returns nothing
    if Trig_Initialization_Players_Func080Func001C() then
        call ForceAddPlayer(udg_AI_Players, GetEnumPlayer())
    else
        call DoNothing()
    endif
endfunction

function Trig_Initialization_Players_Actions takes nothing returns nothing
    local integer i = 0
    set udg_PlayerA[0] = Player(5)
    set udg_PlayerB[0] = Player(11)
    set udg_PlayerA[6] = Player(bj_PLAYER_NEUTRAL_VICTIM)
    set udg_PlayerB[6] = Player(bj_PLAYER_NEUTRAL_EXTRA)
    call ForceAddPlayer(udg_TeamA, udg_PlayerA[0])
    call ForceAddPlayer(udg_TeamB, udg_PlayerB[0])
    call ForceAddPlayer(udg_TeamS, udg_PlayerA[0])
    call ForceAddPlayer(udg_TeamS, udg_PlayerB[0])
    set udg_PlayerName[6] = GetPlayerName(udg_PlayerA[0])
    set udg_PlayerName[12] = GetPlayerName(udg_PlayerB[0])
    call SetPlayerName(udg_PlayerA[0], "Hakurei Shrine " + "(" + GetPlayerName(udg_PlayerA[0]) + ")")
    call SetPlayerName(udg_PlayerB[0], "Moriya Shrine " + "(" + GetPlayerName(udg_PlayerB[0]) + ")")
    call SetPlayerAlliance(udg_PlayerA[0], udg_PlayerA[0], ALLIANCE_SHARED_CONTROL, false)
    call SetPlayerAlliance(udg_PlayerA[0], udg_PlayerA[0], ALLIANCE_SHARED_ADVANCED_CONTROL, false)
    call SetPlayerAlliance(udg_PlayerB[0], udg_PlayerB[0], ALLIANCE_SHARED_CONTROL, false)
    call SetPlayerAlliance(udg_PlayerB[0], udg_PlayerB[0], ALLIANCE_SHARED_ADVANCED_CONTROL, false)
    set udg_PN[GetPlayerId(udg_PlayerA[0])] = "|cFFFF6600Hakurei|r"
    set udg_PN[GetPlayerId(udg_PlayerB[0])] = "|cFF00FF66Moriya|r"
    set i = 0
    set i = i + 1
    set udg_PlayerA[i] = Player(0)
    set i = i + 1
    set udg_PlayerA[i] = Player(1)
    set i = i + 1
    set udg_PlayerA[i] = Player(2)
    set i = i + 1
    set udg_PlayerA[i] = Player(3)
    set i = i + 1
    set udg_PlayerA[i] = Player(4)
    loop
        call ForceAddPlayer(udg_TeamA, udg_PlayerA[i])
    exitwhen i == 0
        set i = i - 1
    endloop
    set i = 0
    set i = i + 1
    set udg_PlayerB[i] = Player(6)
    set i = i + 1
    set udg_PlayerB[i] = Player(7)
    set i = i + 1
    set udg_PlayerB[i] = Player(8)
    set i = i + 1
    set udg_PlayerB[i] = Player(9)
    set i = i + 1
    set udg_PlayerB[i] = Player(10)
    loop
        call ForceAddPlayer(udg_TeamB, udg_PlayerB[i])
    exitwhen i == 0
        set i = i - 1
    endloop
    call SetForceAllianceStateBJ(udg_TeamA, udg_TeamA, bj_ALLIANCE_ALLIED_VISION)
    call SetForceAllianceStateBJ(udg_TeamA, udg_TeamB, bj_ALLIANCE_UNALLIED)
    call SetForceAllianceStateBJ(udg_TeamA, bj_FORCE_PLAYER[PLAYER_NEUTRAL_AGGRESSIVE], bj_ALLIANCE_UNALLIED)
    call SetForceAllianceStateBJ(udg_TeamB, udg_TeamB, bj_ALLIANCE_ALLIED_VISION)
    call SetForceAllianceStateBJ(udg_TeamB, udg_TeamA, bj_ALLIANCE_UNALLIED)
    call SetForceAllianceStateBJ(udg_TeamB, bj_FORCE_PLAYER[PLAYER_NEUTRAL_AGGRESSIVE], bj_ALLIANCE_UNALLIED)
    call SetForceAllianceStateBJ(bj_FORCE_PLAYER[PLAYER_NEUTRAL_AGGRESSIVE], udg_TeamA, bj_ALLIANCE_UNALLIED)
    call SetForceAllianceStateBJ(bj_FORCE_PLAYER[PLAYER_NEUTRAL_AGGRESSIVE], udg_TeamB, bj_ALLIANCE_UNALLIED)
    call ClearTextMessages()
    call SetMapFlag(MAP_LOCK_ALLIANCE_CHANGES, true)
    call ForceRemovePlayer(udg_TeamA, udg_PlayerA[0])
    call ForceRemovePlayer(udg_TeamB, udg_PlayerB[0])
    call ForceAddPlayer(udg_TeamSpawnA, udg_PlayerA[0])
    call ForceAddPlayer(udg_TeamSpawnB, udg_PlayerB[0])
    call ForForce(udg_TeamA, function Trig_Initialization_Players_Func078A)
    call ForForce(udg_TeamB, function Trig_Initialization_Players_Func079A)
    call ForForce(udg_OnlinePlayers, function Trig_Initialization_Players_Func080A)
    set udg_PlayerReviveHouse[0] = gg_unit_H01Q_0033
    set udg_PlayerReviveHouse[1] = gg_unit_H01Q_0048
    set udg_PlayerReviveHouse[2] = gg_unit_H01Q_0059
    set udg_PlayerReviveHouse[3] = gg_unit_H01Q_0118
    set udg_PlayerReviveHouse[4] = gg_unit_H01Q_0119
    set udg_PlayerReviveHouse[6] = gg_unit_H01Q_0120
    set udg_PlayerReviveHouse[7] = gg_unit_H01Q_0121
    set udg_PlayerReviveHouse[8] = gg_unit_H01Q_0122
    set udg_PlayerReviveHouse[9] = gg_unit_H01Q_0123
    set udg_PlayerReviveHouse[10] = gg_unit_H01Q_0124
    set udg_OnlinePlayerSum = CountPlayersInForceBJ(udg_OnlinePlayers)
    call DebugMsg("Number of games:" + I2S(udg_OnlinePlayerSum))
    call DestroyTrigger(GetTriggeringTrigger())
endfunction

function InitTrig_Initialization_Players takes nothing returns nothing
    set gg_trg_Initialization_Players = CreateTrigger()
    call DisableTrigger(gg_trg_Initialization_Players)
    call TriggerAddAction(gg_trg_Initialization_Players, function Trig_Initialization_Players_Actions)
endfunction