function Trig_Command_Kill_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit h = LoadUnitHandle(udg_ht, task, 0)
    local integer count = LoadInteger(udg_ht, task, 1)
    local texttag tt = LoadTextTagHandle(udg_ht, task, 2)
    local real ox = LoadReal(udg_ht, task, 3)
    local real oy = LoadReal(udg_ht, task, 4)
    local real x = GetUnitX(h)
    local real y = GetUnitY(h)
    if count < 80 then
        if x == ox and y == oy then
            call UnitStunTarget(h, h, 2.0, 0, 0)
            call SaveInteger(udg_ht, task, 1, count + 1)
        else
            call DestroyTextTag(tt)
            call ReleaseTimer(t)
            call FlushChildHashtable(udg_ht, task)
        endif
    else
        call DestroyTextTag(tt)
        set udg_Orin_suicide_check = true
        call KillUnit(h)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set tt = null
    set t = null
    set h = null
endfunction

function Trig_Command_Kill takes nothing returns boolean
    local unit h = GetPlayerCharacter(GetTriggerPlayer())
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local texttag tt = CreateTextTag()
    local real x = GetUnitX(h)
    local real y = GetUnitY(h)
    call IssueImmediateOrder(h, "stop")
    call SetTextTagText(tt, "Suicide", 0.02)
    call SetTextTagPos(tt, x - 45.0, y + 45.0, 0)
    call SetTextTagColor(tt, 255, 255, 255, 0)
    if IsUnitAlly(h, GetLocalPlayer()) == false then
        call SetTextTagVisibility(tt, false)
    endif
    call SaveUnitHandle(udg_ht, task, 0, h)
    call SaveInteger(udg_ht, task, 1, 1)
    call SaveTextTagHandle(udg_ht, task, 2, tt)
    call SaveReal(udg_ht, task, 3, x)
    call SaveReal(udg_ht, task, 4, y)
    call TimerStart(t, 0.25, true, function Trig_Command_Kill_Main)
    set h = null
    set t = null
    set tt = null
    return false
endfunction

function InitTrig_Command_Kill takes nothing returns nothing
    set gg_trg_Command_Kill = CreateTrigger()
    call TriggerAddCondition(gg_trg_Command_Kill, Condition(function Trig_Command_Kill))
endfunction