function Trig_PowerOpenActions takes nothing returns nothing
    call DisplayTextToForce(GetPlayersAll(), "PowerSystem on")
    call EnableTrigger(gg_trg_Power_Create)
    call EnableTrigger(gg_trg_Power_Get)
    call EnableTrigger(gg_trg_Power_Lost)
endfunction

function InitTrig_PowerOpen takes nothing returns nothing
    set gg_trg_PowerOpen = CreateTrigger()
    call TriggerAddAction(gg_trg_PowerOpen, function Trig_PowerOpenActions)
endfunction