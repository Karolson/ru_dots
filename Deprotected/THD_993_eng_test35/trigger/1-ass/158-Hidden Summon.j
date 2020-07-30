function Trig_Hidden_Summon_Conditions takes nothing returns boolean
    return GetUnitTypeId(GetSoldUnit()) == 'e03E' or GetUnitTypeId(GetSoldUnit()) == 'e03F'
endfunction

function HS_Moriya takes integer iRoute returns nothing
    local integer route
    local integer t
    local integer n
    local unit u
    local player who = udg_PlayerB[0]
    local real facing = 225.0
    local integer array order
    local integer i
    set order[0] = 2
    set order[1] = 1
    set order[2] = 0
    set i = iRoute
    set route = order[i]
    set t = 0
    set n = 5
    loop
    exitwhen n == 0
        set u = CreateUnitAtLoc(who, 'h02C', udg_SpawnLocB[3], facing)
        call addlife(u, GetPlayerTechCount(udg_PlayerB[0], 'R003', true) * 22)
        call AddUnitWaypointRecord(u, route * 16)
        call UnitAddAbility(u, 'A10A')
        call SetUnitPositionLoc(u, udg_SpawnLocB[route])
        call SpawnIssueOrderB(u)
        if udg_SU_SP_First == false then
            call Trig_Spawn_FirstBan(u)
        endif
        set n = n - 1
    endloop
    set who = null
    set u = null
endfunction

function HS_Hakurei takes integer iRoute returns nothing
    local integer route
    local integer t
    local integer n
    local unit u
    local player who = udg_PlayerA[0]
    local real facing = 45.0
    local integer array order
    local integer i
    set i = iRoute
    set order[0] = 2
    set order[1] = 1
    set order[2] = 0
    set route = order[i]
    set t = 0
    set n = 5
    loop
    exitwhen n == 0
        set u = CreateUnitAtLoc(who, 'h02C', udg_SpawnLocA[3], facing)
        call addlife(u, GetPlayerTechCount(udg_PlayerA[0], 'R003', true) * 22)
        call AddUnitWaypointRecord(u, route * 16)
        call UnitAddAbility(u, 'A10A')
        call SetUnitColor(u, PLAYER_COLOR_RED)
        call SetUnitPositionLoc(u, udg_SpawnLocA[route])
        call SpawnIssueOrderA(u)
        if udg_SU_SP_First == false then
            call Trig_Spawn_FirstBan(u)
        endif
        set n = n - 1
    endloop
    set who = null
    set u = null
endfunction

function HiddenSummon_CD takes nothing returns nothing
    local timer t = GetExpiredTimer()
    call BroadcastMessage("Surprise attack is ready!")
    call PauseTimer(t)
    call DestroyTimer(t)
    set t = null
endfunction

function Trig_Hidden_Summon_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit u = NewDummy(GetOwningPlayer(caster), GetUnitX(caster), GetUnitY(caster), 0)
    local timer t = CreateTimer()
    local unit h
    local integer i
    local player PLY = GetOwningPlayer(caster)
    call UnitAddAbility(u, 'A1AS')
    loop
        set h = udg_PlayerHeroes[i]
        if h != null and IsUnitEnemy(h, PLY) == false then
            call IssueTargetOrder(u, "invisibility", h)
        endif
        set i = i + 1
    exitwhen i >= 12
    endloop
    call TimerStart(t, 180, false, function HiddenSummon_CD)
    call UnitRemoveAbility(u, 'A087')
    call ReleaseDummy(u)
    set caster = null
    set u = null
    set t = null
    set h = null
    set PLY = null
endfunction

function Trig_Hidden_Summon_Action takes nothing returns nothing
    local integer iRoute
    local unit caster = GetSellingUnit()
    local unit u = GetSoldUnit()
    local unit tower = GetTriggerUnit()
    local player PLY = GetOwningPlayer(u)
    call BroadcastMessageFriend(udg_PN[GetPlayerId(PLY)] + " uses a |cff8000ffsurprise attack|r!", PLY)
    if IsUnitAlly(GetSoldUnit(), udg_PlayerA[0]) then
        if GetUnitTypeId(u) == 'e03E' then
            set iRoute = 1
        else
            set iRoute = 2
        endif
        call HS_Hakurei(iRoute)
        call RemoveUnitFromStockBJ('e03E', udg_BaseA[0])
        call RemoveUnitFromStockBJ('e03F', udg_BaseA[0])
        call AddUnitToStockBJ('e03E', udg_BaseA[0], 0, 1)
        call AddUnitToStockBJ('e03F', udg_BaseA[0], 0, 1)
    else
        if GetUnitTypeId(u) == 'e03E' then
            set iRoute = 2
        else
            set iRoute = 1
        endif
        call HS_Moriya(iRoute)
        call RemoveUnitFromStockBJ('e03E', udg_BaseB[0])
        call RemoveUnitFromStockBJ('e03F', udg_BaseB[0])
        call AddUnitToStockBJ('e03E', udg_BaseB[0], 0, 1)
        call AddUnitToStockBJ('e03F', udg_BaseB[0], 0, 1)
    endif
    call KillUnit(u)
    call RemoveUnit(u)
    set caster = null
    set u = null
    set tower = null
    set PLY = null
endfunction

function InitTrig_Hidden_Summon takes nothing returns nothing
    set gg_trg_Hidden_Summon = CreateTrigger()
    call TriggerAddCondition(gg_trg_Hidden_Summon, Condition(function Trig_Hidden_Summon_Conditions))
    call TriggerAddAction(gg_trg_Hidden_Summon, function Trig_Hidden_Summon_Action)
endfunction