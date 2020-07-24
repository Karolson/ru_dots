function KOMACHI02 takes nothing returns integer
    return 'A0JK'
endfunction

function Komachi02_Active_Conditions takes nothing returns boolean
    local unit u
    if GetSpellAbilityId() == 'A0JK' then
        set u = GetTriggerUnit()
        call AbilityCoolDownResetion(u, 'A0JK', 11 - GetUnitAbilityLevel(u, 'A0JK'))
        call SaveInteger(udg_sht, StringHash("Komachi02"), GetHandleId(u), 1)
    endif
    set u = null
    return false
endfunction

function InitTrig_Komachi02_Active takes nothing returns nothing
endfunction