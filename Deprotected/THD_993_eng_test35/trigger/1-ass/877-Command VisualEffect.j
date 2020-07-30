function Trig_Command_VisualEffect_Conditions takes nothing returns boolean
    if GetEventPlayerChatString() == "-veon" then
        set udg_VE_Stat[GetPlayerId(GetTriggerPlayer())] = false
        call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "Global weather visual effects ON")
    else
        set udg_VE_Stat[GetPlayerId(GetTriggerPlayer())] = true
        call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "Global weather visual effects OFF")
    endif
    return false
endfunction

function InitTrig_Command_VisualEffect takes nothing returns nothing
    set gg_trg_Command_VisualEffect = CreateTrigger()
    call TriggerAddCondition(gg_trg_Command_VisualEffect, Condition(function Trig_Command_VisualEffect_Conditions))
endfunction