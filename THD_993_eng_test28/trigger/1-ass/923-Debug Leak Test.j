function Trig_Debug_Leak_Test_Actions takes nothing returns nothing
    local location L = Location(0, 0)
    call BJDebugMsg(I2S(GetHandleId(L) - $100000))
    call RemoveLocation(L)
    set L = null
endfunction

function InitTrig_Debug_Leak_Test takes nothing returns nothing
    set gg_trg_Debug_Leak_Test = CreateTrigger()
    call TriggerRegisterTimerEvent(gg_trg_Debug_Leak_Test, 1.0, true)
    call TriggerAddAction(gg_trg_Debug_Leak_Test, function Trig_Debug_Leak_Test_Actions)
    call DisableTrigger(gg_trg_Debug_Leak_Test)
endfunction