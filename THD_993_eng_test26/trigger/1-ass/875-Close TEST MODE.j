function Trig_Close_TEST_MODEActions takes nothing returns nothing
    set udg_TestMode_Close = true
endfunction

function InitTrig_Close_TEST_MODE takes nothing returns nothing
    set gg_trg_Close_TEST_MODE = CreateTrigger()
    call TriggerRegisterTimerEventSingle(gg_trg_Close_TEST_MODE, 180.0)
    call TriggerAddAction(gg_trg_Close_TEST_MODE, function Trig_Close_TEST_MODEActions)
endfunction