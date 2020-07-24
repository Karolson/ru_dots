function Trig_Hatate01_Learn_Conditions takes nothing returns boolean
    return GetLearnedSkill() == 'A08N'
endfunction

function Trig_Hatate01_Learn_Actions takes nothing returns nothing
    local unit u = GetTriggerUnit()
    if GetUnitAbilityLevel(u, 'A08N') == 1 then
        call UnitAddAbility(u, 'A08O')
    else
        call SetUnitAbilityLevel(u, 'A08O', GetUnitAbilityLevel(u, 'A08N'))
    endif
    set u = null
endfunction

function InitTrig_Hatate01_Learn takes nothing returns nothing
endfunction