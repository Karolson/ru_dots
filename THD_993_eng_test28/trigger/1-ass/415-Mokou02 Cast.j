function Trig_Mokou02_Cast_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A00G'
endfunction

function Trig_Mokou02_Cast_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 21 - 3 * level)
    call UnitHealingTarget(caster, caster, 20 + (GetUnitState(caster, UNIT_STATE_MAX_LIFE) - GetUnitState(caster, UNIT_STATE_LIFE)) * (0.03 + level * 0.01))
    call UnitBuffTarget(caster, caster, 10.0, 'A00N', 0)
    set caster = null
endfunction

function InitTrig_Mokou02_Cast takes nothing returns nothing
endfunction