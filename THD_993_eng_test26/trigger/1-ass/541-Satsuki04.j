function Trig_Satsuki04_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A1HD'
endfunction

function Trig_Satsuki04_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    local unit target = GetSpellTargetUnit()
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 190 - level * 40)
    call UnitBuffTarget(caster, caster, 4 + level, 'A1HE', 0)
    call UnitBuffTarget(caster, target, 4 + level, 'A1HF', 0)
    set caster = null
endfunction

function InitTrig_Satsuki04 takes nothing returns nothing
endfunction