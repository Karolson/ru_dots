function Trig_Reisen202_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A091'
endfunction

function Trig_Reisen02_Fire_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit u = LoadUnitHandle(udg_ht, task, 1)
    local real a = LoadReal(udg_ht, task, 2)
    if a <= 360 then
        set a = a + 12.0
    else
        set a = a - 360 + 12.0
    endif
    call SetUnitXY(u, GetUnitX(caster) + 45 * Cos(a * 0.017454), GetUnitY(caster) + 45 * Sin(a * 0.017454))
    call SaveReal(udg_ht, task, 2, a)
    if GetUnitAbilityLevel(caster, 'A0AX') == 0 then
        call KillUnit(u)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set u = null
endfunction

function Trig_Reisen02_Fire takes unit caster, unit u, real a returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call SetUnitXY(u, GetUnitX(caster) + 45 * Cos(a * 0.017454), GetUnitY(caster) + 45 * Sin(a * 0.017454))
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, u)
    call SaveReal(udg_ht, task, 2, a)
    call TimerStart(t, 0.02, true, function Trig_Reisen02_Fire_Main)
    set t = null
endfunction

function Trig_Reisen202_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A091')
    local unit u
    local integer i
    if udg_GameMode / 100 != 3 and udg_NewMid == false then
        call AbilityCoolDownResetion(caster, 'A091', 27 - 3 * level)
    else
        call AbilityCoolDownResetion(caster, 'A091', (27 - 3 * level) * 0.75)
    endif
    call UnitBuffTarget(caster, caster, 1.0 + level * 0.5, 'A0AX', 0)
    call DMG_DamageReduce(caster, 0.01, 1.0 + level * 0.5, "All")
    set i = 0
    loop
        set i = i + 1
    exitwhen i > 6
        set u = CreateUnit(GetOwningPlayer(caster), 'n01O', GetUnitX(caster), GetUnitY(caster), i * 60)
        call Trig_Reisen02_Fire(caster, u, i * 60)
    endloop
    set caster = null
    set u = null
endfunction

function InitTrig_Reisen202 takes nothing returns nothing
endfunction