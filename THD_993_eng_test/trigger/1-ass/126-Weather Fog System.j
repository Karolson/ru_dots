function Trig_Weather_Fog_Day takes real progress returns nothing
    local real R0 = 255
    local real G0 = 255
    local real B0 = 255
    local real Z0 = 1500
    local real E0 = 3000
    local real f = Pow(Sin(progress * bj_PI), 3.0)
    local real e = 1.0 - f
    local real R1 = 255
    local real G1 = 196
    local real B1 = 0
    local real Z1 = 1500
    local real E1 = 3000
    set R1 = R0 * e + R1 * f
    set G1 = G0 * e + G1 * f
    set B1 = B0 * e + B1 * f
    set Z1 = Z0 * e + Z1 * f
    set E1 = E0 * e + E1 * f
    call SetTerrainFogEx(0, Z1, E1, 0.5, R1 / 255.5, G1 / 255.5, B1 / 255.5)
endfunction

function Trig_Weather_Fog_Night takes real progress returns nothing
    local real R0 = 255
    local real G0 = 255
    local real B0 = 255
    local real Z0 = 1500.0
    local real E0 = 3000.0
    local real f = Pow(Sin(progress * bj_PI), 3.0)
    local real e = 1.0 - f
    local real R1 = 40
    local real G1 = 0
    local real B1 = 100
    local real Z1 = 1500.0
    local real E1 = 3000.0
    set R1 = R0 * e + R1 * f
    set G1 = G0 * e + G1 * f
    set B1 = B0 * e + B1 * f
    set Z1 = Z0 * e + Z1 * f
    set E1 = E0 * e + E1 * f
    call SetTerrainFogEx(0, Z1, E1, 0.5, R1 / 255.5, G1 / 255.5, B1 / 255.5)
endfunction

function Trig_Weather_Fog_System_Actions takes nothing returns nothing
    local real daytime = GetFloatGameState(GAME_STATE_TIME_OF_DAY)
    local real progress
    if daytime > 6.0 and daytime <= 18.0 then
        set progress = (daytime - 6.0) / 12.0
        call Trig_Weather_Fog_Day(progress)
    else
        if daytime <= 6.0 then
            set daytime = daytime + 24.0
        endif
        set progress = (daytime - 18.0) / 12.0
        call Trig_Weather_Fog_Night(progress)
    endif
endfunction

function InitTrig_Weather_Fog_System takes nothing returns nothing
    set gg_trg_Weather_Fog_System = CreateTrigger()
    call DisableTrigger(gg_trg_Weather_Fog_System)
    call TriggerRegisterTimerEvent(gg_trg_Weather_Fog_System, 1.0, true)
    call TriggerAddAction(gg_trg_Weather_Fog_System, function Trig_Weather_Fog_System_Actions)
endfunction