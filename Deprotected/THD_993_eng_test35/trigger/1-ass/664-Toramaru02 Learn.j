function Trig_Toramaru02_Learn_Conditions takes nothing returns boolean
    return GetLearnedSkill() == 'A0Z4'
endfunction

function Trig_Toramaru02_Learn_Actions takes nothing returns nothing
    local unit u = GetTriggerUnit()
    local integer i = GetUnitAbilityLevel(u, 'A0Z4')
    if i == 1 then
        call UnitAddAbility(u, 'A0R3')
        call UnitMakeAbilityPermanent(u, true, 'A0R3')
    else
        call SetUnitAbilityLevel(u, 'A0R3', i)
    endif
    set u = null
endfunction

function InitTrig_Toramaru02_Learn takes nothing returns nothing
endfunction