function Trig_Debug_FogConditions takes nothing returns boolean
    return udg_TestMode
endfunction

function Trig_Debug_FogActions takes nothing returns nothing
    if IsFogEnabled() then
        call FogEnable(false)
        call FogMaskEnable(false)
    else
        call FogEnable(true)
        call FogMaskEnable(true)
    endif
endfunction

function InitTrig_Debug_Fog takes nothing returns nothing
    set gg_trg_Debug_Fog = CreateTrigger()
    call TriggerAddCondition(gg_trg_Debug_Fog, Condition(function Trig_Debug_FogConditions))
    call TriggerAddAction(gg_trg_Debug_Fog, function Trig_Debug_FogActions)
endfunction