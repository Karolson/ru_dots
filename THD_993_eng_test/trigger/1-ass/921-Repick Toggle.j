function Trig_Repick_Toggle_Conditions takes nothing returns boolean
    return udg_TestMode
endfunction

function Trig_Repick_Toggle_Actions takes nothing returns nothing
    set udg_Repick = true
    call BJDebugMsg("Repick Enabled")
endfunction

function InitTrig_Repick_Toggle takes nothing returns nothing
    local integer i = 0
    set gg_trg_Repick_Toggle = CreateTrigger()
    loop
    exitwhen i > 11
        call TriggerRegisterPlayerChatEvent(gg_trg_Repick_Toggle, Player(i), "-repickon", true)
        set i = i + 1
    endloop
    call TriggerAddCondition(gg_trg_Repick_Toggle, Condition(function Trig_Repick_Toggle_Conditions))
    call TriggerAddAction(gg_trg_Repick_Toggle, function Trig_Repick_Toggle_Actions)
endfunction