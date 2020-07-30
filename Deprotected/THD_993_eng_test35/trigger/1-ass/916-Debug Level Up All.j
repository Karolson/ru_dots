function Trig_Debug_Level_Up_All_Conditions takes nothing returns boolean
    if not (udg_TestMode) then
        return false
    endif
    return true
endfunction

function Trig_Debug_Level_Up_All_Func001Func001A takes nothing returns nothing
    local integer i = GetPlayerId(GetEnumPlayer())
    call SetHeroLevel(udg_PlayerHeroes[i], GetHeroLevel(udg_PlayerHeroes[i]) + 1, true)
endfunction

function Trig_Debug_Level_Up_All_Actions takes nothing returns nothing
    set bj_forLoopBIndex = 1
    set bj_forLoopBIndexEnd = S2I(SubString(GetEventPlayerChatString(), 4, 6))
    loop
    exitwhen bj_forLoopBIndex > bj_forLoopBIndexEnd
        call ForForce(udg_OnlinePlayers, function Trig_Debug_Level_Up_All_Func001Func001A)
        call TriggerSleepAction(0.2)
        set bj_forLoopBIndex = bj_forLoopBIndex + 1
    endloop
endfunction

function InitTrig_Debug_Level_Up_All takes nothing returns nothing
    set gg_trg_Debug_Level_Up_All = CreateTrigger()
    call TriggerAddCondition(gg_trg_Debug_Level_Up_All, Condition(function Trig_Debug_Level_Up_All_Conditions))
    call TriggerAddAction(gg_trg_Debug_Level_Up_All, function Trig_Debug_Level_Up_All_Actions)
endfunction