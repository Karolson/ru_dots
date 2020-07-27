function Trig_Temp9Actions takes nothing returns nothing
endfunction

function InitTrig_Temp9 takes nothing returns nothing
    set gg_trg_Temp9 = CreateTrigger()
    call TriggerAddAction(gg_trg_Temp9, function Trig_Temp9Actions)
endfunction