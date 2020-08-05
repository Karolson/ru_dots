function WeatherBuff takes integer i returns integer
    if i == 1 then
        return 'B08K'
    endif
    if i == 2 then
        return 'B000'
    endif
    if i == 3 then
        return 'B089'
    endif
    if i == 4 then
        return 'B08I'
    endif
    if i == 5 then
        return 'B08A'
    endif
    if i == 6 then
        return 'B08B'
    endif
    if i == 7 then
        return 'B08C'
    endif
    if i == 8 then
        return 'B08D'
    endif
    if i == 9 then
        return 'B08E'
    endif
    if i == 10 then
        return 'B08F'
    endif
    if i == 11 then
        return 'B08G'
    endif
    if i == 12 then
        return 'B08H'
    endif
    return 0
endfunction

function NewWeather_Snow takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 1)
    local integer i = 0
    local unit u
    loop
    exitwhen i >= 12
        set u = udg_PlayerHeroes[i]
        if u != null then
            if GetUnitAbilityLevel(u, 'B08D') != 0 then
                if GetUnitAbilityLevel(u, 'A0TW') == 0 then
                    call UnitAddAbility(u, 'A0TW')
                    call SetUnitAbilityLevel(u, 'A0TW', GetUnitAbilityLevel(u, 'B08D'))
                endif
            else
                if GetUnitAbilityLevel(u, 'A0TW') != 0 then
                    call UnitRemoveAbility(u, 'A0TW')
                endif
            endif
        endif
        set i = i + 1
    endloop
    if GetWidgetLife(caster) >= 0.405 == false then
        set i = 0
        loop
        exitwhen i >= 12
            set u = udg_PlayerHeroes[i]
            if u != null then
                if GetUnitAbilityLevel(u, 'A0TW') != 0 then
                    call UnitRemoveAbility(u, 'A0TW')
                endif
            endif
            set i = i + 1
        endloop
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set u = null
endfunction

function NewWeather_Snow_Init takes unit u returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call SaveUnitHandle(udg_ht, task, 1, u)
    call TimerStart(t, 0.5, true, function NewWeather_Snow)
    set t = null
endfunction

function NewWeather_Fog takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 1)
    local integer i = 0
    local real x
    local real y
    local unit u
    local real value
    loop
    exitwhen i >= 12
        set u = udg_PlayerHeroes[i]
        if i != null then
            set x = GetUnitX(u)
            set y = GetUnitY(u)
            if x != LoadReal(udg_ht, task, 10 + i * 4) or y != LoadReal(udg_ht, task, 10 + i * 4 + 1) or GetUnitAbilityLevel(u, 'B08C') == 0 then
                if GetUnitAbilityLevel(u, 'A0TV') != 0 then
                    call UnitRemoveAbility(u, 'A0TV')
                endif
                call SaveReal(udg_ht, task, 10 + i * 4 + 2, 0)
                call SaveReal(udg_ht, task, 10 + i * 4, x)
                call SaveReal(udg_ht, task, 10 + i * 4 + 1, y)
            else
                set value = LoadReal(udg_ht, task, 10 + i * 4 + 2) + 1
                call SaveReal(udg_ht, task, 10 + i * 4 + 2, value)
                if value > 45 - 15 * GetUnitAbilityLevel(u, 'B08C') and GetUnitAbilityLevel(u, 'A0TV') == 0 then
                    call UnitAddAbility(u, 'A0TV')
                endif
            endif
        endif
        set i = i + 1
    endloop
    if GetWidgetLife(caster) >= 0.405 == false then
        set i = 0
        loop
        exitwhen i >= 12
            set u = udg_PlayerHeroes[i]
            if u != null then
                if GetUnitAbilityLevel(u, 'A0TV') != 0 then
                    call UnitRemoveAbility(u, 'A0TV')
                endif
            endif
            set i = i + 1
        endloop
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set u = null
    set t = null
    set caster = null
endfunction

function NewWeather_Fog_Init takes unit u returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call SaveUnitHandle(udg_ht, task, 1, u)
    call TimerStart(t, 0.1, true, function NewWeather_Fog)
    set t = null
endfunction

function Weather_Exp takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit u = LoadUnitHandle(udg_ht, task, 1)
    local integer i = 0
    if GetWidgetLife(u) >= 0.405 == false then
        call FlushChildHashtable(udg_ht, task)
        call ReleaseTimer(t)
    else
        loop
        exitwhen i >= 12
            if GetUnitAbilityLevel(udg_PlayerHeroes[i], WeatherBuff(3)) == 1 then
                call AddHeroXP(udg_PlayerHeroes[i], 3, true)
            endif
            if GetUnitAbilityLevel(udg_PlayerHeroes[i], WeatherBuff(3)) == 2 then
                call SetPlayerStateBJ(GetOwningPlayer(udg_PlayerHeroes[i]), PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(GetOwningPlayer(udg_PlayerHeroes[i]), PLAYER_STATE_RESOURCE_GOLD) + 6)
            endif
            set i = i + 1
        endloop
    endif
    set t = null
    set u = null
