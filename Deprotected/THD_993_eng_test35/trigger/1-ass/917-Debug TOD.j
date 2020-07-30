function Trig_Debug_TOD_Conditions takes nothing returns boolean
    if not (udg_TestMode) then
        return false
    endif
    return true
endfunction

function Trig_Debug_TOD_Actions takes nothing returns nothing
    local integer i = GetPlayerId(GetTriggerPlayer())
    local real s = S2I(SubString(GetEventPlayerChatString(), 5, 9))
    call SetTimeOfDay(s)
endfunction

function InitTrig_Debug_TOD takes nothing returns nothing
    set gg_trg_Debug_TOD = CreateTrigger()
    call TriggerAddCondition(gg_trg_Debug_TOD, Condition(function Trig_Debug_TOD_Conditions))
    call TriggerAddAction(gg_trg_Debug_TOD, function Trig_Debug_TOD_Actions)
endfunction