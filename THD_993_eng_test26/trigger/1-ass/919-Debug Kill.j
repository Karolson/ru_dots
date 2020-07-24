function Trig_Debug_Kill_Conditions takes nothing returns boolean
    if not (udg_TestMode) then
        return false
    endif
    return true
endfunction

function Trig_Debug_Kill_Actions takes nothing returns nothing
    local integer i = GetPlayerId(GetTriggerPlayer())
    call KillUnit(udg_PlayerHeroes[i])
endfunction

function InitTrig_Debug_Kill takes nothing returns nothing
    set gg_trg_Debug_Kill = CreateTrigger()
    call TriggerAddCondition(gg_trg_Debug_Kill, Condition(function Trig_Debug_Kill_Conditions))
    call TriggerAddAction(gg_trg_Debug_Kill, function Trig_Debug_Kill_Actions)
endfunction