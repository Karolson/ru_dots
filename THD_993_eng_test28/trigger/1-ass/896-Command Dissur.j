function Trig_Command_Dissur_Actions takes nothing returns nothing
    local string msg
    local player ply = GetTriggerPlayer()
    local integer k = GetPlayerId(ply)
    if udg_GameSurrendingValue[k] then
        set msg = udg_PN[GetPlayerId(ply)] + "|cffffffff cancels surrender vote|r"
        set udg_GameSurrendingValue[k] = false
        if IsPlayerInForce(ply, udg_TeamA) then
            set udg_GameSurrenderTeamValue[0] = udg_GameSurrenderTeamValue[0] - 1
            set msg = msg + "|cffffffff, Hakurei votes: " + I2S(udg_GameSurrenderTeamValue[0]) + "|r"
            call BroadcastMessage(msg)
        elseif IsPlayerInForce(ply, udg_TeamB) then
            set udg_GameSurrenderTeamValue[1] = udg_GameSurrenderTeamValue[1] - 1
            set msg = msg + "|cffffffff, Moriya votes: " + I2S(udg_GameSurrenderTeamValue[1]) + "|r"
            call BroadcastMessage(msg)
        endif
    endif
    set msg = null
    set ply = null
endfunction

function InitTrig_Command_Dissur takes nothing returns nothing
    set gg_trg_Command_Dissur = CreateTrigger()
    call TriggerAddAction(gg_trg_Command_Dissur, function Trig_Command_Dissur_Actions)
endfunction