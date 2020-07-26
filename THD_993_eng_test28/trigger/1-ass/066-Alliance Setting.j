function Trig_Alliance_Setting_Conditions takes nothing returns boolean
    return SubString(GetEventPlayerChatString(), 0, 3) == "-cp"
endfunction

function Trig_Alliance_Setting_Actions takes nothing returns nothing
    local player p = GetTriggerPlayer()
    local player g
    local integer i = GetSortedPlayerId(p)
    local string command = GetEventPlayerChatString()
    local string side = SubString(command, 4, 6)
    local string hostname
    local string guestname
    local string hoststring
    local integer j
    local integer n
    local integer m
    if side == "bl" or side == "bL" or side == "Bl" or side == "BL" then
        set j = S2I(SubString(command, 6, 7)) - 1
    elseif side == "ss" or side == "sS" or side == "Ss" or side == "SS" then
        set j = S2I(SubString(command, 6, 7)) + 4
    endif
    set g = GetSortedPlayer(j)
    if i == j then
        call DisplayTimedTextToPlayer(p, 0.0, 0.0, 2.0, "|cff8080ffWhy are you inviting yourself.|r")
        return
    endif
    if udg_AllianceSwitch[i * 11] == 2 then
        call DisplayTimedTextToPlayer(p, 0.0, 0.0, 2.0, "|cff8080ffActivate single player mode and refuse team invite.|r")
        return
    endif
    if 0 <= i and i <= 4 then
        set hostname = GetPlayerName(p) + "(" + I2S(i + 1) + "Hakurei slot)"
        set hoststring = "BL" + I2S(i + 1)
    elseif 5 <= i and i <= 9 then
        set hostname = "(" + I2S(i - 4) + "Moriya slot)"
        set hoststring = "SS" + I2S(i - 1)
    endif
    if 0 <= j and j <= 4 then
        set guestname = GetPlayerName(g) + "(" + I2S(j + 1) + "Hakurei slot)"
    elseif 5 <= j and j <= 9 then
        set guestname = GetPlayerName(g) + "(" + I2S(j - 4) + "Moriya slot)"
    endif
    set n = i * 10 + j
    set m = j * 10 + i
    if udg_AllianceSwitch[j * 11] == 2 then
        call DisplayTimedTextToPlayer(p, 0.0, 0.0, 2.0, "|cff8080ffThe invitation failed, " + guestname + " has entered single mode or has been taken away.|r")
        return
    endif
    if 0 <= i and i <= 4 then
        if CountPlayersInForceBJ(udg_TempTeamA) > 4 then
            set udg_AllianceSwitch[n] = 0
            set udg_AllianceSwitch[m] = 0
            call DisplayTimedTextToPlayer(p, 0.0, 0.0, 2.0, "|cff8080ffHakurei team is full!|r")
            return
        endif
    elseif 5 <= i and i <= 9 then
        if CountPlayersInForceBJ(udg_TempTeamB) > 4 then
            set udg_AllianceSwitch[n] = 0
            set udg_AllianceSwitch[m] = 0
            call DisplayTimedTextToPlayer(p, 0.0, 0.0, 2.0, "|cff8080ffMoriya team is full!|r")
            return
        endif
    endif
    if udg_AllianceSwitch[m] == 1 then
        if 0 <= j and j <= 4 then
            call ForceAddPlayer(udg_TempTeamA, p)
            call ForceAddPlayer(udg_TempTeamA, g)
            if CountPlayersInForceBJ(udg_TempTeamA) > 5 then
                call ForceRemovePlayer(udg_TempTeamA, p)
                call ForceRemovePlayer(udg_TempTeamA, g)
                set udg_AllianceSwitch[n] = 0
                set udg_AllianceSwitch[m] = 0
                call DisplayTimedTextToPlayer(p, 0.0, 0.0, 2.0, "|cff8080ffHakurei team is already full!|r")
            else
                call DisplayTimedTextToPlayer(p, 0.0, 0.0, 2.0, "|cff8080ffTeam up successfully with " + guestname + " |r")
                call DisplayTimedTextToPlayer(g, 0.0, 0.0, 2.0, "|cff8080ffTeam up successfully with " + hostname + " |r")
                set udg_AllianceSwitch[GetSortedPlayerId(p) * 11] = 2
                set udg_AllianceSwitch[GetSortedPlayerId(g) * 11] = 2
                if IsPlayerInForce(p, udg_TempTeamB) then
                    call ForceRemovePlayer(udg_TempTeamB, p)
                endif
                if IsPlayerInForce(g, udg_TempTeamB) then
                    call ForceRemovePlayer(udg_TempTeamB, g)
                endif
            endif
            return
        elseif 5 <= j and j <= 9 then
            call ForceAddPlayer(udg_TempTeamB, p)
            call ForceAddPlayer(udg_TempTeamB, g)
            if CountPlayersInForceBJ(udg_TempTeamB) > 5 then
                call ForceRemovePlayer(udg_TempTeamB, p)
                call ForceRemovePlayer(udg_TempTeamB, g)
                set udg_AllianceSwitch[n] = 0
                set udg_AllianceSwitch[m] = 0
                call DisplayTimedTextToPlayer(p, 0.0, 0.0, 2.0, "|cff8080ffMoriya team is already full!|r")
            else
                call DisplayTimedTextToPlayer(p, 0.0, 0.0, 2.0, "|cff8080ffTeam up successfully with " + guestname + " |r")
                call DisplayTimedTextToPlayer(g, 0.0, 0.0, 2.0, "|cff8080ffTeam up successfully with " + hostname + " |r")
                set udg_AllianceSwitch[GetSortedPlayerId(p) * 11] = 2
                set udg_AllianceSwitch[GetSortedPlayerId(g) * 11] = 2
                if IsPlayerInForce(p, udg_TempTeamA) then
                    call ForceRemovePlayer(udg_TempTeamA, p)
                endif
                if IsPlayerInForce(g, udg_TempTeamA) then
                    call ForceRemovePlayer(udg_TempTeamA, g)
                endif
            endif
            return
        endif
    endif
    call DisplayTimedTextToPlayer(p, 0.0, 0.0, 2.0, "|cff8080ffWe have invited " + guestname + " to the team|r")
    call DisplayTimedTextToPlayer(g, 0.0, 0.0, 2.0, "|cff8080ff" + hostname + " invite a team，enter -cp " + hoststring + " to form a team|r")
    set udg_AllianceSwitch[n] = 1
    set command = null
    set side = null
    set hostname = null
    set hoststring = null
    set guestname = null
