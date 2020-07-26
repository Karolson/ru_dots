function Trig_Debug_Death_Conditions takes nothing returns boolean
    if not (udg_TestMode) then
        return false
    endif
    return true
endfunction

function Trig_Debug_Death_Actions takes nothing returns nothing
    local integer i = GetPlayerId(GetTriggerPlayer())
    if IsUnitDeadBJ(udg_PlayerHeroes[i]) then
        call BJDebugMsg("true")
        call BJDebugMsg(R2S(GetUnitState(udg_PlayerHeroes[i], UNIT_STATE_LIFE)))
    else
        call BJDebugMsg("false")
        call BJDebugMsg(R2S(GetUnitState(udg_PlayerHeroes[i], UNIT_STATE_LIFE)))
    endif
endfunction

function InitTrig_Debug_Death takes nothing returns nothing
    set gg_trg_Debug_Death = CreateTrigger()
    call TriggerAddCondition(gg_trg_Debug_Death, Condition(function Trig_Debug_Death_Conditions))
    call TriggerAddAction(gg_trg_Debug_Death, function Trig_Debug_Death_Actions)
endfunction