function Trig_Yuugi03New_Conditions takes nothing returns boolean
    local integer i = 0
    if IsUnitType(GetTriggerUnit(), UNIT_TYPE_STRUCTURE) then
        return false
    endif
    if not IsMobileUnit(GetTriggerUnit()) then
        return false
    endif
    if GetUnitTypeId(GetTriggerUnit()) == 'n006' then
        return false
    endif
    if IsUnitIllusion(GetEventDamageSource()) then
        return false
    endif
    if GetUnitAbilityLevel(GetAttacker(), 'A08C') >= 1 then
        set i = 15
        set udg_SK_Yuugi03_Count = udg_SK_Yuugi03_Count + i
    endif
    if GetRandomInt(0, 100) < i or udg_SK_Yuugi03_Count >= 100 then
        set udg_SK_Yuugi03_Count = 0
        return true
    endif
    return false
endfunction

function Trig_Yuugi03_Des_Condition takes nothing returns nothing
    set udg_SK_Yuugi02I = udg_SK_Yuugi02I + 1
endfunction

function Trig_Yuugi03_Unit_Condition takes nothing returns boolean
    if GetUnitState(GetFilterUnit(), UNIT_STATE_LIFE) > 0 then
        if GetFilterUnit() != udg_SK_Yuugi02U1 and GetFilterUnit() != udg_SK_Yuugi02U2 then
            set udg_SK_Yuugi02I = udg_SK_Yuugi02I + 1
        endif
    endif
    return false
endfunction

function Trig_Yuugi03_Push takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit u = LoadUnitHandle(udg_ht, task, 0)
    local unit ud = LoadUnitHandle(udg_ht, task, 1)
    local group g
    local real d = LoadReal(udg_ht, task, 2)
    local real f = LoadReal(udg_ht, task, 3)
    local real x = LoadReal(udg_ht, task, 4)
    local real y = LoadReal(udg_ht, task, 5)
    local real xt = PolarProjection(u, 9, f, true)
    local real yt = PolarProjection(u, 9, f, false)
    local location p
    set udg_SK_Yuugi02I = 0
    set udg_SK_Yuugi02U1 = u
    set udg_SK_Yuugi02U2 = ud
    if DistanceBetween2(u, x, y) < 500 then
        set g = CreateGroup()
        call GroupEnumUnitsInRange(g, xt, yt, 75, Condition(function Trig_Yuugi03_Unit_Condition))
        call DestroyGroup(g)
        set p = Location(xt, yt)
        call YDWEEnumDestructablesInCircleBJNull(100, p, function Trig_Yuugi03_Des_Condition)
        call RemoveLocation(p)
        set p = null
        if udg_SK_Yuugi02I <= 0 and IsTerrainPathable(xt, yt, PATHING_TYPE_WALKABILITY) == false then
            call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\AncientProtectorMissile\\AncientProtectorMissile.mdl", GetUnitX(u), GetUnitY(u)))
            call SetUnitX(u, xt)
            call SetUnitY(u, yt)
        else
            call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\AncientProtectorMissile\\AncientProtectorMissile.mdl", GetUnitX(u), GetUnitY(u)))
            call PauseUnit(u, false)
            call SetUnitPathing(u, true)
            call SetUnitFlag(u, 4, false)
            call UnitPhysicalDamageTarget(ud, u, d)
            call FlushChildHashtable(udg_ht, task)
            call ReleaseTimer(t)
        endif
    else
        call PauseUnit(u, false)
        call SetUnitPathing(u, true)
        call SetUnitFlag(u, 4, false)
        call UnitPhysicalDamageTarget(ud, u, d)
        call FlushChildHashtable(udg_ht, task)
        call ReleaseTimer(t)
    endif
    set udg_SK_Yuugi02U1 = null
    set udg_SK_Yuugi02U2 = null
    set t = null
    set ud = null
    set u = null
    set g = null
endfunction

function Trig_Yuugi03_Damaged takes nothing returns nothing
    local trigger trg = GetTriggeringTrigger()
    local integer task = GetHandleId(trg)
    local unit caster
    local unit target
    local integer level
    local integer task2
    local timer t
    local real f
    local real d
    if GetTriggerEventId() != EVENT_UNIT_DAMAGED then
        call TriggerRemoveAction(trg, LoadTriggerActionHandle(udg_ht, task, 1))
        call DestroyTrigger(trg)
        call FlushChildHashtable(udg_ht, task)
        set t = null
        set trg = null
        set caster = null
        set target = null
        return
    endif
    set caster = LoadUnitHandle(udg_ht, task, 0)
    if GetEventDamageSource() != caster then
        set t = null
        set trg = null
        set caster = null
        set target = null
        return
    endif
    set target = GetTriggerUnit()
    call DisableTrigger(trg)
    set level = GetUnitAbilityLevel(caster, 'A08C')
    call SetUnitAnimation(caster, "Attack Slam")
    call UnitStunTarget(caster, target, GetUnitAbilityLevel(caster, 'A08C') * 0.4 + 0.4, 0, 0)
    if GetUnitTypeId(target) != 'U00M' then
        set t = CreateTimer()
        set task2 = GetHandleId(t)
        set d = GetUnitAbilityLevel(caster, 'A08C') * 50 + GetUnitAttack(caster)
        set f = AngleBetween(caster, target)
        call SaveUnitHandle(udg_ht, task2, 0, target)
        call SaveUnitHandle(udg_ht, task2, 1, caster)
        call SaveReal(udg_ht, task2, 2, d)
        call SaveReal(udg_ht, task2, 3, f)
        call SaveReal(udg_ht, task2, 4, GetUnitX(caster))
        call SaveReal(udg_ht, task2, 5, GetUnitY(caster))
        call SetUnitPathing(target, true)
        call SetUnitFlag(target, 4, true)
        call TimerStart(t, 0.01, true, function Trig_Yuugi03_Push)
    endif
    call TriggerRemoveAction(trg, LoadTriggerActionHandle(udg_ht, task, 1))
    call DestroyTrigger(trg)
    call FlushChildHashtable(udg_ht, task)
    set caster = null
    set target = null
    set trg = null
    set t = null
endfunction

function Trig_Yuugi03New_Actions takes nothing returns nothing
    local unit caster = GetAttacker()
    local unit target = GetTriggerUnit()
    local trigger trg
    local triggeraction tga
    call SetUnitAnimation(caster, "Attack Slam")
    set trg = CreateTrigger()
    set tga = TriggerAddAction(trg, function Trig_Yuugi03_Damaged)
    call SaveUnitHandle(udg_ht, GetHandleId(trg), 0, caster)
    call SaveTriggerActionHandle(udg_ht, GetHandleId(trg), 1, tga)
    call TriggerRegisterUnitEvent(trg, target, EVENT_UNIT_DAMAGED)
    call TriggerRegisterUnitEvent(trg, caster, EVENT_UNIT_ISSUED_ORDER)
    call TriggerRegisterUnitEvent(trg, caster, EVENT_UNIT_ISSUED_POINT_ORDER)
    call TriggerRegisterUnitEvent(trg, caster, EVENT_UNIT_ISSUED_TARGET_ORDER)
    set trg = null
    set tga = null
    set caster = null
    set target = null
endfunction

function InitTrig_Yuugi03New takes nothing returns nothing
endfunction