function Trig_Captain04_jiansu_Conditions takes nothing returns boolean
    return not IsUnitLoaded(udg_SK_Caption04_Hero)
endfunction

function Trig_Captain04_jiansu_Actions takes nothing returns nothing
    call UnitRemoveAbility(udg_SK_Caption04_Ship, 'A0AF')
    call SetPlayerAbilityAvailable(GetOwningPlayer(udg_SK_Caption04_Hero), 'A0AI', true)
    call DisableTrigger(gg_trg_Captain04_jiansu)
endfunction

function InitTrig_Captain04_jiansu takes nothing returns nothing
    set gg_trg_Captain04_jiansu = CreateTrigger()
    call DisableTrigger(gg_trg_Captain04_jiansu)
    call TriggerRegisterTimerEvent(gg_trg_Captain04_jiansu, 1.0, true)
    call TriggerAddCondition(gg_trg_Captain04_jiansu, Condition(function Trig_Captain04_jiansu_Conditions))
    call TriggerAddAction(gg_trg_Captain04_jiansu, function Trig_Captain04_jiansu_Actions)
endfunction