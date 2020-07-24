function Trig_Reisen204_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A095'
endfunction

function Trig_Reisen204_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A095')
    call AbilityCoolDownResetion(caster, 'A095', 95 - 5 * level)
    call UnitBuffTarget(caster, caster, 8.0, 'A0B9', 0)
    call UnitBuffTarget(caster, caster, 8.0, 'A0BA', 'B07G')
    call SetUnitAbilityLevel(caster, 'A0BA', level)
    set caster = null
endfunction

function InitTrig_Reisen204 takes nothing returns nothing
endfunction