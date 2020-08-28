function Trig_Command_Happy_Actions takes nothing returns nothing
    set udg_OBBCheck = true
    call BroadcastMessage(udg_PN[GetPlayerId(GetTriggerPlayer())] + "Go back to the pit, OK?  ")
    call BroadcastMessage("Otherwise just watch _ spent ______")
    call BroadcastMessage("My god_has_cannot stand it anymore (__)")
endfunction

function InitTrig_Command_Happy takes nothing returns nothing
    set gg_trg_Command_Happy = CreateTrigger()
    call TriggerAddAction(gg_trg_Command_Happy, function Trig_Command_Happy_Actions)
endfunction