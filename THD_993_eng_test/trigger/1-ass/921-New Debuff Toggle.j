function Trig_New_Debuff_Conditions takes nothing returns boolean
    return udg_TestMode
endfunction

function Trig_New_Debuff_Actions takes nothing returns nothing
    if udg_NewDebuffSys then
        set udg_NewDebuffSys = false
        call BJDebugMsg("New Debuff Sys Off")
    else
        set udg_NewDebuffSys = true
        call BJDebugMsg("New Debuff Sys On")
    endif
endfunction

function InitTrig_New_Debuff_Toggle takes nothing returns nothing
    local integer i = 0
    set gg_trg_New_Debuff_Toggle = CreateTrigger()
    loop
    exitwhen i > 11
        call TriggerRegisterPlayerChatEvent(gg_trg_New_Debuff_Toggle, Player(i), "-newdebuff", true)
        set i = i + 1
    endloop
    call TriggerAddCondition(gg_trg_New_Debuff_Toggle, Condition(function Trig_New_Debuff_Conditions))
    call TriggerAddAction(gg_trg_New_Debuff_Toggle, function Trig_New_Debuff_Actions)
endfunction