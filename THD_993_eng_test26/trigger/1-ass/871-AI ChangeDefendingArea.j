function Trig_AI_ChangeDefendingArea_Conditions takes nothing returns boolean
    if IsUnitType(GetTriggerUnit(), UNIT_TYPE_STRUCTURE) then
        return true
    endif
    return false
endfunction

function Trig_AI_ChangeDefendingArea_Actions takes nothing returns nothing
    local integer i = R2I(udg_GameTime / 60 * 0.5)
    if IsUnitType(GetEventDamageSource(), UNIT_TYPE_HERO) then
        set i = i * 4
    endif
    if GetRandomInt(0, 100) <= i then
        if GetTriggerUnit() == udg_BaseA[0] then
            set udg_TeamWorkingModeA = 0
            set udg_TeamWorkingModeB = 0
        elseif GetTriggerUnit() == udg_BaseA[1] then
            set udg_TeamWorkingModeA = 0
            set udg_TeamWorkingModeB = 0
        elseif GetTriggerUnit() == udg_BaseA[3] then
            set udg_TeamWorkingModeA = 1
            set udg_TeamWorkingModeB = 2
        elseif GetTriggerUnit() == udg_BaseA[4] then
            set udg_TeamWorkingModeA = 2
            set udg_TeamWorkingModeB = 1
        elseif GetTriggerUnit() == udg_BaseA[5] then
            set udg_TeamWorkingModeA = 0
            set udg_TeamWorkingModeB = 0
        elseif GetTriggerUnit() == udg_BaseA[6] then
            set udg_TeamWorkingModeA = 0
            set udg_TeamWorkingModeB = 0
        elseif GetTriggerUnit() == udg_BaseA[8] then
            set udg_TeamWorkingModeA = 0
            set udg_TeamWorkingModeB = 0
        elseif GetTriggerUnit() == udg_BaseA[9] then
            set udg_TeamWorkingModeA = 2
            set udg_TeamWorkingModeB = 1
        elseif GetTriggerUnit() == udg_BaseA[11] then
            set udg_TeamWorkingModeA = 1
            set udg_TeamWorkingModeB = 2
        elseif GetTriggerUnit() == udg_BaseA[12] then
            set udg_TeamWorkingModeA = 2
            set udg_TeamWorkingModeB = 1
        endif
    endif
    if GetRandomInt(0, 100) <= i then
        if GetTriggerUnit() == udg_BaseB[0] then
            set udg_TeamWorkingModeA = 0
            set udg_TeamWorkingModeB = 0
        elseif GetTriggerUnit() == udg_BaseB[1] then
            set udg_TeamWorkingModeA = 0
            set udg_TeamWorkingModeB = 0
        elseif GetTriggerUnit() == udg_BaseB[2] then
            set udg_TeamWorkingModeA = 0
            set udg_TeamWorkingModeB = 0
        elseif GetTriggerUnit() == udg_BaseB[3] then
            set udg_TeamWorkingModeA = 1
            set udg_TeamWorkingModeB = 2
        elseif GetTriggerUnit() == udg_BaseB[4] then
            set udg_TeamWorkingModeA = 2
            set udg_TeamWorkingModeB = 1
        elseif GetTriggerUnit() == udg_BaseB[5] then
            set udg_TeamWorkingModeA = 0
            set udg_TeamWorkingModeB = 0
        elseif GetTriggerUnit() == udg_BaseB[6] then
            set udg_TeamWorkingModeA = 1
            set udg_TeamWorkingModeB = 2
        elseif GetTriggerUnit() == udg_BaseB[8] then
            set udg_TeamWorkingModeA = 0
            set udg_TeamWorkingModeB = 0
        elseif GetTriggerUnit() == udg_BaseB[9] then
            set udg_TeamWorkingModeA = 2
            set udg_TeamWorkingModeB = 1
        elseif GetTriggerUnit() == udg_BaseB[11] then
            set udg_TeamWorkingModeA = 1
            set udg_TeamWorkingModeB = 2
        elseif GetTriggerUnit() == udg_BaseB[12] then
            set udg_TeamWorkingModeA = 2
            set udg_TeamWorkingModeB = 1
        elseif GetTriggerUnit() == udg_BaseB[14] then
            set udg_TeamWorkingModeA = 0
            set udg_TeamWorkingModeB = 0
        endif
    endif
endfunction

function InitTrig_AI_ChangeDefendingArea takes nothing returns nothing
    set gg_trg_AI_ChangeDefendingArea = CreateTrigger()
    call RegisterAnyUnitDamage(gg_trg_AI_ChangeDefendingArea)
    call TriggerAddCondition(gg_trg_AI_ChangeDefendingArea, Condition(function Trig_AI_ChangeDefendingArea_Conditions))
    call TriggerAddAction(gg_trg_AI_ChangeDefendingArea, function Trig_AI_ChangeDefendingArea_Actions)
endfunction