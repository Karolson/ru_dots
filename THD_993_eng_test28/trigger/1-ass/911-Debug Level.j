function Trig_Debug_Level_Conditions takes nothing returns boolean
    if not (udg_TestMode) then
        return false
    endif
    return true
endfunction

function Trig_Debug_Level_Actions takes nothing returns nothing
    local integer i = GetPlayerId(GetTriggerPlayer())
    local integer j = S2I(SubString(GetEventPlayerChatString(), 7, 9))
    set bj_forLoopAIndex = 1
    set bj_forLoopAIndexEnd = j
    loop
    exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        call SetHeroLevel(udg_PlayerHeroes[i], GetHeroLevel(udg_PlayerHeroes[i]) + 1, true)
        set bj_forLoopAIndex = bj_forLoopAIndex + 1
    endloop
endfunction

function InitTrig_Debug_Level takes nothing returns nothing
    set gg_trg_Debug_Level = CreateTrigger()
    call TriggerAddCondition(gg_trg_Debug_Level, Condition(function Trig_Debug_Level_Conditions))
    call TriggerAddAction(gg_trg_Debug_Level, function Trig_Debug_Level_Actions)
endfunction