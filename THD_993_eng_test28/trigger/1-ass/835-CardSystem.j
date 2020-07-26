function Trig_CardSystemActions takes nothing returns nothing
endfunction

function InitTrig_CardSystem takes nothing returns nothing
    set gg_trg_CardSystem = CreateTrigger()
    call TriggerAddAction(gg_trg_CardSystem, function Trig_CardSystemActions)
endfunction