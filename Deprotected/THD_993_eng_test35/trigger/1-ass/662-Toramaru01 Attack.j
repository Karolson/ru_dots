function Trig_Toramaru01_Attack_Conditions takes nothing returns boolean
    local unit attacked = GetTriggerUnit()
    local unit attacker = GetAttacker()
    if GetUnitAbilityLevel(attacker, 'A0PB') <= 0 then
        set attacked = null
        set attacker = null
        return false
    endif
    set attacked = null
    set attacker = null
    return true
endfunction

function Trig_Toramaru01_Attack_Damaged takes nothing returns nothing
    local trigger trg = GetTriggeringTrigger()
    local integer task = GetHandleId(trg)
    local unit caster
    local unit target
    local integer level
    local effect e
    if GetTriggerEventId() != EVENT_UNIT_DAMAGED then
        call TriggerRemoveAction(trg, LoadTriggerActionHandle(udg_ht, task, 1))
        call DestroyTrigger(trg)
        call FlushChildHashtable(udg_ht, task)
        set trg = null
        set caster = null
        set target = null
        set e = null
        return
    endif
    set caster = LoadUnitHandle(udg_ht, task, 0)
    if GetEventDamageSource() != caster then
        set trg = null
        set caster = null
        set target = null
        set e = null
        return
    endif
    set target = GetTriggerUnit()
    set level = GetUnitAbilityLevel(caster, 'A0P2')
    call DisableTrigger(trg)
    call DestroyEffect(udg_SK_Toramaru01_Effect)
    set udg_SK_Toramaru01_Effect = null
    call UnitRemoveAbility(caster, 'A0PB')
    call UnitRemoveAbility(caster, 'B05P')
    call UnitStunTarget(caster, target, LoadReal(udg_ht, GetHandleId(caster), 888) * (0.2 + 0.05 * GetUnitAbilityLevel(caster, 'A0P2')), 0, 0)
    call UnitMagicDamageTarget(caster, target, 50 + level * 50 + 1 * GetHeroInt(caster, true), 1)
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl", GetUnitX(target), GetUnitY(target)))
    call TriggerRemoveAction(trg, LoadTriggerActionHandle(udg_ht, task, 1))
    call DestroyTrigger(trg)
    call FlushChildHashtable(udg_ht, task)
    set trg = null
    set caster = null
    set target = null
    set e = null
endfunction

function Trig_Toramaru01_Attack_Actions takes nothing returns nothing
    local unit caster = GetAttacker()
    local unit target = GetTriggerUnit()
    local trigger trg
    local triggeraction tga
    set trg = CreateTrigger()
    set tga = TriggerAddAction(trg, function Trig_Toramaru01_Attack_Damaged)
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

function InitTrig_Toramaru01_Attack takes nothing returns nothing
endfunction