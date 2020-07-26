function Trig_Money_Actions takes nothing returns boolean
    call SetPlayerStateBJ(Player(5), PLAYER_STATE_RESOURCE_GOLD, 0)
    call SetPlayerStateBJ(Player(11), PLAYER_STATE_RESOURCE_GOLD, 0)
    return false
endfunction

function InitTrig_Money takes nothing returns nothing
    set gg_trg_Money = CreateTrigger()
    call TriggerRegisterPlayerStateEvent(gg_trg_Money, Player(5), PLAYER_STATE_RESOURCE_GOLD, GREATER_THAN_OR_EQUAL, 0.0)
    call TriggerRegisterPlayerStateEvent(gg_trg_Money, Player(11), PLAYER_STATE_RESOURCE_GOLD, GREATER_THAN_OR_EQUAL, 0.0)
    call TriggerAddCondition(gg_trg_Money, Condition(function Trig_Money_Actions))
endfunction