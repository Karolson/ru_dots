function Trig_Initialization_LocationsActions takes nothing returns nothing
    set udg_RevivePoint[0] = GetRectCenter(gg_rct_ReviveA)
    set udg_RevivePoint[1] = GetRectCenter(gg_rct_ReviveB)
    set udg_RecoverPoint[0] = GetRectCenter(gg_rct_RecoverAreaA)
    set udg_RecoverPoint[1] = GetRectCenter(gg_rct_RecoverAreaB)
    set udg_BirthPoint[0] = GetRectCenter(gg_rct_BirthA)
    set udg_BirthPoint[1] = GetRectCenter(gg_rct_BirthB)
    set udg_BackStage = GetRectCenter(gg_rct_BackStage)
    set udg_CommonPoint = GetRectCenter(gg_rct_CommonArea)
    call DestroyTrigger(GetTriggeringTrigger())
endfunction

function InitTrig_Initialization_Locations takes nothing returns nothing
    set gg_trg_Initialization_Locations = CreateTrigger()
    call DisableTrigger(gg_trg_Initialization_Locations)
    call TriggerAddAction(gg_trg_Initialization_Locations, function Trig_Initialization_LocationsActions)
endfunction