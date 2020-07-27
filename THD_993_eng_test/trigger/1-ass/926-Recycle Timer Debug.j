function RecycleTimerDebug takes nothing returns boolean
    if udg_RecycleDebug then
        set udg_RecycleDebug = false
        call BJDebugMsg("Recycle Debug Messages Off")
    else
        set udg_RecycleDebug = true
        call BJDebugMsg("Recycle Debug Messages On")
    endif
    return false
endfunction

function InitTrig_Recycle_Timer_Debug takes nothing returns nothing
    local integer i = 0
    set gg_trg_Recycle_Timer_Debug = CreateTrigger()
    loop
    exitwhen i > 11
        call TriggerRegisterPlayerChatEvent(gg_trg_Recycle_Timer_Debug, Player(i), "-debugtimerrecycle", true)
        set i = i + 1
    endloop
    call TriggerAddCondition(gg_trg_Recycle_Timer_Debug, Condition(function RecycleTimerDebug))
endfunction