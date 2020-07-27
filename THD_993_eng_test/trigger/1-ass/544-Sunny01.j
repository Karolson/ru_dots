function Trig_Sunny01_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0NB'
endfunction

function Trig_Sunny01_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    call AbilityCoolDownResetion(caster, 'A0NB', 35 - GetUnitAbilityLevel(caster, GetSpellAbilityId()) * 5)
    set caster = null
endfunction

function InitTrig_Sunny01 takes nothing returns nothing
endfunction