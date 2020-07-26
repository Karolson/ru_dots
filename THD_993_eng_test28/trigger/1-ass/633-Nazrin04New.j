function Trig_Nazrin04New_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A17T'
endfunction

function Trig_Nazrin04New_Fire_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit target = LoadUnitHandle(udg_ht, task, 0)
    local unit u = LoadUnitHandle(udg_ht, task, 1)
    local real a = LoadReal(udg_ht, task, 2)
    local integer i = LoadInteger(udg_ht, task, 3)
    local integer j = LoadInteger(udg_ht, task, 4)
    if a <= 360 then
        set a = a + 3.6
    else
        set a = a - 360
    endif
    call SetUnitXY(u, GetUnitX(target) + 45 * Cos(a * 0.017454), GetUnitY(target) + 45 * Sin(a * 0.017454))
    call SaveReal(udg_ht, task, 2, a)
    call SaveInteger(udg_ht, task, 3, i + 1)
    if i >= j or udg_SK_Nazrin04New_Target == null then
        call KillUnit(u)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set u = null
endfunction

function Trig_Nazrin04New_Fire takes unit target, unit u, real a, integer i returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call SetUnitXY(u, GetUnitX(target) + 45 * Cos(a * 0.017454), GetUnitY(target) + 45 * Sin(a * 0.017454))
    call SaveUnitHandle(udg_ht, task, 0, target)
    call SaveUnitHandle(udg_ht, task, 1, u)
    call SaveReal(udg_ht, task, 2, a)
    call SaveInteger(udg_ht, task, 3, 1)
    call SaveInteger(udg_ht, task, 4, i * 50)
    call TimerStart(t, 0.02, true, function Trig_Nazrin04New_Fire_Main)
    set t = null
endfunction

function Trig_Nazrin04New_Clear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    set udg_SK_Nazrin04New_Target = null
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    set t = null
endfunction

function Trig_Nazrin04New_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A17T')
    local timer t
    local integer task
    local integer i
    local unit u
    call AbilityCoolDownResetion(caster, 'A17T', 70 - 10 * level)
    set udg_SK_Nazrin04New_Caster = caster
    set udg_SK_Nazrin04New_Level = level
    set udg_SK_Nazrin04New_Target = target
    set t = CreateTimer()
    set task = GetHandleId(t)
    call TimerStart(t, 15, false, function Trig_Nazrin04New_Clear)
    set i = 0
    loop
        set u = CreateUnit(GetOwningPlayer(caster), 'n04S', GetUnitX(target), GetUnitY(target), i * 90)
        call Trig_Nazrin04New_Fire(target, u, i * 120, 15)
        set i = i + 1
    exitwhen i == 3
    endloop
    set i = 0
    loop
        set udg_SK_Nazrin04New_Attacked[i] = 0
        set i = i + 1
    exitwhen i == 16
    endloop
    set caster = null
    set target = null
    set t = null
    set u = null
endfunction

function InitTrig_Nazrin04New takes nothing returns nothing
endfunction