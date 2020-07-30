function Trig_Debug_CD_Conditions takes nothing returns boolean
    if not (udg_TestMode) then
        return false
    endif
    return true
endfunction

function Trig_Debug_CD_Actions takes nothing returns nothing
    local integer i = GetPlayerId(GetTriggerPlayer())
    call SetUnitLifePercentBJ(udg_PlayerHeroes[i], 100)
    call SetUnitManaPercentBJ(udg_PlayerHeroes[i], 100)
    call UnitResetCooldown(udg_PlayerHeroes[i])
endfunction

function InitTrig_Debug_CD takes nothing returns nothing
    set gg_trg_Debug_CD = CreateTrigger()
    call TriggerAddCondition(gg_trg_Debug_CD, Condition(function Trig_Debug_CD_Conditions))
    call TriggerAddAction(gg_trg_Debug_CD, function Trig_Debug_CD_Actions)
endfunction