function WeatherFogStartLoop takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local integer i = LoadInteger(udg_Hashtable, task, 1)
    local real zstart1 = LoadReal(udg_Hashtable, task, 2)
    local real zend1 = LoadReal(udg_Hashtable, task, 3)
    local real density1 = LoadReal(udg_Hashtable, task, 4)
    local real red1 = LoadReal(udg_Hashtable, task, 5)
    local real green1 = LoadReal(udg_Hashtable, task, 6)
    local real blue1 = LoadReal(udg_Hashtable, task, 7)
    local real zstart2
    local real zend2
    local real density2
    local real red2
    local real green2
    local real blue2
    local real zstartperiod = LoadReal(udg_Hashtable, task, 14)
    local real zendperiod = LoadReal(udg_Hashtable, task, 15)
    local real densityperiod = LoadReal(udg_Hashtable, task, 16)
    local real redperiod = LoadReal(udg_Hashtable, task, 17)
    local real greenperiod = LoadReal(udg_Hashtable, task, 18)
    local real blueperiod = LoadReal(udg_Hashtable, task, 19)
    local boolean startorend = LoadBoolean(udg_Hashtable, task, 20)
    local integer j
    if i < 50 then
        if startorend then
            set j = i
        else
            set j = 50 - i
        endif
        set i = i + 1
        call SaveInteger(udg_Hashtable, task, 1, i)
        call SetTerrainFogEx(0, zstart1 + j * zstartperiod, zend1 + j * zendperiod, density1 + j * densityperiod, red1 + j * redperiod, green1 + j * greenperiod, blue1 + j * blueperiod)
    else
        if startorend then
            set zstart2 = LoadReal(udg_Hashtable, task, 8)
            set zend2 = LoadReal(udg_Hashtable, task, 9)
            set density2 = LoadReal(udg_Hashtable, task, 10)
            set red2 = LoadReal(udg_Hashtable, task, 11)
            set green2 = LoadReal(udg_Hashtable, task, 12)
            set blue2 = LoadReal(udg_Hashtable, task, 13)
            call SetTerrainFogEx(0, zstart2, zend2, density2, red2, green2, blue2)
        else
            call SetTerrainFogEx(0, zstart1, zend1, density1, red1, green1, blue1)
            call EnableTrigger(gg_trg_Weather_Fog_System)
        endif
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_Hashtable, task)
    endif
    set t = null
endfunction

function WeatherFogStart takes boolean startorend, real zstart2, real zend2, real density2, real red2, real green2, real blue2 returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local integer i = 0
    local real daytime = GetFloatGameState(GAME_STATE_TIME_OF_DAY)
    local real zstart1
    local real zend1
    local real density1
    local real red1
    local real green1
    local real blue1
    local real zstartperiod
    local real zendperiod
    local real densityperiod
    local real redperiod
    local real greenperiod
    local real blueperiod
    if daytime <= 12 then
        set zstart1 = 1000
        set zend1 = daytime * 1250 + 3000
        set density1 = 100
        set red1 = daytime * 0.08
        set green1 = daytime * 0.08
        set blue1 = 0.48 - daytime * 0.04
    else
        set daytime = daytime - 12
        set zstart1 = 1000
        set zend1 = 18000 - daytime * 1250
        set density1 = 100
        set red1 = 0.96 - daytime * 0.08
        set green1 = 0.96 - daytime * 0.08
        set blue1 = daytime * 0.04
    endif
    set zstartperiod = (zstart2 - zstart1) / 50
    set zendperiod = (zend2 - zend1) / 50
    set densityperiod = (density2 - density1) / 50
    set redperiod = (red2 - red1) / 50
    set greenperiod = (green2 - green1) / 50
    set blueperiod = (blue2 - blue1) / 50
    call SaveTimerHandle(udg_Hashtable, task, 0, t)
    call SaveInteger(udg_Hashtable, task, 1, i)
    call SaveReal(udg_Hashtable, task, 2, zstart1)
    call SaveReal(udg_Hashtable, task, 3, zend1)
    call SaveReal(udg_Hashtable, task, 4, density1)
    call SaveReal(udg_Hashtable, task, 5, red1)
    call SaveReal(udg_Hashtable, task, 6, green1)
    call SaveReal(udg_Hashtable, task, 7, blue1)
    call SaveReal(udg_Hashtable, task, 8, zstart2)
    call SaveReal(udg_Hashtable, task, 9, zend2)
    call SaveReal(udg_Hashtable, task, 10, density2)
    call SaveReal(udg_Hashtable, task, 11, red2)
    call SaveReal(udg_Hashtable, task, 12, green2)
    call SaveReal(udg_Hashtable, task, 13, blue2)
    call SaveReal(udg_Hashtable, task, 14, zstartperiod)
    call SaveReal(udg_Hashtable, task, 15, zendperiod)
    call SaveReal(udg_Hashtable, task, 16, densityperiod)
    call SaveReal(udg_Hashtable, task, 17, redperiod)
    call SaveReal(udg_Hashtable, task, 18, greenperiod)
    call SaveReal(udg_Hashtable, task, 19, blueperiod)
    call SaveBoolean(udg_Hashtable, task, 20, startorend)
    call TimerStart(t, 0.04, true, function WeatherFogStartLoop)
    set t = null
endfunction

function InitTrig_Weather_Change takes nothing returns nothing
endfunction