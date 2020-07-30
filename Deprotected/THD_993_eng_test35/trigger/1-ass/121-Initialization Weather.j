function Trig_Initialization_WeatherActions takes nothing returns nothing
    set udg_Weather_Type = -1
    set udg_Weather_Shrine = gg_unit_n000_0160
    set udg_Weather_Shrine02 = gg_unit_n000_0162
    set udg_Weather_Region = Rect(-2025.0, -18142.0, 15237.0, -2144.0)
    set udg_Weather_TriggerItem[0] = 'n02G'
    set udg_Weather_TriggerItem[1] = 'n02C'
    set udg_Weather_TriggerItem[2] = 'n02H'
    set udg_Weather_TriggerItem[3] = 'n02D'
    set udg_Weather_TriggerItem[4] = 'n02B'
    set udg_Weather_TriggerItem[5] = 'n02F'
    set udg_Weather_TriggerItem[6] = 'n02E'
    set udg_Weather_TriggerItem[7] = 'n047'
    set udg_Weather_TriggerItem[8] = 'n049'
    call TriggerRegisterUnitEvent(gg_trg_WeatherSummon, udg_Weather_Shrine, EVENT_UNIT_SELL)
    call TriggerRegisterUnitEvent(gg_trg_WeatherSummon, udg_Weather_Shrine02, EVENT_UNIT_SELL)
endfunction

function InitTrig_Initialization_Weather takes nothing returns nothing
    set gg_trg_Initialization_Weather = CreateTrigger()
    call TriggerAddAction(gg_trg_Initialization_Weather, function Trig_Initialization_WeatherActions)
endfunction