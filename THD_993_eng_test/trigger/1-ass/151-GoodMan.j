function Trig_GoodMan_Actions takes unit u returns nothing
endfunction

function Trig_GoodMan_Conditions takes nothing returns boolean
    return false
endfunction

function InitTrig_GoodMan takes nothing returns nothing
    set gg_trg_GoodMan = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_GoodMan, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddCondition(gg_trg_GoodMan, Condition(function Trig_GoodMan_Conditions))
endfunction