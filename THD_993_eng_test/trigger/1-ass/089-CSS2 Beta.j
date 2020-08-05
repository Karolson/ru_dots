function CSS2_Update_BanPickBoard takes integer node returns nothing
    local multiboarditem field = MultiboardGetItem(udg_BanPickBoard, node - 1, 2)
    local unit h
    local real x = -5344.0
    local real y = -3968.0
    local string name
    if node == 1 then
        call MultiboardSetItemIcon(field, udg_HeroIcon[udg_GIB_HeroBan[1]])
        set h = CreateUnit(Player(12), udg_HeroType[udg_GIB_HeroBan[1]], x, y, 0)
        set name = GetHeroProperName(h)
        call MultiboardSetItemValue(field, name)
        call RemoveUnit(h)
    elseif node == 2 then
        call MultiboardSetItemIcon(field, udg_HeroIcon[udg_GIB_HeroBan[2]])
        set h = CreateUnit(Player(12), udg_HeroType[udg_GIB_HeroBan[2]], x, y, 0)
        set name = GetHeroProperName(h)
        call MultiboardSetItemValue(field, name)
        call RemoveUnit(h)
    elseif node == 3 then
        call MultiboardSetItemIcon(field, udg_HeroIcon[udg_GIB_HeroBan[3]])
        set h = CreateUnit(Player(12), udg_HeroType[udg_GIB_HeroBan[3]], x, y, 0)
        set name = GetHeroProperName(h)
        call MultiboardSetItemValue(field, name)
        call RemoveUnit(h)
    elseif node == 4 then
        call MultiboardSetItemIcon(field, udg_HeroIcon[udg_GIB_HeroBan[4]])
        set h = CreateUnit(Player(12), udg_HeroType[udg_GIB_HeroBan[4]], x, y, 0)
        set name = GetHeroProperName(h)
        call MultiboardSetItemValue(field, name)
        call RemoveUnit(h)
    elseif node == 5 then
        call MultiboardSetItemIcon(field, udg_HeroIcon[udg_PlayerHeroList[10]])
        set h = CreateUnit(Player(12), udg_HeroType[udg_PlayerHeroList[10]], x, y, 0)
        set name = GetHeroProperName(h)
        call MultiboardSetItemValue(field, name)
        call RemoveUnit(h)
    elseif node == 6 then
        call MultiboardSetItemIcon(field, udg_HeroIcon[udg_PlayerHeroList[4]])
        set h = CreateUnit(Player(12), udg_HeroType[udg_PlayerHeroList[4]], x, y, 0)
        set name = GetHeroProperName(h)
        call MultiboardSetItemValue(field, name)
        call RemoveUnit(h)
    elseif node == 7 then
        call MultiboardSetItemIcon(field, udg_HeroIcon[udg_PlayerHeroList[3]])
        set h = CreateUnit(Player(12), udg_HeroType[udg_PlayerHeroList[3]], x, y, 0)
        set name = GetHeroProperName(h)
        call MultiboardSetItemValue(field, name)
        call RemoveUnit(h)
    elseif node == 8 then
        call MultiboardSetItemIcon(field, udg_HeroIcon[udg_PlayerHeroList[9]])
        set h = CreateUnit(Player(12), udg_HeroType[udg_PlayerHeroList[9]], x, y, 0)
        set name = GetHeroProperName(h)
        call MultiboardSetItemValue(field, name)
        call RemoveUnit(h)
    elseif node == 9 then
        call MultiboardSetItemIcon(field, udg_HeroIcon[udg_GIB_HeroBan[9]])
        set h = CreateUnit(Player(12), udg_HeroType[udg_GIB_HeroBan[9]], x, y, 0)
        set name = GetHeroProperName(h)
        call MultiboardSetItemValue(field, name)
        call RemoveUnit(h)
    elseif node == 10 then
        call MultiboardSetItemIcon(field, udg_HeroIcon[udg_GIB_HeroBan[10]])
        set h = CreateUnit(Player(12), udg_HeroType[udg_GIB_HeroBan[10]], x, y, 0)
        set name = GetHeroProperName(h)
        call MultiboardSetItemValue(field, name)
        call RemoveUnit(h)
    elseif node == 11 then
        call MultiboardSetItemIcon(field, udg_HeroIcon[udg_GIB_HeroBan[11]])
        set h = CreateUnit(Player(12), udg_HeroType[udg_GIB_HeroBan[11]], x, y, 0)
        set name = GetHeroProperName(h)
        call MultiboardSetItemValue(field, name)
        call RemoveUnit(h)
    elseif node == 12 then
        call MultiboardSetItemIcon(field, udg_HeroIcon[udg_GIB_HeroBan[12]])
        set h = CreateUnit(Player(12), udg_HeroType[udg_GIB_HeroBan[12]], x, y, 0)
        set name = GetHeroProperName(h)
        call MultiboardSetItemValue(field, name)
        call RemoveUnit(h)
    elseif node == 13 then
        call MultiboardSetItemIcon(field, udg_HeroIcon[udg_PlayerHeroList[2]])
        set h = CreateUnit(Player(12), udg_HeroType[udg_PlayerHeroList[2]], x, y, 0)
        set name = GetHeroProperName(h)
        call MultiboardSetItemValue(field, name)
        call RemoveUnit(h)
    elseif node == 14 then
        call MultiboardSetItemIcon(field, udg_HeroIcon[udg_PlayerHeroList[8]])
        set h = CreateUnit(Player(12), udg_HeroType[udg_PlayerHeroList[8]], x, y, 0)
        set name = GetHeroProperName(h)
        call MultiboardSetItemValue(field, name)
        call RemoveUnit(h)
    elseif node == 15 then
        call MultiboardSetItemIcon(field, udg_HeroIcon[udg_PlayerHeroList[7]])
        set h = CreateUnit(Player(12), udg_HeroType[udg_PlayerHeroList[7]], x, y, 0)
        set name = GetHeroProperName(h)
        call MultiboardSetItemValue(field, name)
        call RemoveUnit(h)
    elseif node == 16 then
        call MultiboardSetItemIcon(field, udg_HeroIcon[udg_PlayerHeroList[1]])
        set h = CreateUnit(Player(12), udg_HeroType[udg_PlayerHeroList[1]], x, y, 0)
        set name = GetHeroProperName(h)
        call MultiboardSetItemValue(field, name)
        call RemoveUnit(h)
    elseif node == 17 then
        call MultiboardSetItemIcon(field, udg_HeroIcon[udg_PlayerHeroList[6]])
        set h = CreateUnit(Player(12), udg_HeroType[udg_PlayerHeroList[6]], x, y, 0)
        set name = GetHeroProperName(h)
        call MultiboardSetItemValue(field, name)
        call RemoveUnit(h)
    elseif node == 18 then
        call MultiboardSetItemIcon(field, udg_HeroIcon[udg_PlayerHeroList[0]])
        set h = CreateUnit(Player(12), udg_HeroType[udg_PlayerHeroList[0]], x, y, 0)
        set name = GetHeroProperName(h)
        call MultiboardSetItemValue(field, name)
        call RemoveUnit(h)
    endif
    call MultiboardReleaseItem(field)
    set h = null
    set field = null
endfunction

