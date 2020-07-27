function Recycle_Conditions takes nothing returns boolean
    return udg_TestMode
endfunction

function Recycle_Actions takes nothing returns nothing
    if udg_Recycle then
        set udg_Recycle = false
        call BJDebugMsg("Recycle Sys Off")
    else
        set udg_Recycle = true
        call BJDebugMsg("Recycle Sys On")
    endif
endfunction

function InitTrig_Recycle_System_Toggle takes nothing returns nothing
    local integer i = 0
    set gg_trg_Recycle_System_Toggle = CreateTrigger()
    loop
    exitwhen i > 11
        call TriggerRegisterPlayerChatEvent(gg_trg_Recycle_System_Toggle, Player(i), "-recycle", true)
        set i = i + 1
    endloop
    call TriggerAddAction(gg_trg_Recycle_System_Toggle, function Recycle_Actions)
endfunction