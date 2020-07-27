function Trig_Byakuren02_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A11W'
endfunction

function Trig_Byakuren02_Clear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    call UnitRemoveAbility(caster, 'A122')
    call UnitRemoveAbility(caster, 'A128')
    call UnitRemoveAbility(caster, 'A129')
    call UnitRemoveAbility(caster, 'A12A')
    call UnitRemoveAbility(caster, 'B06M')
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    set t = null
    set caster = null
endfunction

function Trig_Byakuren02_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A11W')
    local unit e
    local real damage = RMinBJ(GetUnitState(caster, UNIT_STATE_MANA), GetUnitState(caster, UNIT_STATE_MAX_MANA) * 0.1)
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call AbilityCoolDownResetion(caster, 'A11W', 13)
    set e = CreateUnit(GetOwningPlayer(caster), 'e01M', GetUnitX(caster), GetUnitY(caster), 0)
    call SetUnitPathing(e, false)
    call SetUnitXY(e, GetUnitX(caster), GetUnitY(caster))
    call SetUnitState(caster, UNIT_STATE_MANA, GetUnitState(caster, UNIT_STATE_MANA) - damage)
    set udg_SK_Byakuren02_Record = damage * (0.2 + level * 0.2)
    if level == 1 then
        call UnitAddAbility(caster, 'A122')
        call UnitMakeAbilityPermanent(GetTriggerUnit(), true, 'A122')
    elseif level == 2 then
        call UnitAddAbility(caster, 'A128')
        call UnitMakeAbilityPermanent(GetTriggerUnit(), true, 'A128')
    elseif level == 3 then
        call UnitAddAbility(caster, 'A129')
        call UnitMakeAbilityPermanent(GetTriggerUnit(), true, 'A129')
    elseif level == 4 then
        call UnitAddAbility(caster, 'A12A')
        call UnitMakeAbilityPermanent(GetTriggerUnit(), true, 'A12A')
    endif
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call TimerStart(t, 3.0, false, function Trig_Byakuren02_Clear)
    set caster = null
    set e = null
    set t = null
endfunction

function InitTrig_Byakuren02 takes nothing returns nothing
endfunction