function CSS2_Setup_BanPick_Board takes nothing returns nothing
    local multiboard board
    local multiboarditem field = null
    local real array width
    local integer i = 0
    set width[1] = 0.02
    set width[2] = 0.04
    set width[3] = 0.07
    call MultiboardSuppressDisplay(true)
    if udg_BanPickBoard == null then
        set board = CreateMultiboard()
    else
        set board = udg_BanPickBoard
    endif
    call MultiboardSetTitleText(board, "Pick and ban order")
    call MultiboardDisplay(board, true)
    set udg_BanPickBoard = board
    call MultiboardSetRowCount(board, 18)
    call MultiboardSetColumnCount(board, 3)
    loop
        set field = MultiboardGetItem(board, i, 0)
        call MultiboardSetItemStyle(field, true, false)
        call MultiboardSetItemWidth(field, width[1])
        call MultiboardSetItemValue(field, I2S(i + 1))
        call MultiboardReleaseItem(field)
        set field = null
        set i = i + 1
    exitwhen i > 18
    endloop
    set field = MultiboardGetItem(board, 0, 1)
    call MultiboardSetItemStyle(field, true, false)
    call MultiboardSetItemWidth(field, width[2])
    call MultiboardSetItemValue(field, "|cFFFF0000Hakurei bans|r")
    call MultiboardReleaseItem(field)
    set field = null
    set field = MultiboardGetItem(board, 1, 1)
    call MultiboardSetItemStyle(field, true, false)
    call MultiboardSetItemWidth(field, width[2])
    call MultiboardSetItemValue(field, "|cFF006633Moriya bans|r")
    call MultiboardReleaseItem(field)
    set field = null
    set field = MultiboardGetItem(board, 2, 1)
    call MultiboardSetItemStyle(field, true, false)
    call MultiboardSetItemWidth(field, width[2])
    call MultiboardSetItemValue(field, "|cFF006633Moriya bans|r")
    call MultiboardReleaseItem(field)
    set field = null
    set field = MultiboardGetItem(board, 3, 1)
    call MultiboardSetItemStyle(field, true, false)
    call MultiboardSetItemWidth(field, width[2])
    call MultiboardSetItemValue(field, "|cFFFF0000Hakurei bans|r")
    call MultiboardReleaseItem(field)
    set field = null
    set field = MultiboardGetItem(board, 4, 1)
    call MultiboardSetItemStyle(field, true, false)
    call MultiboardSetItemWidth(field, width[2])
    call MultiboardSetItemValue(field, "|cFF006633Moriya picks|r")
    call MultiboardReleaseItem(field)
    set field = null
    set field = MultiboardGetItem(board, 5, 1)
    call MultiboardSetItemStyle(field, true, false)
    call MultiboardSetItemWidth(field, width[2])
    call MultiboardSetItemValue(field, "|cFFFF0000Hakurei picks|r")
    call MultiboardReleaseItem(field)
    set field = null
    set field = MultiboardGetItem(board, 6, 1)
    call MultiboardSetItemStyle(field, true, false)
    call MultiboardSetItemWidth(field, width[2])
    call MultiboardSetItemValue(field, "|cFFFF0000Hakurei picks|r")
    call MultiboardReleaseItem(field)
    set field = null
    set field = MultiboardGetItem(board, 7, 1)
    call MultiboardSetItemStyle(field, true, false)
    call MultiboardSetItemWidth(field, width[2])
    call MultiboardSetItemValue(field, "|cFF006633Moriya picks|r")
    call MultiboardReleaseItem(field)
    set field = null
    set field = MultiboardGetItem(board, 8, 1)
    call MultiboardSetItemStyle(field, true, false)
    call MultiboardSetItemWidth(field, width[2])
    call MultiboardSetItemValue(field, "|cFF006633Moriya bans|r")
    call MultiboardReleaseItem(field)
    set field = null
    set field = MultiboardGetItem(board, 9, 1)
    call MultiboardSetItemStyle(field, true, false)
    call MultiboardSetItemWidth(field, width[2])
    call MultiboardSetItemValue(field, "|cFFFF0000Hakurei bans|r")
    call MultiboardReleaseItem(field)
    set field = null
    set field = MultiboardGetItem(board, 10, 1)
    call MultiboardSetItemStyle(field, true, false)
    call MultiboardSetItemWidth(field, width[2])
    call MultiboardSetItemValue(field, "|cFFFF0000Hakurei bans|r")
    call MultiboardReleaseItem(field)
    set field = null
    set field = MultiboardGetItem(board, 11, 1)
    call MultiboardSetItemStyle(field, true, false)
    call MultiboardSetItemWidth(field, width[2])
    call MultiboardSetItemValue(field, "|cFF006633Moriya bans|r")
    call MultiboardReleaseItem(field)
    set field = null
    set field = MultiboardGetItem(board, 12, 1)
    call MultiboardSetItemStyle(field, true, false)
    call MultiboardSetItemWidth(field, width[2])
    call MultiboardSetItemValue(field, "|cFFFF0000Hakurei picks|r")
    call MultiboardReleaseItem(field)
    set field = null
    set field = MultiboardGetItem(board, 13, 1)
    call MultiboardSetItemStyle(field, true, false)
    call MultiboardSetItemWidth(field, width[2])
    call MultiboardSetItemValue(field, "|cFF006633Moriya picks|r")
    call MultiboardReleaseItem(field)
    set field = null
    set field = MultiboardGetItem(board, 14, 1)
    call MultiboardSetItemStyle(field, true, false)
    call MultiboardSetItemWidth(field, width[2])
    call MultiboardSetItemValue(field, "|cFF006633Moriya picks|r")
    call MultiboardReleaseItem(field)
    set field = null
    set field = MultiboardGetItem(board, 15, 1)
    call MultiboardSetItemStyle(field, true, false)
    call MultiboardSetItemWidth(field, width[2])
    call MultiboardSetItemValue(field, "|cFFFF0000Hakurei picks|r")
    call MultiboardReleaseItem(field)
    set field = null
    set field = MultiboardGetItem(board, 16, 1)
    call MultiboardSetItemStyle(field, true, false)
    call MultiboardSetItemWidth(field, width[2])
    call MultiboardSetItemValue(field, "|cFF006633Moriya picks|r")
    call MultiboardReleaseItem(field)
    set field = null
    set field = MultiboardGetItem(board, 17, 1)
    call MultiboardSetItemStyle(field, true, false)
    call MultiboardSetItemWidth(field, width[2])
    call MultiboardSetItemValue(field, "|cFFFF0000Hakurei picks|r")
    call MultiboardReleaseItem(field)
    set field = null
    set field = MultiboardGetItem(board, 0, 2)
    call MultiboardSetItemStyle(field, true, true)
    call MultiboardSetItemWidth(field, width[3])
    call MultiboardSetItemIcon(field, udg_HeroIcon[udg_GIB_HeroBan[1]])
    call MultiboardReleaseItem(field)
    set field = null
    set field = MultiboardGetItem(board, 1, 2)
    call MultiboardSetItemStyle(field, true, true)
    call MultiboardSetItemWidth(field, width[3])
    call MultiboardSetItemIcon(field, udg_HeroIcon[udg_GIB_HeroBan[2]])
    call MultiboardReleaseItem(field)
    set field = null
    set field = MultiboardGetItem(board, 2, 2)
    call MultiboardSetItemStyle(field, true, true)
    call MultiboardSetItemWidth(field, width[3])
    call MultiboardSetItemIcon(field, udg_HeroIcon[udg_GIB_HeroBan[3]])
    call MultiboardReleaseItem(field)
    set field = null
    set field = MultiboardGetItem(board, 3, 2)
    call MultiboardSetItemStyle(field, true, true)
    call MultiboardSetItemWidth(field, width[3])
    call MultiboardSetItemIcon(field, udg_HeroIcon[udg_GIB_HeroBan[4]])
    call MultiboardReleaseItem(field)
    set field = null
    set field = MultiboardGetItem(board, 4, 2)
    call MultiboardSetItemStyle(field, true, true)
    call MultiboardSetItemWidth(field, width[3])
    call MultiboardSetItemIcon(field, udg_HeroIcon[udg_PlayerHeroList[10]])
    call MultiboardReleaseItem(field)
    set field = null
    set field = MultiboardGetItem(board, 5, 2)
    call MultiboardSetItemStyle(field, true, true)
    call MultiboardSetItemWidth(field, width[3])
    call MultiboardSetItemIcon(field, udg_HeroIcon[udg_PlayerHeroList[4]])
    call MultiboardReleaseItem(field)
    set field = null
    set field = MultiboardGetItem(board, 6, 2)
    call MultiboardSetItemStyle(field, true, true)
    call MultiboardSetItemWidth(field, width[3])
    call MultiboardSetItemIcon(field, udg_HeroIcon[udg_PlayerHeroList[3]])
    call MultiboardReleaseItem(field)
    set field = null
    set field = MultiboardGetItem(board, 7, 2)
    call MultiboardSetItemStyle(field, true, true)
    call MultiboardSetItemWidth(field, width[3])
    call MultiboardSetItemIcon(field, udg_HeroIcon[udg_PlayerHeroList[9]])
    call MultiboardReleaseItem(field)
    set field = null
    set field = MultiboardGetItem(board, 8, 2)
    call MultiboardSetItemStyle(field, true, true)
    call MultiboardSetItemWidth(field, width[3])
    call MultiboardSetItemIcon(field, udg_HeroIcon[udg_GIB_HeroBan[9]])
    call MultiboardReleaseItem(field)
    set field = null
    set field = MultiboardGetItem(board, 9, 2)
    call MultiboardSetItemStyle(field, true, true)
    call MultiboardSetItemWidth(field, width[3])
    call MultiboardSetItemIcon(field, udg_HeroIcon[udg_GIB_HeroBan[10]])
    call MultiboardReleaseItem(field)
    set field = null
    set field = MultiboardGetItem(board, 10, 2)
    call MultiboardSetItemStyle(field, true, true)
    call MultiboardSetItemWidth(field, width[3])
    call MultiboardSetItemIcon(field, udg_HeroIcon[udg_GIB_HeroBan[11]])
    call MultiboardReleaseItem(field)
    set field = null
    set field = MultiboardGetItem(board, 11, 2)
    call MultiboardSetItemStyle(field, true, true)
    call MultiboardSetItemWidth(field, width[3])
    call MultiboardSetItemIcon(field, udg_HeroIcon[udg_GIB_HeroBan[12]])
    call MultiboardReleaseItem(field)
    set field = null
    set field = MultiboardGetItem(board, 12, 2)
    call MultiboardSetItemStyle(field, true, true)
    call MultiboardSetItemWidth(field, width[3])
    call MultiboardSetItemIcon(field, udg_HeroIcon[udg_PlayerHeroList[2]])
    call MultiboardReleaseItem(field)
    set field = null
    set field = MultiboardGetItem(board, 13, 2)
    call MultiboardSetItemStyle(field, true, true)
    call MultiboardSetItemWidth(field, width[3])
    call MultiboardSetItemIcon(field, udg_HeroIcon[udg_PlayerHeroList[8]])
    call MultiboardReleaseItem(field)
    set field = null
    set field = MultiboardGetItem(board, 14, 2)
    call MultiboardSetItemStyle(field, true, true)
    call MultiboardSetItemWidth(field, width[3])
    call MultiboardSetItemIcon(field, udg_HeroIcon[udg_PlayerHeroList[7]])
    call MultiboardReleaseItem(field)
    set field = null
    set field = MultiboardGetItem(board, 15, 2)
    call MultiboardSetItemStyle(field, true, true)
    call MultiboardSetItemWidth(field, width[3])
    call MultiboardSetItemIcon(field, udg_HeroIcon[udg_PlayerHeroList[1]])
    call MultiboardReleaseItem(field)
    set field = null
    set field = MultiboardGetItem(board, 16, 2)
    call MultiboardSetItemStyle(field, true, true)
    call MultiboardSetItemWidth(field, width[3])
    call MultiboardSetItemIcon(field, udg_HeroIcon[udg_PlayerHeroList[6]])
    call MultiboardReleaseItem(field)
    set field = null
    set field = MultiboardGetItem(board, 17, 2)
    call MultiboardSetItemStyle(field, true, true)
    call MultiboardSetItemWidth(field, width[3])
    call MultiboardSetItemIcon(field, udg_HeroIcon[udg_PlayerHeroList[0]])
    call MultiboardReleaseItem(field)
    set field = null
    call MultiboardSuppressDisplay(false)
    call MultiboardMinimize(board, true)
    set board = null
    set field = null
endfunction

function CSS2_SetupBanMode takes nothing returns nothing
    local integer htask = StringHash("BanModeOrder")
    call SaveInteger(udg_cssht, htask, 0, 0)
    call SaveInteger(udg_cssht, htask, 1, 0)
    call SaveBoolean(udg_cssht, htask, 1, false)
    call SaveInteger(udg_cssht, htask, 2, 5)
    call SaveBoolean(udg_cssht, htask, 2, false)
    call SaveInteger(udg_cssht, htask, 3, 5)
    call SaveBoolean(udg_cssht, htask, 3, false)
    call SaveInteger(udg_cssht, htask, 4, 0)
    call SaveBoolean(udg_cssht, htask, 4, false)
    call SaveInteger(udg_cssht, htask, 5, 5)
    call SaveBoolean(udg_cssht, htask, 5, true)
    call SaveReal(udg_cssht, htask, 5, 9.1)
    call SaveInteger(udg_cssht, htask, 6, 0)
    call SaveBoolean(udg_cssht, htask, 6, true)
    call SaveReal(udg_cssht, htask, 6, 4.1)
    call SaveInteger(udg_cssht, htask, 7, 0)
    call SaveBoolean(udg_cssht, htask, 7, true)
    call SaveReal(udg_cssht, htask, 7, 3.1)
    call SaveInteger(udg_cssht, htask, 8, 5)
    call SaveBoolean(udg_cssht, htask, 8, true)
    call SaveReal(udg_cssht, htask, 8, 8.1)
    call SaveInteger(udg_cssht, htask, 9, 5)
    call SaveBoolean(udg_cssht, htask, 9, false)
    call SaveInteger(udg_cssht, htask, 10, 0)
    call SaveBoolean(udg_cssht, htask, 10, false)
    call SaveInteger(udg_cssht, htask, 11, 0)
    call SaveBoolean(udg_cssht, htask, 11, false)
    call SaveInteger(udg_cssht, htask, 12, 5)
    call SaveBoolean(udg_cssht, htask, 12, false)
    call SaveInteger(udg_cssht, htask, 13, 0)
    call SaveBoolean(udg_cssht, htask, 13, true)
    call SaveReal(udg_cssht, htask, 13, 2.1)
    call SaveInteger(udg_cssht, htask, 14, 5)
    call SaveBoolean(udg_cssht, htask, 14, true)
    call SaveReal(udg_cssht, htask, 14, 7.1)
    call SaveInteger(udg_cssht, htask, 15, 5)
    call SaveBoolean(udg_cssht, htask, 15, true)
    call SaveReal(udg_cssht, htask, 15, 6.1)
    call SaveInteger(udg_cssht, htask, 16, 0)
    call SaveBoolean(udg_cssht, htask, 16, true)
    call SaveReal(udg_cssht, htask, 16, 1.1)
    call SaveInteger(udg_cssht, htask, 17, 5)
    call SaveBoolean(udg_cssht, htask, 17, true)
    call SaveReal(udg_cssht, htask, 17, 5.1)
    call SaveInteger(udg_cssht, htask, 18, 0)
    call SaveBoolean(udg_cssht, htask, 18, true)
    call SaveReal(udg_cssht, htask, 18, 0.1)
endfunction

function CSS2_SetupDraftMode takes nothing returns nothing
    local integer htask = StringHash("DraftModeOrder")
    call SaveInteger(udg_cssht, htask, 0, 0)
    call SaveInteger(udg_cssht, htask, 1, 0)
    call SaveInteger(udg_cssht, htask, 2, 5)
    call SaveInteger(udg_cssht, htask, 3, 6)
    call SaveInteger(udg_cssht, htask, 4, 1)
    call SaveInteger(udg_cssht, htask, 5, 2)
    call SaveInteger(udg_cssht, htask, 6, 7)
    call SaveInteger(udg_cssht, htask, 7, 8)
    call SaveInteger(udg_cssht, htask, 8, 3)
    call SaveInteger(udg_cssht, htask, 9, 4)
    call SaveInteger(udg_cssht, htask, 10, 9)
endfunction

