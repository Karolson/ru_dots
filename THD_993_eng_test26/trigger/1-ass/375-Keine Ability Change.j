function Trig_Keine_Ability_Change_Actions takes nothing returns nothing
    local unit u = udg_SK_Keine
    if GetUnitAbilityLevel(u, 'A0M5') == 0 and GetUnitAbilityLevel(u, 'A0M8') > 0 then
        call UnitAddAbility(u, 'A0M5')
    endif
    if GetUnitAbilityLevel(u, 'A0M8') != 0 then
        call SetUnitAbilityLevel(u, 'A0M5', GetUnitAbilityLevel(u, 'A0M8'))
    endif
    if GetUnitAbilityLevel(u, 'A0M6') == 0 and GetUnitAbilityLevel(u, 'A0M9') > 0 then
        call UnitAddAbility(u, 'A0M6')
    endif
    if GetUnitAbilityLevel(u, 'A0M9') != 0 then
        call SetUnitAbilityLevel(u, 'A0M6', GetUnitAbilityLevel(u, 'A0M9'))
    endif
    if GetUnitAbilityLevel(u, 'A0M7') == 0 and GetUnitAbilityLevel(u, 'A0MA') > 0 then
        call UnitAddAbility(u, 'A0M7')
    endif
    if GetUnitAbilityLevel(u, 'A0MA') != 0 then
        call SetUnitAbilityLevel(u, 'A0M7', GetUnitAbilityLevel(u, 'A0MA'))
    endif
    set u = null
endfunction

function InitTrig_Keine_Ability_Change takes nothing returns nothing
endfunction