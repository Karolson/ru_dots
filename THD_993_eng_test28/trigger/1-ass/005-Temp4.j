function Trig_Temp4Actions takes nothing returns nothing
endfunction

function InitTrig_Temp4 takes nothing returns nothing
    set gg_trg_Temp4 = CreateTrigger()
    call TriggerAddAction(gg_trg_Temp4, function Trig_Temp4Actions)
endfunction