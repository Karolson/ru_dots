function Trig_Nitori03_Conditions takes nothing returns boolean
    if GetUnitAbilityLevel(GetTriggerUnit(), 'A17F') == 0 then
        return false
    elseif GetUnitAbilityLevel(GetTriggerUnit(), 'A096') != 0 then
        return false
    elseif GetSpellAbilityId() != 'A094' and GetSpellAbilityId() != 'A0GF' and GetSpellAbilityId() != 'A0LK' and GetSpellAbilityId() != 'A17F' then
        return false
    elseif GetSpellAbilityId() == 'A094' then
        if GetUnitTypeId(GetTriggerUnit()) == 'H00S' then
            return false
        endif
    elseif GetSpellAbilityId() == 'A0GF' then
        return true
    endif
    return true
endfunction

function Trig_Nitori03_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A17F')
    call UnitAddAbility(caster, 'A096')
    call UnitMakeAbilityPermanent(caster, true, 'A096')
    call UnitMakeAbilityPermanent(caster, true, 'A0GG')
    call UnitMakeAbilityPermanent(caster, true, 'A097')
    call SetUnitAbilityLevel(caster, 'A097', level)
    set caster = null
endfunction

function InitTrig_Nitori03 takes nothing returns nothing
endfunction