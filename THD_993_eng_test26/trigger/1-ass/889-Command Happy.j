function Trig_Command_Happy_Actions takes nothing returns nothing
    set udg_OBBCheck = true
    call BroadcastMessage(udg_PN[GetPlayerId(GetTriggerPlayer())] + "快回坑好不好   _傲_了  ")
    call BroadcastMessage("不然就天天看_花了______")
    call BroadcastMessage("我的神_已_受不了了(__)")
endfunction

function InitTrig_Command_Happy takes nothing returns nothing
    set gg_trg_Command_Happy = CreateTrigger()
    call TriggerAddAction(gg_trg_Command_Happy, function Trig_Command_Happy_Actions)
endfunction