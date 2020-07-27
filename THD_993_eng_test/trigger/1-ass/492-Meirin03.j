function Trig_Meirin03_Damage_Conditions takes nothing returns boolean
    return GetUnitCurrentOrder(GetEventDamageSource()) < 852032
endfunction

function Trig_Meirin03_Damage takes nothing returns nothing
    local trigger trg = GetTriggeringTrigger()
    local integer task = GetHandleId(trg)
    local unit caster
    local unit target = GetTriggerUnit()
    local real x
    local real y
    if GetTriggerEventId() != EVENT_UNIT_DAMAGED then
        call TriggerRemoveAction(trg, LoadTriggerActionHandle(udg_ht, task, 1))
        call DestroyTrigger(trg)
        call FlushChildHashtable(udg_ht, task)
        set trg = null
        set caster = null
        set target = null
        return
    endif
    set caster = LoadUnitHandle(udg_ht, task, 0)
    if GetEventDamageSource() != caster then
        set trg = null
        set caster = null
        set target = null
        return
    endif
    set x = GetUnitX(target)
    set y = GetUnitY(target)
    call DisableTrigger(trg)
    call UnitStunTarget(caster, target, 0.4, 0, 0)
    call UnitPhysicalDamageTarget(caster, target, 10 * LoadInteger(udg_ht, task, 4) + GetUnitState(caster, UNIT_STATE_MAX_LIFE) * 0.02)
    call TriggerRemoveAction(trg, LoadTriggerActionHandle(udg_ht, task, 1))
    call DestroyTrigger(trg)
    call FlushChildHashtable(udg_ht, task)
    set caster = null
    set target = null
    set trg = null
endfunction

function Trig_Meirin03_Attacked_Conditions takes nothing returns boolean
    local integer task = GetHandleId(GetTriggeringTrigger())
    local unit caster
    local triggeraction tga
    local timer t
    if GetAttacker() != LoadUnitHandle(udg_ht, task, 1) then
        return false
    endif
    if LoadInteger(udg_ht, task, 4) > 0 then
        call SaveInteger(udg_ht, task, 4, LoadInteger(udg_ht, task, 4) - 1)
        return true
    else
        set caster = LoadUnitHandle(udg_ht, task, 1)
        set t = LoadTimerHandle(udg_ht, task, 5)
        set tga = LoadTriggerActionHandle(udg_ht, task, 3)
        call FlushChildHashtable(udg_ht, task)
        call FlushChildHashtable(udg_ht, GetHandleId(t))
        call TriggerRemoveAction(GetTriggeringTrigger(), tga)
        call DestroyTrigger(GetTriggeringTrigger())
        call ReleaseTimer(t)
        call UnitRemoveAbility(caster, 'A0SJ')
        set caster = null
        set t = null
        set tga = null
        return true
    endif
endfunction

function Trig_Meirin03_Attacked takes nothing returns nothing
    local unit caster = GetAttacker()
    local unit target = GetTriggerUnit()
    local trigger trg
    local triggeraction tga
    set trg = CreateTrigger()
    set tga = TriggerAddAction(trg, function Trig_Meirin03_Damage)
    call SaveUnitHandle(udg_ht, GetHandleId(trg), 0, caster)
    call SaveTriggerActionHandle(udg_ht, GetHandleId(trg), 1, tga)
    call TriggerRegisterUnitEvent(trg, target, EVENT_UNIT_DAMAGED)
    call TriggerRegisterUnitEvent(trg, caster, EVENT_UNIT_ISSUED_ORDER)
    call TriggerRegisterUnitEvent(trg, caster, EVENT_UNIT_ISSUED_POINT_ORDER)
    call TriggerRegisterUnitEvent(trg, caster, EVENT_UNIT_ISSUED_TARGET_ORDER)
    call TriggerAddCondition(trg, Condition(function Trig_Meirin03_Damage_Conditions))
    set trg = null
    set tga = null
    set caster = null
    set target = null
endfunction

function Trig_Meirin03_Conditions takes nothing returns boolean
    if GetSpellAbilityId() != 'A0GC' then
        return false
    endif
    call Trig_MeirinStar_Cast()
    return true
endfunction

function MeilingSkill3ActTimeOut takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 1)
    local trigger trg = LoadTriggerHandle(udg_ht, task, 2)
    local triggeraction tga = LoadTriggerActionHandle(udg_ht, task, 3)
    call UnitRemoveAbility(caster, 'A0SJ')
    call AddUnitAnimationProperties(caster, "alternate", false)
    call TriggerRemoveAction(trg, tga)
    call FlushChildHashtable(udg_ht, task)
    call FlushChildHashtable(udg_ht, GetHandleId(trg))
    call ReleaseTimer(t)
    call DestroyTrigger(trg)
    set t = null
    set caster = null
endfunction

function Trig_Meirin03_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    local timer t
    local trigger trg
    local triggeraction tga
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 16.5 - 1.5 * level)
    call UnitBuffTarget(caster, caster, 5, 'A1Z4' + level - 1, 0)
    call UnitBuffTarget(caster, caster, 5, 'A1Z0' + level - 1, 'B088')
    call UnitAddAbility(caster, 'A0SJ')
    call AddUnitAnimationProperties(caster, "alternate", true)
    set t = CreateTimer()
    set trg = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(trg, EVENT_PLAYER_UNIT_ATTACKED)
    call TriggerAddCondition(trg, Condition(function Trig_Meirin03_Attacked_Conditions))
    set tga = TriggerAddAction(trg, function Trig_Meirin03_Attacked)
    call SaveTriggerActionHandle(udg_ht, GetHandleId(trg), 3, tga)
    call SaveTimerHandle(udg_ht, GetHandleId(trg), 5, t)
    call SaveUnitHandle(udg_ht, GetHandleId(trg), 1, caster)
    call SaveInteger(udg_ht, GetHandleId(trg), 4, 4)
    call SaveTriggerHandle(udg_ht, GetHandleId(t), 2, trg)
    call SaveTriggerActionHandle(udg_ht, GetHandleId(t), 3, tga)
    call SaveUnitHandle(udg_ht, GetHandleId(t), 1, caster)
    call TimerStart(t, 9.0, false, function MeilingSkill3ActTimeOut)
    call UnitStunArea(caster, 0.4, GetUnitX(caster), GetUnitY(caster), 225, 0, 0)
    call UnitPhysicalDamageArea(caster, GetUnitX(caster), GetUnitY(caster), 225, 10 * level + GetUnitState(caster, UNIT_STATE_MAX_LIFE) * 0.02)
    set trg = null
    set tga = null
    set caster = null
    set t = null
endfunction

function InitTrig_Meirin03 takes nothing returns nothing
endfunction