function CSS2_BanModeUpdateStatus takes nothing returns boolean
    local integer mtask = StringHash("BanModeOrder")
    local integer newnode = LoadInteger(udg_cssht, mtask, 0) + 1
    local player p
    if not HaveSavedInteger(udg_cssht, mtask, newnode) then
        set p = null
        return false
    endif
    call SaveInteger(udg_cssht, mtask, 0, newnode)
    set p = GetSortedPlayer(LoadInteger(udg_cssht, mtask, newnode))
    if LoadBoolean(udg_cssht, mtask, newnode) then
        call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, udg_PN[GetPlayerId(p)] + " picks a character")
    else
        call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, udg_PN[GetPlayerId(p)] + " bans a character")
    endif
    set p = null
    return true
endfunction

function CSS2_DraftModeUpdateStatus takes nothing returns boolean
    local integer mtask = StringHash("DraftModeOrder")
    local integer newnode = LoadInteger(udg_cssht, mtask, 0) + 1
    local player p
    if not HaveSavedInteger(udg_cssht, mtask, newnode) then
        set p = null
        return false
    endif
    call SaveInteger(udg_cssht, mtask, 0, newnode)
    set p = GetSortedPlayer(LoadInteger(udg_cssht, mtask, newnode))
    call SaveInteger(udg_cssht, mtask, 0, newnode)
    if GetPlayerSlotState(p) == PLAYER_SLOT_STATE_PLAYING then
        call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, udg_PN[GetPlayerId(p)] + " picks their character")
    endif
    set p = null
    return true
endfunction

function CSS2_UpdateDMModeLives takes nothing returns nothing
    if GetTriggerEventId() == EVENT_GAME_TIMER_EXPIRED then
        call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "Default DM mode life number: " + I2S(udg_DMModeLives))
    else
        if S2I(SubString(GetEventPlayerChatString(), 7, 11)) > 0 then
            set udg_DMModeLives = S2I(SubString(GetEventPlayerChatString(), 7, 11))
        else
            set udg_DMModeLives = 1
        endif
        call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "The DM life number is set to: " + I2S(udg_DMModeLives))
    endif
    call DisableTrigger(GetTriggeringTrigger())
    call DestroyTrigger(GetTriggeringTrigger())
endfunction

function CSS2_ChangeCloth takes integer i returns integer
    local integer index = udg_PlayerHeroList[i]
    local integer outhero = udg_HeroType[index]
    local boolean cloth01
    local boolean cloth02
    local boolean cloth03
    local integer maxcloth
    local boolean ramdomget
    if (udg_GameMode - udg_GameMode / 100 * 100) / 10 == 6 then
        call DebugMsg("Set " + I2S(i) + " Value To : " + I2S(i))
        set udg_HeroClothChangeTo[i] = udg_HeroClothChangeToB[i]
    endif
    if udg_HeroClothChangeTo[i] == -1 then
        return outhero
    endif
    set cloth01 = udg_HeroCloth01[index] != 0
    set cloth02 = udg_HeroCloth02[index] != 0
    set cloth03 = udg_HeroCloth03[index] != 0
    set maxcloth = 1
    if cloth01 then
        set maxcloth = maxcloth + 1
    endif
    if cloth02 then
        set maxcloth = maxcloth + 1
    endif
    if cloth03 then
        set maxcloth = maxcloth + 1
    endif
    set ramdomget = GetRandomInt(1, 100) <= 50
    if udg_HeroCloth01[index] != 0 then
        if udg_HeroClothChangeTo[i] == 0 and ramdomget then
            if GetRandomInt(1, 100) <= 100 / maxcloth then
                set outhero = udg_HeroCloth01[index]
            endif
        elseif udg_HeroClothChangeTo[i] == 1 then
            set outhero = udg_HeroCloth01[index]
        endif
    endif
    if udg_HeroCloth02[index] != 0 then
        if udg_HeroClothChangeTo[i] == 0 and ramdomget then
            if GetRandomInt(1, 100) <= 100 / maxcloth then
                set outhero = udg_HeroCloth02[index]
            endif
        elseif udg_HeroClothChangeTo[i] == 2 then
            set outhero = udg_HeroCloth02[index]
        endif
    endif
    if udg_HeroCloth03[index] != 0 then
        if udg_HeroClothChangeTo[i] == 3 then
            set outhero = udg_HeroCloth03[index]
        endif
    endif
    return outhero
endfunction

function CSS2_GetPlayerSlotX takes player p returns real
    local real x
    if IsPlayerInForce(p, udg_TeamA) then
        set x = GetRectCenterX(gg_rct_PlayerCSS_A5) - 80.0
    elseif IsPlayerInForce(p, udg_TeamB) then
        set x = GetRectCenterX(gg_rct_PlayerCSS_A5) + 80.0
    endif
    return x
endfunction

function CSS2_GetPlayerSlotY takes player p returns real
    local integer i = 0
    local real y
    loop
    exitwhen udg_PlayerA[i] == p or udg_PlayerB[i] == p
    exitwhen i > 5
        set i = i + 1
    endloop
    set y = GetRectCenterY(gg_rct_PlayerCSS_A5) + 200.0 - 128.0 * (i - 1)
    return y
endfunction

function CSS2_GetRandomCharacter takes nothing returns integer
    local integer htask = StringHash("HeroAvailability")
    local integer index = GetRandomInt(1, udg_HeroType[0] + udg_HeroType[100])
    if index > udg_HeroType[0] then
        set index = index - udg_HeroType[0] + 100
    endif
    loop
    exitwhen LoadBoolean(udg_cssht, htask, index) and index != 131
        set index = index + 1
        if index == 100 then
            set index = 101
        elseif index > 100 + udg_HeroType[100] then
            set index = 1
        endif
    endloop
    return index
endfunction

function CSS2_BanCharacter takes integer index returns nothing
    local real x
    local real y
    local real z = 762
    local destructable d1
    if index == 0 then
        set index = CSS2_GetRandomCharacter()
    endif
    set x = LoadReal(udg_cssht, index, 0)
    set y = LoadReal(udg_cssht, index, 1)
    set d1 = CreateDestructableZ('B01Y', x, y, z - 1, 180.0, 1.0, 0)
    call SaveBoolean(udg_cssht, StringHash("HeroAvailability"), index, false)
    call SaveInteger(udg_cssht, StringHash("HeroAvailability"), index, 1)
    set d1 = null
endfunction

function CSS2_SelectCharacterForPlayer takes player p, integer index, boolean feedback, boolean tickoverlay returns nothing
    local integer ptask = GetHandleId(p)
    local integer pid = GetPlayerId(p)
    local integer htask = StringHash("HeroAvailability")
    local destructable d1
    local destructable d2
    local real x = LoadReal(udg_cssht, index, 0)
    local real y = LoadReal(udg_cssht, index, 1)
    local real tx = CSS2_GetPlayerSlotX(p)
    local real ty = CSS2_GetPlayerSlotY(p)
    local real z = 762
    local integer i = 0
    if feedback then
        if HaveSavedHandle(udg_cssht, ptask, 2) then
            set d1 = LoadDestructableHandle(udg_cssht, ptask, 2)
            call RemoveDestructable(d1)
            if HaveSavedHandle(udg_cssht, ptask, 3) then
                set d2 = LoadDestructableHandle(udg_cssht, ptask, 3)
                call RemoveDestructable(d2)
            endif
        endif
        set d1 = CreateDestructableZ('B00A', x, y, z - 8.0, 180.0, 1.5, 0)
        if GetLocalPlayer() != p then
            call ShowDestructable(d1, false)
        endif
        call SaveDestructableHandle(udg_cssht, ptask, 2, d1)
        if index > 0 then
            set d2 = CreateDestructableZ('B00C', x, y, z - 1, 180.0, 1.0, 0)
            if GetLocalPlayer() != p then
                call ShowDestructable(d2, false)
            endif
            call SaveDestructableHandle(udg_cssht, ptask, 3, d2)
        endif
        if GetLocalPlayer() == p then
            call ClearTextMessages()
        endif
        call DisplayTextToPlayer(p, 0, 0, udg_HeroBrief[index])
    endif
    if udg_PlayerHeroList[pid] > 0 and LoadInteger(udg_cssht, htask, udg_PlayerHeroList[pid]) != 1 then
        call SaveBoolean(udg_cssht, htask, udg_PlayerHeroList[pid], true)
    endif
    set udg_PlayerHeroList[pid] = index
    call SaveInteger(udg_cssht, ptask, 0, index)
    if index != 0 then
        call SaveBoolean(udg_cssht, htask, index, false)
    endif
    if HaveSavedHandle(udg_cssht, ptask, 5) then
        set d1 = LoadDestructableHandle(udg_cssht, ptask, 5)
        call RemoveDestructable(d1)
    endif
    if index > 0 then
        set d1 = CreateDestructableZ(udg_HeroButton[index], tx, ty, z - 3.0, 180.0, 1.0, 0)
    elseif index == 0 then
        set d1 = CreateDestructableZ('B00D', tx, ty, z - 3.0, 180.0, 1.0, 0)
    endif
    call SaveDestructableHandle(udg_cssht, ptask, 5, d1)
    if tickoverlay then
        set d1 = CreateDestructableZ('B001', x, y, z - 1, 180.0, 1.0, 0)
    endif
    set d1 = null
    set d2 = null
endfunction

function CSS2_SetPlayerPrepared takes player p returns nothing
    local integer ptask = GetHandleId(p)
    local integer preparedsum = LoadInteger(udg_cssht, StringHash("PreparedPlayerSum"), 0)
    local real tx = CSS2_GetPlayerSlotX(p)
    local real ty = CSS2_GetPlayerSlotY(p)
    local real z = 762
    local destructable d1
    local integer i = 0
    call SaveBoolean(udg_cssht, ptask, 1, true)
    call SaveInteger(udg_cssht, StringHash("PreparedPlayerSum"), 0, preparedsum + 1)
    set d1 = CreateDestructableZ('B007', tx, ty, z, 180.0, 1.3, 0)
    call SaveDestructableHandle(udg_cssht, ptask, 7, d1)
    if udg_PlayerHeroList[GetPlayerId(p)] != 0 then
        loop
        exitwhen i > 10
            if Player(i) != p and udg_PlayerHeroList[i] == udg_PlayerHeroList[GetPlayerId(p)] then
                call CSS2_SelectCharacterForPlayer(Player(i), -1 + i * -1, true, false)
            endif
            set i = i + 1
        endloop
    endif
    set d1 = null
endfunction

function CSS2_AIPlayerSelect takes nothing returns nothing
    local player p = GetEnumPlayer()
    local integer ainum = LoadInteger(udg_cssht, StringHash("CSS2"), 1)
    local integer preparedsum = LoadInteger(udg_cssht, StringHash("PreparedPlayerSum"), 0)
    if ainum >= udg_OnlinePlayerSum - preparedsum then
        if not LoadBoolean(udg_cssht, GetHandleId(GetEnumPlayer()), 1) then
            call CSS2_SetPlayerPrepared(p)
        endif
        call DebugMsg(GetPlayerName(p) + " Ready")
    else
        call CSS2_SelectCharacterForPlayer(p, CSS2_GetRandomCharacter(), false, false)
    endif
    set p = null
endfunction

