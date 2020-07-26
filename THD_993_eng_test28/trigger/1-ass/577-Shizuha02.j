function Trig_Shizuha02_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0JC'
endfunction

function Trig_Shizuha02_End takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local integer i = LoadInteger(udg_ht, task, 1)
    if i > 0 and GetWidgetLife(caster) >= 0.405 then
        call SaveInteger(udg_ht, task, 1, i - 1)
    else
        call UnitRemoveAbility(caster, 'A0JM')
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set caster = null
    set t = null
endfunction

function Trig_Shizuha02_Trace takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local integer level = LoadInteger(udg_ht, task, 0)
    local integer i = LoadInteger(udg_ht, task, 1)
    local integer c = LoadInteger(udg_ht, task, 2)
    local boolean o = GetUnitCurrentOrder(caster) == OrderId("tranquility")
    local boolean b = GetUnitAbilityLevel(caster, 'B04R') > 0
    if i > 0 then
        if o and b then
            call SaveInteger(udg_ht, task, 1, i - 1)
        else
            call SetUnitTimeScale(caster, 1.0)
            call SetUnitAnimation(caster, "stand")
            if o then
                call IssueImmediateOrder(caster, "stop")
            endif
            if b then
                call UnitRemoveAbility(caster, 'B04R')
            endif
            call ReleaseTimer(t)
            call FlushChildHashtable(udg_ht, task)
        endif
    else
        call SetUnitTimeScale(caster, 1.0)
        call SetUnitAnimation(caster, "stand")
        call IssueImmediateOrder(caster, "stop")
        call UnitAddAbility(caster, 'A0JM')
        call SetUnitAbilityLevel(caster, 'A0JM', level)
        call SaveInteger(udg_ht, task, 1, 200)
        call TimerStart(t, 0.1, true, function Trig_Shizuha02_End)
    endif
    set t = null
    set caster = null
endfunction

function Trig_Shizuha02_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit u
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local integer level = GetUnitAbilityLevel(caster, 'A0JC')
    local real s = 6.9 / (8.0 - 1.0 * level)
    call AbilityCoolDownResetion(caster, 'A0JC', 60)
    call SetUnitTimeScale(caster, s)
    call IssueImmediateOrder(caster, "tranquility")
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveInteger(udg_ht, task, 0, level)
    call SaveInteger(udg_ht, task, 1, 80 - 10 * level)
    call SaveBoolean(udg_ht, task, 0, false)
    call TimerStart(t, 0.1, true, function Trig_Shizuha02_Trace)
    set caster = null
    set u = null
    set t = null
endfunction

function InitTrig_Shizuha02 takes nothing returns nothing
endfunction