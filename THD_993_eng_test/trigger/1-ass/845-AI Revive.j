function Trig_AI_Revive_Conditions takes nothing returns boolean
    return GetPlayerController(GetOwningPlayer(GetTriggerUnit())) == MAP_CONTROL_COMPUTER
endfunction

function Trig_AI_Revive_Actions takes nothing returns nothing
    local integer level = GetHeroLevel(GetTriggerUnit())
    local player w = GetOwningPlayer(GetTriggerUnit())
    call TriggerSleepAction(0.0)
    call AddHeroXP(GetTriggerUnit(), 150 + level * 180, true)
    set udg_AI_States[GetPlayerId(w) * 512 + 1 * 16 + 0] = 0
    set w = null
endfunction

function InitTrig_AI_Revive takes nothing returns nothing
endfunction