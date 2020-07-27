function Trig_UnitSee_Actions takes nothing returns nothing
endfunction

function InitTrig_UnitSee takes nothing returns nothing
    set gg_trg_UnitSee = CreateTrigger()
    call TriggerAddAction(gg_trg_UnitSee, function Trig_UnitSee_Actions)
endfunction