function CSS2_BanDraftModeTimeOut takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local integer mtask
    local integer pid
    local integer currentnode
    local player p
    local boolean continue
    local integer i
    if (udg_GameMode - udg_GameMode / 100 * 100) / 10 == 3 or (udg_GameMode - udg_GameMode / 100 * 100) / 10 == 4 then
        set mtask = StringHash("DraftModeOrder")
        set currentnode = LoadInteger(udg_cssht, mtask, 0)
        set p = GetSortedPlayer(LoadInteger(udg_cssht, mtask, currentnode))
        set pid = GetPlayerId(p)
        if udg_PlayerHeroList[pid] == 0 then
            call CSS2_SelectCharacterForPlayer(p, CSS2_GetRandomCharacter(), false, false)
        endif
        call CSS2_SetPlayerPrepared(p)
        set continue = CSS2_DraftModeUpdateStatus()
        if continue then
            call TimerStart(t, 20.0, false, function CSS2_BanDraftModeTimeOut)
        endif
    elseif (udg_GameMode - udg_GameMode / 100 * 100) / 10 == 6 then
        set mtask = StringHash("BanModeOrder")
        set currentnode = LoadInteger(udg_cssht, mtask, 0)
        set p = GetSortedPlayer(LoadInteger(udg_cssht, mtask, currentnode))
        set pid = GetPlayerId(p)
        if udg_PlayerHeroList[pid] == 0 then
            set udg_PlayerHeroList[pid] = CSS2_GetRandomCharacter()
        endif
        if LoadBoolean(udg_cssht, mtask, currentnode) then
            set i = R2I(LoadReal(udg_cssht, mtask, currentnode))
            set udg_HeroClothChangeToB[GetPlayerId(GetSortedPlayer(i))] = udg_HeroClothChangeTo[pid]
            call CSS2_SelectCharacterForPlayer(GetSortedPlayer(i), udg_PlayerHeroList[pid], false, true)
            call CSS2_SetPlayerPrepared(GetSortedPlayer(i))
        else
            call CSS2_BanCharacter(udg_PlayerHeroList[pid])
        endif
        call CSS2_Update_BanPickBoard(currentnode)
        set continue = CSS2_BanModeUpdateStatus()
        if continue then
            call TimerStart(t, 60.0, false, function CSS2_BanDraftModeTimeOut)
        endif
    endif
    set t = null
    set p = null
endfunction

function CSS2_OnClick takes nothing returns boolean
    local trackable t = GetTriggeringTrackable()
    local integer pid = LoadInteger(udg_cssht, GetHandleId(t), 2)
    local player p = Player(pid)
    local integer ptask = GetHandleId(p)
    local integer pindex = LoadInteger(udg_cssht, ptask, 0)
    local integer htask = StringHash("HeroAvailability")
    local real x = LoadReal(udg_cssht, GetHandleId(t), 3)
    local real y = LoadReal(udg_cssht, GetHandleId(t), 4)
    local integer index = LoadInteger(udg_cssht, GetHandleId(t), 5)
    local texttag e
    local string s
    local destructable d1
    local destructable d2
    local boolean available = LoadBoolean(udg_cssht, htask, index)
    local boolean prepared = LoadBoolean(udg_cssht, ptask, 1)
    local boolean disabled = LoadBoolean(udg_cssht, StringHash("CSS2"), 3)
    local boolean isbanstage = LoadBoolean(udg_cssht, StringHash("CSS2"), 4)
    local boolean continue
    local timer tm
    local integer currentnode
    local integer i
    local integer mtask
    if index >= 200 then
        set e = CreateTextTag()
        if GetLocalPlayer() != p then
            call SetTextTagVisibility(e, false)
        endif
        set s = GetPlayerName(GetSortedPlayer(index - 200))
        call SetTextTagText(e, s, 0.0207)
        call SetTextTagPos(e, x - RMinBJ(64.0, StringLength(s) * 6.0), y - 64.0, 0.0)
        call SetTextTagColor(e, 255, 255, 255, 180)
        call SetTextTagPermanent(e, false)
        call SetTextTagFadepoint(e, 2.0)
        call SetTextTagLifespan(e, 3.0)
        set t = null
        set e = null
        set s = ""
        set d1 = null
        set d2 = null
        set tm = null
        set p = null
        return false
    endif
    if prepared or (disabled and index != 0) or p == Player(5) or p == Player(11) or (LoadInteger(udg_cssht, htask, index) == 1 and index != 0) then
        set t = null
        set e = null
        set s = ""
        set d1 = null
        set d2 = null
        set tm = null
        set p = null
        return false
    elseif (udg_GameMode - udg_GameMode / 100 * 100) / 10 == 4 or (udg_GameMode - udg_GameMode / 100 * 100) / 10 == 5 and p != GetSortedPlayer(LoadInteger(udg_cssht, StringHash("DraftModeOrder"), LoadInteger(udg_cssht, StringHash("DraftModeOrder"), 0))) then
        if LoadBoolean(udg_cssht, StringHash("CSS2"), 5) then
            set t = null
            set e = null
            set s = ""
            set d1 = null
            set d2 = null
            set tm = null
            set p = null
            return false
        endif
    elseif (udg_GameMode - udg_GameMode / 100 * 100) / 10 == 6 and p != GetSortedPlayer(LoadInteger(udg_cssht, StringHash("BanModeOrder"), LoadInteger(udg_cssht, StringHash("BanModeOrder"), 0))) then
        set t = null
        set e = null
        set s = ""
        set d1 = null
        set d2 = null
        set tm = null
        set p = null
        return false
    elseif udg_CSS2_BanSelected[pid] and isbanstage then
        set t = null
        set e = null
        set s = ""
        set d1 = null
        set d2 = null
        set tm = null
        set p = null
        return false
    endif
    if index < 200 then
        if index == 0 or available or ((udg_GameMode - udg_GameMode / 100 * 100) / 10 == 3 and index != 100) or (GetPlayerName(p) == "blankname10" or GetPlayerName(p) == "blankname11" and index != 100) then
            call CSS2_SelectCharacterForPlayer(p, index, true, false)
        elseif index == 100 and pindex >= 0 then
            if (udg_GameMode - udg_GameMode / 100 * 100) / 10 == 4 or (udg_GameMode - udg_GameMode / 100 * 100) / 10 == 5 then
                call CSS2_SetPlayerPrepared(p)
                set continue = CSS2_DraftModeUpdateStatus()
                if continue then
                    set tm = LoadTimerHandle(udg_cssht, StringHash("BanDraftTimer"), 0)
                    call TimerStart(tm, 20.0, false, function CSS2_BanDraftModeTimeOut)
                endif
            elseif (udg_GameMode - udg_GameMode / 100 * 100) / 10 == 6 then
                set mtask = StringHash("BanModeOrder")
                set currentnode = LoadInteger(udg_cssht, mtask, 0)
                set d1 = LoadDestructableHandle(udg_cssht, ptask, 5)
                call RemoveDestructable(d1)
                if udg_PlayerHeroList[pid] == 0 then
                    set udg_PlayerHeroList[pid] = CSS2_GetRandomCharacter()
                endif
                if LoadBoolean(udg_cssht, mtask, currentnode) then
                    set i = R2I(LoadReal(udg_cssht, mtask, currentnode))
                    call DebugMsg("SetData " + I2S(GetPlayerId(GetSortedPlayer(i))) + " Value : " + I2S(udg_HeroClothChangeTo[pid]))
                    set udg_HeroClothChangeToB[GetPlayerId(GetSortedPlayer(i))] = udg_HeroClothChangeTo[pid]
                    call CSS2_SelectCharacterForPlayer(GetSortedPlayer(i), udg_PlayerHeroList[pid], false, true)
                    call CSS2_SetPlayerPrepared(GetSortedPlayer(i))
                else
                    set udg_GIB_HeroBan[currentnode] = udg_PlayerHeroList[pid]
                    call CSS2_BanCharacter(udg_PlayerHeroList[pid])
                endif
                call CSS2_Update_BanPickBoard(currentnode)
                set continue = CSS2_BanModeUpdateStatus()
                if continue then
                    if currentnode < 17 then
                        set udg_PlayerHeroList[pid] = 0
                    endif
                    set tm = LoadTimerHandle(udg_cssht, StringHash("BanDraftTimer"), 0)
                    call TimerStart(tm, 60.0, false, function CSS2_BanDraftModeTimeOut)
                endif
            else
                if udg_PlayerHeroList[pid] == 0 then
                    call CSS2_SelectCharacterForPlayer(p, 0, false, false)
                endif
                if (udg_GameMode - udg_GameMode / 100 * 100) / 10 == 3 and not udg_CSS2_BanSelected[pid] and isbanstage then
                    set udg_CSS2_BanSelected[pid] = true
                    call CSS2_BanCharacter(udg_PlayerHeroList[pid])
                    set d1 = LoadDestructableHandle(udg_cssht, ptask, 5)
                    call RemoveDestructable(d1)
                    set udg_PlayerHeroList[pid] = 0
                    set udg_CSS2_BanTotal = udg_CSS2_BanTotal + 1
                elseif (udg_GameMode - udg_GameMode / 100 * 100) / 10 == 3 and udg_CSS2_BanSelected[pid] then
                    if LoadInteger(udg_cssht, htask, udg_PlayerHeroList[pid]) != 1 or udg_PlayerHeroList[pid] == 0 then
                        call SaveInteger(udg_cssht, htask, udg_PlayerHeroList[pid], 1)
                        call CSS2_SetPlayerPrepared(p)
                    endif
                else
                    call SaveInteger(udg_cssht, htask, udg_PlayerHeroList[pid], 1)
                    call CSS2_SetPlayerPrepared(p)
                endif
            endif
        endif
    endif
    set t = null
    set e = null
    set s = ""
    set d1 = null
    set d2 = null
    set tm = null
    set p = null
    return false
endfunction

function CSS2_CreateIconOverlay takes trigger trg, string s, real x, real y, integer index, boolean hit returns nothing
    local integer i = 0
    local trackable t
    loop
    exitwhen i > 11
        if GetPlayerSlotState(Player(i)) == PLAYER_SLOT_STATE_PLAYING then
            set t = CreateTrackableForPlayerId(s, x, y, 0, i, index)
            if hit then
                call TriggerRegisterTrackableHitEvent(trg, t)
            else
                call TriggerRegisterTrackableTrackEvent(trg, t)
            endif
        endif
        set i = i + 1
    endloop
    set t = null
endfunction

function CSS2_ClearDestructable takes nothing returns nothing
    local destructable d = GetEnumDestructable()
    call RemoveDestructable(d)
    set d = null
endfunction

function CSS2_DestroyCSS takes nothing returns nothing
    call DisableTrigger(LoadTriggerHandle(udg_cssht, StringHash("CSS2"), 0))
    call DestroyTrigger(LoadTriggerHandle(udg_cssht, StringHash("CSS2"), 0))
    call EnumDestructablesInRect(udg_MapRegionScreen, null, function CSS2_ClearDestructable)
    call FlushParentHashtable(udg_cssht)
endfunction

