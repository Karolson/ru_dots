function Trig_Weather_Effect_CreateActions takes nothing returns nothing
    call RemoveWeatherEffect(udg_WE_FallingLeaves)
    call RemoveWeatherEffect(udg_WE_SunShine)
    call DisableTrigger(gg_trg_Weather_Fog_System)
    call PlaySoundBJ(gg_snd_Weather)
    if udg_Weather_Type == 0 then
        call AddWeatherEffectSaveLast(udg_Weather_Region, 'RLlr')
        call EnableWeatherEffect(GetLastCreatedWeatherEffect(), true)
        set udg_Weather_Effect[0] = GetLastCreatedWeatherEffect()
        call AddWeatherEffectSaveLast(udg_Weather_Region, 'FDwl')
        call EnableWeatherEffect(GetLastCreatedWeatherEffect(), true)
        set udg_Weather_Effect[1] = GetLastCreatedWeatherEffect()
        call StartTimerBJ(udg_Weather_Timer[0], false, 80.0)
        return
    else
        call DoNothing()
    endif
    if udg_Weather_Type == 1 then
        call AddWeatherEffectSaveLast(udg_Weather_Region, 'FDrl')
        call EnableWeatherEffect(GetLastCreatedWeatherEffect(), true)
        set udg_Weather_Effect[0] = GetLastCreatedWeatherEffect()
        call StartTimerBJ(udg_Weather_Timer[0], false, 80.0)
        return
    else
        call DoNothing()
    endif
    if udg_Weather_Type == 2 then
        call AddWeatherEffectSaveLast(udg_Weather_Region, 'FDwl')
        call EnableWeatherEffect(GetLastCreatedWeatherEffect(), true)
        set udg_Weather_Effect[0] = GetLastCreatedWeatherEffect()
        call StartTimerBJ(udg_Weather_Timer[0], false, 40.0)
        return
    else
        call DoNothing()
    endif
    if udg_Weather_Type == 3 then
        call AddWeatherEffectSaveLast(udg_Weather_Region, 'RAlr')
        call EnableWeatherEffect(GetLastCreatedWeatherEffect(), true)
        set udg_Weather_Effect[0] = GetLastCreatedWeatherEffect()
        call StartTimerBJ(udg_Weather_Timer[0], false, 60.0)
        return
    else
        call DoNothing()
    endif
    if udg_Weather_Type == 4 then
        call AddWeatherEffectSaveLast(udg_Weather_Region, 'MEds')
        call EnableWeatherEffect(GetLastCreatedWeatherEffect(), true)
        set udg_Weather_Effect[0] = GetLastCreatedWeatherEffect()
        call StartTimerBJ(udg_Weather_Timer[0], false, 25.0)
        return
    else
        call DoNothing()
    endif
    if udg_Weather_Type == 5 then
        call AddWeatherEffectSaveLast(udg_Weather_Region, 'WOlw')
        call EnableWeatherEffect(GetLastCreatedWeatherEffect(), true)
        set udg_Weather_Effect[0] = GetLastCreatedWeatherEffect()
        call StartTimerBJ(udg_Weather_Timer[0], false, 60.0)
        return
    else
        call DoNothing()
    endif
    if udg_Weather_Type == 6 then
        call AddWeatherEffectSaveLast(udg_Weather_Region, 'SNls')
        call EnableWeatherEffect(GetLastCreatedWeatherEffect(), true)
        set udg_Weather_Effect[0] = GetLastCreatedWeatherEffect()
        call StartTimerBJ(udg_Weather_Timer[0], false, 60.0)
        return
    else
        call DoNothing()
    endif
    if udg_Weather_Type == 7 then
        call AddWeatherEffectSaveLast(udg_Weather_Region, 'WOlw')
        call EnableWeatherEffect(GetLastCreatedWeatherEffect(), true)
        set udg_Weather_Effect[0] = GetLastCreatedWeatherEffect()
        call StartTimerBJ(udg_Weather_Timer[0], false, 60.0)
        return
    else
        call DoNothing()
    endif
    if udg_Weather_Type == 8 then
        call AddWeatherEffectSaveLast(udg_Weather_Region, 'RLhr')
        call EnableWeatherEffect(GetLastCreatedWeatherEffect(), true)
        set udg_Weather_Effect[0] = GetLastCreatedWeatherEffect()
        call StartTimerBJ(udg_Weather_Timer[0], false, 25.0)
        return
    else
        call DoNothing()
    endif
    if udg_Weather_Type == 9 then
        call AddWeatherEffectSaveLast(udg_Weather_Region, 'RAhr')
        call EnableWeatherEffect(GetLastCreatedWeatherEffect(), true)
        set udg_Weather_Effect[0] = GetLastCreatedWeatherEffect()
        call StartTimerBJ(udg_Weather_Timer[0], false, 25.0)
        call EnableTrigger(gg_trg_Weather_Spell_09)
        return
    else
        call DoNothing()
    endif
    if udg_Weather_Type == 10 then
        call StartTimerBJ(udg_Weather_Timer[0], false, 25.0)
        return
    else
        call DoNothing()
    endif
endfunction

function InitTrig_Weather_Effect_Create takes nothing returns nothing
    set gg_trg_Weather_Effect_Create = CreateTrigger()
    call TriggerAddAction(gg_trg_Weather_Effect_Create, function Trig_Weather_Effect_CreateActions)
endfunction