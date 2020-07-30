function RanEx_Conditions takes nothing returns boolean
    if GetSpellAbilityId() == 'A0NW' then
        call AbilityCoolDownResetion(GetTriggerUnit(), 'A0NW', 180)
    endif
    return false
endfunction

function InitTrig_RanEx takes nothing returns nothing
endfunction