function Trig_PowerOffActions takes nothing returns nothing
    call DisplayTextToForce(GetPlayersAll(), "PowerSystem on")
    call DisableTrigger(gg_trg_Power_Create)
    call DisableTrigger(gg_trg_Power_Get)
    call DisableTrigger(gg_trg_Power_Lost)
endfunction

function InitTrig_PowerOff takes nothing returns nothing
    set gg_trg_PowerOff = CreateTrigger()
    call TriggerAddAction(gg_trg_PowerOff, function Trig_PowerOffActions)
endfunction