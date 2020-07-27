function Trig_Meirin01_Conditions takes nothing returns boolean
    if GetRandomInt(0, 100) > 12 + 3 * GetUnitAbilityLevel(GetTriggerUnit(), 'A0GA') then
        return false
    elseif GetEventDamage() <= 5.0 then
        return false
    endif
    call Trig_MeirinStar_Cast()
    return true
endfunction

function Trig_Meirin01_Frame takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local integer i = LoadInteger(udg_ht, task, 1)
    if i == 0 then
        call SaveInteger(udg_ht, task, 1, i + 1)
        call TimerStart(t, 0.7, false, function Trig_Meirin01_Frame)
    elseif i == 1 then
        call AddUnitAnimationProperties(caster, "spin", false)
        call SaveInteger(udg_ht, task, 1, i + 1)
        call TimerStart(t, 0.8, false, function Trig_Meirin01_Frame)
    else
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
        call EnableTrigger(gg_trg_Meirin01)
    endif
    set t = null
    set caster = null
endfunction

function Trig_Meirin01_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local real damage = RMinBJ(GetEventDamage(), 300)
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local integer level = GetUnitAbilityLevel(caster, 'A0GA')
    local unit u
    local timer t
    if LoadBoolean(udg_sht, GetHandleId(caster), 0) then
        call DisableTrigger(gg_trg_Meirin01)
        call SetUnitState(caster, UNIT_STATE_LIFE, damage + GetUnitState(caster, UNIT_STATE_LIFE))
        call AddUnitAnimationProperties(caster, "spin", true)
        set t = CreateTimer()
        call SaveUnitHandle(udg_ht, GetHandleId(t), 0, caster)
        call SaveInteger(udg_ht, GetHandleId(t), 1, 0)
        call TimerStart(t, 0.1, false, function Trig_Meirin01_Frame)
        call UnitPhysicalDamageArea(caster, ox, oy, 200, 45 + level * 15 + 0.02 * GetUnitState(caster, UNIT_STATE_MAX_LIFE))
    endif
    set caster = null
    set u = null
    set t = null
endfunction

function Trig_Meirin01_Trace takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local real px = GetUnitX(caster)
    local real py = GetUnitY(caster)
    local real ox = LoadReal(udg_ht, task, 0)
    local real oy = LoadReal(udg_ht, task, 1)
    if IsUnitInRangeXY(caster, ox, oy, 200.0) then
        call SaveBoolean(udg_sht, GetHandleId(caster), 0, true)
    else
        call SaveBoolean(udg_sht, GetHandleId(caster), 0, false)
    endif
    call SaveReal(udg_ht, task, 0, px)
    call SaveReal(udg_ht, task, 1, py)
    set caster = null
    set t = null
endfunction

function Trig_Meirin01_Learn_Conditions takes nothing returns boolean
    return GetLearnedSkill() == 'A0GA'
endfunction

function Trig_Meirin01_Learn_Actions takes nothing returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local unit u = GetTriggerUnit()
    call DestroyTrigger(gg_trg_Meirin01)
    set gg_trg_Meirin01 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Meirin01, u, EVENT_UNIT_DAMAGED)
    call TriggerAddCondition(gg_trg_Meirin01, Condition(function Trig_Meirin01_Conditions))
    call TriggerAddAction(gg_trg_Meirin01, function Trig_Meirin01_Actions)
    call SaveBoolean(udg_sht, GetHandleId(u), 0, true)
    call SaveUnitHandle(udg_ht, task, 0, u)
    call SaveReal(udg_ht, task, 0, GetUnitX(u))
    call SaveReal(udg_ht, task, 1, GetUnitY(u))
    call TimerStart(t, 0.7, true, function Trig_Meirin01_Trace)
    set t = null
    set u = null
endfunction

function InitTrig_Meirin01 takes nothing returns nothing
endfunction