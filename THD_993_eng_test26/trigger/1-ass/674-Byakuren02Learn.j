function Trig_Byakuren02Learn_Conditions takes nothing returns boolean
    return GetLearnedSkill() == 'A11W'
endfunction

function Trig_Byakuren02Learn_Actions takes nothing returns nothing
    local unit u = GetTriggerUnit()
    if GetUnitAbilityLevel(u, 'A11W') == 1 then
        call UnitAddAbility(u, 'A11X')
        call UnitMakeAbilityPermanent(u, true, 'A11X')
    elseif GetUnitAbilityLevel(u, 'A11W') == 2 then
        call UnitAddAbility(u, 'A11Y')
        call UnitMakeAbilityPermanent(u, true, 'A11Y')
    elseif GetUnitAbilityLevel(u, 'A11W') == 3 then
        call UnitAddAbility(u, 'A11Z')
        call UnitMakeAbilityPermanent(u, true, 'A11Z')
    elseif GetUnitAbilityLevel(u, 'A11W') == 4 then
        call UnitAddAbility(u, 'A120')
        call UnitMakeAbilityPermanent(u, true, 'A120')
    endif
    set u = null
endfunction

function InitTrig_Byakuren02Learn takes nothing returns nothing
endfunction