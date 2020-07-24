function Trig_Command_HeroIcon_Actions takes nothing returns nothing
    local player p = GetTriggerPlayer()
    local integer offset = 0
    local integer i = 0
    if GetPlayerId(p) > 5 then
        set offset = 6
    endif
    call SetReservedLocalHeroButtons(1)
    loop
        call SetPlayerAllianceBJ(Player(i + offset), ALLIANCE_SHARED_ADVANCED_CONTROL, true, p)
        set i = i + 1
    exitwhen i == 5
    endloop
endfunction

function InitTrig_Command_HeroIcon takes nothing returns nothing
    local trigger tr = CreateTrigger()
    call TriggerRegisterPlayerChatEvent(tr, Player(0), "-icons", true)
    call TriggerRegisterPlayerChatEvent(tr, Player(1), "-icons", true)
    call TriggerRegisterPlayerChatEvent(tr, Player(2), "-icons", true)
    call TriggerRegisterPlayerChatEvent(tr, Player(3), "-icons", true)
    call TriggerRegisterPlayerChatEvent(tr, Player(4), "-icons", true)
    call TriggerRegisterPlayerChatEvent(tr, Player(6), "-icons", true)
    call TriggerRegisterPlayerChatEvent(tr, Player(7), "-icons", true)
    call TriggerRegisterPlayerChatEvent(tr, Player(8), "-icons", true)
    call TriggerRegisterPlayerChatEvent(tr, Player(9), "-icons", true)
    call TriggerRegisterPlayerChatEvent(tr, Player(10), "-icons", true)
    call TriggerAddAction(tr, function Trig_Command_HeroIcon_Actions)
endfunction