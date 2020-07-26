function Trig_AI_EXP_Bonus_Conditions takes nothing returns boolean
    if not IsUnitType(GetTriggerUnit(), UNIT_TYPE_HERO) then
        return false
    elseif IsUnitIllusion(GetTriggerUnit()) then
        return false
    elseif IsUnitDead(GetTriggerUnit()) then
        return false
    endif
    return GetPlayerController(GetOwningPlayer(GetTriggerUnit())) == MAP_CONTROL_COMPUTER
endfunction

function Trig_AI_EXP_Bonus_Actions takes nothing returns nothing
    local integer level = GetHeroLevel(GetTriggerUnit())
    call TriggerSleepAction(0.0)
    call AddHeroXP(GetTriggerUnit(), 15 + level * 8, true)
endfunction

function InitTrig_AI_EXP_Bonus takes nothing returns nothing
endfunction