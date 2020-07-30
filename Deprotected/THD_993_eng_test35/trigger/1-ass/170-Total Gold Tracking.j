function Trig_Total_Gold_Tracking_Actions takes nothing returns boolean
    local player p = GetTriggerPlayer()
    local integer currentgold = GetPlayerState(p, PLAYER_STATE_RESOURCE_GOLD)
    local integer i = GetPlayerId(p)
    if currentgold > udg_PlayerCurrentGold[i] then
        set udg_PlayerTotalGoldIncome[i] = udg_PlayerTotalGoldLoss[i] + currentgold
    else
        set udg_PlayerTotalGoldLoss[i] = udg_PlayerTotalGoldIncome[i] - currentgold
    endif
    set udg_PlayerCurrentGold[i] = currentgold
    set p = null
    return false
endfunction

function InitTrig_Total_Gold_Tracking takes nothing returns nothing
    local integer i = 0
    set gg_trg_Total_Gold_Tracking = CreateTrigger()
    loop
    exitwhen i > 10
        call TriggerRegisterPlayerStateEvent(gg_trg_Total_Gold_Tracking, Player(i), PLAYER_STATE_RESOURCE_GOLD, NOT_EQUAL, udg_PlayerCurrentGold[i])
        call TriggerRegisterPlayerStateEvent(gg_trg_Total_Gold_Tracking, Player(i), PLAYER_STATE_RESOURCE_GOLD, EQUAL, 0)
        set i = i + 1
    endloop
    call TriggerAddCondition(gg_trg_Total_Gold_Tracking, Condition(function Trig_Total_Gold_Tracking_Actions))
endfunction