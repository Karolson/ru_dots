function Trig_PointOffActions takes nothing returns nothing
    call DisplayTextToForce(GetPlayersAll(), "PointSystem on")
    call DisableTrigger(gg_trg_Point_Creat)
    call DisableTrigger(gg_trg_Point_Delete)
endfunction

function InitTrig_PointOff takes nothing returns nothing
    set gg_trg_PointOff = CreateTrigger()
    call TriggerAddAction(gg_trg_PointOff, function Trig_PointOffActions)
endfunction