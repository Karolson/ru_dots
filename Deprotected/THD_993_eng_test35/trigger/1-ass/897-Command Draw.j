function Trig_Command_Draw_Conditions takes nothing returns boolean
    return udg_GameTime > 3000
endfunction

function Trig_Draw_Game takes nothing returns nothing
    call CustomVictoryBJ(GetEnumPlayer(), true, true)
endfunction

function Trig_Command_Draw_Actions takes nothing returns nothing
    local string msg
    local player ply = GetTriggerPlayer()
    local integer k = GetPlayerId(ply)
    set udg_GameSurrenderTeamValue[3] = 0
    set udg_GameSurrenderTeamValue[4] = 0
    call ForForce(udg_TeamA, function CountOnlineTeam)
    call ForForce(udg_TeamB, function CountOnlineTeam)
    if udg_GameDrawValue[k] == false then
        set msg = udg_PN[GetPlayerId(ply)] + "|cffffffffvotes for draw (tie)|r"
        set udg_GameDrawValue[k] = true
        if IsPlayerInForce(ply, udg_TeamA) then
            set udg_GameSurrenderTeamValue[5] = udg_GameSurrenderTeamValue[5] + 1
            set msg = msg + "|cffffffff, Hakurei votes: " + I2S(udg_GameSurrenderTeamValue[5]) + "|r"
            call BroadcastMessage(msg)
        elseif IsPlayerInForce(ply, udg_TeamB) then
            set udg_GameSurrenderTeamValue[6] = udg_GameSurrenderTeamValue[6] + 1
            set msg = msg + "|cffffffff, Moriya votes: " + I2S(udg_GameSurrenderTeamValue[6]) + "|r"
            call BroadcastMessage(msg)
        endif
    endif
    if udg_GameSurrenderTeamValue[5] >= udg_GameSurrenderTeamValue[3] * 0.7 and udg_GameSurrenderTeamValue[6] >= udg_GameSurrenderTeamValue[4] * 0.7 then
        call BroadcastMessage("The outcome of this battle is draw!")
        call YDWEPolledWaitNull(5.0)
        if udg_SK_Nazirin != null then
            call RemoveUnit(udg_SK_Nazirin)
        endif
        call PauseGameOn()
        call ForForce(udg_TeamA, function Trig_Draw_Game)
        call ForForce(udg_TeamB, function Trig_Draw_Game)
        call ForForce(udg_TeamOB, function Trig_Draw_Game)
    endif
    set msg = null
    set ply = null
endfunction

function InitTrig_Command_Draw takes nothing returns nothing
    set gg_trg_Command_Draw = CreateTrigger()
    call TriggerRegisterPlayerChatEvent(gg_trg_Command_Draw, Player(0), "-dr", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Command_Draw, Player(1), "-dr", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Command_Draw, Player(2), "-dr", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Command_Draw, Player(3), "-dr", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Command_Draw, Player(4), "-dr", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Command_Draw, Player(6), "-dr", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Command_Draw, Player(7), "-dr", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Command_Draw, Player(8), "-dr", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Command_Draw, Player(9), "-dr", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Command_Draw, Player(10), "-dr", true)
    call TriggerAddCondition(gg_trg_Command_Draw, Condition(function Trig_Command_Draw_Conditions))
    call TriggerAddAction(gg_trg_Command_Draw, function Trig_Command_Draw_Actions)
endfunction