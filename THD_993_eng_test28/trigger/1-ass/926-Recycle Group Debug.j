function RecycleGroupDebug takes nothing returns boolean
    if udg_RecycleGroupDebug then
        set udg_RecycleGroupDebug = false
        call BJDebugMsg("Recycle Group Debug Messages Off")
    else
        set udg_RecycleGroupDebug = true
        call BJDebugMsg("Recycle Group Debug Messages On")
    endif
    return false
endfunction

function InitTrig_Recycle_Group_Debug takes nothing returns nothing
    local integer i = 0
    set gg_trg_Recycle_Group_Debug = CreateTrigger()
    loop
    exitwhen i > 11
        call TriggerRegisterPlayerChatEvent(gg_trg_Recycle_Group_Debug, Player(i), "-debuggrouprecycle", true)
        set i = i + 1
    endloop
    call TriggerAddCondition(gg_trg_Recycle_Group_Debug, Condition(function RecycleGroupDebug))
endfunction