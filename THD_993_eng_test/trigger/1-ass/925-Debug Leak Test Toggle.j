function Trig_Debug_Leak_Test_Toggle_Conditions takes nothing returns boolean
    return true
endfunction

function Trig_Debug_Leak_Test_Toggle_Actions takes nothing returns nothing
    if IsTriggerEnabled(gg_trg_Debug_Leak_Test) then
        call BroadcastMessage("Leak Test Disabled")
        call DisableTrigger(gg_trg_Debug_Leak_Test)
    else
        call BroadcastMessage("Leak Test Enabled")
        call EnableTrigger(gg_trg_Debug_Leak_Test)
    endif
endfunction

function InitTrig_Debug_Leak_Test_Toggle takes nothing returns nothing
    set gg_trg_Debug_Leak_Test_Toggle = CreateTrigger()
    call TriggerRegisterPlayerChatEvent(gg_trg_Debug_Leak_Test_Toggle, Player(0), "-debugleak", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Debug_Leak_Test_Toggle, Player(1), "-debugleak", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Debug_Leak_Test_Toggle, Player(2), "-debugleak", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Debug_Leak_Test_Toggle, Player(3), "-debugleak", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Debug_Leak_Test_Toggle, Player(4), "-debugleak", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Debug_Leak_Test_Toggle, Player(6), "-debugleak", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Debug_Leak_Test_Toggle, Player(7), "-debugleak", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Debug_Leak_Test_Toggle, Player(8), "-debugleak", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Debug_Leak_Test_Toggle, Player(9), "-debugleak", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Debug_Leak_Test_Toggle, Player(10), "-debugleak", true)
    call TriggerAddCondition(gg_trg_Debug_Leak_Test_Toggle, Condition(function Trig_Debug_Leak_Test_Toggle_Conditions))
    call TriggerAddAction(gg_trg_Debug_Leak_Test_Toggle, function Trig_Debug_Leak_Test_Toggle_Actions)
endfunction