function Trig_Keep_Order_B_Conditions takes nothing returns boolean
    if GetIssuedOrderId() == 851986 then
        call SpawnIssueOrderB(GetTriggerUnit())
    endif
    return false
endfunction

function InitTrig_Keep_Order_B takes nothing returns nothing
    set gg_trg_Keep_Order_B = CreateTrigger()
    call TriggerAddCondition(gg_trg_Keep_Order_B, Condition(function Trig_Keep_Order_B_Conditions))
endfunction