endfunction

function Weather_Exp_Start takes unit u returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call SaveUnitHandle(udg_ht, task, 1, u)
    call TimerStart(t, 1.0, true, function Weather_Exp)
    set t = null
endfunction

function RefreshStock takes integer num returns nothing
    local integer i = 0
    loop
        call RemoveUnitFromStockBJ(udg_Weather_TriggerItem[i], udg_Weather_Shrine)
        call AddUnitToStockBJ(udg_Weather_TriggerItem[i], udg_Weather_Shrine, num, 1)
        call RemoveUnitFromStockBJ(udg_Weather_TriggerItem[i], udg_Weather_Shrine02)
        call AddUnitToStockBJ(udg_Weather_TriggerItem[i], udg_Weather_Shrine02, num, 1)
    exitwhen i == 9
        set i = i + 1
    endloop
endfunction

function ResetRandomData takes nothing returns nothing
    local integer i
    call BroadcastMessage("Weather ended, previous weather will reappear again.")
    set i = 1
    loop
    exitwhen i > 12
        set udg_NewWeather_Count[i] = 0
        set i = i + 1
    endloop
    set udg_NewWeather_C = 1
endfunction

function RandomWeather takes nothing returns integer
    local integer i = GetRandomInt(1, 10)
    local integer oi = i - 1
    local integer j
    loop
        set j = 1
        loop
        exitwhen j >= udg_NewWeather_C or i == udg_NewWeather_Count[j]
            set j = j + 1
        endloop
    exitwhen i != udg_NewWeather_Count[j] or i == oi
        set i = i + 1
        if i > 10 then
            set i = 1
        endif
    endloop
    set udg_NewWeather_C = udg_NewWeather_C + 1
    set udg_NewWeather_Count[udg_NewWeather_C] = i
    call DebugMsg("WID:" + I2S(i))
    if udg_NewWeather_C >= 11 then
        call ResetRandomData()
    endif
    return i
endfunction

function WeatherMain_Apply takes nothing returns nothing
    local integer start = 360
    if udg_GameMode / 100 == 3 then
        set start = 242
    endif
    call DebugMsg("Weather Create")
    set udg_WeatherDuration = (udg_GameTime - start) / 240
    call ExecuteFunc("WeatherApply")
endfunction

function NewWeatherTime_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local integer i = LoadInteger(udg_ht, task, 2) - 1
    call SaveInteger(udg_ht, task, 2, i)
    if i <= 0 then
        call TimerStart(udg_NewWeather_T, LoadInteger(udg_ht, task, 3), false, function WeatherMain_Apply)
        set udg_NewWeather_WID = RandomWeather()
        set udg_NewWeather_InWeather = false
        call KillUnit(udg_NewWeather_AuraUnit)
        call RemoveWeatherEffect(udg_Weather_Effect[0])
        call RemoveWeatherEffect(udg_Weather_Effect[1])
        call RefreshStock(1)
        call BroadcastMessage("Weather ended, next weather: " + udg_NewWeather_WeatherName[udg_NewWeather_WID])
        call BroadcastMessage(udg_NewWeather_WeatherInfo[udg_NewWeather_WID])
        call TimerDialogSetTitle(udg_NewWeather_TD, "Next: " + udg_NewWeather_WeatherName[udg_NewWeather_WID])
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
        set udg_NewWeather_CT = null
    endif
    set t = null
endfunction

function NewWeatherTime_Init takes unit u, integer times returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call SaveUnitHandle(udg_ht, task, 1, u)
    call SaveInteger(udg_ht, task, 2, 90 + times * 10)
    call SaveInteger(udg_ht, task, 3, 90)
    call TimerStart(t, 1, true, function NewWeatherTime_Main)
    set udg_NewWeather_CT = t
    call TimerStart(udg_NewWeather_T, 90 + times * 10, false, null)
    call TimerDialogSetTitle(udg_NewWeather_TD, "Weather: " + udg_NewWeather_WeatherName[udg_NewWeather_WID])
    set udg_NewWeather_ChangeTime = 0
    set t = null
endfunction

