function Trig_Tokiko03_Attack_Conditions takes nothing returns boolean
    local integer k = GetPlayerId(GetOwningPlayer(GetAttacker())) + 1
    if IsUnitType(GetTriggerUnit(), UNIT_TYPE_HERO) == false then
        if HaveSavedBoolean(udg_SK_Tokiko03_Hashtable[k], GetHandleId(GetTriggerUnit()), 0) then
            return false
        else
            return GetUnitAbilityLevel(GetAttacker(), 'A0ZM') >= 1 and IsUnitIllusion(GetAttacker()) == false
        endif
        return false
    elseif HaveSavedBoolean(udg_SK_Tokiko03_Hashtable[k], GetHandleId(GetTriggerUnit()), 0) then
        return false
    else
        return GetUnitAbilityLevel(GetAttacker(), 'A0ZM') >= 1 and IsUnitIllusion(GetAttacker()) == false
    endif
    return false
endfunction

function Trig_Tokiko03_Fire_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local real x = LoadReal(udg_ht, task, 0)
    local real y = LoadReal(udg_ht, task, 1)
    local real a = LoadReal(udg_ht, task, 2)
    local integer i = LoadInteger(udg_ht, task, 3)
    if i <= 6 then
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Human\\ManaFlare\\ManaFlareMissile.mdl", x + i * 27 * CosBJ(a), y + i * 27 * SinBJ(a)))
    endif
    call SaveInteger(udg_ht, task, 3, i + 1)
    if i >= 6 then
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
endfunction

function Trig_Tokiko03_Fire takes real x, real y, real a returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call SaveReal(udg_ht, task, 0, x)
    call SaveReal(udg_ht, task, 1, y)
    call SaveReal(udg_ht, task, 2, a)
    call SaveInteger(udg_ht, task, 3, 1)
    call TimerStart(t, 0.05, true, function Trig_Tokiko03_Fire_Main)
    set t = null
endfunction

function Trig_Tokiko03_Attack_Fade takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit target = LoadUnitHandle(udg_ht, task, 1)
    local integer k = GetPlayerId(GetOwningPlayer(caster)) + 1
    call FlushChildHashtable(udg_SK_Tokiko03_Hashtable[k], GetHandleId(target))
    call FlushChildHashtable(udg_ht, task)
    call ReleaseTimer(t)
    set t = null
    set caster = null
    set target = null
endfunction

function Trig_Tokiko03_Attack_Damaged takes nothing returns nothing
    local trigger trg = GetTriggeringTrigger()
    local integer task = GetHandleId(trg)
    local unit caster
    local unit target
    local real damage = 0
    local timer t
    local integer level
    local real ox
    local real oy
    local real tx
    local real ty
    local real a
    local integer i
    local integer k
    if GetTriggerEventId() != EVENT_UNIT_DAMAGED then
        call TriggerRemoveAction(trg, LoadTriggerActionHandle(udg_ht, task, 1))
        call DestroyTrigger(trg)
        call FlushChildHashtable(udg_ht, task)
        set trg = null
        set caster = null
        set target = null
        set t = null
        return
    endif
    set caster = LoadUnitHandle(udg_ht, task, 0)
    if GetEventDamageSource() != caster then
        set trg = null
        set caster = null
        set target = null
        set t = null
        return
    endif
    set target = GetTriggerUnit()
    call DisableTrigger(trg)
    set ox = GetUnitX(caster)
    set oy = GetUnitY(caster)
    set tx = GetUnitX(target)
    set ty = GetUnitY(target)
    set a = Atan2(ty - oy, tx - ox)
    set i = 0
    loop
        call Trig_Tokiko03_Fire(tx, ty, bj_RADTODEG * a + 33.3 * (i - 1))
        set i = i + 1
    exitwhen i == 3
    endloop
    set level = GetUnitAbilityLevel(caster, 'A0ZM')
    set damage = level * 10 + GetUnitState(target, UNIT_STATE_LIFE) * (level * 0.04)
    call UnitMagicDamageTarget(caster, target, damage, 2)
    set k = GetPlayerId(GetOwningPlayer(caster)) + 1
    call SaveBoolean(udg_SK_Tokiko03_Hashtable[k], GetHandleId(target), 0, true)
    set t = CreateTimer()
    call SaveUnitHandle(udg_ht, GetHandleId(t), 0, caster)
    call SaveUnitHandle(udg_ht, GetHandleId(t), 1, target)
    call TimerStart(t, 10.0, false, function Trig_Tokiko03_Attack_Fade)
    call TriggerRemoveAction(trg, LoadTriggerActionHandle(udg_ht, task, 1))
    call DestroyTrigger(trg)
    call FlushChildHashtable(udg_ht, task)
    set trg = null
    set caster = null
    set target = null
    set t = null
endfunction

function Trig_Tokiko03_Attack_Actions takes nothing returns nothing
    local unit caster = GetAttacker()
    local unit target = GetTriggerUnit()
    local trigger trg
    local triggeraction tga
    set trg = CreateTrigger()
    set tga = TriggerAddAction(trg, function Trig_Tokiko03_Attack_Damaged)
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

function InitTrig_Tokiko03_Attack takes nothing returns nothing
endfunction