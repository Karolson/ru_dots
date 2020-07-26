function CameraForCoach takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit u = LoadUnitHandle(udg_ht, task, 0)
    if GetLocalPlayer() == Player(5) then
        call PanCameraToTimed(GetUnitX(u), GetUnitY(u), 0.1)
        call SetCameraField(CAMERA_FIELD_ZOFFSET, 0.0, 0.0)
        call SetCameraField(CAMERA_FIELD_ROTATION, 90.0, 0.0)
        call SetCameraField(CAMERA_FIELD_ANGLE_OF_ATTACK, 304.0, 0.0)
        call SetCameraField(CAMERA_FIELD_FIELD_OF_VIEW, 70.0, 0)
        call SetCameraField(CAMERA_FIELD_FARZ, 5000, 0.0)
    endif
    if udg_CameraState[5] == 0 then
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
        call FlushChildHashtable(udg_ht, StringHash("CoachCamera"))
    endif
    set t = null
    set u = null
endfunction

function CameraForSupervisor takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit u = LoadUnitHandle(udg_ht, task, 0)
    if GetLocalPlayer() == Player(11) then
        call PanCameraToTimed(GetUnitX(u), GetUnitY(u), 0.1)
        call SetCameraField(CAMERA_FIELD_ZOFFSET, 0.0, 0.0)
        call SetCameraField(CAMERA_FIELD_ROTATION, 90.0, 0.0)
        call SetCameraField(CAMERA_FIELD_ANGLE_OF_ATTACK, 304.0, 0.0)
        call SetCameraField(CAMERA_FIELD_FIELD_OF_VIEW, 70.0, 0)
        call SetCameraField(CAMERA_FIELD_FARZ, 5000, 0.0)
    endif
    if udg_CameraState[11] == 0 then
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
        call FlushChildHashtable(udg_ht, StringHash("SupervisorCamera"))
    endif
    set t = null
    set u = null
endfunction

function CoachCameraConditions takes nothing returns boolean
    if GetEventPlayerChatString() == "-foloff" then
        call DebugMsg("Coach Camera Turned Off")
        set udg_CameraState[GetPlayerId(GetTriggerPlayer())] = 0
        return false
    elseif S2I(SubString(GetEventPlayerChatString(), 5, 6)) < 1 or S2I(SubString(GetEventPlayerChatString(), 5, 6)) > 5 or SubString(GetEventPlayerChatString(), 5, 6) == null then
        call DebugMsg("Invalid")
        return false
    elseif udg_PlayerHeroes[S2I(SubString(GetEventPlayerChatString(), 5, 6))] == null then
        call DebugMsg("No hero")
        return false
    elseif udg_CameraState[GetPlayerId(GetTriggerPlayer())] == 1 then
        if GetTriggerPlayer() == Player(5) then
            call DebugMsg("Coach Camera Switched")
            call DisplayTextToPlayer(Player(5), 0, 0, "Onlookers now" + udg_PN[GetPlayerId(udg_PlayerA[S2I(SubString(GetEventPlayerChatString(), 5, 6))])])
            call SaveUnitHandle(udg_ht, LoadInteger(udg_ht, StringHash("CoachCamera"), 0), 0, udg_PlayerHeroes[GetPlayerId(udg_PlayerA[S2I(SubString(GetEventPlayerChatString(), 5, 6))])])
        elseif GetTriggerPlayer() == Player(11) then
            call DebugMsg("Supervisor Camera Switched")
            call DisplayTextToPlayer(Player(11), 0, 0, "Onlookers now" + udg_PN[GetPlayerId(udg_PlayerB[S2I(SubString(GetEventPlayerChatString(), 5, 6))])])
            call SaveUnitHandle(udg_ht, LoadInteger(udg_ht, StringHash("SupervisorCamera"), 0), 0, udg_PlayerHeroes[GetPlayerId(udg_PlayerB[S2I(SubString(GetEventPlayerChatString(), 5, 6))])])
        endif
        return false
    endif
    return true
endfunction

function CoachCameraActions takes nothing returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    if GetTriggerPlayer() == Player(5) then
        set udg_CameraState[5] = 1
        call DisplayTextToPlayer(Player(5), 0, 0, "Onlookers now" + udg_PN[GetPlayerId(udg_PlayerA[S2I(SubString(GetEventPlayerChatString(), 5, 6))])])
        call SaveUnitHandle(udg_ht, task, 0, udg_PlayerHeroes[GetPlayerId(udg_PlayerA[S2I(SubString(GetEventPlayerChatString(), 5, 6))])])
        call SaveInteger(udg_ht, StringHash("CoachCamera"), 0, task)
        call TimerStart(t, 0.1, true, function CameraForCoach)
    elseif GetTriggerPlayer() == Player(11) then
        set udg_CameraState[11] = 1
        call DisplayTextToPlayer(Player(11), 0, 0, "Onlookers now" + udg_PN[GetPlayerId(udg_PlayerB[S2I(SubString(GetEventPlayerChatString(), 5, 6))])])
        call SaveUnitHandle(udg_ht, task, 0, udg_PlayerHeroes[GetPlayerId(udg_PlayerB[S2I(SubString(GetEventPlayerChatString(), 5, 6))])])
        call SaveInteger(udg_ht, StringHash("SupervisorCamera"), 0, task)
        call TimerStart(t, 0.1, true, function CameraForSupervisor)
    endif
    set t = null
endfunction

function InitTrig_Command_Coach_Camera takes nothing returns nothing
    set gg_trg_Command_Coach_Camera = CreateTrigger()
    call TriggerRegisterPlayerChatEvent(gg_trg_Command_Coach_Camera, Player(5), "-fol", false)
    call TriggerRegisterPlayerChatEvent(gg_trg_Command_Coach_Camera, Player(11), "-fol", false)
    call TriggerAddCondition(gg_trg_Command_Coach_Camera, Condition(function CoachCameraConditions))
    call TriggerAddAction(gg_trg_Command_Coach_Camera, function CoachCameraActions)
endfunction