function Trig_Momiji01_Death_Conditions takes nothing returns boolean
    local unit u = GetTriggerUnit()
    local player p = GetOwningPlayer(u)
    if IsPlayerInForce(p, udg_TeamA) then
        if udg_SK_Momizi01[0] != null then
            call SetUnitPositionLoc(udg_SK_Momizi01[0], udg_BirthPoint[0])
        endif
        if udg_SK_Momizi01[1] != null then
            call SetUnitPositionLoc(udg_SK_Momizi01[1], udg_BirthPoint[0])
        endif
    else
        if udg_SK_Momizi01[0] != null then
            call SetUnitPositionLoc(udg_SK_Momizi01[0], udg_BirthPoint[1])
        endif
        if udg_SK_Momizi01[1] != null then
            call SetUnitPositionLoc(udg_SK_Momizi01[1], udg_BirthPoint[1])
        endif
    endif
    set u = null
    set p = null
    return false
endfunction

function InitTrig_Momiji01_Death takes nothing returns nothing
endfunction