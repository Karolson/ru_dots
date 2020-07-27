function Trig_Debug_Gold_Conditions takes nothing returns boolean
    if not (udg_TestMode) then
        return false
    endif
    return true
endfunction

function Trig_Debug_Gold_Actions takes nothing returns nothing
    local integer i = S2I(SubString(GetEventPlayerChatString(), 6, 11))
    call AdjustPlayerStateBJ(i, GetTriggerPlayer(), PLAYER_STATE_RESOURCE_GOLD)
endfunction

function InitTrig_Debug_Gold takes nothing returns nothing
    set gg_trg_Debug_Gold = CreateTrigger()
    call TriggerAddCondition(gg_trg_Debug_Gold, Condition(function Trig_Debug_Gold_Conditions))
    call TriggerAddAction(gg_trg_Debug_Gold, function Trig_Debug_Gold_Actions)
endfunction