endfunction

function InitTrig_Alliance_Setting takes nothing returns nothing
    set gg_trg_Alliance_Setting = CreateTrigger()
    call TriggerRegisterPlayerChatEvent(gg_trg_Alliance_Setting, Player(0), "-cp", false)
    call TriggerRegisterPlayerChatEvent(gg_trg_Alliance_Setting, Player(1), "-cp", false)
    call TriggerRegisterPlayerChatEvent(gg_trg_Alliance_Setting, Player(2), "-cp", false)
    call TriggerRegisterPlayerChatEvent(gg_trg_Alliance_Setting, Player(3), "-cp", false)
    call TriggerRegisterPlayerChatEvent(gg_trg_Alliance_Setting, Player(4), "-cp", false)
    call TriggerRegisterPlayerChatEvent(gg_trg_Alliance_Setting, Player(6), "-cp", false)
    call TriggerRegisterPlayerChatEvent(gg_trg_Alliance_Setting, Player(7), "-cp", false)
    call TriggerRegisterPlayerChatEvent(gg_trg_Alliance_Setting, Player(8), "-cp", false)
    call TriggerRegisterPlayerChatEvent(gg_trg_Alliance_Setting, Player(9), "-cp", false)
    call TriggerRegisterPlayerChatEvent(gg_trg_Alliance_Setting, Player(10), "-cp", false)
    call TriggerAddCondition(gg_trg_Alliance_Setting, Condition(function Trig_Alliance_Setting_Conditions))
    call TriggerAddAction(gg_trg_Alliance_Setting, function Trig_Alliance_Setting_Actions)
    call DisableTrigger(gg_trg_Alliance_Setting)
endfunction