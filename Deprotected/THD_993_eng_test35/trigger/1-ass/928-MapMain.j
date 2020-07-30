function InitTrig_MapMain takes nothing returns nothing
    call Trig_Initialization_UDG_Actions()
    call TriggerExecute(gg_trg_Master_Initialization)
endfunction