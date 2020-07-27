function Trig_ByakurenExAttack_Conditions takes nothing returns boolean
    return GetUnitTypeId(GetAttacker()) == 'H01K'
endfunction

function Trig_ByakurenExAttack_Damaged takes nothing returns nothing
    local trigger trg = GetTriggeringTrigger()
    local integer task = GetHandleId(trg)
    local unit caster
    local unit target
    local real damage
    local group g
    local boolexpr iff
    local real heal = 0
    local unit v
    if GetTriggerEventId() != EVENT_UNIT_DAMAGED or IsUnitIllusion(GetEventDamageSource()) then
        call TriggerRemoveAction(trg, LoadTriggerActionHandle(udg_ht, task, 1))
        call DestroyTrigger(trg)
        call FlushChildHashtable(udg_ht, task)
        set trg = null
        set caster = null
        set target = null
        set g = null
        set iff = null
        set v = null
        return
    endif
    set caster = LoadUnitHandle(udg_ht, task, 0)
    if GetEventDamageSource() != caster then
        set trg = null
        set caster = null
        set target = null
        set g = null
        set iff = null
        set v = null
        return
    endif
    set target = GetTriggerUnit()
    call DisableTrigger(trg)
    set damage = 16 + (GetUnitState(caster, UNIT_STATE_MAX_LIFE) - GetUnitState(caster, UNIT_STATE_LIFE)) * 0.025
    set heal = heal + UnitMagicDamageTarget(caster, target, damage, 2)
    set g = CreateGroup()
    set iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    call GroupEnumUnitsInRange(g, GetUnitX(target), GetUnitY(target), 300, iff)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if IsUnitType(v, UNIT_TYPE_DEAD) == false and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false and target != v then
            set heal = heal + UnitMagicDamageTarget(caster, v, damage * 0.5, 6)
        endif
    endloop
    call DestroyGroup(g)
    if IsUnitType(target, UNIT_TYPE_STRUCTURE) then
        call UnitHealingTarget(caster, caster, heal)
    else
        call UnitHealingTarget(caster, caster, heal)
    endif
    call DestroyEffect(AddSpecialEffect("Abilities \\Weapons\\GreenDragonMissile\\GreenDragonMissile.mdl", GetUnitX(target), GetUnitY(target)))
    call TriggerRemoveAction(trg, LoadTriggerActionHandle(udg_ht, task, 1))
    call DestroyTrigger(trg)
    call FlushChildHashtable(udg_ht, task)
    set trg = null
    set caster = null
    set target = null
    set g = null
    set iff = null
    set v = null
endfunction

function Trig_ByakurenExAttack_Actions takes nothing returns nothing
    local unit caster = GetAttacker()
    local unit target = GetTriggerUnit()
    local trigger trg
    local triggeraction tga
    set trg = CreateTrigger()
    set tga = TriggerAddAction(trg, function Trig_ByakurenExAttack_Damaged)
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

function InitTrig_ByakurenExAttack takes nothing returns nothing
endfunction