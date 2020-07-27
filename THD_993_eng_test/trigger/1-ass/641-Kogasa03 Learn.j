function Trig_Kogasa03_Learn_Conditions takes nothing returns boolean
    if GetUnitAbilityLevel(GetPlayerCharacter(GetOwningPlayer(GetKillingUnit())), 'A0C8') == 0 then
        return false
    endif
    return GetUnitTypeId(GetPlayerCharacter(GetOwningPlayer(GetKillingUnit()))) == 'E00X' or GetUnitTypeId(GetPlayerCharacter(GetOwningPlayer(GetKillingUnit()))) == 'E03D'
endfunction

function Trig_Kogasa03_Learn_Actions takes nothing returns nothing
    local unit caster = GetPlayerCharacter(GetOwningPlayer(GetKillingUnit()))
    local integer level = GetUnitAbilityLevel(caster, 'A0C8')
    if GetUnitAbilityLevel(caster, 'A0LT') < 20 * level then
        if GetUnitAbilityLevel(caster, 'A0Z7') == 0 then
            call UnitAddAbility(caster, 'A0Z7')
        else
            call SetUnitAbilityLevel(caster, 'A0LT', GetUnitAbilityLevel(caster, 'A0LT') + 2)
            if udg_GameMode / 100 != 3 and udg_NewMid == false then
            else
                call SetUnitAbilityLevel(caster, 'A0LT', GetUnitAbilityLevel(caster, 'A0LT') + 2)
            endif
            call UnitRemoveAbility(caster, 'A0Z7')
        endif
    endif
    set caster = null
endfunction

function InitTrig_Kogasa03_Learn takes nothing returns nothing
endfunction