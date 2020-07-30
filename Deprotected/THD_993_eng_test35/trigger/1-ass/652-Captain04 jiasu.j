function Trig_Captain04_jiasu_Conditions takes nothing returns boolean
    return GetUnitTypeId(GetLoadedUnit()) == 'E00Q'
endfunction

function Trig_Captain04_jiasu_Actions takes nothing returns nothing
    call UnitAddAbility(udg_SK_Caption04_Ship, 'A0AF')
    call SetPlayerAbilityAvailable(GetOwningPlayer(GetLoadedUnit()), 'A0AI', false)
    call EnableTrigger(gg_trg_Captain04_jiansu)
endfunction

function InitTrig_Captain04_jiasu takes nothing returns nothing
endfunction