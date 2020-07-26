function Trig_TEST_MODE_OFFFunc004A takes nothing returns nothing
    call DisplayTextToPlayer(GetEnumPlayer(), 0, 0, "|cFFFFFF00\r\n===============================\r\nTEST mode is off\r\n===============================")
endfunction

function Trig_TEST_MODE_OFFActions takes nothing returns nothing
    set udg_TestMode = false
    set udg_DebugMode = false
    call DisableTrigger(gg_trg_Debug_Leak_Test)
    call ForForce(bj_FORCE_ALL_PLAYERS, function Trig_TEST_MODE_OFFFunc004A)
    call DisableTrigger(GetTriggeringTrigger())
endfunction

function InitTrig_TEST_MODE_OFF takes nothing returns nothing
    set gg_trg_TEST_MODE_OFF = CreateTrigger()
    call TriggerAddAction(gg_trg_TEST_MODE_OFF, function Trig_TEST_MODE_OFFActions)
endfunction