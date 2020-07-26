function Trig_Keep_Order_A_Conditions takes nothing returns boolean
    if GetIssuedOrderId() == 851986 then
        call SpawnIssueOrderA(GetTriggerUnit())
    endif
    return false
endfunction

function InitTrig_Keep_Order_A takes nothing returns nothing
    set gg_trg_Keep_Order_A = CreateTrigger()
    call TriggerAddCondition(gg_trg_Keep_Order_A, Condition(function Trig_Keep_Order_A_Conditions))
endfunction