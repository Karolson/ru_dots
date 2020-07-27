function Trig_Merlin03_Conditions takes nothing returns boolean
    return GetLearnedSkill() == 'A0RX'
endfunction

function Trig_Merlin03_Target takes nothing returns boolean
    if IsUnitType(GetFilterUnit(), UNIT_TYPE_DEAD) then
        return false
    endif
    if IsUnitType(GetFilterUnit(), UNIT_TYPE_STRUCTURE) then
        return false
    endif
    return IsUnitAlly(GetFilterUnit(), GetOwningPlayer(LoadUnitHandle(udg_ht, GetHandleId(GetExpiredTimer()), 0)))
endfunction

function Trig_Merlin03_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local integer level = GetUnitAbilityLevel(caster, 'A0RX')
    local real h0 = GetUnitState(caster, UNIT_STATE_LIFE)
    local real h1 = GetUnitState(caster, UNIT_STATE_MAX_LIFE)
    local real c = 26 - level * 4
    local real incres = (1 - h0 / h1) * (100 / c) * 3
    local group g = LoadGroupHandle(udg_ht, task, 1)
    local boolexpr iff
    local unit v
    set iff = Filter(function Trig_Merlin03_Target)
    call GroupEnumUnitsInRange(g, GetUnitX(caster), GetUnitY(caster), 600, iff)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        call UnitHealingTarget(caster, v, incres)
    endloop
    set t = null
    set caster = null
    set g = null
    set iff = null
    set v = null
endfunction

function Trig_Merlin03_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local timer t
    local integer task
    local integer level = GetUnitAbilityLevel(caster, 'A0RX')
    local group g
    if level == 1 then
        set t = CreateTimer()
        set g = CreateGroup()
        set task = GetHandleId(t)
        call SaveUnitHandle(udg_ht, task, 0, caster)
        call SaveGroupHandle(udg_ht, task, 1, g)
        call TimerStart(t, 1.0, true, function Trig_Merlin03_Main)
    endif
    set g = null
    set t = null
    set caster = null
endfunction

function InitTrig_Merlin03 takes nothing returns nothing
endfunction