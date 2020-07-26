function Trig_Alliance_Rejection_Conditions takes nothing returns boolean
    local player p = GetTriggerPlayer()
    if GetEventPlayerChatString() == "-dissin" then
        set udg_AllianceSwitch[GetSortedPlayerId(p) * 11] = 0
        call DisplayTimedTextToPlayer(p, 0.0, 0.0, 2.0, "|cff8080ffSingle player mode has been cancelled|r")
        return false
    else
        return true
    endif
endfunction

function Trig_Alliance_Rejection_Actions takes nothing returns nothing
    local player p = GetTriggerPlayer()
    local integer j = GetSortedPlayerId(p)
    local integer n = 0
    local string array names
    local integer switch = 1
    set names[0] = GetPlayerName(Player(0)) + "(Hakurei slot 1)"
    set names[1] = GetPlayerName(Player(1)) + "(Hakurei slot 2)"
    set names[2] = GetPlayerName(Player(2)) + "(Hakurei slot 3)"
    set names[3] = GetPlayerName(Player(3)) + "(Hakurei slot 4)"
    set names[4] = GetPlayerName(Player(4)) + "(Hakurei slot 5)"
    set names[5] = GetPlayerName(Player(6)) + "(Moriya slot 1)"
    set names[6] = GetPlayerName(Player(7)) + "(Moriya slot 2)"
    set names[7] = GetPlayerName(Player(8)) + "(Moriya slot 3)"
    set names[8] = GetPlayerName(Player(9)) + "(Moriya slot 4)"
    set names[9] = GetPlayerName(Player(10)) + "(Moriya slot 5)"
    loop
    exitwhen n > 9
        if udg_AllianceSwitch[n * 10 + j] == 1 then
            if udg_AllianceSwitch[j * 10 + n] == 0 then
                call DisplayTimedTextToPlayer(p, 0.0, 0.0, 2.0, "|cff8080ffActivate single player mode, rejected " + names[n] + " team invitation.|r")
                set udg_AllianceSwitch[j * 11] = 2
                set switch = 0
            elseif udg_AllianceSwitch[j * 10 + n] == 1 then
                call DisplayTimedTextToPlayer(p, 0.0, 0.0, 2.0, "|cff8080ffStart single player mode, canceled the team with " + names[n] + " |r")
                set udg_AllianceSwitch[j * 11] = 2
                set switch = 0
                if 0 <= n and n <= 4 then
                    call ForceRemovePlayerSimple(p, udg_TempTeamA)
                elseif 5 <= n and n <= 9 then
                    call ForceRemovePlayerSimple(p, udg_TempTeamB)
                endif
            endif
        endif
        set n = n + 1
    endloop
    if switch == 1 then
        set udg_AllianceSwitch[j * 11] = 2
        call DisplayTimedTextToPlayer(p, 0.0, 0.0, 2.0, "|cff8080ffStart the single player mode, and you will not be invited by the team |r")
    endif
endfunction

function InitTrig_Alliance_Rejection takes nothing returns nothing
    set gg_trg_Alliance_Rejection = CreateTrigger()
    call TriggerRegisterPlayerChatEvent(gg_trg_Alliance_Rejection, Player(0), "-sin", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Alliance_Rejection, Player(1), "-sin", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Alliance_Rejection, Player(2), "-sin", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Alliance_Rejection, Player(3), "-sin", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Alliance_Rejection, Player(4), "-sin", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Alliance_Rejection, Player(6), "-sin", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Alliance_Rejection, Player(7), "-sin", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Alliance_Rejection, Player(8), "-sin", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Alliance_Rejection, Player(9), "-sin", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Alliance_Rejection, Player(10), "-sin", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Alliance_Rejection, Player(0), "-dissin", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Alliance_Rejection, Player(1), "-dissin", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Alliance_Rejection, Player(2), "-dissin", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Alliance_Rejection, Player(3), "-dissin", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Alliance_Rejection, Player(4), "-dissin", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Alliance_Rejection, Player(6), "-dissin", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Alliance_Rejection, Player(7), "-dissin", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Alliance_Rejection, Player(8), "-dissin", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Alliance_Rejection, Player(9), "-dissin", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Alliance_Rejection, Player(10), "-dissin", true)
    call TriggerAddCondition(gg_trg_Alliance_Rejection, Condition(function Trig_Alliance_Rejection_Conditions))
    call TriggerAddAction(gg_trg_Alliance_Rejection, function Trig_Alliance_Rejection_Actions)
    call DisableTrigger(gg_trg_Alliance_Rejection)
endfunction