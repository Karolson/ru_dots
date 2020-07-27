function Trig_Spawn_FirstBan takes unit u returns nothing
    local unit v = CreateUnit(GetOwningPlayer(u), 'n001', GetUnitX(u), GetUnitY(u), 0)
    call UnitAddAbility(v, 'A18P')
    call IssueTargetOrder(v, "drunkenhaze", u)
    set v = null
endfunction

function Trig_Spawn_A_Actions takes nothing returns nothing
    local integer route
    local integer t
    local integer n
    local unit u
    local player who = udg_PlayerA[0]
    local real facing = 45.0
    local integer array order
    local integer i
    if udg_smodestat then
        return
    endif
    set order[0] = 2
    set order[1] = 1
    set order[2] = 0
    set udg_SU_SP_Loop_i = udg_SU_SP_Loop_i + 1
    if udg_SU_SP_Loop_i >= 12 then
        set udg_SU_SP_Loop_i = 0
    endif
    set i = 0
    if udg_NewMid then
        set i = 2
    endif
    if udg_GameMode / 100 == 3 then
        set i = 1
    endif
    loop
        if udg_GameMode / 100 == 3 and i == 2 then
            call TriggerSleepAction(5.1)
        endif
        if udg_GameMode / 100 == 2 then
            call TriggerSleepAction(4.0)
            set i = 2
        endif
        set route = order[i]
        set t = 0
        set n = udg_SU_No_A[t]
        loop
        exitwhen n == 0
            set u = CreateUnitAtLoc(who, udg_SU_ID_A[t], udg_SpawnLocA[3], facing)
            call addlife(u, GetPlayerTechCount(udg_SpawnPlayer[0], 'R003', true) * 22)
            call AddUnitWaypointRecord(u, route * 16)
            call SetUnitColor(u, PLAYER_COLOR_RED)
            call SetUnitPositionLoc(u, udg_SpawnLocA[route])
            call SpawnIssueOrderA(u)
            if udg_SU_SP_First == false then
                call Trig_Spawn_FirstBan(u)
            endif
            set n = n - 1
        endloop
        call TriggerSleepAction(1.0)
        set t = 1
        set n = udg_SU_No_A[t]
        loop
        exitwhen n == 0
            set u = CreateUnitAtLoc(who, udg_SU_ID_A[t], udg_SpawnLocA[3], facing)
            call addlife(u, GetPlayerTechCount(udg_SpawnPlayer[0], 'R003', true) * 15)
            call AddUnitWaypointRecord(u, route * 16)
            call SetUnitColor(u, PLAYER_COLOR_RED)
            call SetUnitPositionLoc(u, udg_SpawnLocA[route])
            call SpawnIssueOrderA(u)
            if udg_SU_SP_First == false then
                call Trig_Spawn_FirstBan(u)
            endif
            set n = n - 1
        endloop
        if udg_SU_SP_Loop_i == 0 or udg_SU_SP_Loop_i == 3 or udg_SU_SP_Loop_i == 6 or udg_SU_SP_Loop_i == 9 then
            set t = 2
            set n = udg_SU_No_A[t]
            loop
            exitwhen n == 0
                set u = CreateUnitAtLoc(who, udg_SU_ID_A[t], udg_SpawnLocA[3], facing)
                call addlife(u, GetPlayerTechCount(udg_SpawnPlayer[0], 'R003', true) * 15)
                if udg_GameTime >= 60 * 90 then
                    call addlife(u, R2I(GetUnitState(u, UNIT_STATE_MAX_LIFE) * 2.0))
                elseif udg_GameTime >= 60 * 72 then
                    call addlife(u, R2I(GetUnitState(u, UNIT_STATE_MAX_LIFE) * 1.5))
                elseif udg_GameTime >= 60 * 54 then
                    call addlife(u, R2I(GetUnitState(u, UNIT_STATE_MAX_LIFE) * 1.0))
                elseif udg_GameTime >= 60 * 36 then
                    call addlife(u, R2I(GetUnitState(u, UNIT_STATE_MAX_LIFE) * 0.5))
                endif
                call AddUnitWaypointRecord(u, route * 16)
                call SetUnitColor(u, PLAYER_COLOR_RED)
                call SetUnitPositionLoc(u, udg_SpawnLocA[route])
                call SpawnIssueOrderA(u)
                set n = n - 1
            endloop
        endif
        call TriggerSleepAction(1.0)
        set udg_SU_SP_First = true
        set i = i + 1
    exitwhen i > 2
    endloop
    set who = null
    set u = null
endfunction

function InitTrig_Spawn_A takes nothing returns nothing
    set gg_trg_Spawn_A = CreateTrigger()
    call TriggerAddAction(gg_trg_Spawn_A, function Trig_Spawn_A_Actions)
    call DisableTrigger(gg_trg_Spawn_A)
endfunction