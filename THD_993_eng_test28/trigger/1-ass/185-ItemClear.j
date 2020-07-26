function Trig_ItemClear_Main takes nothing returns nothing
    if GetWidgetLife(GetEnumItem()) <= 0.0 then
        call RemoveItem(GetEnumItem())
    endif
endfunction

function Trig_ItemClear_Actions takes nothing returns nothing
    call EnumItemsInRect(bj_mapInitialPlayableArea, null, function Trig_ItemClear_Main)
endfunction

function InitTrig_ItemClear takes nothing returns nothing
    set gg_trg_ItemClear = CreateTrigger()
    call TriggerRegisterTimerEvent(gg_trg_ItemClear, 60.0, true)
    call TriggerAddAction(gg_trg_ItemClear, function Trig_ItemClear_Actions)
endfunction