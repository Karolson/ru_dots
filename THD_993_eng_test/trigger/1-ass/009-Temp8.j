function Trig_Temp8Actions takes nothing returns nothing
endfunction

function InitTrig_Temp8 takes nothing returns nothing
    set gg_trg_Temp8 = CreateTrigger()
    call TriggerAddAction(gg_trg_Temp8, function Trig_Temp8Actions)
endfunction