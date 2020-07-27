function Trig_ReisenN02_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A1GS'
endfunction

function Trig_ReisenN02_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    call AbilityCoolDownResetion(caster, 'A1GS', 7)
    call UnitAddAbility(caster, 'A1GP')
    set caster = null
endfunction

function InitTrig_ReisenN02 takes nothing returns nothing
endfunction