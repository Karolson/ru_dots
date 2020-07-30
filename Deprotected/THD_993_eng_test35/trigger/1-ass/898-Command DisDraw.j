function Trig_Command_DisDraw_Actions takes nothing returns nothing
    local string msg
    local player ply = GetTriggerPlayer()
    local integer k = GetPlayerId(ply)
    if udg_GameDrawValue[k] then
        set msg = udg_PN[GetPlayerId(ply)] + "|cffffffff cancels draw vote|r"
        set udg_GameDrawValue[k] = false
        if IsPlayerInForce(ply, udg_TeamA) then
            set udg_GameSurrenderTeamValue[5] = udg_GameSurrenderTeamValue[5] - 1
            set msg = msg + "|cffffffff, Hakurei votes: " + I2S(udg_GameSurrenderTeamValue[5]) + "|r"
            call BroadcastMessage(msg)
        elseif IsPlayerInForce(ply, udg_TeamB) then
            set udg_GameSurrenderTeamValue[6] = udg_GameSurrenderTeamValue[6] - 1
            set msg = msg + "|cffffffff, Moriya votes: " + I2S(udg_GameSurrenderTeamValue[6]) + "|r"
            call BroadcastMessage(msg)
        endif
    endif
    set msg = null
    set ply = null
endfunction

function InitTrig_Command_DisDraw takes nothing returns nothing
    set gg_trg_Command_DisDraw = CreateTrigger()
    call TriggerRegisterPlayerChatEvent(gg_trg_Command_DisDraw, Player(0), "-disdr", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Command_DisDraw, Player(1), "-disdr", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Command_DisDraw, Player(2), "-disdr", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Command_DisDraw, Player(3), "-disdr", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Command_DisDraw, Player(4), "-disdr", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Command_DisDraw, Player(6), "-disdr", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Command_DisDraw, Player(7), "-disdr", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Command_DisDraw, Player(8), "-disdr", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Command_DisDraw, Player(9), "-disdr", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Command_DisDraw, Player(10), "-disdr", true)
    call TriggerAddAction(gg_trg_Command_DisDraw, function Trig_Command_DisDraw_Actions)
endfunction