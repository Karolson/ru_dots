function IsSinglePlayer takes nothing returns boolean
    local gamecache gc = null
    call FlushGameCache(InitGameCache("sptest.w3v"))
    set gc = InitGameCache("sptest.w3v")
    call DebugMsg("Testing for Single Player")
    call StoreInteger(gc, "s", "s", 1)
    return SaveGameCache(gc)
endfunction

function Trig_TEST_MODE_OPEN_Actions takes nothing returns nothing
    local unit u
    if GetEventPlayerChatString() == "/test" then
        if IsSinglePlayer() or GetTriggerPlayer() == Player(0) or (GetTriggerPlayer() == Player(6) and GetPlayerSlotState(Player(0)) == PLAYER_SLOT_STATE_EMPTY) then
            if not udg_TestMode then
                set udg_TestMode = true
                set udg_DebugMode = true
                call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|cFFFFFF00\r\n\r\nTEST mode is on\r\n/*#endtest#*/ = TEST mode is off\r\n/cd = refresh CD, full of blood and magic\r\n/fog = cancel fog\r\n/kill = suicide\r\n/up = all players upgrade one level\r\n/lvlup specified level = upgrade\r\n/tod specified time = change game day and night time")
                call DisableTrigger(GetTriggeringTrigger())
                set u = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE), 'ushd', 6685.0, -12974.0, bj_UNIT_FACING)
                call SetUnitColor(u, GetPlayerColor(Player(7)))
                set u = CreateUnit(udg_PlayerA[0], 'ushd', 6679.0, -13038.0, bj_UNIT_FACING)
                call SetUnitColor(u, GetPlayerColor(Player(7)))
                set u = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE), 'Ulic', 6700.0, -13000.0, bj_UNIT_FACING)
                call SetUnitColor(u, GetPlayerColor(Player(7)))
                set u = CreateUnit(udg_PlayerA[0], 'ULic', 6655.0, -13000.0, bj_UNIT_FACING)
                call SetUnitColor(u, GetPlayerColor(Player(7)))
            endif
        endif
    elseif GetEventPlayerChatString() == "/biubiubiu" and udg_UtopianFlag then
        if not udg_TestMode then
            set udg_TestMode = true
            set udg_DebugMode = true
            call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|cFFFFFF00\r\n\r\nTEST mode is on\r\n/*#endtest#*/ = TEST mode is off\r\n/cd = refresh CD, full of blood and magic\r\n/fog = cancel fog\r\n /kill = suicide\r\n/up = all players upgrade one level\r\n/lvlup specified level = upgrade\r\n/tod specified time = change game day and night time")
            call DisableTrigger(GetTriggeringTrigger())
            set u = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE), 'ushd', 6685.0, -12974.0, bj_UNIT_FACING)
            call SetUnitColor(u, GetPlayerColor(Player(7)))
            set u = CreateUnit(udg_PlayerA[0], 'ushd', 6679.0, -13038.0, bj_UNIT_FACING)
            call SetUnitColor(u, GetPlayerColor(Player(7)))
            set u = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE), 'Ulic', 6700.0, -13030.0, bj_UNIT_FACING)
            call SetUnitColor(u, GetPlayerColor(Player(7)))
            set u = CreateUnit(udg_PlayerA[0], 'ULic', 6655.0, -13000.0, bj_UNIT_FACING)
            call SetUnitColor(u, GetPlayerColor(Player(7)))
        endif
    endif
endfunction

function InitTrig_TEST_MODE_OPEN takes nothing returns nothing
    set gg_trg_TEST_MODE_OPEN = CreateTrigger()
    call TriggerAddAction(gg_trg_TEST_MODE_OPEN, function Trig_TEST_MODE_OPEN_Actions)
endfunction