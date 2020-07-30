function Trig_Roll_Conditions takes nothing returns boolean
    return SubString(GetEventPlayerChatString(), 0, 5) == "-roll"
endfunction

function Trig_Roll_Actions takes nothing returns nothing
    local integer i = S2I(SubString(GetEventPlayerChatString(), 6, 10))
    local integer j = GetRandomInt(0, i)
    call BroadcastMessage(udg_PN[GetPlayerId(GetTriggerPlayer())] + " rolls between 0 and " + I2S(i) + ", result: " + I2S(j))
endfunction

function InitTrig_Roll takes nothing returns nothing
    local integer i = 0
    set gg_trg_Roll = CreateTrigger()
    loop
    exitwhen i > 11
        if GetPlayerSlotState(Player(i)) == PLAYER_SLOT_STATE_PLAYING then
            call TriggerRegisterPlayerChatEvent(gg_trg_Roll, Player(i), "-roll", false)
        endif
        set i = i + 1
    endloop
    call TriggerAddAction(gg_trg_Roll, function Trig_Roll_Actions)
endfunction