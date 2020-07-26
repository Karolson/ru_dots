function Trig_Enter_Character_Select_Screen_Actions takes nothing returns nothing
    call SetSkyModel(null)
    call SetCameraBounds(GetRectMinX(udg_MapRegionScreen), GetRectMinY(udg_MapRegionScreen), GetRectMinX(udg_MapRegionScreen), GetRectMaxY(udg_MapRegionScreen), GetRectMaxX(udg_MapRegionScreen), GetRectMaxY(udg_MapRegionScreen), GetRectMaxX(udg_MapRegionScreen), GetRectMinY(udg_MapRegionScreen))
    call TriggerEvaluate(gg_trg_CSS2_Beta)
    call DestroyTrigger(GetTriggeringTrigger())
endfunction

function InitTrig_Enter_Character_Select_Screen takes nothing returns nothing
    set gg_trg_Enter_Character_Select_Screen = CreateTrigger()
    call TriggerAddAction(gg_trg_Enter_Character_Select_Screen, function Trig_Enter_Character_Select_Screen_Actions)
endfunction