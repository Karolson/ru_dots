function Trig_WeatherSummon_Actions takes nothing returns nothing
    local unit u = GetSoldUnit()
    local integer ID = GetUnitTypeId(u)
    local integer wid
    local integer cost = 25
    local player PLY = GetOwningPlayer(u)
    local unit caster = GetSellingUnit()
    if ID == 'n02F' then
        set wid = 1
    elseif ID == 'n02E' then
        set wid = 2
    elseif ID == 'n02C' then
        set wid = 8
    elseif ID == 'n02G' then
        set wid = 10
    elseif ID == 'n02D' then
        set wid = 6
    elseif ID == 'n02H' then
        set wid = 3
    elseif ID == 'n047' then
        set wid = 7
    elseif ID == 'n02B' then
        set wid = 9
    elseif ID == 'n049' then
        set wid = 4
    elseif ID == 'n048' then
        set wid = 5
    endif
    call KillUnit(u)
    if THD_GetSpirit(PLY) < cost then
        call DisplayTextToPlayer(PLY, 0, 0, "Not enough faith, need " + I2S(cost) + " faith to change the weather.")
        call AddUnitToStock(caster, ID, 1, 1)
        set caster = null
        set u = null
        set PLY = null
        return
    endif
    call THD_AddSpirit(PLY, -cost)
    call DisplayTextToPlayer(PLY, 0, 0, "")
    call BroadcastMessage("Weather was changed!")
    set udg_NewWeather_WID = wid
    call TimerStart(udg_NewWeather_T, 5, false, function WeatherMain_Apply)
    call BroadcastMessage("Next weather: " + udg_NewWeather_WeatherName[udg_NewWeather_WID])
    call BroadcastMessage(udg_NewWeather_WeatherInfo[udg_NewWeather_WID])
    call TimerDialogSetTitle(udg_NewWeather_TD, "Next: " + udg_NewWeather_WeatherName[udg_NewWeather_WID])
    call RefreshStock(0)
    set caster = null
    set u = null
    set PLY = null
endfunction

function InitTrig_WeatherSummon takes nothing returns nothing
    set gg_trg_WeatherSummon = CreateTrigger()
    call TriggerAddAction(gg_trg_WeatherSummon, function Trig_WeatherSummon_Actions)
endfunction