function WeatherApply takes nothing returns nothing
    local integer tID = 'n00X'
    local real x = GetRectCenterX(udg_Weather_Region)
    local real y = GetRectCenterY(udg_Weather_Region)
    local integer aid
    local integer i = udg_NewWeather_WID
    local unit u = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE), tID, x, y, 0)
    local integer times = udg_WeatherDuration
    if times >= 6 then
        set times = 6
    endif
    set udg_NewWeather_InWeather = true
    call RefreshStock(0)
    call BroadcastMessage("Abnormal weather incoming: " + udg_NewWeather_WeatherName[udg_NewWeather_WID])
    call BroadcastMessage(udg_NewWeather_WeatherInfo[udg_NewWeather_WID])
    set udg_NewWeather_InWeather = true
    if udg_NewWeather_AuraUnit != null then
        call KillUnit(udg_NewWeather_AuraUnit)
    endif
    set udg_NewWeather_AuraUnit = u
    call NewWeatherTime_Init(u, times)
    if i == 1 then
        set aid = 'A0RT'
    endif
    if i == 2 then
        set aid = 'A0RU'
    endif
    if i == 3 then
        set aid = 'A0S5'
        if udg_VE_Stat[GetPlayerId(GetLocalPlayer())] == false then
            call AddWeatherEffectSaveLast(udg_Weather_Region, 'MEds')
            call EnableWeatherEffect(GetLastCreatedWeatherEffect(), true)
            set udg_Weather_Effect[0] = GetLastCreatedWeatherEffect()
        endif
    endif
    if i == 4 then
        set aid = 'A0S6'
        if udg_VE_Stat[GetPlayerId(GetLocalPlayer())] == false then
            call AddWeatherEffectSaveLast(udg_Weather_Region, 'LRaa')
            call EnableWeatherEffect(GetLastCreatedWeatherEffect(), true)
            set udg_Weather_Effect[0] = GetLastCreatedWeatherEffect()
        endif
    endif
    if i == 5 then
        if udg_VE_Stat[GetPlayerId(GetLocalPlayer())] == false then
            call AddWeatherEffectSaveLast(udg_Weather_Region, 'SNls')
            call EnableWeatherEffect(GetLastCreatedWeatherEffect(), true)
            set udg_Weather_Effect[0] = GetLastCreatedWeatherEffect()
        endif
        set aid = 'A0SP'
    endif
    if i == 6 then
        set aid = 'A0SV'
        if udg_VE_Stat[GetPlayerId(GetLocalPlayer())] == false then
            call AddWeatherEffectSaveLast(udg_Weather_Region, 'FDrl')
            call EnableWeatherEffect(GetLastCreatedWeatherEffect(), true)
            set udg_Weather_Effect[0] = GetLastCreatedWeatherEffect()
        endif
    endif
    if i == 7 then
        set aid = 'A0T2'
        call NewWeather_Fog_Init(u)
        if udg_VE_Stat[GetPlayerId(GetLocalPlayer())] == false then
            call AddWeatherEffectSaveLast(udg_Weather_Region, 'FDwl')
            call EnableWeatherEffect(GetLastCreatedWeatherEffect(), true)
            set udg_Weather_Effect[0] = GetLastCreatedWeatherEffect()
        endif
    endif
    if i == 8 then
        set aid = 'A0T3'
        call NewWeather_Snow_Init(u)
        if udg_VE_Stat[GetPlayerId(GetLocalPlayer())] == false then
            call AddWeatherEffectSaveLast(udg_Weather_Region, 'SNhs')
            call EnableWeatherEffect(GetLastCreatedWeatherEffect(), true)
            set udg_Weather_Effect[0] = GetLastCreatedWeatherEffect()
        endif
    endif
    if i == 9 then
        if udg_VE_Stat[GetPlayerId(GetLocalPlayer())] == false then
            call AddWeatherEffectSaveLast(udg_Weather_Region, 'LRma')
            call EnableWeatherEffect(GetLastCreatedWeatherEffect(), true)
            set udg_Weather_Effect[0] = GetLastCreatedWeatherEffect()
        endif
        set aid = 'A0TG'
    endif
    if i == 10 then
        if udg_VE_Stat[GetPlayerId(GetLocalPlayer())] == false then
            call AddWeatherEffectSaveLast(udg_Weather_Region, 'RAlr')
            call EnableWeatherEffect(GetLastCreatedWeatherEffect(), true)
            set udg_Weather_Effect[0] = GetLastCreatedWeatherEffect()
        endif
        set aid = 'A0TN'
    endif
    call UnitAddAbility(u, aid)
    call SetUnitAbilityLevel(u, aid, udg_NewWeather_Round)
    set u = null
endfunction

