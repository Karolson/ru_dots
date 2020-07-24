function Trig_Reisen2ExTime_Actions takes nothing returns nothing
    local timer t = GetExpiredTimer()
    set udg_SK_Reisen2Ex_Time = udg_SK_Reisen2Ex_Time + 0.02
    set t = null
endfunction

function InitTrig_Reisen2ExTime takes nothing returns nothing
endfunction