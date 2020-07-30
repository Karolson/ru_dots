function Trig_Remilia02Back_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0D3'
endfunction

function Trig_Remilia02Back_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    call SetUnitInvulnerable(caster, true)
    set udg_SK_Remilia02_Return = true
    call UnitAddAbility(caster, 'A0DG')
    set caster = null
endfunction

function InitTrig_Remilia02Back takes nothing returns nothing
endfunction