function CSS2_RepickTimerActions takes nothing returns nothing
    local player p = GetEnumPlayer()
    local integer ptask = GetHandleId(p)
    local integer pid = GetPlayerId(p)
    local integer index
    local integer i
    local integer mtask = StringHash("CSS2_Repick")
    local fogmodifier f
    local integer j
    local real x
    local real y
    call SetCameraFieldForPlayer(p, CAMERA_FIELD_ROTATION, 90.0, 0)
    call SetCameraFieldForPlayer(p, CAMERA_FIELD_ANGLE_OF_ATTACK, 270.0, 0)
    call SetCameraFieldForPlayer(p, CAMERA_FIELD_ROLL, 0.0, 0)
    call SetCameraFieldForPlayer(p, CAMERA_FIELD_TARGET_DISTANCE, 1800.0, 0)
    call SetCameraFieldForPlayer(p, CAMERA_FIELD_FARZ, 5000.0, 0)
    call SetCameraFieldForPlayer(p, CAMERA_FIELD_FIELD_OF_VIEW, 70.0, 0)
    if LoadBoolean(udg_cssht, ptask, 1) then
        call SetCameraBoundsToRectForPlayerBJ(p, udg_MapRegion)
        if IsPlayerInForce(p, udg_TeamA) then
            set x = GetLocationX(udg_BirthPoint[0])
            set y = GetLocationY(udg_BirthPoint[0])
        else
            set x = GetLocationX(udg_BirthPoint[1])
            set y = GetLocationY(udg_BirthPoint[1])
        endif
        call RemoveUnit(udg_PlayerHeroes[pid])
        set f = LoadFogModifierHandle(udg_cssht, mtask, pid)
        call DestroyFogModifier(f)
        if udg_PlayerHeroList[pid] == 0 then
            call CSS2_SelectCharacterForPlayer(p, CSS2_GetRandomCharacter(), false, false)
        endif
        set i = GetSortedPlayerId(p)
        if i >= 5 then
            set i = i + 1
        endif
        set udg_PlayerHeroes[pid] = CreateUnit(p, udg_HeroType[udg_PlayerHeroList[pid]], x, y, 0.0)
        if udg_DMRepick[pid] then
            call AddHeroXP(udg_PlayerHeroes[pid], udg_DMXP[pid], false)
            set j = 0
            loop
            exitwhen j > 5
                call SetItemVisible(udg_DMItems[10 * pid + j], true)
                call SetItemPosition(udg_DMItems[10 * pid + j], x, y)
                call UnitAddItem(udg_PlayerHeroes[pid], udg_DMItems[10 * pid + j])
                set j = j + 1
            endloop
            set udg_DMRepick[pid] = false
        endif
        call UnitAddAbility(udg_PlayerHeroes[pid], 'A0DV')
        call UnitMakeAbilityPermanent(udg_PlayerHeroes[pid], true, 'A0DV')
        call TriggerRegisterUnitEvent(gg_trg_Ping, udg_PlayerHeroes[pid], EVENT_UNIT_SPELL_EFFECT)
        call SetPlayerName(p, udg_OriginalPlayerName[pid])
        set udg_PlayerName[pid] = udg_PlayerColors[i] + GetPlayerName(p) + "|r"
        call SetPlayerName(p, GetPlayerName(p) + " " + "(" + GetHeroProperName(udg_PlayerHeroes[pid]) + ")")
        set udg_PN[pid] = udg_PlayerColors[i] + GetPlayerName(p) + "|r"
        call TriggerExecute(udg_HeroInit[udg_PlayerHeroList[pid]])
        call GIB_SetPlayerField(p, 1, GetHeroProperName(udg_PlayerHeroes[pid]))
        call GIB_SetFieldIcon(p, 1, udg_HeroIcon[GetHeroIndex(GetUnitTypeId(udg_PlayerHeroes[pid]))])
        call TriggerRegisterUnitEvent(gg_trg_CE_Input, udg_PlayerHeroes[pid], EVENT_UNIT_DAMAGED)
        call ForceRemovePlayer(udg_TempTeamA, p)
        call ResetToGameCameraForPlayer(p, 2.0)
        call PanCameraToTimedForPlayer(p, x, y, 0.0)
        if udg_CameraState[pid] == 1 then
            call CameraAdd(udg_PlayerHeroes[pid])
        endif
    elseif udg_GameTime >= 90 and not (udg_GameMode / 100 == 4) then
        call PauseUnit(udg_PlayerHeroes[pid], false)
        set f = LoadFogModifierHandle(udg_cssht, mtask, pid)
        call DestroyFogModifier(f)
        set index = GetUnitTypeId(udg_PlayerHeroes[pid])
        call CSS2_SelectCharacterForPlayer(p, index, false, false)
        call CSS2_SetPlayerPrepared(p)
        call SetCameraBoundsToRectForPlayerBJ(p, udg_MapRegion)
        if IsPlayerInForce(p, udg_TeamA) then
            set x = GetLocationX(udg_BirthPoint[0])
            set y = GetLocationY(udg_BirthPoint[0])
        else
            set x = GetLocationX(udg_BirthPoint[1])
            set y = GetLocationY(udg_BirthPoint[1])
        endif
        call ResetToGameCameraForPlayer(p, 2.0)
        call PanCameraToTimedForPlayer(p, x, y, 0.0)
        call ForceRemovePlayer(udg_TempTeamA, p)
        if udg_CameraState[pid] == 1 then
            call CameraAdd(udg_PlayerHeroes[pid])
        endif
    endif
    set f = null
    set p = null
endfunction

function CSS2_RepickTimer takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local integer mtask = StringHash("CSS2_Repick")
    call ForForce(udg_TempTeamA, function CSS2_RepickTimerActions)
    if udg_GameTime > 90 and not (udg_GameMode / 100 == 4) then
        call ForceClear(udg_TempTeamA)
        call DestroyForce(udg_TempTeamA)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_cssht, StringHash("CSS2_Repick"))
        call CSS2_DestroyCSS()
    endif
    set t = null
endfunction

function CSS2_RepickForPlayer takes player p returns nothing
    local integer ptask = GetHandleId(p)
    local integer pid = GetPlayerId(p)
    local integer mtask = StringHash("CSS2_Repick")
    local integer i = 5
    local destructable d
    local fogmodifier f
    local unit u
    local timer t
    local integer task
    if LoadBoolean(udg_cssht, ptask, 1) then
        call CameraRemove(udg_PlayerHeroes[pid])
        if HaveSavedHandle(udg_cssht, mtask, 0) then
            set t = LoadTimerHandle(udg_cssht, mtask, 0)
            set task = GetHandleId(t)
            set u = LoadUnitHandle(udg_cssht, mtask, 2)
        else
            set t = CreateTimer()
            set task = GetHandleId(t)
            set u = CreateUnit(Player(13), 'n003', GetRectCenterX(gg_rct_PlayerCSS_A5), GetRectCenterY(gg_rct_PlayerCSS_A5), 0.0)
            call SaveTimerHandle(udg_cssht, mtask, 0, t)
            call SaveUnitHandle(udg_cssht, mtask, 2, u)
            call TimerStart(t, 0.02, true, function CSS2_RepickTimer)
        endif
        call ForceAddPlayer(udg_TempTeamA, p)
        call PauseUnit(udg_PlayerHeroes[pid], true)
        set f = CreateFogModifierRect(p, FOG_OF_WAR_VISIBLE, gg_rct_PlayerCSS_A5, true, true)
        call FogModifierStart(f)
        call SaveFogModifierHandle(udg_cssht, mtask, pid, f)
        call SetCameraBoundsToRectForPlayerBJ(p, gg_rct_PlayerCSS_A5)
        call SetCameraTargetControllerNoZForPlayer(p, u, 0.0, 0.0, false)
        call SetCameraFieldForPlayer(p, CAMERA_FIELD_ROTATION, 90.0, 0)
        call SetCameraFieldForPlayer(p, CAMERA_FIELD_ANGLE_OF_ATTACK, 270.0, 0)
        call SetCameraFieldForPlayer(p, CAMERA_FIELD_ROLL, 0.0, 0)
        call SetCameraFieldForPlayer(p, CAMERA_FIELD_TARGET_DISTANCE, 1800.0, 0)
        call SetCameraFieldForPlayer(p, CAMERA_FIELD_FARZ, 5000.0, 0)
        call SetCameraFieldForPlayer(p, CAMERA_FIELD_FIELD_OF_VIEW, 70.0, 0)
        loop
        exitwhen i > 7
            set d = LoadDestructableHandle(udg_cssht, ptask, i)
            call RemoveDestructable(d)
            set i = i + 1
        endloop
        call SaveBoolean(udg_cssht, ptask, 1, false)
        call SaveInteger(udg_cssht, StringHash("PreparedPlayerSum"), 0, LoadInteger(udg_cssht, StringHash("PreparedPlayerSum"), 0) - 1)
        if udg_GameMode / 100 == 4 and (udg_GameMode - udg_GameMode / 100 * 100) / 10 == 7 then
            call CSS2_SelectCharacterForPlayer(p, CSS2_GetRandomCharacter(), false, false)
            call CSS2_SetPlayerPrepared(p)
        endif
    endif
    set f = null
    set d = null
    set u = null
    set t = null
endfunction

function CSS2_Repick takes nothing returns nothing
    local player p = GetTriggerPlayer()
    local timer t
    if GetTriggerEventId() == EVENT_GAME_TIMER_EXPIRED then
        set p = null
        set t = GetExpiredTimer()
        call ReleaseTimer(t)
        set t = null
        call DisableTrigger(GetTriggeringTrigger())
        call DestroyTrigger(GetTriggeringTrigger())
        if not (udg_GameMode / 100 == 4) then
            call CSS2_DestroyCSS()
        endif
        return
    else
        if GetPlayerState(p, PLAYER_STATE_RESOURCE_GOLD) >= 200 then
            call THD_AddCredit(p, -200)
            call CSS2_RepickForPlayer(p)
        else
            call DisplayTextToPlayer(p, 0.0, 0.0, "Insufficient gold for repicking!")
        endif
    endif
    set t = null
    set p = null
endfunction

function CSS2_Swap takes nothing returns nothing
    local player p = GetTriggerPlayer()
    local integer pid = GetPlayerId(p)
    local string command = GetEventPlayerChatString()
    local player g
    local integer i
    local integer j
    local integer k
    local integer m
    local integer n
    local integer h
    local real ox
    local real oy
    local real tx
    local real ty
    local unit u
    if GetTriggerEventId() == EVENT_GAME_TIMER_EXPIRED then
        set u = null
        set p = null
        set g = null
        set command = ""
        call ReleaseTimer(GetExpiredTimer())
        call DisableTrigger(GetTriggeringTrigger())
        call DestroyTrigger(GetTriggeringTrigger())
        return
    endif
    set k = 0
    loop
    exitwhen k > 6
        if UnitItemInSlot(udg_PlayerHeroes[pid], k) != null then
            call DisplayTextToPlayer(p, 0, 0, "This order is not allowed after buying the item")
            set u = null
            set p = null
            set g = null
            set command = ""
            return
        endif
        set k = k + 1
    endloop
    if IsPlayerInForce(p, udg_TeamA) then
        set j = S2I(SubString(command, 6, 7)) - 1
    elseif IsPlayerInForce(p, udg_TeamB) then
        set j = S2I(SubString(command, 6, 7)) + 4
    endif
    set g = GetSortedPlayer(j)
    set i = GetSortedPlayerId(p)
    set m = i * 10 + j
    set n = j * 10 + i
    if udg_Swap[n] then
        set j = GetPlayerId(g)
        set ox = GetUnitX(udg_PlayerHeroes[pid])
        set oy = GetUnitY(udg_PlayerHeroes[pid])
        set tx = GetUnitX(udg_PlayerHeroes[j])
        set ty = GetUnitY(udg_PlayerHeroes[j])
        call SetUnitOwner(udg_PlayerHeroes[pid], g, true)
        call SetUnitXY(udg_PlayerHeroes[pid], tx, ty)
        set udg_PlayerHeroList[j] = udg_PlayerHeroList[pid]
        call SetUnitOwner(udg_PlayerHeroes[j], p, true)
        call SetUnitXY(udg_PlayerHeroes[j], ox, oy)
        set u = udg_PlayerHeroes[pid]
        set h = udg_PlayerHeroList[pid]
        set udg_PlayerHeroes[pid] = udg_PlayerHeroes[j]
        set udg_PlayerHeroList[pid] = udg_PlayerHeroList[j]
        set udg_PlayerHeroes[j] = u
        set udg_PlayerHeroList[j] = h
        call SetPlayerName(p, udg_OriginalPlayerName[pid])
        set udg_PlayerName[pid] = udg_PlayerColors[pid] + GetPlayerName(p) + "|r"
        call SetPlayerName(p, GetPlayerName(p) + " " + "(" + GetHeroProperName(udg_PlayerHeroes[pid]) + ")")
        set udg_PN[pid] = udg_PlayerColors[pid] + GetPlayerName(p) + "|r"
        call TriggerExecute(udg_HeroInit[udg_PlayerHeroList[pid]])
        call SetPlayerName(g, udg_OriginalPlayerName[j])
        set udg_PlayerName[j] = udg_PlayerColors[j] + GetPlayerName(g) + "|r"
        call SetPlayerName(g, GetPlayerName(g) + " " + "(" + GetHeroProperName(udg_PlayerHeroes[j]) + ")")
        set udg_PN[j] = udg_PlayerColors[j] + GetPlayerName(g) + "|r"
        call TriggerExecute(udg_HeroInit[udg_PlayerHeroList[j]])
        call TriggerExecute(gg_trg_Setup_Game_Info_Board)
    else
        call DisplayTextToPlayer(g, 0, 0, udg_PN[GetPlayerId(p)] + " wants to swap with your girl")
        set udg_Swap[m] = true
    endif
    set u = null
    set p = null
    set g = null
    set command = ""
endfunction

