function Trig_Share_Actions takes nothing returns nothing
    local integer i = 1
    loop
    exitwhen i > 5
        if GetPlayerSlotState(udg_PlayerA[i]) == PLAYER_SLOT_STATE_PLAYING then
            call SetPlayerAlliance(udg_PlayerA[0], udg_PlayerA[i], ALLIANCE_SHARED_CONTROL, false)
        endif
        if GetPlayerSlotState(udg_PlayerB[i]) == PLAYER_SLOT_STATE_PLAYING then
            call SetPlayerAlliance(udg_PlayerB[0], udg_PlayerB[i], ALLIANCE_SHARED_CONTROL, false)
        endif
        set i = i + 1
    endloop
endfunction

function InitTrig_Share takes nothing returns nothing
    set gg_trg_Share = CreateTrigger()
    call TriggerRegisterPlayerAllianceChange(gg_trg_Share, udg_PlayerA[0], ALLIANCE_SHARED_CONTROL)
    call TriggerRegisterPlayerAllianceChange(gg_trg_Share, udg_PlayerB[0], ALLIANCE_SHARED_CONTROL)
    call TriggerAddAction(gg_trg_Share, function Trig_Share_Actions)
endfunction