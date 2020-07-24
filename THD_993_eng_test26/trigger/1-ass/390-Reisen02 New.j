function Trig_Reisen02_New_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0PJ'
endfunction

function Trig_Reisen02_New_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    call AbilityCoolDownResetion(caster, 'A0PJ', 7)
    set udg_SK_Reisen02 = true
    set caster = null
endfunction

function InitTrig_Reisen02_New takes nothing returns nothing
endfunction