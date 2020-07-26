function Trig_Shanghai01_Conditions takes nothing returns boolean
    local unit caster = null
    if GetIssuedOrderId() == OrderId("defend") then
        set caster = GetTriggerUnit()
        call UnitAddAbility(caster, 'AIsr')
        call UnitAddAbility(caster, 'A0HH')
        call SetUnitAbilityLevel(caster, 'A0HG', GetUnitAbilityLevel(caster, 'A0HF'))
        if GetUnitAbilityLevel(caster, 'B044') > 0 then
            call UnitRemoveAbility(caster, 'B044')
        endif
        if GetUnitAbilityLevel(caster, 'A0HW') > 0 then
            call UnitRemoveAbility(caster, 'A0HW')
        endif
        set caster = null
        return false
    endif
    if GetIssuedOrderId() == OrderId("undefend") then
        set caster = GetTriggerUnit()
        call UnitRemoveAbility(caster, 'AIsr')
        call UnitRemoveAbility(caster, 'A0HH')
        set caster = null
        return false
    endif
    set caster = null
    return false
endfunction

function InitTrig_Shanghai01 takes nothing returns nothing
endfunction