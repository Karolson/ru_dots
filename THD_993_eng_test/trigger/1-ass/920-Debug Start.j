function Trig_Debug_Start_Conditions takes nothing returns boolean
    if not (udg_TestMode) then
        return false
    endif
    return true
endfunction

function Trig_Debug_Start_Actions takes nothing returns nothing
    if udg_GameTime < 90 then
        set udg_GameTime = 90
        call Spawn_Start()
        call TriggerExecute(gg_trg_Spawn_A)
        call TriggerExecute(gg_trg_Spawn_B)
        call TriggerExecute(gg_trg_RuneBorn)
        call Trig_Neutral_System_Init()
        call Trig_Neutral_System_First_Spawn_WW()
    endif
endfunction

function Trig_Initialization_Debug_Start takes nothing returns nothing
    call TriggerRegisterPlayerChatEvent(gg_trg_Debug_Start, GetEnumPlayer(), "/start", true)
endfunction

function InitTrig_Debug_Start takes nothing returns nothing
    set gg_trg_Debug_Start = CreateTrigger()
    call TriggerAddCondition(gg_trg_Debug_Start, Condition(function Trig_Debug_Start_Conditions))
    call TriggerAddAction(gg_trg_Debug_Start, function Trig_Debug_Start_Actions)
    call ForForce(bj_FORCE_ALL_PLAYERS, function Trig_Initialization_Debug_Start)
endfunction