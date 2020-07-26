function GetTeamATowerStatus takes nothing returns integer
    if GetWidgetLife(udg_BaseA[8]) >= 0.405 then
        return 3
    elseif GetWidgetLife(udg_BaseA[6]) >= 0.405 then
        return 2
    elseif GetWidgetLife(udg_BaseA[2]) >= 0.405 or GetWidgetLife(udg_BaseA[1]) >= 0.405 then
        return 1
    else
        return 0
    endif
endfunction

function GetTeamBTowerStatus takes nothing returns integer
    if GetWidgetLife(udg_BaseB[8]) >= 0.405 then
        return 3
    elseif GetWidgetLife(udg_BaseB[6]) >= 0.405 then
        return 2
    elseif GetWidgetLife(udg_BaseB[2]) >= 0.405 or GetWidgetLife(udg_BaseB[1]) >= 0.405 then
        return 1
    else
        return 0
    endif
endfunction

function Trig_RuneBorn_Actions takes nothing returns nothing
    local location loc1
    local location loc2
    local rect rct
    local unit u
    local integer i
    if udg_GameMode / 100 == 2 then
        set loc1 = null
        set loc2 = null
        return
    endif
    if udg_GameMode / 100 != 3 then
        set loc1 = GetRandomLocInRect(gg_rct_Rune1)
        set loc2 = GetRandomLocInRect(gg_rct_Rune2)
        call RemoveItem(udg_Rune[1])
        call RemoveItem(udg_Rune[2])
        set udg_Rune[1] = CreateItemLoc('I000', loc1)
        set udg_Rune[2] = CreateItemLoc('I000', loc2)
        call RemoveLocation(loc1)
        call RemoveLocation(loc2)
        set loc1 = null
        set loc2 = null
    else
        set i = GetTeamBTowerStatus() - GetTeamATowerStatus()
        if i == -3 then
            set rct = gg_rct_Rune01_C
        elseif i == -2 then
            set rct = gg_rct_Rune02_C
        elseif i == -1 then
            set rct = gg_rct_Rune03_C
        elseif i == 0 then
            set rct = gg_rct_Rune04_C
        elseif i == 1 then
            set rct = gg_rct_Rune05_C
        elseif i == 2 then
            set rct = gg_rct_Rune06_C
        elseif i == 3 then
            set rct = gg_rct_Rune07_C
        endif
        set loc1 = GetRandomLocInRect(rct)
        set u = CreateUnit(udg_PlayerA[0], 'n04Z', GetLocationX(loc1), GetLocationY(loc1), 0.0)
        call UnitApplyTimedLife(u, 'B07E', 120.0)
        set u = CreateUnit(udg_PlayerB[0], 'n04Z', GetLocationX(loc1), GetLocationY(loc1), 0.0)
        call UnitApplyTimedLife(u, 'B07E', 120.0)
        call RemoveItem(udg_Rune[1])
        set udg_Rune[1] = CreateItemLoc('I000', loc1)
        call RemoveLocation(loc1)
        set loc1 = null
        set rct = null
        set u = null
    endif
endfunction

function InitTrig_RuneBorn takes nothing returns nothing
    set gg_trg_RuneBorn = CreateTrigger()
    call TriggerAddAction(gg_trg_RuneBorn, function Trig_RuneBorn_Actions)
endfunction