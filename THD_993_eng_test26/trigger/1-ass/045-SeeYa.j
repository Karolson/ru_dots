function Trig_SeeYa_Conditions takes nothing returns boolean
    local real r = S2R(SubString(GetEventPlayerChatString(), 5, 8))
    return r >= 0.0 and r <= 100.0
endfunction

function Trig_SeeYa_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local player p = LoadPlayerHandle(udg_ht, task, 0)
    local real distance = LoadReal(udg_ht, GetHandleId(p), 0)
    if GetLocalPlayer() == p then
        call SetCameraField(CAMERA_FIELD_TARGET_DISTANCE, distance, 0.5)
    endif
    if distance == 0.0 then
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
        call FlushChildHashtable(udg_ht, GetHandleId(p))
    endif
    set t = null
    set p = null
endfunction

function Trig_SeeYa_Actions takes nothing returns nothing
    local player p = GetTriggerPlayer()
    local timer t
    local integer task
    local real distance = 18.0 * (S2R(SubString(GetEventPlayerChatString(), 5, 8)) + 80)
    if LoadReal(udg_ht, GetHandleId(p), 0) == distance then
        set t = null
        set p = null
        return
    endif
    if GetLocalPlayer() == p then
        call SetCameraField(CAMERA_FIELD_TARGET_DISTANCE, distance, 1.0)
    endif
    if LoadReal(udg_ht, GetHandleId(p), 0) == null then
        set t = CreateTimer()
        set task = GetHandleId(t)
        call SavePlayerHandle(udg_ht, task, 0, p)
        call SaveReal(udg_ht, GetHandleId(p), 0, distance)
        call TimerStart(t, 0.5, true, function Trig_SeeYa_Main)
    else
        call SaveReal(udg_ht, GetHandleId(p), 0, distance)
    endif
    set t = null
    set p = null
endfunction

function InitTrig_SeeYa takes nothing returns nothing
    local integer i = 0
    set gg_trg_SeeYa = CreateTrigger()
    loop
        if GetPlayerSlotState(Player(i)) == PLAYER_SLOT_STATE_PLAYING then
            call TriggerRegisterPlayerChatEvent(gg_trg_SeeYa, Player(i), "-cam ", false)
        endif
        set i = i + 1
    exitwhen i > 11
    endloop
    call TriggerAddCondition(gg_trg_SeeYa, Condition(function Trig_SeeYa_Conditions))
    call TriggerAddAction(gg_trg_SeeYa, function Trig_SeeYa_Actions)
endfunction