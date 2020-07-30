function Trig_Route_B_Actions takes nothing returns nothing
    local integer i = 0
    local integer j = 0
    set j = 0
    set i = 0
    set udg_SpawnRouteB[j * 16 + i] = GetRectCenter(gg_rct_BaseB)
    set i = i + 1
    set udg_SpawnRouteB[j * 16 + i] = GetRectCenter(gg_rct_WayPoint_0_5)
    set i = i + 1
    set udg_SpawnRouteB[j * 16 + i] = GetRectCenter(gg_rct_WayPoint_0_4)
    set i = i + 1
    set udg_SpawnRouteB[j * 16 + i] = GetRectCenter(gg_rct_WayPoint_0_3)
    set i = i + 1
    set udg_SpawnRouteB[j * 16 + i] = GetRectCenter(gg_rct_WayPoint_0_2)
    set i = i + 1
    set udg_SpawnRouteB[j * 16 + i] = GetRectCenter(gg_rct_WayPoint_0_1)
    set i = i + 1
    set udg_SpawnRouteB[j * 16 + i] = GetRectCenter(gg_rct_WayPoint_0_0)
    set i = i + 1
    set udg_SpawnRouteB[j * 16 + i] = GetRectCenter(gg_rct_BaseA)
    set j = 1
    set i = 0
    set udg_SpawnRouteB[j * 16 + i] = GetRectCenter(gg_rct_BaseB)
    set i = i + 1
    set udg_SpawnRouteB[j * 16 + i] = GetRectCenter(gg_rct_WayPoint_1_5)
    set i = i + 1
    set udg_SpawnRouteB[j * 16 + i] = GetRectCenter(gg_rct_WayPoint_1_4)
    set i = i + 1
    set udg_SpawnRouteB[j * 16 + i] = GetRectCenter(gg_rct_WayPoint_1_3)
    set i = i + 1
    set udg_SpawnRouteB[j * 16 + i] = GetRectCenter(gg_rct_WayPoint_1_2)
    set i = i + 1
    set udg_SpawnRouteB[j * 16 + i] = GetRectCenter(gg_rct_WayPoint_1_1)
    set i = i + 1
    set udg_SpawnRouteB[j * 16 + i] = GetRectCenter(gg_rct_WayPoint_1_0)
    set i = i + 1
    set udg_SpawnRouteB[j * 16 + i] = GetRectCenter(gg_rct_BaseA)
    set j = 2
    set i = 0
    set udg_SpawnRouteB[j * 16 + i] = GetRectCenter(gg_rct_BaseB)
    set i = i + 1
    set udg_SpawnRouteB[j * 16 + i] = GetRectCenter(gg_rct_WayPoint_2_5)
    set i = i + 1
    set udg_SpawnRouteB[j * 16 + i] = GetRectCenter(gg_rct_WayPoint_2_4)
    set i = i + 1
    set udg_SpawnRouteB[j * 16 + i] = GetRectCenter(gg_rct_WayPoint_2_3)
    set i = i + 1
    set udg_SpawnRouteB[j * 16 + i] = GetRectCenter(gg_rct_WayPoint_2_2)
    set i = i + 1
    set udg_SpawnRouteB[j * 16 + i] = GetRectCenter(gg_rct_WayPoint_2_1)
    set i = i + 1
    set udg_SpawnRouteB[j * 16 + i] = GetRectCenter(gg_rct_WayPoint_2_0)
    set i = i + 1
    set udg_SpawnRouteB[j * 16 + i] = GetRectCenter(gg_rct_BaseA)
endfunction

function InitTrig_Route_B takes nothing returns nothing
    set gg_trg_Route_B = CreateTrigger()
    call DisableTrigger(gg_trg_Route_B)
    call TriggerAddAction(gg_trg_Route_B, function Trig_Route_B_Actions)
endfunction