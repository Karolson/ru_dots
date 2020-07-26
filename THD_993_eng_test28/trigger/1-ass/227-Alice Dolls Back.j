function Trig_Alice_Dolls_Back_Conditions takes nothing returns boolean
    if GetSpellAbilityId() != 'A0GZ' then
        return false
    endif
    return IsUnitIllusion(GetSpellTargetUnit()) == false
endfunction

function Trig_Alice_Dolls_Back_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    if GetDollType(target) > 0 and GetUnitAbilityLevel(target, 'A0HR') == 0 then
        call RemoveDoll(caster, target, true)
    endif
    set caster = null
    set target = null
endfunction

function InitTrig_Alice_Dolls_Back takes nothing returns nothing
endfunction