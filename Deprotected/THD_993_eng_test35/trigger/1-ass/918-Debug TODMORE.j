function Trig_Debug_TODMOREConditions takes nothing returns boolean
    return udg_TestMode
endfunction

function Trig_Debug_TODMOREActions takes nothing returns nothing
    call SetTimeOfDayScale(20.0)
endfunction

function InitTrig_Debug_TODMORE takes nothing returns nothing
    set gg_trg_Debug_TODMORE = CreateTrigger()
    call TriggerAddCondition(gg_trg_Debug_TODMORE, Condition(function Trig_Debug_TODMOREConditions))
    call TriggerAddAction(gg_trg_Debug_TODMORE, function Trig_Debug_TODMOREActions)
endfunction