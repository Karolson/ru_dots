function Trig_Temp5Actions takes nothing returns nothing
endfunction

function InitTrig_Temp5 takes nothing returns nothing
    set gg_trg_Temp5 = CreateTrigger()
    call TriggerAddAction(gg_trg_Temp5, function Trig_Temp5Actions)
endfunction