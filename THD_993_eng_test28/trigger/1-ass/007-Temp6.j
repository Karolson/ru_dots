function Trig_Temp6Actions takes nothing returns nothing
endfunction

function InitTrig_Temp6 takes nothing returns nothing
    set gg_trg_Temp6 = CreateTrigger()
    call TriggerAddAction(gg_trg_Temp6, function Trig_Temp6Actions)
endfunction