function Trig_Route_A_Actions takes nothing returns nothing
    local integer i = 0
    local integer j = 0
    set j = 0
    set i = 0
    set udg_SpawnRouteA[j * 16 + i] = GetRectCenter(gg_rct_BaseA)
    set i = i + 1
    set udg_SpawnRouteA[j * 16 + i] = GetRectCenter(gg_rct_WayPoint_0_0)
    set i = i + 1
    set udg_SpawnRouteA[j * 16 + i] = GetRectCenter(gg_rct_WayPoint_0_1)
    set i = i + 1
    set udg_SpawnRouteA[j * 16 + i] = GetRectCenter(gg_rct_WayPoint_0_2)
    set i = i + 1
    set udg_SpawnRouteA[j * 16 + i] = GetRectCenter(gg_rct_WayPoint_0_3)
    set i = i + 1
    set udg_SpawnRouteA[j * 16 + i] = GetRectCenter(gg_rct_WayPoint_0_4)
    set i = i + 1
    set udg_SpawnRouteA[j * 16 + i] = GetRectCenter(gg_rct_WayPoint_0_5)
    set i = i + 1
    set udg_SpawnRouteA[j * 16 + i] = GetRectCenter(gg_rct_BaseB)
    set j = 1
    set i = 0
    set udg_SpawnRouteA[j * 16 + i] = GetRectCenter(gg_rct_BaseA)
    set i = i + 1
    set udg_SpawnRouteA[j * 16 + i] = GetRectCenter(gg_rct_WayPoint_1_0)
    set i = i + 1
    set udg_SpawnRouteA[j * 16 + i] = GetRectCenter(gg_rct_WayPoint_1_1)
    set i = i + 1
    set udg_SpawnRouteA[j * 16 + i] = GetRectCenter(gg_rct_WayPoint_1_2)
    set i = i + 1
    set udg_SpawnRouteA[j * 16 + i] = GetRectCenter(gg_rct_WayPoint_1_3)
    set i = i + 1
    set udg_SpawnRouteA[j * 16 + i] = GetRectCenter(gg_rct_WayPoint_1_4)
    set i = i + 1
    set udg_SpawnRouteA[j * 16 + i] = GetRectCenter(gg_rct_WayPoint_1_5)
    set i = i + 1
    set udg_SpawnRouteA[j * 16 + i] = GetRectCenter(gg_rct_BaseB)
    set j = 2
    set i = 0
    set udg_SpawnRouteA[j * 16 + i] = GetRectCenter(gg_rct_BaseA)
    set i = i + 1
    set udg_SpawnRouteA[j * 16 + i] = GetRectCenter(gg_rct_WayPoint_2_0)
    set i = i + 1
    set udg_SpawnRouteA[j * 16 + i] = GetRectCenter(gg_rct_WayPoint_2_1)
    set i = i + 1
    set udg_SpawnRouteA[j * 16 + i] = GetRectCenter(gg_rct_WayPoint_2_2)
    set i = i + 1
    set udg_SpawnRouteA[j * 16 + i] = GetRectCenter(gg_rct_WayPoint_2_3)
    set i = i + 1
    set udg_SpawnRouteA[j * 16 + i] = GetRectCenter(gg_rct_WayPoint_2_4)
    set i = i + 1
    set udg_SpawnRouteA[j * 16 + i] = GetRectCenter(gg_rct_WayPoint_2_5)
    set i = i + 1
    set udg_SpawnRouteA[j * 16 + i] = GetRectCenter(gg_rct_BaseB)
endfunction

function InitTrig_Route_A takes nothing returns nothing
    set gg_trg_Route_A = CreateTrigger()
    call DisableTrigger(gg_trg_Route_A)
    call TriggerAddAction(gg_trg_Route_A, function Trig_Route_A_Actions)
endfunction