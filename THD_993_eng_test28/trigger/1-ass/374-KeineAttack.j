function Trig_KeineAttack_Conditions takes nothing returns boolean
    if IsUnitIllusion(GetEventDamageSource()) then
        return false
    endif
    if IsUnitType(GetTriggerUnit(), UNIT_TYPE_STRUCTURE) then
        return false
    endif
    if GetUnitAbilityLevel(GetAttacker(), 'A0VZ') != 0 then
        return false
    endif
    return GetUnitAbilityLevel(GetAttacker(), 'A0M7') > 0 and GetRandomInt(0, 100) < 20
endfunction

function Trig_KeineAttack_Damaged takes nothing returns nothing
    local trigger trg = GetTriggeringTrigger()
    local integer task = GetHandleId(trg)
    local unit caster
    local unit target = GetTriggerUnit()
    local real x
    local real y
    local integer level
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
    set level = GetUnitAbilityLevel(caster, 'A0M7')
    call DisableTrigger(trg)
    call UnitPhysicalDamageTarget(caster, target, GetUnitAttack(caster) + 10 + level * 40 + ABCIExtraInt(caster, 0, 1.0))
    call UnitStunTarget(caster, target, 1.0, 0, 0)
    call TriggerRemoveAction(trg, LoadTriggerActionHandle(udg_ht, task, 1))
    call DestroyTrigger(trg)
    call FlushChildHashtable(udg_ht, task)
    set caster = null
    set target = null
    set trg = null
endfunction

function Trig_KeineAttack_Actions takes nothing returns nothing
    local unit caster = GetAttacker()
    local unit target = GetTriggerUnit()
    local trigger trg
    local triggeraction tga
    set trg = CreateTrigger()
    call SetUnitAnimation(caster, "Attack Slam")
    set tga = TriggerAddAction(trg, function Trig_KeineAttack_Damaged)
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

function InitTrig_KeineAttack takes nothing returns nothing
endfunction