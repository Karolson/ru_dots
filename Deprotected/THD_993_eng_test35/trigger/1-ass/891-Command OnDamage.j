function Trig_Command_OnDamageActions takes nothing returns nothing
    set udg_DamageSystem_WordsOn = true
endfunction

function InitTrig_Command_OnDamage takes nothing returns nothing
    set gg_trg_Command_OnDamage = CreateTrigger()
    call TriggerAddAction(gg_trg_Command_OnDamage, function Trig_Command_OnDamageActions)
endfunction