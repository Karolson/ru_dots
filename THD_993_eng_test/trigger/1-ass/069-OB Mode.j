function Trig_OB_Mode_Actions takes nothing returns nothing
    local integer i = 1
    call BroadcastMessage("\n\n|cff8080ffReferee mode is activated. In this game, " + GetPlayerName(udg_PlayerA[0]) + " Hakurei overseer and " + GetPlayerName(udg_PlayerB[0]) + " Moriya overseer |r")
    call ForceRemovePlayer(udg_TeamS, udg_PlayerA[0])
    call ForceRemovePlayer(udg_TeamS, udg_PlayerB[0])
    call RemoveUnit(udg_PlayerHeroes[5])
    call RemoveUnit(udg_PlayerHeroes[11])
    set udg_PlayerHeroes[5] = null
    set udg_PlayerHeroes[11] = null
    call ForceAddPlayer(udg_TeamOB, udg_PlayerA[0])
    call ForceAddPlayer(udg_TeamOB, udg_PlayerB[0])
    call SetPlayerState(udg_PlayerA[0], PLAYER_STATE_OBSERVER, 1)
    call SetPlayerState(udg_PlayerB[0], PLAYER_STATE_OBSERVER, 1)
    call SetPlayerName(udg_PlayerA[0], udg_PlayerName[6] + "(Onlookers)")
    call SetPlayerName(udg_PlayerB[0], udg_PlayerName[12] + "(Bros)")
    loop
    exitwhen i > 5
        call SetPlayerAllianceStateBJ(udg_PlayerA[i], udg_PlayerA[0], bj_ALLIANCE_NEUTRAL_VISION)
        call SetPlayerAllianceStateBJ(udg_PlayerB[i], udg_PlayerA[0], bj_ALLIANCE_UNALLIED_VISION)
        call SetPlayerAllianceStateBJ(udg_PlayerA[i], udg_PlayerB[0], bj_ALLIANCE_UNALLIED_VISION)
        call SetPlayerAllianceStateBJ(udg_PlayerB[i], udg_PlayerB[0], bj_ALLIANCE_NEUTRAL_VISION)
        call SetPlayerAlliance(udg_PlayerA[i], udg_PlayerA[0], ALLIANCE_SHARED_CONTROL, true)
        call SetPlayerAlliance(udg_PlayerB[i], udg_PlayerA[0], ALLIANCE_SHARED_CONTROL, true)
        call SetPlayerAlliance(udg_PlayerA[i], udg_PlayerB[0], ALLIANCE_SHARED_CONTROL, true)
        call SetPlayerAlliance(udg_PlayerB[i], udg_PlayerB[0], ALLIANCE_SHARED_CONTROL, true)
        set i = i + 1
    endloop
    call SetPlayerAllianceStateBJ(Player(PLAYER_NEUTRAL_PASSIVE), udg_PlayerA[0], bj_ALLIANCE_NEUTRAL_VISION)
    call SetPlayerAllianceStateBJ(Player(PLAYER_NEUTRAL_PASSIVE), udg_PlayerB[0], bj_ALLIANCE_NEUTRAL_VISION)
    call SetPlayerAllianceStateBJ(udg_PlayerA[0], Player(PLAYER_NEUTRAL_AGGRESSIVE), bj_ALLIANCE_UNALLIED)
    call SetPlayerAllianceStateBJ(udg_PlayerB[0], Player(PLAYER_NEUTRAL_AGGRESSIVE), bj_ALLIANCE_UNALLIED)
    call SetPlayerAllianceStateBJ(Player(PLAYER_NEUTRAL_AGGRESSIVE), udg_PlayerA[0], bj_ALLIANCE_UNALLIED)
    call SetPlayerAllianceStateBJ(Player(PLAYER_NEUTRAL_AGGRESSIVE), udg_PlayerB[0], bj_ALLIANCE_UNALLIED)
    call ClearTextMessages()
    call SetMapFlag(MAP_LOCK_ALLIANCE_CHANGES, true)
    call DisableTrigger(gg_trg_OB_Mode)
    call DestroyTrigger(gg_trg_OB_Mode)
endfunction

function InitTrig_OB_Mode takes nothing returns nothing
    set gg_trg_OB_Mode = CreateTrigger()
    call TriggerRegisterPlayerChatEvent(gg_trg_OB_Mode, udg_HostPlayer, "-obtestmode", true)
    call TriggerAddAction(gg_trg_OB_Mode, function Trig_OB_Mode_Actions)
endfunction