function GIB_COLUMN_NAME takes nothing returns integer
    return 0
endfunction

function GIB_COLUMN_CHARACTER takes nothing returns integer
    return 1
endfunction

function GIB_COLUMN_FLAG_KILL takes nothing returns integer
    return 2
endfunction

function GIB_COLUMN_FLAG_DEATH takes nothing returns integer
    return 3
endfunction

function GIB_COLUMN_FLAG_ASSIST takes nothing returns integer
    return 4
endfunction

function GIB_COLUMN_REVIVE takes nothing returns integer
    return 5
endfunction

function GIB_COLUMN_TOWER takes nothing returns integer
    return 5
endfunction

function GIB_SetPlayerField takes player who, integer column, string text returns nothing
    local integer row = udg_GIB_PlayerRow[8 + GetPlayerId(who)]
    local multiboarditem field = null
    set field = MultiboardGetItem(udg_GIB, row, column)
    call MultiboardSetItemValue(field, text)
    call MultiboardReleaseItem(field)
    set field = null
endfunction

function GIB_SetFieldIcon takes player who, integer column, string icon returns nothing
    local integer row = udg_GIB_PlayerRow[8 + GetPlayerId(who)]
    local multiboarditem field = null
    set field = MultiboardGetItem(udg_GIB, row, column)
    call MultiboardSetItemIcon(field, icon)
    call MultiboardReleaseItem(field)
    set field = null
endfunction

