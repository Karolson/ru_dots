function Trig_Weather_Shrine_ResetActions takes nothing returns nothing
    local integer i = 0
    if udg_Weather_Type == -1 then
        set i = 0
        loop
        exitwhen udg_Weather_TriggerItem[i] == 0 or i > 12
            call RemoveUnitFromStockBJ(udg_Weather_TriggerItem[i], udg_Weather_Shrine)
            call AddUnitToStockBJ(udg_Weather_TriggerItem[i], udg_Weather_Shrine, 1, 1)
            call RemoveUnitFromStockBJ(udg_Weather_TriggerItem[i], udg_Weather_Shrine02)
            call AddUnitToStockBJ(udg_Weather_TriggerItem[i], udg_Weather_Shrine02, 1, 1)
            set i = i + 1
        endloop
    else
        set i = 0
        loop
        exitwhen udg_Weather_TriggerItem[i] == 0 or i > 12
            call RemoveUnitFromStockBJ(udg_Weather_TriggerItem[i], udg_Weather_Shrine)
            call AddUnitToStockBJ(udg_Weather_TriggerItem[i], udg_Weather_Shrine, 0, 1)
            call RemoveUnitFromStockBJ(udg_Weather_TriggerItem[i], udg_Weather_Shrine02)
            call AddUnitToStockBJ(udg_Weather_TriggerItem[i], udg_Weather_Shrine02, 0, 1)
            set i = i + 1
        endloop
    endif
endfunction

function InitTrig_Weather_Shrine_Reset takes nothing returns nothing
    set gg_trg_Weather_Shrine_Reset = CreateTrigger()
    call TriggerRegisterTimerExpireEvent(gg_trg_Weather_Shrine_Reset, udg_Weather_Timer[1])
    call TriggerAddAction(gg_trg_Weather_Shrine_Reset, function Trig_Weather_Shrine_ResetActions)
endfunction