function WeatherMain takes nothing returns nothing
    local integer start = 360
    if udg_GameMode / 100 == 3 then
        set start = 242
    endif
    if udg_GameTime == start - 240 then
        call SetRandomSeed(GetRandomInt(1, 80))
        call ResetRandomData()
        set udg_NewWeather_WID = RandomWeather()
        call RefreshStock(1)
        call BroadcastMessage("We are expecting abnormal weather after 90 seconds, please take your umbrellas with you, next weather: " + udg_NewWeather_WeatherName[udg_NewWeather_WID])
        call TimerStart(udg_NewWeather_T, 90, false, function WeatherMain_Apply)
        call TimerDialogSetTitle(udg_NewWeather_TD, "Next: " + udg_NewWeather_WeatherName[udg_NewWeather_WID])
        call TimerDialogDisplay(udg_NewWeather_TD, true)
    endif
    if udg_GameTime == start + 240 * 12 and false then
        call BroadcastMessage("")
        set udg_NewWeather_WeatherInfo[1] = ""
        set udg_NewWeather_WeatherInfo[2] = ""
        set udg_NewWeather_WeatherInfo[3] = ""
        set udg_NewWeather_WeatherInfo[4] = ""
        set udg_NewWeather_WeatherInfo[5] = ""
        set udg_NewWeather_WeatherInfo[6] = ""
        set udg_NewWeather_WeatherInfo[7] = ""
        set udg_NewWeather_WeatherInfo[8] = ""
        set udg_NewWeather_WeatherInfo[9] = ""
        set udg_NewWeather_WeatherInfo[10] = ""
        set udg_NewWeather_Round = 2
    endif
endfunction

function WeatherMain_Init takes nothing returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call TimerStart(t, 1.0, true, function WeatherMain)
    set t = null
endfunction

function WeatherPick_Test takes nothing returns nothing
    local integer i
    local integer j
    call DebugMsg("Weather Test Start")
    set i = 1
    loop
    exitwhen i > 12
        set udg_NewWeather_Count[i] = 0
        set i = i + 1
    endloop
    set udg_NewWeather_C = 1
    call DebugMsg("Weather Data Reset")
    set i = 1
    loop
    exitwhen i > 12
        call RandomWeather()
        set j = 1
        loop
        exitwhen j > 12
            if udg_NewWeather_Count[j] != 0 then
                call DebugMsg("Weather Data " + I2S(j) + ":" + I2S(udg_NewWeather_Count[j]))
            endif
            set j = j + 1
        endloop
        call DebugMsg("Data Count:" + I2S(udg_NewWeather_C))
        set i = i + 1
    endloop
    call DebugMsg("Weather Pick Test End")
endfunction

function NewWeather_Init takes nothing returns nothing
    set udg_NewWeather_Round = 1
    set udg_NewWeather_T = CreateTimer()
    set udg_NewWeather_TD = CreateTimerDialog(udg_NewWeather_T)
    call TriggerExecute(gg_trg_Initialization_Weather)
    call RefreshStock(0)
    set udg_NewWeather_WeatherName[1] = "Sunlight"
    set udg_NewWeather_WeatherName[2] = "Moonlight"
    set udg_NewWeather_WeatherName[3] = "Cloudy"
    set udg_NewWeather_WeatherName[4] = "River Mist"
    set udg_NewWeather_WeatherName[5] = "Chill"
    set udg_NewWeather_WeatherName[6] = "Heavy Fog"
    set udg_NewWeather_WeatherName[7] = "Diamond Dust"
    set udg_NewWeather_WeatherName[8] = "Sand Storm"
    set udg_NewWeather_WeatherName[9] = "Heavy Snow"
    set udg_NewWeather_WeatherName[10] = "Monsoon"
    set udg_NewWeather_WeatherInfo[1] = "+6 HP regen"
    set udg_NewWeather_WeatherInfo[2] = "+3 MP regen"
    set udg_NewWeather_WeatherInfo[3] = "+25% cooldown reduction"
    set udg_NewWeather_WeatherInfo[4] = "+10% movement speed"
    set udg_NewWeather_WeatherInfo[5] = "When girl deals damage, target's movement speed is reduced by 20% for 2 seconds."
    set udg_NewWeather_WeatherInfo[6] = "When girl deals damage, target loses 1% of current HP per second for 2 seconds."
    set udg_NewWeather_WeatherInfo[7] = "If girl stands in one place for 3 seconds, she becomes invisible. Any action will break this effect"
    set udg_NewWeather_WeatherInfo[8] = "Girl becomes invisible, 8 seconds fade time. Attacking or using abilities will break this effect."
    set udg_NewWeather_WeatherInfo[9] = "Reduces girls' CC duration by 30%, but increases damage by 30%"
    set udg_NewWeather_WeatherInfo[10] = "Decreases girls' damage by 20%, but increases CC duration by 40%."
    set udg_Weather_Region = Rect(-2025.0, -18142.0, 15237.0, -2144.0)
    call WeatherMain_Init()
endfunction

function Trig_WeatherMain_Actions takes nothing returns nothing
    call DestroyTrigger(GetTriggeringTrigger())
    call NewWeather_Init()
endfunction

function InitTrig_WeatherMain takes nothing returns nothing
    set gg_trg_WeatherMain = CreateTrigger()
    call TriggerAddAction(gg_trg_WeatherMain, function Trig_WeatherMain_Actions)
endfunction