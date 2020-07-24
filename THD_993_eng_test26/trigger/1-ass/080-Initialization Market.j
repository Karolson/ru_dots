function Trig_Initialization_Market_Actions takes nothing returns nothing
    call TriggerRegisterUnitEvent(gg_trg_Item_Exchange, gg_unit_h00D_0013, EVENT_UNIT_SELL)
endfunction

function InitTrig_Initialization_Market takes nothing returns nothing
    set gg_trg_Initialization_Market = CreateTrigger()
    call TriggerAddAction(gg_trg_Initialization_Market, function Trig_Initialization_Market_Actions)
endfunction