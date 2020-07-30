function Announce_Msg3 takes nothing returns nothing
    call DisplayTimedTextToPlayer(GetLocalPlayer(), 0, 0, 5, "|cffffcc00For more information, please refer to our discord|r\nCurrently, the map is updated at a faster rate, so please pay attention to the latest version at any time.\nYou can also read the information in the quests section.")
    if udg_TestMode then
        call DisplayTimedTextToPlayer(GetLocalPlayer(), 0, 0, 30, "|cffffcc00The game is in test mode. You can use the following commands: |r\r\n/*#endtest#*/ = End test mode\r\n/cd = Refresh Cooldowns, HP and MP\r\n/fog = Remove fog of war\r\n/kill = Suicide\r\n/up = Level up\r\n/lvlup <number> Gain the specified amount of levels")
        call DisplayTimedTextToPlayer(GetLocalPlayer(), 0, 0, 30, "/tod <number> Change day and night to the specified time\r\n/tod+ time flies\r\n/gold <number> Get the specified amount of points\r\n/spirit <number> Get the specified amount of faith\r\n/start Advance game time to 0")
    endif
    call ReleaseTimer(GetExpiredTimer())
    call TriggerExecute(gg_trg_SoloMode)
endfunction

function Announce_Msg2 takes nothing returns nothing
    call DisplayTimedTextToPlayer(GetLocalPlayer(), 0, 0, 5, "Our website: |cffff8091 http://thdots.ru/ |r- Welcome to the DotS")
    call PauseTimer(GetExpiredTimer())
    call TimerStart(GetExpiredTimer(), 5.0, false, function Announce_Msg3)
endfunction

function Announce_Msg1 takes nothing returns nothing
    call FlashQuestDialogButton()
    call ClearTextMessages()
    call DisplayTimedTextToPlayer(GetLocalPlayer(), 0, 0, 5, "\nCool your blaze before the game")
    call TimerStart(CreateTimer(), 5.0, false, function Announce_Msg2)
endfunction

function InitTrig_Announce takes nothing returns nothing
endfunction