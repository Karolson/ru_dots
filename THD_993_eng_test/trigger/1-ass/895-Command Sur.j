function Trig_Command_Sur_Conditions takes nothing returns boolean
    return udg_GameTime > 1200
endfunction

function Trig_Command_Sur_Actions takes nothing returns nothing
    call PLY_Sur(GetTriggerPlayer())
endfunction

function InitTrig_Command_Sur takes nothing returns nothing
    set gg_trg_Command_Sur = CreateTrigger()
    call TriggerAddCondition(gg_trg_Command_Sur, Condition(function Trig_Command_Sur_Conditions))
    call TriggerAddAction(gg_trg_Command_Sur, function Trig_Command_Sur_Actions)
endfunction