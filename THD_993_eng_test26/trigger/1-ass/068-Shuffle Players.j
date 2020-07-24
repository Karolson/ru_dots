function Trig_Shuffle_Players_Actions takes nothing returns nothing
    local integer n = 0
    local player p
    local integer m = 0
    local unit array u
    local integer numa
    local integer numb
    call SetMapFlag(MAP_LOCK_ALLIANCE_CHANGES, false)
    set u[0] = gg_unit_h01Q_0033
    set u[1] = gg_unit_h01Q_0120
    set u[2] = gg_unit_h01Q_0048
    set u[3] = gg_unit_h01Q_0121
    set u[4] = gg_unit_h01Q_0059
    set u[5] = gg_unit_h01Q_0122
    set u[6] = gg_unit_h01Q_0118
    set u[7] = gg_unit_h01Q_0123
    set u[8] = gg_unit_h01Q_0119
    set u[9] = gg_unit_h01Q_0124
    call SetUnitOwner(u[0], Player(5), true)
    call SetUnitOwner(u[1], Player(11), true)
    call SetUnitOwner(u[2], Player(5), true)
    call SetUnitOwner(u[3], Player(11), true)
    call SetUnitOwner(u[4], Player(5), true)
    call SetUnitOwner(u[5], Player(11), true)
    call SetUnitOwner(u[6], Player(5), true)
    call SetUnitOwner(u[7], Player(11), true)
    call SetUnitOwner(u[8], Player(5), true)
    call SetUnitOwner(u[9], Player(11), true)
    call ForceAddPlayer(udg_TeamA, Player(5))
    call ForceAddPlayer(udg_TeamB, Player(11))
    call SetForceAllianceStateBJ(udg_TeamA, udg_TeamA, bj_ALLIANCE_UNALLIED)
    call SetForceAllianceStateBJ(udg_TeamB, udg_TeamB, bj_ALLIANCE_UNALLIED)
    call ForceClear(udg_TeamA)
    call ForceClear(udg_TeamB)
    loop
    exitwhen n > 11
        if n != 5 and n != 11 then
            call RemoveUnit(udg_PlayerHeroes[n])
            set udg_PlayerHeroes[n] = null
        endif
        loop
        exitwhen m > 11
            if n != m then
                call SetPlayerAllianceStateBJ(Player(n), Player(m), bj_ALLIANCE_UNALLIED)
            endif
            set m = m + 1
        endloop
        set udg_PlayerReviveHouse[n] = null
        set n = n + 1
    endloop
    set m = 0
    set n = 1
    loop
    exitwhen n > 5
        set udg_PlayerA[n] = null
        set udg_PlayerB[n] = null
        set n = n + 1
    endloop
    set n = 0
    call ForceClear(udg_OnlinePlayers)
    loop
    exitwhen n > 11
        if GetPlayerSlotState(Player(n)) == PLAYER_SLOT_STATE_PLAYING then
            call ForceAddPlayer(udg_OnlinePlayers, Player(n))
        endif
        set n = n + 1
    endloop
    call ForceRemovePlayer(udg_OnlinePlayers, Player(5))
    call ForceRemovePlayer(udg_OnlinePlayers, Player(11))
    set n = 1
    loop
        set p = ForcePickRandomPlayer(udg_TempTeamA)
    exitwhen p == null
        set m = GetPlayerId(p)
        call ForceAddPlayer(udg_TeamA, p)
        call ForceRemovePlayer(udg_OnlinePlayers, p)
        call ForceRemovePlayer(udg_TempTeamA, p)
        set udg_PlayerA[n] = p
        call SetUnitOwner(u[2 * n - 2], p, true)
        set udg_PlayerReviveHouse[m] = u[2 * n - 2]
        call BroadcastMessage(udg_PN[GetPlayerId(p)] + " has joined Hakurei team")
        set n = n + 1
    endloop
    call ForceClear(udg_TempTeamA)
    set n = 1
    loop
        set p = ForcePickRandomPlayer(udg_TempTeamB)
    exitwhen p == null
        set m = GetPlayerId(p)
        call ForceAddPlayer(udg_TeamB, p)
        call ForceRemovePlayer(udg_OnlinePlayers, p)
        call ForceRemovePlayer(udg_TempTeamB, p)
        set udg_PlayerB[n] = p
        call SetUnitOwner(u[2 * n - 1], p, true)
        set udg_PlayerReviveHouse[m] = u[2 * n - 1]
        call BroadcastMessage(udg_PN[GetPlayerId(p)] + " has joined Moriya team")
        set n = n + 1
    endloop
    call ForceClear(udg_TempTeamB)
    set n = 0
    set numa = CountPlayersInForceBJ(udg_TeamA)
    set numb = CountPlayersInForceBJ(udg_TeamB)
    loop
        set p = ForcePickRandomPlayer(udg_OnlinePlayers)
    exitwhen p == null
        set m = GetPlayerId(p)
        call ForceRemovePlayer(udg_OnlinePlayers, p)
        if numa <= numb then
            set numa = numa + 1
            call ForceAddPlayer(udg_TeamA, p)
            set udg_PlayerA[numa] = p
            call SetUnitOwner(u[2 * numa - 2], p, true)
            set udg_PlayerReviveHouse[m] = u[2 * numa - 2]
            call BroadcastMessage(udg_PN[GetPlayerId(p)] + " has joined Hakurei team")
        else
            set numb = numb + 1
            call ForceAddPlayer(udg_TeamB, p)
            set udg_PlayerB[numb] = p
            call SetUnitOwner(u[2 * numb - 1], p, true)
            set udg_PlayerReviveHouse[m] = u[2 * numb - 1]
            call BroadcastMessage(udg_PN[GetPlayerId(p)] + " has joined Moriya team")
        endif
        set n = n + 1
    endloop
    call ForceClear(udg_OnlinePlayers)
    set n = 0
    loop
    exitwhen n > 11
        if GetPlayerSlotState(Player(n)) == PLAYER_SLOT_STATE_PLAYING then
            call ForceAddPlayer(udg_OnlinePlayers, Player(n))
        endif
        set n = n + 1
    endloop
    call ForceRemovePlayer(udg_OnlinePlayers, Player(5))
    call ForceRemovePlayer(udg_OnlinePlayers, Player(11))
    call ForceAddPlayer(udg_TeamA, Player(5))
    call ForceAddPlayer(udg_TeamB, Player(11))
    call SetForceAllianceStateBJ(udg_TeamA, udg_TeamA, bj_ALLIANCE_ALLIED_VISION)
    call SetForceAllianceStateBJ(udg_TeamA, udg_TeamB, bj_ALLIANCE_UNALLIED)
    call SetForceAllianceStateBJ(udg_TeamA, bj_FORCE_PLAYER[PLAYER_NEUTRAL_AGGRESSIVE], bj_ALLIANCE_UNALLIED)
    call SetForceAllianceStateBJ(bj_FORCE_PLAYER[PLAYER_NEUTRAL_AGGRESSIVE], udg_TeamA, bj_ALLIANCE_UNALLIED)
    call SetForceAllianceStateBJ(udg_TeamB, udg_TeamB, bj_ALLIANCE_ALLIED_VISION)
    call SetForceAllianceStateBJ(udg_TeamB, udg_TeamA, bj_ALLIANCE_UNALLIED)
    call SetForceAllianceStateBJ(udg_TeamB, bj_FORCE_PLAYER[PLAYER_NEUTRAL_AGGRESSIVE], bj_ALLIANCE_UNALLIED)
    call SetForceAllianceStateBJ(bj_FORCE_PLAYER[PLAYER_NEUTRAL_AGGRESSIVE], udg_TeamB, bj_ALLIANCE_UNALLIED)
    call ForceRemovePlayer(udg_TeamA, Player(5))
    call ForceRemovePlayer(udg_TeamB, Player(11))
    call SetMapFlag(MAP_LOCK_ALLIANCE_CHANGES, true)
    set u[0] = null
    set u[1] = null
    set u[2] = null
    set u[3] = null
    set u[4] = null
    set u[5] = null
    set u[6] = null
    set u[7] = null
    set u[8] = null
    set u[9] = null
endfunction

function InitTrig_Shuffle_Players takes nothing returns nothing
endfunction