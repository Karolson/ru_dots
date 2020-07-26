function Trig_Nue03_Conditions takes nothing returns boolean
    if GetUnitAbilityLevel(GetTriggerUnit(), 'A0MM') != 0 then
        return false
    endif
    return GetOwningPlayer(GetKillingUnit()) == udg_SK_nue_rscd_player
endfunction

function Trig_Nue03_Actions takes nothing returns nothing
    local unit killer = GetKillingUnit()
    local unit dyer = GetTriggerUnit()
    local unit killerhero = GetPlayerCharacter(GetOwningPlayer(killer))
    call NueResetCD(killerhero, dyer)
    set killer = null
    set dyer = null
    set killerhero = null
endfunction

function InitTrig_Nue03 takes nothing returns nothing
endfunction