function CSS2_CreateHeroes takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local integer i
    local integer h
    if udg_UtopianFlag then
        set udg_Repick = true
    endif
    set i = 0
    loop
    exitwhen i > 10
        set h = udg_HeroType[udg_PlayerHeroList[i]]
        if (udg_GameMode - udg_GameMode / 100 * 100) / 10 == 6 then
            if IsPlayerAlly(Player(i), udg_PlayerA[0]) then
                set udg_PlayerHeroes[i] = CreateUnitAtLoc(udg_PlayerA[0], h, udg_BackStage, 0)
            else
                set udg_PlayerHeroes[i] = CreateUnitAtLoc(udg_PlayerB[0], h, udg_BackStage, 0)
            endif
            call PauseUnit(udg_PlayerHeroes[i], true)
            call SaveInteger(udg_cssht, GetHandleId(udg_PlayerHeroes[i]), 0, udg_PlayerHeroList[i])
        else
            set h = CSS2_ChangeCloth(i)
            set udg_PlayerHeroes[i] = CreateUnitAtLoc(Player(i), h, udg_BackStage, 0)
            call PauseUnit(udg_PlayerHeroes[i], true)
            call TriggerExecute(udg_HeroInit[udg_PlayerHeroList[i]])
        endif
        set i = i + 1
        if i == 5 then
            set i = 6
        endif
    endloop
    call ReleaseTimer(t)
    set t = null
endfunction

function CSS2_ExitCamera takes nothing returns nothing
    if IsPlayerInForce(GetLocalPlayer(), udg_TeamA) or GetLocalPlayer() == udg_PlayerA[0] then
        call PanCameraToTimed(GetRectCenterX(gg_rct_BirthA), GetRectCenterY(gg_rct_BirthA), 0.0)
    elseif IsPlayerInForce(GetLocalPlayer(), udg_TeamB) or GetLocalPlayer() == udg_PlayerB[0] then
        call PanCameraToTimed(GetRectCenterX(gg_rct_BirthB), GetRectCenterY(gg_rct_BirthB), 0.0)
    else
        call PanCameraToTimed(GetRectCenterX(gg_rct_CommonArea), GetRectCenterY(gg_rct_CommonArea), 0.0)
    endif
endfunction

function CSS2_ExitStage2 takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit u = LoadUnitHandle(udg_cssht, task, 0)
    local timerdialog w = LoadTimerDialogHandle(udg_cssht, task, 1)
    local timer tm = LoadTimerHandle(udg_cssht, task, 2)
    local integer i = 0
    local trigger trg
    local trigger trg2
    call RemoveUnit(u)
    call DestroyTimerDialog(w)
    call ReleaseTimer(tm)
    call SetCameraBounds(GetRectMinX(udg_MapRegion), GetRectMinY(udg_MapRegion), GetRectMinX(udg_MapRegion), GetRectMaxY(udg_MapRegion), GetRectMaxX(udg_MapRegion), GetRectMaxY(udg_MapRegion), GetRectMaxX(udg_MapRegion), GetRectMinY(udg_MapRegion))
    call SetCameraField(CAMERA_FIELD_TARGET_DISTANCE, 3800.0, 0)
    call SetCameraField(CAMERA_FIELD_FARZ, 5000.0, 0)
    call SetCameraField(CAMERA_FIELD_FIELD_OF_VIEW, 70.0, 0)
    call ResetToGameCamera(3)
    if (udg_GameMode - udg_GameMode / 100 * 100) / 10 == 6 then
        call MultiboardClear(udg_BanPickBoard)
        call DestroyMultiboard(udg_BanPickBoard)
        call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "Now players are invited to choose their own characters")
        loop
        exitwhen i > 4
            call SetUnitPosition(udg_PlayerHeroes[i], GetLocationX(udg_BirthPoint[0]) - 100 + i * 100, GetLocationY(udg_BirthPoint[0]))
            call UnitAddAbility(udg_PlayerHeroes[i], 'Asud')
            call UnitAddAbility(udg_PlayerHeroes[i], 'Aall')
            call AddUnitToStock(udg_PlayerHeroes[i], 'n00D', 1, 1)
            call UnitMakeAbilityPermanent(udg_PlayerHeroes[i], true, 'Asud')
            call UnitMakeAbilityPermanent(udg_PlayerHeroes[i], true, 'Aall')
            call UnitModifySkillPoints(udg_PlayerHeroes[i], -1)
            call PauseUnit(udg_PlayerHeroes[i], false)
            set udg_PlayerHeroesBan[i] = udg_PlayerHeroes[i]
            set udg_PlayerHeroes[i] = null
            call SetUnitPosition(udg_PlayerHeroes[i + 6], GetLocationX(udg_BirthPoint[1]) - 200 + i * 100, GetLocationY(udg_BirthPoint[1]))
            call UnitAddAbility(udg_PlayerHeroes[i + 6], 'Asud')
            call UnitAddAbility(udg_PlayerHeroes[i + 6], 'Aall')
            call AddUnitToStock(udg_PlayerHeroes[i + 6], 'n00D', 1, 1)
            call UnitMakeAbilityPermanent(udg_PlayerHeroes[i + 6], true, 'Asud')
            call UnitMakeAbilityPermanent(udg_PlayerHeroes[i + 6], true, 'Aall')
            call UnitModifySkillPoints(udg_PlayerHeroes[i + 6], -1)
            call PauseUnit(udg_PlayerHeroes[i + 6], false)
            set udg_PlayerHeroesBan[i + 6] = udg_PlayerHeroes[i + 6]
            set udg_PlayerHeroes[i + 6] = null
            set i = i + 1
        endloop
        call CSS2_DestroyCSS()
    else
        if udg_Repick then
            set trg = CreateTrigger()
            call TriggerRegisterTimerEvent(trg, 90.0, false)
            call TriggerAddAction(trg, function CSS2_Repick)
            set trg2 = CreateTrigger()
            call TriggerRegisterTimerEvent(trg2, 90.0, false)
            call TriggerAddAction(trg2, function CSS2_Swap)
            call SaveBoolean(udg_cssht, StringHash("CSS2"), 5, false)
        endif
        loop
        exitwhen i > 10
            if GetPlayerSlotState(Player(i)) == PLAYER_SLOT_STATE_PLAYING then
                if udg_Repick then
                    call TriggerRegisterPlayerChatEvent(trg, Player(i), "-repick", true)
                    call TriggerRegisterPlayerChatEvent(trg2, Player(i), "-swap", false)
                endif
                if IsPlayerInForce(Player(i), udg_TeamA) then
                    call SetUnitPositionLoc(udg_PlayerHeroes[i], udg_BirthPoint[0])
                    call PauseUnit(udg_PlayerHeroes[i], false)
                elseif IsPlayerInForce(Player(i), udg_TeamB) then
                    call SetUnitPositionLoc(udg_PlayerHeroes[i], udg_BirthPoint[1])
                    call PauseUnit(udg_PlayerHeroes[i], false)
                endif
                if udg_GameMode / 100 == 3 or udg_NewMid then
                    call SetHeroLevel(udg_PlayerHeroes[i], 4, true)
                    call SetPlayerState(Player(i), PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(Player(i), PLAYER_STATE_RESOURCE_GOLD) + 900)
                endif
                call SetUnitUserData(udg_PlayerHeroes[i], 0)
                set udg_OriginalPlayerName[i] = GetPlayerName(Player(i))
                call TriggerRegisterUnitEvent(gg_trg_CE_Input, udg_PlayerHeroes[i], EVENT_UNIT_DAMAGED)
            endif
            set i = i + 1
            if i == 5 then
                set i = 6
            endif
        endloop
        set i = 1
        loop
            set udg_PlayerName[GetPlayerId(udg_PlayerA[i])] = udg_PlayerColors[i - 1] + GetPlayerName(udg_PlayerA[i]) + "|r"
            set udg_PlayerName[GetPlayerId(udg_PlayerB[i])] = udg_PlayerColors[i + 5] + GetPlayerName(udg_PlayerB[i]) + "|r"
            call SetPlayerName(udg_PlayerA[i], GetPlayerName(udg_PlayerA[i]) + " " + "(" + GetHeroProperName(udg_PlayerHeroes[GetPlayerId(udg_PlayerA[i])]) + ")")
            call SetPlayerName(udg_PlayerB[i], GetPlayerName(udg_PlayerB[i]) + " " + "(" + GetHeroProperName(udg_PlayerHeroes[GetPlayerId(udg_PlayerB[i])]) + ")")
            set udg_PN[GetPlayerId(udg_PlayerA[i])] = udg_PlayerColors[i - 1] + GetPlayerName(udg_PlayerA[i]) + "|r"
            set udg_PN[GetPlayerId(udg_PlayerB[i])] = udg_PlayerColors[i + 5] + GetPlayerName(udg_PlayerB[i]) + "|r"
            call SetPlayerColor(udg_PlayerA[i], ConvertPlayerColor(i - 1))
            call SetPlayerColor(udg_PlayerB[i], ConvertPlayerColor(i + 5))
            set i = i + 1
        exitwhen i == 6
        endloop
        call DisableTrigger(gg_trg_CSS_Ban_Pick)
        call DestroyTrigger(gg_trg_CSS_Ban_Pick)
        if not udg_Repick and not (udg_GameMode / 100 == 4) then
            call CSS2_DestroyCSS()
        endif
    endif
    if IsPlayerInForce(GetLocalPlayer(), udg_TeamA) or GetLocalPlayer() == udg_PlayerA[0] then
        call PanCameraToTimed(GetRectCenterX(gg_rct_BirthA), GetRectCenterY(gg_rct_BirthA), 0.0)
    elseif IsPlayerInForce(GetLocalPlayer(), udg_TeamB) or GetLocalPlayer() == udg_PlayerB[0] then
        call PanCameraToTimed(GetRectCenterX(gg_rct_BirthB), GetRectCenterY(gg_rct_BirthB), 0.0)
    else
        call PanCameraToTimed(GetRectCenterX(gg_rct_CommonArea), GetRectCenterY(gg_rct_CommonArea), 0.0)
    endif
    call FogMaskEnable(true)
    call FogEnable(true)
    call TriggerEvaluate(gg_trg_Game_Start)
    call FlushChildHashtable(udg_cssht, task)
    call ReleaseTimer(t)
    call SetDoodadAnimation(-1297.0, -2656.8, 500.0, 'D00A', false, "show", false)
    set t = null
    set u = null
    set tm = null
    set w = null
    set trg = null
endfunction

