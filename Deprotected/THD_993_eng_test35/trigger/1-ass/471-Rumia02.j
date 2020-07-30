function Trig_Rumia02_Conditions takes nothing returns boolean
    return GetUnitAbilityLevel(GetAttacker(), 'A11N') > 0 and IsUnitIllusion(GetEventDamageSource()) == false
endfunction

function Trig_Rumia02_Damaged takes nothing returns nothing
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
    if udg_NewDebuffSys then
        call UnitSlowTargetMspd(caster, target, 20 + GetUnitAbilityLevel(caster, 'A11N') * 5, 1.0, 2, 0)
    else
        if GetUnitAbilityLevel(caster, 'A11N') == 1 then
            call UnitSlowTarget(caster, target, 1.0, 'A11O', 'B079')
        elseif GetUnitAbilityLevel(caster, 'A11N') == 2 then
            call UnitSlowTarget(caster, target, 1.0, 'A11P', 'B079')
        elseif GetUnitAbilityLevel(caster, 'A11N') == 3 then
            call UnitSlowTarget(caster, target, 1.0, 'A11Q', 'B079')
        elseif GetUnitAbilityLevel(caster, 'A11N') == 4 then
            call UnitSlowTarget(caster, target, 1.0, 'A11R', 'B079')
        endif
    endif
    call UnitMagicDamageTarget(caster, target, udg_SK_Rumia04_Life / 25 + GetUnitAbilityLevel(caster, 'A11N') * 5 + 5, 2)
    call TriggerRemoveAction(trg, LoadTriggerActionHandle(udg_ht, task, 1))
    call DestroyTrigger(trg)
    call FlushChildHashtable(udg_ht, task)
    set caster = null
    set target = null
    set trg = null
endfunction

function Trig_Rumia02_Actions takes nothing returns nothing
    local unit caster = GetAttacker()
    local unit target = GetTriggerUnit()
    local trigger trg
    local triggeraction tga
    set trg = CreateTrigger()
    set tga = TriggerAddAction(trg, function Trig_Rumia02_Damaged)
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

function InitTrig_Rumia02 takes nothing returns nothing
endfunction