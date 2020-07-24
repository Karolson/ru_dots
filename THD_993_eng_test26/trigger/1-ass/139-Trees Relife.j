function Trig_Trees_Relife_Func001A takes nothing returns nothing
    if GetEnumDestructable() == gg_dest_DTlv_1987 then
        return
    elseif GetEnumDestructable() == gg_dest_LT07_0951 then
        return
    elseif GetEnumDestructable() == gg_dest_LT06_0189 then
        return
    elseif GetEnumDestructable() == gg_dest_LTt5_0498 then
        return
    endif
    call DestructableRestoreLife(GetEnumDestructable(), GetDestructableMaxLife(GetEnumDestructable()), true)
endfunction

function Trig_Trees_Relife_Actions takes nothing returns nothing
    call EnumDestructablesInRectAll(udg_MapRegion, function Trig_Trees_Relife_Func001A)
endfunction

function InitTrig_Trees_Relife takes nothing returns nothing
    set gg_trg_Trees_Relife = CreateTrigger()
    call TriggerRegisterTimerEventPeriodic(gg_trg_Trees_Relife, 180.0)
    call TriggerAddAction(gg_trg_Trees_Relife, function Trig_Trees_Relife_Actions)
endfunction