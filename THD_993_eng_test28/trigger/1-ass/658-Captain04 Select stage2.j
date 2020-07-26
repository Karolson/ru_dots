function Trig_Captain04_Select_stage2_Func001C takes nothing returns boolean
    if not (GetClickedButtonBJ() == udg_Captain_Select_Button[0]) then
        return false
    endif
    return true
endfunction

function Trig_Captain04_Select_stage2_Actions takes nothing returns nothing
    if Trig_Captain04_Select_stage2_Func001C() then
        call SetPlayerAbilityAvailable(GetOwningPlayer(udg_SK_Caption04_Hero), 'A1B0', false)
        call UnitAddAbility(udg_SK_Caption04_Hero, 'A1B0')
        call UnitMakeAbilityPermanent(udg_SK_Caption04_Hero, true, 'A1B0')
    else
        call SetPlayerAbilityAvailable(GetOwningPlayer(udg_SK_Caption04_Hero), 'A1AY', false)
        call UnitAddAbility(udg_SK_Caption04_Hero, 'A1AY')
        call UnitMakeAbilityPermanent(udg_SK_Caption04_Hero, true, 'A1AY')
    endif
    call DialogDisplay(GetOwningPlayer(udg_SK_Caption04_Hero), udg_Captain_Select, false)
endfunction

function InitTrig_Captain04_Select_stage2 takes nothing returns nothing
    set gg_trg_Captain04_Select_stage2 = CreateTrigger()
    call TriggerRegisterDialogEventBJ(gg_trg_Captain04_Select_stage2, udg_Captain_Select)
    call TriggerAddAction(gg_trg_Captain04_Select_stage2, function Trig_Captain04_Select_stage2_Actions)
endfunction