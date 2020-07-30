function Trig_Command_OffDamageConditions takes nothing returns boolean
    return udg_TestMode
endfunction

function Trig_Command_OffDamageActions takes nothing returns nothing
    set udg_DamageSystem_WordsOn = false
endfunction

function InitTrig_Command_OffDamage takes nothing returns nothing
    set gg_trg_Command_OffDamage = CreateTrigger()
    call TriggerAddCondition(gg_trg_Command_OffDamage, Condition(function Trig_Command_OffDamageConditions))
    call TriggerAddAction(gg_trg_Command_OffDamage, function Trig_Command_OffDamageActions)
endfunction