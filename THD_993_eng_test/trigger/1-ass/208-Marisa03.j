function Trig_Marisa03_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A03Z'
endfunction

function Trig_Marisa03_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit u = LoadUnitHandle(udg_ht, task, 1)
    local real a
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real px
    local real py
    local integer i
    if GetWidgetLife(u) >= 0.405 and GetWidgetLife(caster) >= 0.405 then
        set i = 1
        loop
        exitwhen i > 4
            set u = LoadUnitHandle(udg_ht, task, i)
            set a = LoadReal(udg_ht, task, i)
            set a = a + 1.5
            set px = ox + 150 * CosBJ(a)
            set py = oy + 150 * SinBJ(a)
            call SetUnitX(u, px)
            call SetUnitY(u, py)
            call SaveReal(udg_ht, task, i, a)
            set i = i + 1
        endloop
    else
        set i = 1
        loop
        exitwhen i > 4
            set u = LoadUnitHandle(udg_ht, task, i)
            call KillUnit(u)
            set i = i + 1
        endloop
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set u = null
endfunction

function Trig_Marisa03_Actions takes nothing returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local unit caster = GetTriggerUnit()
    local unit u
    local real a
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real px
    local real py
    local integer level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    local integer i = 1
    local integer abid = GetSpellAbilityId()
    if GetUnitAbilityLevel(caster, 'A02L') > 0 then
        call AbilityCoolDownResetion(caster, abid, 18.0)
    else
        call AbilityCoolDownResetion(caster, abid, 18.0)
    endif
    call MarisaEx_ColdTimer(caster)
    loop
    exitwhen i > 4
        set a = 90 * i
        set px = ox + 150 * CosBJ(a)
        set py = oy + 150 * SinBJ(a)
        set u = CreateUnit(GetOwningPlayer(caster), 'n00O', px, py, a)
        call SetUnitAbilityLevel(u, 'A045', level)
        call UnitApplyTimedLife(u, 'BHwe', 8.0)
        call SetUnitScale(u, level * 0.3 + 1, level * 0.3 + 1, level * 0.3 + 1)
        call SaveUnitHandle(udg_ht, task, i, u)
        call SaveReal(udg_ht, task, i, a)
        set i = i + 1
    endloop
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call TimerStart(t, 0.02, true, function Trig_Marisa03_Main)
    set t = null
    set caster = null
    set u = null
endfunction

function InitTrig_Marisa03 takes nothing returns nothing
endfunction