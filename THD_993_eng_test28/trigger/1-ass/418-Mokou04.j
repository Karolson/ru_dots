function Trig_Mokou04_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A059'
endfunction

function Trig_Mokou04_Finish takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local integer level = LoadInteger(udg_ht, task, 0)
    if GetUnitAbilityLevel(caster, 'A053') > 0 then
        call UnitRemoveAbility(caster, 'A055')
    endif
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    set t = null
    set caster = null
endfunction

function Trig_Mokou04_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A059')
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 105 - level * 10)
    call VE_Spellcast(caster)
    call UnitMagicDamageTarget(caster, caster, GetUnitState(caster, UNIT_STATE_LIFE) * 0.25, 1)
    call UnitRemoveAbility(caster, 'A053')
    call UnitRemoveAbility(caster, 'A054')
    call UnitRemoveAbility(caster, 'A055')
    call UnitRemoveAbility(caster, 'A056')
    call UnitRemoveAbility(caster, 'A057')
    call UnitRemoveAbility(caster, 'A058')
    call UnitRemoveAbility(caster, 'B00U')
    call UnitRemoveAbility(caster, 'B00V')
    call UnitRemoveAbility(caster, 'B00W')
    call UnitRemoveAbility(caster, 'B00X')
    call UnitAddAbility(caster, 'A055')
    call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A055', false)
    call SetUnitAbilityLevel(caster, 'A053', level)
    call SetUnitAbilityLevel(caster, 'A054', level)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveInteger(udg_ht, task, 0, level)
    call TimerStart(t, 20.0, false, function Trig_Mokou04_Finish)
    set caster = null
    set t = null
endfunction

function InitTrig_Mokou04 takes nothing returns nothing
endfunction