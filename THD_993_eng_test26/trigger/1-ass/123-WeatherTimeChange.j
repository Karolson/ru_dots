function Trig_WeatherTimeChange_Actions takes nothing returns nothing
    local unit u = GetSoldUnit()
    local integer cost = 0
    local integer typ = GetUnitTypeId(u)
    local unit caster = GetSellingUnit()
    local integer i
    local integer task
    local string str1
    local string str2
    local player PLY = GetOwningPlayer(u)
    call KillUnit(u)
    call RemoveUnit(u)
    if typ == 'n02P' then
        set i = 20
        set str1 = "Temperament Declaration"
    else
        if typ == 'n03M' then
            set i = -20
            set str1 = "Weather Dissipation"
        else
            set caster = null
            set u = null
            set PLY = null
            return
        endif
    endif
    if IsUnitAlly(caster, udg_PlayerA[0]) then
        set str2 = "|cffff0000Hakurei Shrine|r"
    else
        set str2 = "|cff00ff00Moriya Shrine|r"
    endif
    if udg_NewWeather_InWeather then
        call THD_AddSpirit(GetOwningPlayer(GetSellingUnit()), -cost)
        call BroadcastMessage(str2 + " is using " + str1 + " to disperse the weather.")
        set task = GetHandleId(udg_NewWeather_CT)
        set i = 5
        call SaveInteger(udg_ht, task, 2, i)
        call TimerStart(udg_NewWeather_T, i, false, null)
        set caster = null
        set u = null
        set PLY = null
        return
    endif
    if THD_GetSpirit(PLY) < cost then
        call DisplayTextToPlayer(PLY, 0, 0, "Not enough faith, need " + I2S(cost) + " faith to change the weather.")
        call AddUnitToStock(caster, typ, 1, 1)
        set caster = null
        set u = null
        set PLY = null
        return
    endif
    call THD_AddSpirit(GetOwningPlayer(GetSellingUnit()), -cost)
    set udg_NewWeather_WID = RandomWeather()
    call BroadcastMessage(str2 + " is using " + str1 + " to change the weather.")
    call BroadcastMessage("Weather changed to: " + udg_NewWeather_WeatherName[udg_NewWeather_WID])
    call TimerDialogSetTitle(udg_NewWeather_TD, "Next: " + udg_NewWeather_WeatherName[udg_NewWeather_WID])
    call BroadcastMessage(udg_NewWeather_WeatherInfo[udg_NewWeather_WID])
    set caster = null
    set u = null
    set PLY = null
endfunction

function InitTrig_WeatherTimeChange takes nothing returns nothing
    set gg_trg_WeatherTimeChange = CreateTrigger()
    call TriggerAddAction(gg_trg_WeatherTimeChange, function Trig_WeatherTimeChange_Actions)
endfunction