function Trig_Temp10Actions takes nothing returns nothing
endfunction

function InitTrig_Temp10 takes nothing returns nothing
    set gg_trg_Temp10 = CreateTrigger()
    call TriggerAddAction(gg_trg_Temp10, function Trig_Temp10Actions)
endfunction