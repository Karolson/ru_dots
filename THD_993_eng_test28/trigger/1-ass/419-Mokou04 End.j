function Trig_Mokou04_End_Conditions takes nothing returns boolean
    return true
endfunction

function Trig_Mokou04_End_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    call UnitRemoveAbility(caster, 'A053')
    call UnitRemoveAbility(caster, 'A054')
    call UnitRemoveAbility(caster, 'A055')
    call UnitRemoveAbility(caster, 'B00U')
    call UnitRemoveAbility(caster, 'B00V')
    call UnitRemoveAbility(caster, 'B00W')
    call UnitRemoveAbility(caster, 'B00X')
    set caster = null
endfunction

function InitTrig_Mokou04_End takes nothing returns nothing
endfunction