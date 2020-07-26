function Trig_Momizi02_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A09V'
endfunction

function Trig_Momizi02_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    call AbilityCoolDownResetion(caster, 'A09V', 15)
    set caster = null
endfunction

function InitTrig_Momizi02 takes nothing returns nothing
endfunction