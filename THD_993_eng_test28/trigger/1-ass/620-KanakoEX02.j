function Trig_KanakoEX02_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0F8'
endfunction

function Trig_KanakoEX02_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A0F8')
    call AbilityCoolDownResetion(caster, 'A0F8', 24)
    if GetTriggerEventId() == EVENT_UNIT_SPELL_EFFECT then
        call UnitAddAbility(caster, 'A0F9')
        call SetUnitAbilityLevel(caster, 'A0F9', level)
    else
        call UnitRemoveAbility(caster, 'A0F9')
    endif
    set caster = null
endfunction

function InitTrig_KanakoEX02 takes nothing returns nothing
endfunction