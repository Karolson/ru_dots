function Trig_FeetManFix_Conditions takes nothing returns boolean
    return GetPlayerSlotState(GetTriggerPlayer()) == PLAYER_SLOT_STATE_PLAYING
endfunction

function Trig_FeetManFix_Func002A takes nothing returns nothing
    call SetPlayerAllianceBJ(GetTriggerPlayer(), ALLIANCE_SHARED_CONTROL, false, GetEnumPlayer())
    call SetPlayerAllianceBJ(GetTriggerPlayer(), ALLIANCE_SHARED_ADVANCED_CONTROL, false, GetEnumPlayer())
endfunction

function Trig_FeetManFix_Actions takes nothing returns nothing
    call ForForce(bj_FORCE_ALL_PLAYERS, function Trig_FeetManFix_Func002A)
endfunction

function InitTrig_FeetManFix takes nothing returns nothing
    local integer i = 0
    set gg_trg_FeetManFix = CreateTrigger()
    loop
    exitwhen i > 11
        call TriggerRegisterPlayerAllianceChange(gg_trg_FeetManFix, Player(i), ALLIANCE_SHARED_CONTROL)
        set i = i + 1
    endloop
    call TriggerRegisterPlayerAllianceChange(gg_trg_FeetManFix, Player(5), ALLIANCE_SHARED_ADVANCED_CONTROL)
    call TriggerRegisterPlayerAllianceChange(gg_trg_FeetManFix, Player(11), ALLIANCE_SHARED_ADVANCED_CONTROL)
    call TriggerAddCondition(gg_trg_FeetManFix, Condition(function Trig_FeetManFix_Conditions))
    call TriggerAddAction(gg_trg_FeetManFix, function Trig_FeetManFix_Actions)
endfunction