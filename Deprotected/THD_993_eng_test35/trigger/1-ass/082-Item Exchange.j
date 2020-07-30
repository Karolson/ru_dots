function Trig_Item_Exchange_Conditions takes nothing returns boolean
    call DebugMsg("Condition check = return false")
    return false
endfunction

function Trig_Item_Exchange_Actions takes nothing returns nothing
endfunction

function InitTrig_Item_Exchange takes nothing returns nothing
    set gg_trg_Item_Exchange = CreateTrigger()
    call TriggerAddCondition(gg_trg_Item_Exchange, Condition(function Trig_Item_Exchange_Conditions))
    call TriggerAddAction(gg_trg_Item_Exchange, function Trig_Item_Exchange_Actions)
endfunction