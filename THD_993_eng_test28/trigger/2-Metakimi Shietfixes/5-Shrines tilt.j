function Trig_Shrines_tilt_Actions takes nothing returns nothing
    call SetUnitFacingTimed( gg_unit_h00U_0019, 225.00, 1.00 )
    call SetUnitFacingTimed( gg_unit_h00D_0013, 45.00, 1.00 )
endfunction

//===========================================================================
function InitTrig_Shrines_tilt takes nothing returns nothing
    set gg_trg_Shrines_tilt = CreateTrigger(  )
    call TriggerRegisterTimerEventSingle( gg_trg_Shrines_tilt, 1.00 )
    call TriggerAddAction( gg_trg_Shrines_tilt, function Trig_Shrines_tilt_Actions )
endfunction

