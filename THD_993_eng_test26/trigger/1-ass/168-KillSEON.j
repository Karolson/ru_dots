function Trig_KillSEON_Actions takes nothing returns nothing
    if GetEventPlayerChatString() == "-seon" then
        set udg_SE_Stat[GetPlayerId(GetTriggerPlayer())] = true
        call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "\n killing sound effect on")
    else
        set udg_SE_Stat[GetPlayerId(GetTriggerPlayer())] = false
        call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "\n killing sound effect off")
    endif
endfunction

function InitTrig_KillSEON takes nothing returns nothing
    local integer i = 0
    set gg_trg_KillSEON = CreateTrigger()
    loop
    exitwhen i > 11
        if GetPlayerSlotState(Player(i)) == PLAYER_SLOT_STATE_PLAYING then
            call TriggerRegisterPlayerChatEvent(gg_trg_KillSEON, Player(i), "-seon", true)
            call TriggerRegisterPlayerChatEvent(gg_trg_KillSEON, Player(i), "-seoff", true)
        endif
        set i = i + 1
    endloop
    call TriggerAddAction(gg_trg_KillSEON, function Trig_KillSEON_Actions)
endfunction