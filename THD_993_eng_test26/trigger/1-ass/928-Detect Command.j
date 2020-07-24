function Trig_Detect_Command_Conditions takes nothing returns boolean
    if SubString(GetEventPlayerChatString(), 0, 5) == "kick " and S2I(SubString(GetEventPlayerChatString(), 4, 10)) != 0 then
        call BroadcastMessage("Playerdetected " + udg_PN[GetPlayerId(GetTriggerPlayer())] + " Suspected cheating: Plug-in software kicked outplayer abnormally (host limited)")
    endif
    if SubString(GetEventPlayerChatString(), 0, 4) == "lag " and S2I(SubString(GetEventPlayerChatString(), 4, 10)) != 0 then
        call BroadcastMessage("Playerdetected " + udg_PN[GetPlayerId(GetTriggerPlayer())] + " Suspected cheating: Plug-in software kicked outplayer abnormally (host limited)")
    endif
    return false
endfunction

function Trig_Detect_Command_Actions takes nothing returns nothing
endfunction

function InitTrig_Detect_Command takes nothing returns nothing
    set gg_trg_Detect_Command = CreateTrigger()
    call TriggerRegisterPlayerChatEvent(gg_trg_Detect_Command, Player(0), "", false)
    call TriggerAddCondition(gg_trg_Detect_Command, Condition(function Trig_Detect_Command_Conditions))
    call TriggerAddAction(gg_trg_Detect_Command, function Trig_Detect_Command_Actions)
endfunction