function CSS2_EndHeroSelection takes nothing returns nothing
    local integer i = 0
    local integer ii = 0
    local integer h
    local integer j = 1
    local integer task = 0
    loop
    exitwhen i > 10
        if udg_PlayerHeroList[i] <= 0 and IsPlayerInForce(Player(i), udg_OnlinePlayers) then
            set udg_RandomPicked[i] = true
            call CSS2_SelectCharacterForPlayer(Player(i), CSS2_GetRandomCharacter(), false, false)
        endif
        if udg_PlayerHeroList[i] != 0 then
            loop
            exitwhen ii > 10
                if i != ii and udg_PlayerHeroList[i] == udg_PlayerHeroList[ii] and LoadBoolean(udg_cssht, GetHandleId(Player(ii)), 1) then
                    call CSS2_SelectCharacterForPlayer(Player(i), CSS2_GetRandomCharacter(), false, false)
                endif
                set ii = ii + 1
                if ii == 5 then
                    set ii = 6
                endif
            endloop
        endif
        set ii = 0
        if IsPlayerInForce(Player(i), udg_OnlinePlayers) and not LoadBoolean(udg_cssht, GetHandleId(Player(i)), 1) then
            call CSS2_SetPlayerPrepared(Player(i))
        endif
        set i = i + 1
        if i == 5 then
            set i = 6
        endif
    endloop
    set i = 0
    loop
        call DebugMsg("Cloth Data Info" + I2S(i) + " : " + I2S(udg_HeroClothChangeToB[i]))
        set i = i + 1
    exitwhen i > 12
    endloop
    if udg_UtopianFlag then
        set udg_Repick = true
    endif
    set i = 0
    loop
    exitwhen i > 10
        set h = CSS2_ChangeCloth(i)
        if (udg_GameMode - udg_GameMode / 100 * 100) / 10 == 6 then
            if IsPlayerAlly(Player(i), udg_PlayerA[0]) then
                set udg_PlayerHeroes[i] = CreateUnitAtLoc(udg_PlayerA[0], h, udg_BackStage, 0)
            else
                set udg_PlayerHeroes[i] = CreateUnitAtLoc(udg_PlayerB[0], h, udg_BackStage, 0)
            endif
            call PauseUnit(udg_PlayerHeroes[i], true)
            call SaveInteger(udg_ht, GetHandleId(udg_PlayerHeroes[i]), 0, udg_PlayerHeroList[i])
        else
            set h = CSS2_ChangeCloth(i)
            set udg_PlayerHeroes[i] = CreateUnitAtLoc(Player(i), h, udg_BackStage, 0)
            call PauseUnit(udg_PlayerHeroes[i], true)
            if udg_RandomPicked[i] then
                set j = GetRandomInt(1, 3)
                if j == 1 then
                    set j = 'I00F'
                elseif j == 2 then
                    set j = 'I00L'
                else
                    set j = 'I029'
                endif
                set bj_lastCreatedItem = CreateItem(j, GetUnitX(udg_PlayerHeroes[i]), GetUnitY(udg_PlayerHeroes[i]))
                call SetItemPlayer(bj_lastCreatedItem, Player(i), false)
                call UnitAddItem(udg_PlayerHeroes[i], bj_lastCreatedItem)
            endif
            call TriggerExecute(udg_HeroInit[udg_PlayerHeroList[i]])
            set udg_PlayerCharacterString[i] = GetCharacterString(h)
            call InitPlayerHero(GetCharacterHandle(h))
            if udg_PlayerHeroes[i] != null then
                set task = GetCharacterIndex(udg_PlayerHeroes[i])
                call s__soundresponse_create(udg_PlayerHeroes[i])
                call s__soundresponse_register(task, 0, "THDots\\music\\"+GetCharacterString(h)+"Reborn0.0mp3")
                call s__soundresponse_register(task, 1, "THDots\\music\\"+GetCharacterString(h)+"Pissed1.0mp3")
                call s__soundresponse_register(task, 2, "THDots\\music\\"+GetCharacterString(h)+"Pissed2.0mp3")
                call s__soundresponse_register(task, 3, "THDots\\music\\"+GetCharacterString(h)+"What1.0mp3")
                call s__soundresponse_register(task, 4, "THDots\\music\\"+GetCharacterString(h)+"What2.0mp3")
                call s__soundresponse_register(task, 5, "THDots\\music\\"+GetCharacterString(h)+"What3.0mp3")
                call s__soundresponse_register(task, 6, "THDots\\music\\"+GetCharacterString(h)+"What4.0mp3")
                call s__soundresponse_register(task, 7, "THDots\\music\\"+GetCharacterString(h)+"Yes1.0mp3")
                call s__soundresponse_register(task, 8, "THDots\\music\\"+GetCharacterString(h)+"Yes2.0mp3")
                call s__soundresponse_register(task, 9, "THDots\\music\\"+GetCharacterString(h)+"Yes3.0mp3")
                call s__soundresponse_register(task, 10, "THDots\\music\\"+GetCharacterString(h)+"Yes4.0mp3")
                call s__soundresponse_register(task, 11, "THDots\\music\\"+GetCharacterString(h)+"YesAttack1.0mp3")
                call s__soundresponse_register(task, 12, "THDots\\music\\"+GetCharacterString(h)+"YesAttack2.0mp3")
                call s__soundresponse_register(task, 13, "THDots\\music\\"+GetCharacterString(h)+"YesAttack3.0mp3")
                call s__soundresponse_register(task, 14, "THDots\\music\\"+GetCharacterString(h)+"YesAttack4.0mp3")
                call s__soundresponse_register(task, 15, "THDots\\music\\"+GetCharacterString(h)+"Warcry1.0mp3")
                call s__soundresponse_register(task, 16, "THDots\\music\\"+GetCharacterString(h)+"Death0.0mp3")
                call s__soundresponse_play(task, 0)
                call DebugMsg("After the sound effects are initialized, players begin to choose their own characters")
                call DebugMsg("THDots\\music\\"+GetCharacterString(h)+"Death0.0mp3")
            endif
        endif
        if GetPlayerId(GetLocalPlayer()) == i then
            call SelectUnit(udg_PlayerHeroes[i], true)
        endif
        if GetPlayerSlotState(Player(i)) == PLAYER_SLOT_STATE_EMPTY then
            call RemoveUnit(udg_PlayerReviveHouse[i])
        else
            call UnitRemoveAbility(udg_PlayerReviveHouse[i], 'Aral')
            call UnitRemoveAbility(udg_PlayerReviveHouse[i], 'ARal')
            call UnitRemoveAbility(udg_PlayerReviveHouse[i], 'Amov')
            call SuspendHeroXP(udg_PlayerReviveHouse[i], true)
            call TriggerRegisterUnitEvent(gg_trg_WeatherTimeChange, udg_PlayerReviveHouse[i], EVENT_UNIT_SPELL_EFFECT)
            if i < 5 then
                call UnitAddAbility(udg_PlayerReviveHouse[i], 'A01C')
            else
                call UnitAddAbility(udg_PlayerReviveHouse[i], 'A01D')
            endif
            call SetUnitOwner(udg_PlayerReviveHouse[i], Player(i), true)
        endif
        set i = i + 1
        if i == 5 then
            set i = 6
        endif
    endloop
    if udg_UtopianFlag then
        set udg_Repick = false
    endif
    call DisableTrigger(gg_trg_OB_Mode)
    call DestroyTrigger(gg_trg_OB_Mode)
endfunction

function CSS2_End takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local timerdialog w = LoadTimerDialogHandle(udg_cssht, task, 0)
    call DestroyTimerDialog(w)
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_cssht, task)
    call SaveBoolean(udg_cssht, StringHash("CSS2"), 2, true)
    set t = null
    set w = null
endfunction

function CSS2_EndBanStage takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local timerdialog w = LoadTimerDialogHandle(udg_cssht, task, 0)
    local integer i = 0
    local destructable d1
    loop
    exitwhen i > 10
        if GetPlayerSlotState(Player(i)) == PLAYER_SLOT_STATE_PLAYING then
            call CSS2_SelectCharacterForPlayer(Player(i), -1 + i * -1, true, false)
        endif
        set i = i + 1
        if i == 5 then
            set i = 6
        endif
    endloop
    call TimerDialogSetTitle(w, "Character selection")
    call SaveBoolean(udg_cssht, StringHash("CSS2"), 4, false)
    call TimerStart(t, 45.0, false, function CSS2_End)
    set w = null
    set t = null
    set d1 = null
endfunction

function CSS2_MainTimer takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local timer tm = LoadTimerHandle(udg_cssht, task, 3)
    local timer t2
    local timerdialog w = LoadTimerDialogHandle(udg_cssht, task, 4)
    local timerdialog u = LoadTimerDialogHandle(udg_cssht, task, 6)
    local timerdialog v = LoadTimerDialogHandle(udg_cssht, task, 2)
    local integer tick = LoadInteger(udg_cssht, task, 0)
    local integer i = 0
    call SetCameraField(CAMERA_FIELD_ROTATION, 90.0, 0.0)
    call SetCameraField(CAMERA_FIELD_ANGLE_OF_ATTACK, 270.0, 0.0)
    call SetCameraField(CAMERA_FIELD_ROLL, 0.0, 0.0)
    call SetCameraField(CAMERA_FIELD_TARGET_DISTANCE, 1800.0, 0.0)
    call SetCameraField(CAMERA_FIELD_FARZ, 5000.0, 0.0)
    call SetCameraField(CAMERA_FIELD_FIELD_OF_VIEW, 70.0, 0.0)
    if LoadInteger(udg_cssht, StringHash("PreparedPlayerSum"), 0) >= udg_OnlinePlayerSum then
        if not IsTimerDialogDisplayed(u) then
            call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "The game is loading information, you may experience a slight delay.")
            call CSS2_EndHeroSelection()
            set tick = -1
            call SaveInteger(udg_cssht, task, 0, tick)
            call ReleaseTimer(tm)
            call DestroyTimerDialog(w)
            set t2 = LoadTimerHandle(udg_cssht, task, 5)
            call TimerDialogDisplay(u, true)
            set task = GetHandleId(t2)
            call SaveTimerDialogHandle(udg_cssht, task, 1, u)
            call SaveTimerHandle(udg_cssht, task, 2, t)
            call TimerStart(t2, 5.0, false, function CSS2_ExitStage2)
        endif
    elseif LoadBoolean(udg_cssht, StringHash("CSS2"), 2) then
        call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "The game is loading information, you may experience a slight delay.")
        call SaveBoolean(udg_cssht, StringHash("CSS2"), 2, false)
        call ReleaseTimer(tm)
        call DestroyTimerDialog(w)
        call CSS2_EndHeroSelection()
        call ForForce(udg_AI_Players, function CSS2_AIPlayerSelect)
        set tick = -1
        call SaveInteger(udg_cssht, task, 0, tick)
        set t2 = LoadTimerHandle(udg_cssht, task, 5)
        call TimerDialogDisplay(u, true)
        set task = GetHandleId(t2)
        call SaveTimerDialogHandle(udg_cssht, task, 1, u)
        call SaveTimerHandle(udg_cssht, task, 2, t)
        call TimerStart(t2, 7.0, false, function CSS2_ExitStage2)
    elseif udg_CSS2_BanTotal == udg_OnlinePlayerSum then
        set udg_CSS2_BanTotal = udg_CSS2_BanTotal + 1
        call TimerStart(tm, 0.0, false, function CSS2_EndBanStage)
    endif
    set i = (udg_GameMode - udg_GameMode / 100 * 100) / 10
    if LoadInteger(udg_cssht, StringHash("CSS2"), 1) > 0 and tick == 50 and IsTimerDialogDisplayed(w) and i < 4 or i > 6 then
        call ForForce(udg_AI_Players, function CSS2_AIPlayerSelect)
    endif
    if tick > 0 then
        if tick < 50 then
            set tick = tick + 1
        elseif tick == 50 then
            set tick = 1
        endif
        call SaveInteger(udg_cssht, task, 0, tick)
    endif
    set t = null
    set tm = null
    set t2 = null
    set w = null
    set v = null
    set u = null
endfunction

