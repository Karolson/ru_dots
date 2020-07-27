function Trig_Weather_Effect_RemoveFunc024A takes nothing returns nothing
    call RemoveUnit(GetEnumUnit())
    call GroupRemoveUnit(udg_Weather_SpellGroup, GetEnumUnit())
endfunction

function Trig_Weather_Effect_RemoveActions takes nothing returns nothing
    local group ydl_group
    local unit ydl_unit
    call DebugMsg("RemoveWeather")
    if udg_Weather_Type == 0 then
    else
    endif
    if udg_Weather_Type == 1 then
    else
    endif
    if udg_Weather_Type == 2 then
        call TriggerExecute(gg_trg_Weather_Spell_02_Off)
    else
    endif
    if udg_Weather_Type == 3 then
    else
    endif
    if udg_Weather_Type == 4 then
    else
    endif
    if udg_Weather_Type == 5 then
    else
    endif
    if udg_Weather_Type == 6 then
    else
    endif
    if udg_Weather_Type == 7 then
    else
    endif
    if udg_Weather_Type == 8 then
    else
    endif
    if udg_Weather_Type == 9 then
        call DisableTrigger(gg_trg_Weather_Spell_09)
    else
    endif
    set udg_Weather_Type = -1
    call RemoveWeatherEffect(udg_Weather_Effect[0])
    call RemoveWeatherEffect(udg_Weather_Effect[1])
    call ForGroupBJ(udg_Weather_SpellGroup, function Trig_Weather_Effect_RemoveFunc024A)
    set ydl_group = null
    set ydl_unit = null
endfunction

function InitTrig_Weather_Effect_Remove takes nothing returns nothing
    set gg_trg_Weather_Effect_Remove = CreateTrigger()
    call TriggerRegisterTimerExpireEvent(gg_trg_Weather_Effect_Remove, udg_Weather_Timer[0])
    call TriggerAddAction(gg_trg_Weather_Effect_Remove, function Trig_Weather_Effect_RemoveActions)
endfunction