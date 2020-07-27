function Trig_Hatate02_Attack_Conditions takes nothing returns boolean
    local unit attacked = GetTriggerUnit()
    local unit attacker = GetAttacker()
    if IsUnitIllusion(GetEventDamageSource()) then
        set attacked = null
        set attacker = null
        return false
    elseif GetUnitAbilityLevel(attacker, 'A09B') <= 0 then
        set attacked = null
        set attacker = null
        return false
    elseif GetUnitAbilityLevel(attacked, 'B05Z') == 0 then
        set attacked = null
        set attacker = null
        return false
    endif
    set attacked = null
    set attacker = null
    return true
endfunction

function Trig_Hatate02_Attack_Damaged takes nothing returns nothing
    local trigger trg = GetTriggeringTrigger()
    local integer task = GetHandleId(trg)
    local unit caster
    local unit target
    local integer level
    local real damage = 0
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
    set level = GetUnitAbilityLevel(caster, 'A09B')
    set damage = level * 15.0 + GetUnitAttack(caster) * 0.05
    call DisableTrigger(trg)
    call UnitMagicDamageTarget(caster, target, damage, 1)
    call TriggerRemoveAction(trg, LoadTriggerActionHandle(udg_ht, task, 1))
    call DestroyTrigger(trg)
    call FlushChildHashtable(udg_ht, task)
    set trg = null
    set caster = null
    set target = null
    set e = null
endfunction

function Trig_Hatate02_Attack_Actions takes nothing returns nothing
    local unit caster = GetAttacker()
    local unit target = GetTriggerUnit()
    local trigger trg
    local triggeraction tga
    set trg = CreateTrigger()
    set tga = TriggerAddAction(trg, function Trig_Hatate02_Attack_Damaged)
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

function InitTrig_Hatate02_Attack takes nothing returns nothing
endfunction