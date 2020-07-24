function Trig_Nazrin04NewAttack_Conditions takes nothing returns boolean
    if GetTriggerUnit() != udg_SK_Nazrin04New_Target then
        return false
    elseif not IsUnitType(GetAttacker(), UNIT_TYPE_HERO) then
        return false
    elseif udg_SK_Nazrin04New_Attacked[GetPlayerId(GetOwningPlayer(GetAttacker()))] == 0 then
        set udg_SK_Nazrin04New_Attacked[GetPlayerId(GetOwningPlayer(GetAttacker()))] = 1
        return true
    endif
    return false
endfunction

function Trig_Nazrin04NewAttack_Damaged takes nothing returns nothing
    local trigger trg = GetTriggeringTrigger()
    local integer task = GetHandleId(trg)
    local unit caster
    local unit target
    local real damage
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
    set target = GetTriggerUnit()
    call DisableTrigger(trg)
    set level = udg_SK_Nazrin04New_Level
    set damage = 25 + level * 25 + GetHeroInt(udg_SK_Nazrin04New_Caster, true) * 1.0
    call UnitMagicDamageTarget(udg_SK_Nazrin04New_Caster, target, damage, 1)
    call UnitStunTarget(udg_SK_Nazrin04New_Caster, target, 0.6 + level * 0.2, 0, 0)
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Items\\ResourceItems\\ResourceEffectTarget.mdl", GetUnitX(target), GetUnitY(target)))
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Items\\ResourceItems\\ResourceEffectTarget.mdl", GetUnitX(target) + 100, GetUnitY(target) + 100))
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Items\\ResourceItems\\ResourceEffectTarget.mdl", GetUnitX(target) + 100, GetUnitY(target) - 100))
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Items\\ResourceItems\\ResourceEffectTarget.mdl", GetUnitX(target) - 100, GetUnitY(target) - 100))
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Items\\ResourceItems\\ResourceEffectTarget.mdl", GetUnitX(target) - 100, GetUnitY(target) + 100))
    call TriggerRemoveAction(trg, LoadTriggerActionHandle(udg_ht, task, 1))
    call DestroyTrigger(trg)
    call FlushChildHashtable(udg_ht, task)
    set trg = null
    set caster = null
    set target = null
endfunction

function Trig_Nazrin04NewAttack_Actions takes nothing returns nothing
    local unit caster = GetAttacker()
    local unit target = GetTriggerUnit()
    local trigger trg
    local triggeraction tga
    set trg = CreateTrigger()
    set tga = TriggerAddAction(trg, function Trig_Nazrin04NewAttack_Damaged)
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

function InitTrig_Nazrin04NewAttack takes nothing returns nothing
endfunction