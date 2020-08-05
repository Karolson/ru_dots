function Trig_WeatherTimeChange_Actions takes nothing returns nothing
    local integer cost = 0
    local integer typ = GetSpellAbilityId()
    local unit caster = GetTriggerUnit()
    local integer i
    local integer a
    local integer max
    local integer task
    local string str1
    local string str2
    local player PLY = GetTriggerPlayer()
    local integer pid = GetPlayerId(PLY)
    local timer t
    if typ == 'A01B' then
        set i = 20
        set str1 = "Temperament Declaration"
        if pid < 5 then
            set a = 0
            set max = 5
        else
            set a = 5
            set max = 10
        endif
        loop
            call UnitRemoveAbility(udg_PlayerReviveHouse[a], 'A01B')
            call UnitAddAbility(udg_PlayerReviveHouse[a], 'A02P')
            call IssueImmediateOrder(udg_PlayerReviveHouse[a], "cripple")
            set a = a + 1
        exitwhen a > max
        endloop
        set t = CreateTimer()
        call SaveInteger(udg_ht, GetHandleId(t), 0, 'A02P')
        call SaveInteger(udg_ht, GetHandleId(t), 1, 'A01B')
        call SaveInteger(udg_ht, GetHandleId(t), 2, pid)
        call TimerStart(t, 60.0 - 0.05, false, function ReturnTrueCampAbility)
    else
        //if typ == 'n03M' then
        //    set i = -20
        //    set str1 = "Weather Dissipation"
        //else
        //    set caster = null
        //    set u = null
        //    set PLY = null
        //    return
        //endif
    endif
    if IsUnitAlly(caster, udg_PlayerA[0]) then
        set str2 = "|cffff0000Hakurei Shrine|r"
    else
        set str2 = "|cff00ff00Moriya Shrine|r"
    endif
    if udg_NewWeather_InWeather then
        call BroadcastMessage(str2 + " is using " + str1 + " to disperse the weather.")
        set task = GetHandleId(udg_NewWeather_CT)
        set i = 5
        call SaveInteger(udg_ht, task, 2, i)
        call TimerStart(udg_NewWeather_T, i, false, null)
        set caster = null
        set PLY = null
        return
    endif
    set udg_NewWeather_WID = RandomWeather()
    call BroadcastMessage(str2 + " is using " + str1 + " to change the weather.")
    call BroadcastMessage("Weather changed to: " + udg_NewWeather_WeatherName[udg_NewWeather_WID])
    call TimerDialogSetTitle(udg_NewWeather_TD, "Next: " + udg_NewWeather_WeatherName[udg_NewWeather_WID])
    call BroadcastMessage(udg_NewWeather_WeatherInfo[udg_NewWeather_WID])
    set caster = null
    set PLY = null
    set t = null
endfunction

function InitTrig_WeatherTimeChange takes nothing returns nothing
    set gg_trg_WeatherTimeChange = CreateTrigger()
    call TriggerAddAction(gg_trg_WeatherTimeChange, function Trig_WeatherTimeChange_Actions)
endfunction