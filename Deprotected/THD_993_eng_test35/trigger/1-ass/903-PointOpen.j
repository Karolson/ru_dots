function Trig_PointOpenActions takes nothing returns nothing
    call DisplayTextToForce(GetPlayersAll(), "PointSystem on")
    call EnableTrigger(gg_trg_Point_Creat)
    call EnableTrigger(gg_trg_Point_Delete)
endfunction

function InitTrig_PointOpen takes nothing returns nothing
    set gg_trg_PointOpen = CreateTrigger()
    call TriggerAddAction(gg_trg_PointOpen, function Trig_PointOpenActions)
endfunction