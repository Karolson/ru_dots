function Trig_Debug_Spirit_Conditions takes nothing returns boolean
    if not (udg_TestMode) then
        return false
    endif
    return true
endfunction

function Trig_Debug_Spirit_Actions takes nothing returns nothing
    local integer i = S2I(SubString(GetEventPlayerChatString(), 8, 13))
    call THD_AddSpirit(GetTriggerPlayer(), i)
endfunction

function InitTrig_Debug_Spirit takes nothing returns nothing
    set gg_trg_Debug_Spirit = CreateTrigger()
    call TriggerAddCondition(gg_trg_Debug_Spirit, Condition(function Trig_Debug_Spirit_Conditions))
    call TriggerAddAction(gg_trg_Debug_Spirit, function Trig_Debug_Spirit_Actions)
endfunction