function CSS2_ShufflePlayers takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local integer ttask
    local timerdialog w
    local boolean b = LoadBoolean(udg_cssht, task, 2)
    local integer i
    local player p
    if b then
        call DisableTrigger(gg_trg_Alliance_Setting)
        call DestroyTrigger(gg_trg_Alliance_Setting)
        call DisableTrigger(gg_trg_Alliance_Rejection)
        call DestroyTrigger(gg_trg_Alliance_Rejection)
        set w = LoadTimerDialogHandle(udg_cssht, task, 1)
        call DestroyTimerDialog(w)
        call Trig_Shuffle_Players_Actions()
        call TimerStart(t, 1.0, false, function CSS2_ShufflePlayers)
        call SaveBoolean(udg_cssht, task, 2, false)
    else
        call ReleaseTimer(t)
        set ttask = LoadInteger(udg_cssht, task, 0)
        set t = LoadTimerHandle(udg_cssht, ttask, 3)
        set w = LoadTimerDialogHandle(udg_cssht, ttask, 4)
        call TimerDialogDisplay(w, true)
        call SaveBoolean(udg_cssht, StringHash("CSS2"), 3, false)
        if (udg_GameMode - udg_GameMode / 100 * 100) / 10 == 3 then
            call TimerDialogSetTitle(w, "Character ban")
            call SaveBoolean(udg_cssht, StringHash("CSS2"), 4, true)
            call TimerStart(t, 60.0, false, function CSS2_EndBanStage)
        elseif (udg_GameMode - udg_GameMode / 100 * 100) / 10 == 4 or (udg_GameMode - udg_GameMode / 100 * 100) / 10 == 5 then
            call CSS2_SetupDraftMode()
            call SaveTimerHandle(udg_cssht, StringHash("BanDraftTimer"), 0, t)
            call CSS2_DraftModeUpdateStatus()
            call TimerStart(t, 20.0, false, function CSS2_BanDraftModeTimeOut)
        elseif (udg_GameMode - udg_GameMode / 100 * 100) / 10 == 6 then
            call CSS2_SetupBanMode()
            call CSS2_Setup_BanPick_Board()
            call SaveTimerHandle(udg_cssht, StringHash("BanDraftTimer"), 0, t)
            call CSS2_BanModeUpdateStatus()
            call TimerStart(t, 60.0, false, function CSS2_BanDraftModeTimeOut)
        elseif (udg_GameMode - udg_GameMode / 100 * 100) / 10 == 7 then
            set i = 0
            loop
            exitwhen i > 9
                set p = GetSortedPlayer(i)
                if GetPlayerSlotState(p) == PLAYER_SLOT_STATE_PLAYING then
                    call CSS2_SelectCharacterForPlayer(p, CSS2_GetRandomCharacter(), false, false)
                    call CSS2_SetPlayerPrepared(p)
                endif
                set i = i + 1
            endloop
            call TimerStart(t, 2.0, false, function CSS2_End)
        else
            call TimerStart(t, 45.0, false, function CSS2_End)
        endif
        call CountPlayer()
        call FlushChildHashtable(udg_cssht, task)
    endif
    set p = null
    set w = null
    set t = null
endfunction

function CSS2_Setup takes nothing returns boolean
    local real x = GetRectCenterX(gg_rct_PlayerCSS_A5)
    local real y = GetRectCenterY(gg_rct_PlayerCSS_A5)
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local real z = 762
    local real tx
    local real ty
    local trigger trg
    local integer i = 0
    local integer j = 0
    local destructable d
    local unit u = CreateUnit(Player(13), 'n003', x, y, 0.0)
    local timer t2 = CreateTimer()
    local integer task2 = GetHandleId(t2)
    local timerdialog w
    local integer ainum = CountPlayersInForceBJ(udg_AI_Players)
    local player p
    call SetDoodadAnimation(-1297.0, -2656.8, 500.0, 'D00A', false, "hide", false)
    call SaveInteger(udg_cssht, StringHash("CSS2"), 1, ainum)
    call SaveBoolean(udg_cssht, StringHash("CSS2"), 2, false)
    call FogMaskEnable(false)
    call FogEnable(false)
    call SetCameraBounds(GetRectMinX(gg_rct_PlayerCSS_A5), GetRectMinY(gg_rct_PlayerCSS_A5), GetRectMinX(gg_rct_PlayerCSS_A5), GetRectMaxY(gg_rct_PlayerCSS_A5), GetRectMaxX(gg_rct_PlayerCSS_A5), GetRectMaxY(gg_rct_PlayerCSS_A5), GetRectMaxX(gg_rct_PlayerCSS_A5), GetRectMinY(gg_rct_PlayerCSS_A5))
    call SetCameraTargetController(u, 0.0, 0.0, false)
    call SetCameraField(CAMERA_FIELD_ROTATION, 90.0, 0)
    call SetCameraField(CAMERA_FIELD_ANGLE_OF_ATTACK, 270.0, 0)
    call SetCameraField(CAMERA_FIELD_ROLL, 0.0, 0)
    call SetCameraField(CAMERA_FIELD_TARGET_DISTANCE, 1800.0, 0)
    call SetCameraField(CAMERA_FIELD_FARZ, 5000.0, 0)
    call SetCameraField(CAMERA_FIELD_FIELD_OF_VIEW, 70.0, 0)
    set w = CreateTimerDialog(t2)
    call TimerDialogSetTitle(w, "Game mode selection")
    call TimerDialogDisplay(w, false)
    call SaveTimerHandle(udg_cssht, task, 1, t2)
    call SaveTimerDialogHandle(udg_cssht, task, 2, w)
    set t2 = CreateTimer()
    set w = CreateTimerDialog(t2)
    call TimerDialogSetTitle(w, "Game starts in:")
    call TimerDialogDisplay(w, false)
    call SaveUnitHandle(udg_cssht, GetHandleId(t2), 0, u)
    call SaveTimerHandle(udg_cssht, task, 5, t2)
    call SaveTimerDialogHandle(udg_cssht, task, 6, w)
    set t2 = CreateTimer()
    set task2 = GetHandleId(t2)
    set w = CreateTimerDialog(t2)
    call TimerDialogSetTitle(w, "Character selection")
    call TimerDialogDisplay(w, false)
    call SaveTimerDialogHandle(udg_cssht, GetHandleId(t2), 0, w)
    call SaveTimerHandle(udg_cssht, task, 3, t2)
    call SaveTimerDialogHandle(udg_cssht, task, 4, w)
    if udg_GameMode - udg_GameMode / 10 * 10 == 2 then
        call DisplayTextToForce(GetPlayersAll(), "\n\n|cff8080ffShuffle mode is activated. Players are randomly assigned to different teams after the countdown ends. \nenter -cp # to team up with the specified player\nenter -sin and you will not be invited by the team|r")
        call EnableTrigger(gg_trg_Alliance_Setting)
        call EnableTrigger(gg_trg_Alliance_Rejection)
        set t2 = LoadTimerHandle(udg_cssht, task, 1)
        set w = LoadTimerDialogHandle(udg_cssht, task, 2)
        set task2 = GetHandleId(t2)
        call SaveInteger(udg_cssht, task2, 0, task)
        call SaveTimerDialogHandle(udg_cssht, task2, 1, w)
        call SaveBoolean(udg_cssht, StringHash("CSS2"), 3, true)
        call SaveBoolean(udg_cssht, task2, 2, true)
        call TimerStart(t2, 25.0, false, function CSS2_ShufflePlayers)
    elseif (udg_GameMode - udg_GameMode / 100 * 100) / 10 == 3 then
        call TimerDialogSetTitle(w, "Character ban")
        call SaveBoolean(udg_cssht, StringHash("CSS2"), 4, true)
        call TimerStart(t2, 60.0, false, function CSS2_EndBanStage)
    elseif (udg_GameMode - udg_GameMode / 100 * 100) / 10 == 4 or (udg_GameMode - udg_GameMode / 100 * 100) / 10 == 5 then
        call CSS2_SetupDraftMode()
        call SaveBoolean(udg_cssht, StringHash("CSS2"), 5, true)
        call SaveTimerHandle(udg_cssht, StringHash("BanDraftTimer"), 0, t2)
        call CSS2_DraftModeUpdateStatus()
        call TimerStart(t2, 20.0, false, function CSS2_BanDraftModeTimeOut)
    elseif (udg_GameMode - udg_GameMode / 100 * 100) / 10 == 6 then
        call CSS2_SetupBanMode()
        call CSS2_Setup_BanPick_Board()
        call SaveTimerHandle(udg_cssht, StringHash("BanDraftTimer"), 0, t2)
        call CSS2_BanModeUpdateStatus()
        call TimerStart(t2, 60.0, false, function CSS2_BanDraftModeTimeOut)
    else
        call TimerStart(t2, 45.0, false, function CSS2_End)
    endif
    call TimerDialogDisplay(w, true)
    call SaveInteger(udg_cssht, task, 0, 1)
    call TimerStart(t, 0.02, true, function CSS2_MainTimer)
    call CreateDeadDestructableZ('B00G', x + 32.0, y - 128.0, -1500, 40.0, 1.0, 0)
    set trg = CreateTrigger()
    call TriggerAddCondition(trg, Condition(function CSS2_OnClick))
    call SaveTriggerHandle(udg_cssht, StringHash("CSS2"), 0, trg)
    set i = 1
    loop
    exitwhen i > udg_HeroType[0]
        set tx = x - 230.0 - 128.0 * (i - 1 - (i - 1) / 6 * 6)
        set ty = y + 384.0 - 128.0 * ((i - 1) / 6)
        call CreateDestructableZ(udg_HeroButton[i], tx, ty, z - 5.0, 180.0, 1.0, 0)
        call CSS2_CreateIconOverlay(trg, "HitBoxRed.MDX", tx, ty, i, true)
        call SaveBoolean(udg_cssht, StringHash("HeroAvailability"), i, true)
        set i = i + 1
    endloop
    set i = 1
    loop
    exitwhen i > udg_HeroType[100]
        set tx = x + 230.0 + 128.0 * (i - 1 - (i - 1) / 6 * 6)
        set ty = y + 384.0 - 128.0 * ((i - 1) / 6)
        call CreateDestructableZ(udg_HeroButton[i + 100], tx, ty, z - 5.0, 180.0, 1.0, 0)
        call CSS2_CreateIconOverlay(trg, "HitBoxGreen.MDX", tx, ty, i + 100, true)
        call SaveBoolean(udg_cssht, StringHash("HeroAvailability"), i + 100, true)
        set i = i + 1
    endloop
    set ty = y + 384.0
    call CreateDestructableZ('B00D', x, ty, z - 5.0, 180.0, 1.0, 0)
    call CSS2_CreateIconOverlay(trg, "HitBoxYellow.MDX", x, ty, 0, true)
    set tx = x
    set ty = y - 475.0
    call CreateDestructableZ('B001', tx, ty, z, 180.0, 1.0, 0)
    call CreateDestructableZ('B009', tx, ty, z - 10.0, 180.0, 1.25, 0)
    call CSS2_CreateIconOverlay(trg, "HitBoxHidden.MDX", tx, ty, 100, true)
    set i = 0
    loop
        if i <= 4 then
            set tx = x - 80.0
            set ty = y + 200.0 - 128.0 * i
        else
            set tx = x + 80.0
            set ty = y + 200.0 - 128.0 * (i - 5)
        endif
        call CreateDestructableZ('B00B', tx, ty, z - 24.0, 180.0, 1.25, 0)
        call CSS2_CreateIconOverlay(trg, "4x4Trackable.MDX", tx, ty, 200 + i, false)
        set i = i + 1
    exitwhen i > 9
    endloop
    if (udg_GameMode - udg_GameMode / 100 * 100) / 10 == 2 or (udg_GameMode - udg_GameMode / 100 * 100) / 10 == 4 then
        set i = R2I((udg_HeroType[0] + udg_HeroType[100]) / 2)
        set j = 1
        loop
        exitwhen j == i
            call CSS2_BanCharacter(CSS2_GetRandomCharacter())
            set j = j + 1
        endloop
    endif
    if (udg_GameMode - udg_GameMode / 100 * 100) / 10 == 7 and udg_GameMode - udg_GameMode / 10 * 10 != 2 then
        set i = 0
        loop
        exitwhen i > 9
            set p = GetSortedPlayer(i)
            if GetPlayerSlotState(p) == PLAYER_SLOT_STATE_PLAYING then
                call CSS2_SelectCharacterForPlayer(p, CSS2_GetRandomCharacter(), false, false)
                call CSS2_SetPlayerPrepared(p)
            endif
            set i = i + 1
        endloop
    endif
    call DisplayTimedTextToPlayer(GetLocalPlayer(), 0, 0, 5, "Russian DotS community|cffff8091 thdots.ru")
    call DisplayTimedTextToPlayer(GetLocalPlayer(), 0, 0, 5, "This is currently a test version. If you encounter any bugs, please save the video and send it to the production team. Thank you.")
    set t = null
    set t2 = null
    set w = null
    set d = null
    set trg = null
    set u = null
    set p = null
    return false
endfunction

function InitTrig_CSS2_Beta takes nothing returns nothing
    set gg_trg_CSS2_Beta = CreateTrigger()
    call TriggerAddCondition(gg_trg_CSS2_Beta, Condition(function CSS2_Setup))
endfunction