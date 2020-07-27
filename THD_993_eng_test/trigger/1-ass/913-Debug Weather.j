function Trig_Debug_Weather_Conditions takes nothing returns boolean
    if not (udg_TestMode) then
        return false
    endif
    return true
endfunction

function Trig_Debug_Weather_Actions takes nothing returns nothing
    local integer i = S2I(SubString(GetEventPlayerChatString(), 8, 11))
    if i == 14 then
        call WeatherPick_Test()
    else
        set udg_NewWeather_WID = i
        call WeatherApply()
    endif
endfunction

function InitTrig_Debug_Weather takes nothing returns nothing
    set gg_trg_Debug_Weather = CreateTrigger()
    call TriggerAddCondition(gg_trg_Debug_Weather, Condition(function Trig_Debug_Weather_Conditions))
    call TriggerAddAction(gg_trg_Debug_Weather, function Trig_Debug_Weather_Actions)
endfunction