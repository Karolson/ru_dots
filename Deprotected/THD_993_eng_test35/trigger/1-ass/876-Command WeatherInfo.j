function Trig_Command_WeatherInfo_Actions takes nothing returns nothing
    local integer i
    set i = 1
    call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "Appeared weather: ")
    loop
    exitwhen i > 12
        if udg_NewWeather_Count[i] != 0 then
            call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, I2S(i) + udg_NewWeather_WeatherName[udg_NewWeather_Count[i]])
        endif
        set i = i + 1
    endloop
    call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "Current (or next) weather: " + udg_NewWeather_WeatherName[udg_NewWeather_WID])
    call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, udg_NewWeather_WeatherInfo[udg_NewWeather_WID])
    set udg_NewWeather_C = 1
endfunction

function InitTrig_Command_WeatherInfo takes nothing returns nothing
    set gg_trg_Command_WeatherInfo = CreateTrigger()
    call TriggerAddAction(gg_trg_Command_WeatherInfo, function Trig_Command_WeatherInfo_Actions)
endfunction