function Trig_Setup_Game_Info_Board_Actions takes nothing returns nothing
    local multiboard board
    local multiboarditem field = null
    local integer row = 0
    local integer column = 0
    local real array w
    local integer i
    local player who
    local unit h
    local string line = " "
    local string PCNameA = udg_PN[GetPlayerId(udg_PlayerA[0])]
    local string PCNameB = udg_PN[GetPlayerId(udg_PlayerB[0])]
    set w[0] = 0.07
    set w[1] = 0.15
    set w[2] = 0.02
    set w[3] = 0.02
    set w[4] = 0.02
    set w[5] = 0.05
    call MultiboardSuppressDisplay(true)
    if udg_GIB == null then
        set board = CreateMultiboard()
    else
        set board = udg_GIB
    endif
    call MultiboardSetTitleText(board, "|cffffcc00Game Info|r")
    call MultiboardDisplay(board, true)
    set udg_GIB = board
    if ModuloInteger(udg_GameMode, 100) / 10 == 5 then
        call MultiboardSetRowCount(board, 9 + udg_OnlinePlayerSum)
    else
        call MultiboardSetRowCount(board, 6 + udg_OnlinePlayerSum)
    endif
    call MultiboardSetColumnCount(board, 6)
    set row = 0
    set column = 0
    set field = MultiboardGetItem(board, row, column)
    call MultiboardSetItemStyle(field, true, false)
    call MultiboardSetItemWidth(field, w[column])
    call MultiboardSetItemValue(field, "|cffffcc00Player|r")
    call MultiboardReleaseItem(field)
    set field = null
    set column = column + 1
    set field = MultiboardGetItem(board, row, column)
    call MultiboardSetItemStyle(field, true, false)
    call MultiboardSetItemWidth(field, w[column])
    call MultiboardSetItemValue(field, "|cffffcc00Hero|r")
    call MultiboardReleaseItem(field)
    set field = null
    set column = column + 1
    set field = MultiboardGetItem(board, row, column)
    call MultiboardSetItemStyle(field, true, false)
    call MultiboardSetItemWidth(field, w[column])
    call MultiboardSetItemValue(field, "|cffffcc00K|r")
    call MultiboardReleaseItem(field)
    set field = null
    set column = column + 1
    set field = MultiboardGetItem(board, row, column)
    call MultiboardSetItemStyle(field, true, false)
    call MultiboardSetItemWidth(field, w[column])
    if udg_smodestat == false then
        call MultiboardSetItemValue(field, "|cffffcc00D|r")
    else
        call MultiboardSetItemValue(field, "|cffffcc00L|r")
    endif
    call MultiboardReleaseItem(field)
    set field = null
    set column = column + 1
    set field = MultiboardGetItem(board, row, column)
    call MultiboardSetItemStyle(field, true, false)
    call MultiboardSetItemWidth(field, w[column])
    if udg_smodestat == false then
        call MultiboardSetItemValue(field, "|cffffcc00A|r")
    else
        call MultiboardSetItemValue(field, "|cffffcc00P|r")
    endif
    call MultiboardReleaseItem(field)
    set field = null
    set column = column + 1
    set field = MultiboardGetItem(board, row, column)
    call MultiboardSetItemStyle(field, true, false)
    call MultiboardSetItemWidth(field, w[column])
    call MultiboardSetItemValue(field, "|cffffcc00Revive|r")
    call MultiboardReleaseItem(field)
    set field = null
    set row = row + 1
    set column = 0
    set field = MultiboardGetItem(board, row, column)
    call MultiboardSetItemStyle(field, true, false)
    call MultiboardSetItemWidth(field, 0.4)
    call MultiboardSetItemValue(field, line)
    call MultiboardReleaseItem(field)
    set field = null
    set column = column + 1
    set field = MultiboardGetItem(board, row, column)
    call MultiboardSetItemStyle(field, false, false)
    call MultiboardSetItemWidth(field, 0.0)
    call MultiboardReleaseItem(field)
    set field = null
    set column = column + 1
    set field = MultiboardGetItem(board, row, column)
    call MultiboardSetItemStyle(field, false, false)
    call MultiboardSetItemWidth(field, 0.0)
    call MultiboardReleaseItem(field)
    set field = null
    set column = column + 1
    set field = MultiboardGetItem(board, row, column)
    call MultiboardSetItemStyle(field, false, false)
    call MultiboardSetItemWidth(field, 0.0)
    call MultiboardReleaseItem(field)
    set field = null
    set column = column + 1
    set field = MultiboardGetItem(board, row, column)
    call MultiboardSetItemStyle(field, false, false)
    call MultiboardSetItemWidth(field, 0.0)
    call MultiboardReleaseItem(field)
    set field = null
    set column = column + 1
    set field = MultiboardGetItem(board, row, column)
    call MultiboardSetItemStyle(field, false, false)
    call MultiboardSetItemWidth(field, 0.0)
    call MultiboardReleaseItem(field)
    set field = null
    set row = row + 1
    set column = 0
    set field = MultiboardGetItem(board, row, column)
    call MultiboardSetItemStyle(field, true, false)
    call MultiboardSetItemWidth(field, w[column])
    call MultiboardSetItemValue(field, PCNameA)
    call MultiboardReleaseItem(field)
    set field = null
    set column = column + 1
    set field = MultiboardGetItem(board, row, column)
    call MultiboardSetItemStyle(field, false, false)
    call MultiboardSetItemWidth(field, w[column])
    call MultiboardReleaseItem(field)
    set field = null
    set column = column + 1
    set field = MultiboardGetItem(board, row, column)
    call MultiboardSetItemStyle(field, true, false)
    call MultiboardSetItemWidth(field, w[column])
    call MultiboardSetItemValue(field, "|cffffcc000|r")
    call MultiboardReleaseItem(field)
    set field = null
    set column = column + 1
    set field = MultiboardGetItem(board, row, column)
    call MultiboardSetItemStyle(field, false, false)
    call MultiboardSetItemWidth(field, w[column])
    call MultiboardReleaseItem(field)
    set field = null
    set column = column + 1
    set field = MultiboardGetItem(board, row, column)
    call MultiboardSetItemStyle(field, true, false)
    call MultiboardSetItemWidth(field, w[column])
    call MultiboardSetItemValue(field, "8")
    call MultiboardReleaseItem(field)
    set field = null
    set column = column + 1
    set field = MultiboardGetItem(board, row, column)
    call MultiboardSetItemStyle(field, true, false)
    call MultiboardSetItemWidth(field, w[column])
    call MultiboardSetItemValue(field, " |cffff6600towers|r")
    call MultiboardReleaseItem(field)
    set field = null
    set udg_GIB_PlayerRow[8 + GetPlayerId(udg_PlayerA[0])] = row
    set i = 0
    loop
        set who = GetSortedPlayer(i)
        if GetPlayerSlotState(who) != PLAYER_SLOT_STATE_EMPTY then
            set h = udg_PlayerHeroes[GetPlayerId(who)]
            set row = row + 1
            set column = 0
            set field = MultiboardGetItem(board, row, column)
            call MultiboardSetItemStyle(field, true, false)
            call MultiboardSetItemWidth(field, w[column])
            call MultiboardSetItemValue(field, udg_PlayerName[GetPlayerId(who)])
            call MultiboardReleaseItem(field)
            set field = null
            set column = column + 1
            set field = MultiboardGetItem(board, row, column)
            call MultiboardSetItemStyle(field, true, true)
            call MultiboardSetItemWidth(field, w[column])
            call MultiboardSetItemValue(field, GetHeroProperName(h))
            call MultiboardSetItemIcon(field, udg_HeroIcon[GetHeroIndex(GetUnitTypeId(h))])
            call MultiboardReleaseItem(field)
            set field = null
            set column = column + 1
            set field = MultiboardGetItem(board, row, column)
            call MultiboardSetItemStyle(field, true, false)
            call MultiboardSetItemWidth(field, w[column])
            call MultiboardSetItemValue(field, I2S(0))
            call MultiboardReleaseItem(field)
            set field = null
            set column = column + 1
            set field = MultiboardGetItem(board, row, column)
            call MultiboardSetItemStyle(field, true, false)
            call MultiboardSetItemWidth(field, w[column])
            call MultiboardSetItemValue(field, I2S(0))
            call MultiboardReleaseItem(field)
            set field = null
            set column = column + 1
            set field = MultiboardGetItem(board, row, column)
            call MultiboardSetItemStyle(field, true, false)
            call MultiboardSetItemWidth(field, w[column])
            call MultiboardSetItemValue(field, I2S(0))
            call MultiboardReleaseItem(field)
            set field = null
            set column = column + 1
            set field = MultiboardGetItem(board, row, column)
            call MultiboardSetItemStyle(field, true, false)
            call MultiboardSetItemWidth(field, w[column])
            call MultiboardSetItemValue(field, "    -")
            call MultiboardReleaseItem(field)
            set field = null
            set udg_GIB_PlayerRow[8 + GetPlayerId(who)] = row
        endif
        set i = i + 1
    exitwhen i > 4
    endloop
    set row = row + 1
    set column = 0
    set field = MultiboardGetItem(board, row, column)
    call MultiboardSetItemStyle(field, true, false)
    call MultiboardSetItemWidth(field, w[column])
    call MultiboardSetItemValue(field, PCNameB)
    call MultiboardReleaseItem(field)
    set field = null
    set column = column + 1
    set field = MultiboardGetItem(board, row, column)
    call MultiboardSetItemStyle(field, false, false)
    call MultiboardSetItemWidth(field, w[column])
    call MultiboardReleaseItem(field)
    set field = null
    set column = column + 1
    set field = MultiboardGetItem(board, row, column)
    call MultiboardSetItemStyle(field, true, false)
    call MultiboardSetItemWidth(field, w[column])
    call MultiboardSetItemValue(field, "|cffffcc000|r")
    call MultiboardReleaseItem(field)
    set field = null
    set column = column + 1
    set field = MultiboardGetItem(board, row, column)
    call MultiboardSetItemStyle(field, false, false)
    call MultiboardSetItemWidth(field, w[column])
    call MultiboardReleaseItem(field)
    set field = null
    set column = column + 1
    set field = MultiboardGetItem(board, row, column)
    call MultiboardSetItemStyle(field, true, false)
    call MultiboardSetItemWidth(field, w[column])
    call MultiboardSetItemValue(field, "8")
    call MultiboardReleaseItem(field)
    set field = null
    set column = column + 1
    set field = MultiboardGetItem(board, row, column)
    call MultiboardSetItemStyle(field, true, false)
    call MultiboardSetItemWidth(field, w[column])
    call MultiboardSetItemValue(field, " |cff00ff66towers|r")
    call MultiboardReleaseItem(field)
    set field = null
    set udg_GIB_PlayerRow[8 + GetPlayerId(udg_PlayerB[0])] = row
    set i = 5
    loop
        set who = GetSortedPlayer(i)
        if GetPlayerSlotState(who) != PLAYER_SLOT_STATE_EMPTY then
            set h = udg_PlayerHeroes[GetPlayerId(who)]
            set row = row + 1
            set column = 0
            set field = MultiboardGetItem(board, row, column)
            call MultiboardSetItemStyle(field, true, false)
            call MultiboardSetItemWidth(field, w[column])
            call MultiboardSetItemValue(field, udg_PlayerName[GetPlayerId(who)])
            call MultiboardReleaseItem(field)
            set field = null
            set column = column + 1
            set field = MultiboardGetItem(board, row, column)
            call MultiboardSetItemStyle(field, true, true)
            call MultiboardSetItemWidth(field, w[column])
            call MultiboardSetItemValue(field, GetHeroProperName(h))
            call MultiboardSetItemIcon(field, udg_HeroIcon[GetHeroIndex(GetUnitTypeId(h))])
            call MultiboardReleaseItem(field)
            set field = null
            set column = column + 1
            set field = MultiboardGetItem(board, row, column)
            call MultiboardSetItemStyle(field, true, false)
            call MultiboardSetItemWidth(field, w[column])
            call MultiboardSetItemValue(field, I2S(0))
            call MultiboardReleaseItem(field)
            set field = null
            set column = column + 1
            set field = MultiboardGetItem(board, row, column)
            call MultiboardSetItemStyle(field, true, false)
            call MultiboardSetItemWidth(field, w[column])
            call MultiboardSetItemValue(field, I2S(0))
            call MultiboardReleaseItem(field)
            set field = null
            set column = column + 1
            set field = MultiboardGetItem(board, row, column)
            call MultiboardSetItemStyle(field, true, false)
            call MultiboardSetItemWidth(field, w[column])
            call MultiboardSetItemValue(field, I2S(0))
            call MultiboardReleaseItem(field)
            set field = null
            set column = column + 1
            set field = MultiboardGetItem(board, row, column)
            call MultiboardSetItemStyle(field, true, false)
            call MultiboardSetItemWidth(field, w[column])
            call MultiboardSetItemValue(field, "    -   ")
            call MultiboardReleaseItem(field)
            set field = null
            set udg_GIB_PlayerRow[8 + GetPlayerId(who)] = row
        endif
        set i = i + 1
    exitwhen i > 9
    endloop
    set row = row + 1
    set column = 0
    set field = MultiboardGetItem(board, row, column)
    call MultiboardSetItemStyle(field, true, false)
    call MultiboardSetItemWidth(field, 0.4)
    call MultiboardSetItemValue(field, line)
    call MultiboardReleaseItem(field)
    set field = null
    set column = column + 1
    set field = MultiboardGetItem(board, row, column)
    call MultiboardSetItemStyle(field, false, false)
    call MultiboardSetItemWidth(field, 0.0)
    call MultiboardReleaseItem(field)
    set field = null
    set column = column + 1
    set field = MultiboardGetItem(board, row, column)
    call MultiboardSetItemStyle(field, false, false)
    call MultiboardSetItemWidth(field, 0.0)
    call MultiboardReleaseItem(field)
    set field = null
    set column = column + 1
    set field = MultiboardGetItem(board, row, column)
    call MultiboardSetItemStyle(field, false, false)
    call MultiboardSetItemWidth(field, 0.0)
    call MultiboardReleaseItem(field)
    set field = null
    set column = column + 1
    set field = MultiboardGetItem(board, row, column)
    call MultiboardSetItemStyle(field, false, false)
    call MultiboardSetItemWidth(field, 0.0)
    call MultiboardReleaseItem(field)
    set field = null
    set column = column + 1
    set field = MultiboardGetItem(board, row, column)
    call MultiboardSetItemStyle(field, false, false)
    call MultiboardSetItemWidth(field, 0.0)
    call MultiboardReleaseItem(field)
    set field = null
    set row = row + 1
    set column = 0
    set field = MultiboardGetItem(board, row, column)
    call MultiboardSetItemStyle(field, true, false)
    call MultiboardSetItemWidth(field, w[column])
    call MultiboardSetItemValue(field, "|cffffffffFaith:|r")
    call MultiboardReleaseItem(field)
    set field = null
    set column = column + 1
    set field = MultiboardGetItem(board, row, column)
    call MultiboardSetItemStyle(field, true, false)
    call MultiboardSetItemWidth(field, w[column])
    call MultiboardSetItemValue(field, "|cffff6600Hakurei:       " + "|r" + I2S(udg_ScoreSpirit[5]))
    call MultiboardReleaseItem(field)
    set field = null
    set column = column + 1
    set field = MultiboardGetItem(board, row, column)
    call MultiboardSetItemStyle(field, true, false)
    call MultiboardSetItemWidth(field, w[column - 1])
    call MultiboardSetItemValue(field, "|cff00ff66Moriya:       " + "|r" + I2S(udg_ScoreSpirit[11]))
    call MultiboardReleaseItem(field)
    set field = null
    set column = column + 1
    set field = MultiboardGetItem(board, row, column)
    call MultiboardSetItemStyle(field, false, false)
    call MultiboardSetItemWidth(field, 0.0)
    call MultiboardReleaseItem(field)
    set field = null
    set column = column + 1
    set field = MultiboardGetItem(board, row, column)
    call MultiboardSetItemStyle(field, false, false)
    call MultiboardSetItemWidth(field, 0.0)
    call MultiboardReleaseItem(field)
    set field = null
    set column = column + 1
    set field = MultiboardGetItem(board, row, column)
    call MultiboardSetItemStyle(field, false, false)
    call MultiboardSetItemWidth(field, 0.0)
    call MultiboardReleaseItem(field)
    set field = null
    set udg_GIB_PlayerRow[0] = row
    if ModuloInteger(udg_GameMode, 100) / 10 == 5 then
        set row = row + 1
        set column = 0
        set field = MultiboardGetItem(board, row, column)
        call MultiboardSetItemStyle(field, true, false)
        call MultiboardSetItemWidth(field, 0.4)
        call MultiboardSetItemValue(field, line)
        call MultiboardReleaseItem(field)
        set field = null
        set column = column + 1
        set field = MultiboardGetItem(board, row, column)
        call MultiboardSetItemStyle(field, false, false)
        call MultiboardSetItemWidth(field, 0.0)
        call MultiboardReleaseItem(field)
        set field = null
        set column = column + 1
        set field = MultiboardGetItem(board, row, column)
        call MultiboardSetItemStyle(field, false, false)
        call MultiboardSetItemWidth(field, 0.0)
        call MultiboardReleaseItem(field)
        set field = null
        set column = column + 1
        set field = MultiboardGetItem(board, row, column)
        call MultiboardSetItemStyle(field, false, false)
        call MultiboardSetItemWidth(field, 0.0)
        call MultiboardReleaseItem(field)
        set field = null
        set column = column + 1
        set field = MultiboardGetItem(board, row, column)
        call MultiboardSetItemStyle(field, false, false)
        call MultiboardSetItemWidth(field, 0.0)
        call MultiboardReleaseItem(field)
        set field = null
        set column = column + 1
        set field = MultiboardGetItem(board, row, column)
        call MultiboardSetItemStyle(field, false, false)
        call MultiboardSetItemWidth(field, 0.0)
        call MultiboardReleaseItem(field)
        set field = null
        set row = row + 1
        set column = 0
        set field = MultiboardGetItem(board, row, column)
        call MultiboardSetItemStyle(field, true, false)
        call MultiboardSetItemWidth(field, w[column])
        call MultiboardSetItemValue(field, "|cffff6600Hakurei bans:|r")
        call MultiboardReleaseItem(field)
        set field = null
        set column = column + 1
        set field = MultiboardGetItem(board, row, column)
        call MultiboardSetItemStyle(field, true, true)
        call MultiboardSetItemWidth(field, w[2])
        call MultiboardSetItemIcon(field, udg_HeroIcon[udg_GIB_HeroBan[1]])
        call MultiboardReleaseItem(field)
        set field = null
        set column = column + 1
        set field = MultiboardGetItem(board, row, column)
        call MultiboardSetItemStyle(field, true, false)
        call MultiboardSetItemWidth(field, w[2])
        call MultiboardSetItemIcon(field, udg_HeroIcon[udg_GIB_HeroBan[4]])
        call MultiboardReleaseItem(field)
        set field = null
        set column = column + 1
        set field = MultiboardGetItem(board, row, column)
        call MultiboardSetItemStyle(field, true, false)
        call MultiboardSetItemWidth(field, w[2])
        call MultiboardSetItemIcon(field, udg_HeroIcon[udg_GIB_HeroBan[5]])
        call MultiboardReleaseItem(field)
        set field = null
        set column = column + 1
        set field = MultiboardGetItem(board, row, column)
        call MultiboardSetItemStyle(field, false, false)
        call MultiboardSetItemWidth(field, 0.0)
        call MultiboardReleaseItem(field)
        set field = null
        set column = column + 1
        set field = MultiboardGetItem(board, row, column)
        call MultiboardSetItemStyle(field, false, false)
        call MultiboardSetItemWidth(field, 0.0)
        call MultiboardReleaseItem(field)
        set field = null
        set row = row + 1
        set column = 0
        set field = MultiboardGetItem(board, row, column)
        call MultiboardSetItemStyle(field, true, false)
        call MultiboardSetItemWidth(field, w[column])
        call MultiboardSetItemValue(field, "|cff00ff66Moriya bans:|r")
        call MultiboardReleaseItem(field)
        set field = null
        set column = column + 1
        set field = MultiboardGetItem(board, row, column)
        call MultiboardSetItemStyle(field, true, true)
        call MultiboardSetItemWidth(field, w[2])
        call MultiboardSetItemIcon(field, udg_HeroIcon[udg_GIB_HeroBan[2]])
        call MultiboardReleaseItem(field)
        set field = null
        set column = column + 1
        set field = MultiboardGetItem(board, row, column)
        call MultiboardSetItemStyle(field, true, false)
        call MultiboardSetItemWidth(field, w[2])
        call MultiboardSetItemIcon(field, udg_HeroIcon[udg_GIB_HeroBan[3]])
        call MultiboardReleaseItem(field)
        set field = null
        set column = column + 1
        set field = MultiboardGetItem(board, row, column)
        call MultiboardSetItemStyle(field, true, false)
        call MultiboardSetItemWidth(field, w[2])
        call MultiboardSetItemIcon(field, udg_HeroIcon[udg_GIB_HeroBan[6]])
        call MultiboardReleaseItem(field)
        set field = null
        set column = column + 1
        set field = MultiboardGetItem(board, row, column)
        call MultiboardSetItemStyle(field, false, false)
        call MultiboardSetItemWidth(field, 0.0)
        call MultiboardReleaseItem(field)
        set field = null
        set column = column + 1
        set field = MultiboardGetItem(board, row, column)
        call MultiboardSetItemStyle(field, false, false)
        call MultiboardSetItemWidth(field, 0.0)
        call MultiboardReleaseItem(field)
        set field = null
    endif
    call MultiboardSuppressDisplay(false)
    call MultiboardMinimize(board, true)
    set board = null
    set field = null
    set h = null
endfunction

function InitTrig_Setup_Game_Info_Board takes nothing returns nothing
    set gg_trg_Setup_Game_Info_Board = CreateTrigger()
    call TriggerAddAction(gg_trg_Setup_Game_Info_Board, function Trig_Setup_Game_Info_Board_Actions)
endfunction