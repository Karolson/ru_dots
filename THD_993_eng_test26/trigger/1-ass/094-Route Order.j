function SetUnitWaypointRecord takes unit u, integer value returns nothing
    call SetUnitAbilityLevel(u, 'A008', 1 + value - value / 10 * 10)
    call SetUnitAbilityLevel(u, 'A009', 1 + value / 10)
endfunction

function AddUnitWaypointRecord takes unit u, integer value returns nothing
    call UnitAddAbility(u, 'A008')
    call UnitAddAbility(u, 'A009')
    call SetUnitWaypointRecord(u, value)
endfunction

function GetUnitWaypointRecord takes unit u returns integer
    return GetUnitAbilityLevel(u, 'A008') - 1 + 10 * (GetUnitAbilityLevel(u, 'A009') - 1)
endfunction

function SpawnIssueOrderA takes unit u returns nothing
    local integer i = GetUnitWaypointRecord(u)
    local integer waypoint = i - i / 16 * 16
    local location p
    if udg_SpawnRouteA[i + 1] != null and waypoint <= 15 then
        set p = udg_SpawnRouteA[i + 1]
    else
        set p = udg_SpawnRouteA[i]
    endif
    call IssuePointOrderLoc(u, "attack", p)
    set p = null
endfunction

function SpawnIssueOrderB takes unit u returns nothing
    local integer i = GetUnitWaypointRecord(u)
    local integer waypoint = i - i / 16 * 16
    local location p
    if udg_SpawnRouteB[i + 1] != null and waypoint <= 15 then
        set p = udg_SpawnRouteB[i + 1]
    else
        set p = udg_SpawnRouteB[i]
    endif
    call IssuePointOrderLoc(u, "attack", p)
    set p = null
endfunction

function Trig_WayPointA_Actions takes nothing returns nothing
    local unit u = GetEnteringUnit()
    local location p = GetUnitLoc(u)
    local integer i
    local integer route = GetUnitWaypointRecord(u) / 16
    set i = 0
    loop
        if udg_SpawnRouteA[i] != null then
        exitwhen DistanceBetweenPoints(udg_SpawnRouteA[i], p) < 400
        endif
        set i = i + 1
    exitwhen i > 47
    endloop
    call RemoveLocation(p)
    if route == i / 16 and i < 48 then
        call SetUnitWaypointRecord(u, i)
        call SpawnIssueOrderA(u)
    endif
    set p = null
    set u = null
endfunction

function Trig_WayPointB_Actions takes nothing returns nothing
    local unit u = GetEnteringUnit()
    local location p = GetUnitLoc(u)
    local integer i
    local integer route = GetUnitWaypointRecord(u) / 16
    set i = 0
    loop
        if udg_SpawnRouteB[i] != null then
        exitwhen DistanceBetweenPoints(udg_SpawnRouteB[i], p) < 400
        endif
        set i = i + 1
    exitwhen i > 47
    endloop
    call RemoveLocation(p)
    if route == i / 16 and i < 48 then
        call SetUnitWaypointRecord(u, i)
        call SpawnIssueOrderB(u)
    endif
    set p = null
    set u = null
endfunction

function Trig_Route_Order_A_Filter takes nothing returns boolean
    return IsUnitOwnedByPlayer(GetFilterUnit(), udg_SpawnPlayer[0])
endfunction

function Trig_Route_Order_B_Filter takes nothing returns boolean
    return IsUnitOwnedByPlayer(GetFilterUnit(), udg_SpawnPlayer[1])
endfunction

function Trig_Route_Order_Actions takes nothing returns nothing
    local trigger trg
    local integer i
    local integer j
    local location p
    local unit u
    local boolexpr f
    set trg = CreateTrigger()
    set f = Filter(function Trig_Route_Order_A_Filter)
    set j = 0
    loop
        set i = 0
        loop
            set p = udg_SpawnRouteA[j * 16 + i]
        exitwhen p == null
            set u = CreateUnitAtLoc(Player(15), 'n004', p, 270.0)
            call TriggerRegisterUnitInRange(trg, u, 270.0, f)
            set i = i + 1
        exitwhen i > 15
        endloop
        set j = j + 1
    exitwhen j > 2
    endloop
    call TriggerAddAction(trg, function Trig_WayPointA_Actions)
    set trg = CreateTrigger()
    set f = Filter(function Trig_Route_Order_B_Filter)
    set j = 0
    loop
        set i = 0
        loop
            set p = udg_SpawnRouteB[j * 16 + i]
        exitwhen p == null
            set u = CreateUnitAtLoc(Player(15), 'n004', p, 270.0)
            call TriggerRegisterUnitInRange(trg, u, 270.0, f)
            set i = i + 1
        exitwhen i > 15
        endloop
        set j = j + 1
    exitwhen j > 2
    endloop
    call TriggerAddAction(trg, function Trig_WayPointB_Actions)
    set trg = null
    set u = null
    set p = null
    set f = null
endfunction

function InitTrig_Route_Order takes nothing returns nothing
    set gg_trg_Route_Order = CreateTrigger()
    call TriggerAddAction(gg_trg_Route_Order, function Trig_Route_Order_Actions)
endfunction