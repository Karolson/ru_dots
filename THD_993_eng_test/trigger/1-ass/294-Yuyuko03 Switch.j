function Trig_Yuyuko03_Switch_Actions takes nothing returns nothing
    if GetIssuedOrderId() == OrderId("parasiteon") then
        set udg_SK_uuz03_switch = 1
    endif
    if GetIssuedOrderId() == OrderId("parasiteoff") then
        set udg_SK_uuz03_switch = 0
    endif
endfunction

function InitTrig_Yuyuko03_Switch takes nothing returns nothing
endfunction