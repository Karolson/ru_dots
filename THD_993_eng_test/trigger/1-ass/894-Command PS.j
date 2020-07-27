function Trig_Command_PSActions takes nothing returns nothing
    call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, I2S(CountPlayersInForceBJ(udg_OnlinePlayers)))
endfunction

function InitTrig_Command_PS takes nothing returns nothing
    set gg_trg_Command_PS = CreateTrigger()
    call TriggerAddAction(gg_trg_Command_PS, function Trig_Command_PSActions)
endfunction