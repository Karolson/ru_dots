function Trig_Command_CrowdControlShowActions takes nothing returns nothing
    call DisplayTimedTextToPlayer(GetTriggerPlayer(), 0, 0, 6.0, "Control debuffs will now be shown for you.")
    set udg_CCSystem_WordsOn[GetConvertedPlayerId(GetTriggerPlayer())] = true
endfunction

function InitTrig_Command_CrowdControlShow takes nothing returns nothing
    set gg_trg_Command_CrowdControlShow = CreateTrigger()
    call TriggerAddAction(gg_trg_Command_CrowdControlShow, function Trig_Command_CrowdControlShowActions)
endfunction