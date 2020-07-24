function CancelRetreat takes nothing returns boolean
    local unit u
    if GetIssuedOrderId() != 851983 then
        set u = GetTriggerUnit()
        call SetUnitPosition(u, GetUnitX(u), GetUnitY(u))
        if GetTriggerPlayer() == udg_SpawnPlayer[0] then
            call SpawnIssueOrderA(u)
        elseif GetTriggerPlayer() == udg_SpawnPlayer[1] then
            call SpawnIssueOrderB(u)
        endif
    endif
    return false
endfunction

function CreepApproachBuilding takes nothing returns boolean
    local unit u = GetTriggerUnit()
    call SetUnitPosition(u, GetUnitX(u), GetUnitY(u))
    if GetOwningPlayer(u) == udg_SpawnPlayer[0] then
        call SpawnIssueOrderA(u)
    elseif GetOwningPlayer(u) == udg_SpawnPlayer[1] then
        call SpawnIssueOrderB(u)
    endif
    set u = null
    return false
endfunction

function IsUnitFoggedToAnyPlayer takes nothing returns boolean
    return GetOwningPlayer(GetAttacker()) == udg_SpawnPlayer[0] or GetOwningPlayer(GetAttacker()) == udg_SpawnPlayer[1] and IsUnitFogged(GetAttacker(), udg_PlayerA[1]) or IsUnitFogged(GetAttacker(), udg_PlayerB[1])
endfunction

function CreepRevealFoggedAttacker takes nothing returns nothing
    local unit u = GetAttacker()
    local real x = GetUnitX(u)
    local real y = GetUnitY(u)
    local player p = GetOwningPlayer(u)
    local fogmodifier f
    if p == udg_SpawnPlayer[0] then
        set f = CreateFogModifierRadius(udg_PlayerB[1], FOG_OF_WAR_VISIBLE, x, y, 128.0, true, false)
    elseif p == udg_SpawnPlayer[1] then
        set f = CreateFogModifierRadius(udg_PlayerA[1], FOG_OF_WAR_VISIBLE, x, y, 128.0, true, false)
    endif
    call FogModifierStart(f)
    call TriggerSleepAction(1.5)
    call FogModifierStop(f)
    call DestroyFogModifier(f)
    set u = null
    set p = null
    set f = null
endfunction

function CreepFilter takes nothing returns boolean
    return GetOwningPlayer(GetFilterUnit()) == udg_SpawnPlayer[0] or GetOwningPlayer(GetFilterUnit()) == udg_SpawnPlayer[1]
endfunction

function SetupObservers takes nothing returns nothing
    local trigger t = CreateTrigger()
    local group g = CreateGroup()
    local unit u
    call SetPlayerAllianceStateBJ(udg_SpawnPlayer[0], udg_PlayerA[0], bj_ALLIANCE_ALLIED_VISION)
    call SetPlayerAllianceStateBJ(udg_SpawnPlayer[0], udg_PlayerA[1], bj_ALLIANCE_ALLIED_VISION)
    call SetPlayerAllianceStateBJ(udg_SpawnPlayer[0], udg_PlayerA[2], bj_ALLIANCE_ALLIED_VISION)
    call SetPlayerAllianceStateBJ(udg_SpawnPlayer[0], udg_PlayerA[3], bj_ALLIANCE_ALLIED_VISION)
    call SetPlayerAllianceStateBJ(udg_SpawnPlayer[0], udg_PlayerA[4], bj_ALLIANCE_ALLIED_VISION)
    call SetPlayerAllianceStateBJ(udg_SpawnPlayer[0], udg_PlayerA[5], bj_ALLIANCE_ALLIED_VISION)
    call SetPlayerAllianceStateBJ(udg_PlayerA[0], udg_SpawnPlayer[0], bj_ALLIANCE_ALLIED_VISION)
    call SetPlayerAllianceStateBJ(udg_PlayerA[1], udg_SpawnPlayer[0], bj_ALLIANCE_ALLIED_VISION)
    call SetPlayerAllianceStateBJ(udg_PlayerA[2], udg_SpawnPlayer[0], bj_ALLIANCE_ALLIED_VISION)
    call SetPlayerAllianceStateBJ(udg_PlayerA[3], udg_SpawnPlayer[0], bj_ALLIANCE_ALLIED_VISION)
    call SetPlayerAllianceStateBJ(udg_PlayerA[4], udg_SpawnPlayer[0], bj_ALLIANCE_ALLIED_VISION)
    call SetPlayerAllianceStateBJ(udg_PlayerA[5], udg_SpawnPlayer[0], bj_ALLIANCE_ALLIED_VISION)
    call SetPlayerAllianceStateBJ(udg_SpawnPlayer[0], udg_PlayerB[0], bj_ALLIANCE_UNALLIED)
    call SetPlayerAllianceStateBJ(udg_SpawnPlayer[0], udg_PlayerB[1], bj_ALLIANCE_UNALLIED)
    call SetPlayerAllianceStateBJ(udg_SpawnPlayer[0], udg_PlayerB[2], bj_ALLIANCE_UNALLIED)
    call SetPlayerAllianceStateBJ(udg_SpawnPlayer[0], udg_PlayerB[3], bj_ALLIANCE_UNALLIED)
    call SetPlayerAllianceStateBJ(udg_SpawnPlayer[0], udg_PlayerB[4], bj_ALLIANCE_UNALLIED)
    call SetPlayerAllianceStateBJ(udg_SpawnPlayer[0], udg_PlayerB[5], bj_ALLIANCE_UNALLIED)
    call SetPlayerAllianceStateBJ(udg_PlayerB[0], udg_SpawnPlayer[0], bj_ALLIANCE_UNALLIED)
    call SetPlayerAllianceStateBJ(udg_PlayerB[1], udg_SpawnPlayer[0], bj_ALLIANCE_UNALLIED)
    call SetPlayerAllianceStateBJ(udg_PlayerB[2], udg_SpawnPlayer[0], bj_ALLIANCE_UNALLIED)
    call SetPlayerAllianceStateBJ(udg_PlayerB[3], udg_SpawnPlayer[0], bj_ALLIANCE_UNALLIED)
    call SetPlayerAllianceStateBJ(udg_PlayerB[4], udg_SpawnPlayer[0], bj_ALLIANCE_UNALLIED)
    call SetPlayerAllianceStateBJ(udg_PlayerB[5], udg_SpawnPlayer[0], bj_ALLIANCE_UNALLIED)
    call SetPlayerAllianceStateBJ(udg_SpawnPlayer[1], udg_PlayerB[0], bj_ALLIANCE_ALLIED_VISION)
    call SetPlayerAllianceStateBJ(udg_SpawnPlayer[1], udg_PlayerB[1], bj_ALLIANCE_ALLIED_VISION)
    call SetPlayerAllianceStateBJ(udg_SpawnPlayer[1], udg_PlayerB[2], bj_ALLIANCE_ALLIED_VISION)
    call SetPlayerAllianceStateBJ(udg_SpawnPlayer[1], udg_PlayerB[3], bj_ALLIANCE_ALLIED_VISION)
    call SetPlayerAllianceStateBJ(udg_SpawnPlayer[1], udg_PlayerB[4], bj_ALLIANCE_ALLIED_VISION)
    call SetPlayerAllianceStateBJ(udg_SpawnPlayer[1], udg_PlayerB[5], bj_ALLIANCE_ALLIED_VISION)
    call SetPlayerAllianceStateBJ(udg_PlayerB[0], udg_SpawnPlayer[1], bj_ALLIANCE_ALLIED_VISION)
    call SetPlayerAllianceStateBJ(udg_PlayerB[1], udg_SpawnPlayer[1], bj_ALLIANCE_ALLIED_VISION)
    call SetPlayerAllianceStateBJ(udg_PlayerB[2], udg_SpawnPlayer[1], bj_ALLIANCE_ALLIED_VISION)
    call SetPlayerAllianceStateBJ(udg_PlayerB[3], udg_SpawnPlayer[1], bj_ALLIANCE_ALLIED_VISION)
    call SetPlayerAllianceStateBJ(udg_PlayerB[4], udg_SpawnPlayer[1], bj_ALLIANCE_ALLIED_VISION)
    call SetPlayerAllianceStateBJ(udg_PlayerB[5], udg_SpawnPlayer[1], bj_ALLIANCE_ALLIED_VISION)
    call SetPlayerAllianceStateBJ(udg_SpawnPlayer[1], udg_PlayerA[0], bj_ALLIANCE_UNALLIED)
    call SetPlayerAllianceStateBJ(udg_SpawnPlayer[1], udg_PlayerA[1], bj_ALLIANCE_UNALLIED)
    call SetPlayerAllianceStateBJ(udg_SpawnPlayer[1], udg_PlayerA[2], bj_ALLIANCE_UNALLIED)
    call SetPlayerAllianceStateBJ(udg_SpawnPlayer[1], udg_PlayerA[3], bj_ALLIANCE_UNALLIED)
    call SetPlayerAllianceStateBJ(udg_SpawnPlayer[1], udg_PlayerA[4], bj_ALLIANCE_UNALLIED)
    call SetPlayerAllianceStateBJ(udg_SpawnPlayer[1], udg_PlayerA[5], bj_ALLIANCE_UNALLIED)
    call SetPlayerAllianceStateBJ(udg_PlayerA[0], udg_SpawnPlayer[1], bj_ALLIANCE_UNALLIED)
    call SetPlayerAllianceStateBJ(udg_PlayerA[1], udg_SpawnPlayer[1], bj_ALLIANCE_UNALLIED)
    call SetPlayerAllianceStateBJ(udg_PlayerA[2], udg_SpawnPlayer[1], bj_ALLIANCE_UNALLIED)
    call SetPlayerAllianceStateBJ(udg_PlayerA[3], udg_SpawnPlayer[1], bj_ALLIANCE_UNALLIED)
    call SetPlayerAllianceStateBJ(udg_PlayerA[4], udg_SpawnPlayer[1], bj_ALLIANCE_UNALLIED)
    call SetPlayerAllianceStateBJ(udg_PlayerA[5], udg_SpawnPlayer[1], bj_ALLIANCE_UNALLIED)
    call SetPlayerAllianceStateBJ(udg_SpawnPlayer[0], udg_SpawnPlayer[1], bj_ALLIANCE_UNALLIED)
    call SetPlayerAllianceStateBJ(udg_SpawnPlayer[1], udg_SpawnPlayer[0], bj_ALLIANCE_UNALLIED)
    call ClearTextMessages()
    set t = CreateTrigger()
    call TriggerAddCondition(t, Condition(function CancelRetreat))
    call TriggerRegisterPlayerUnitEvent(t, udg_SpawnPlayer[0], EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER, null)
    call TriggerRegisterPlayerUnitEvent(t, udg_SpawnPlayer[1], EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER, null)
    set t = CreateTrigger()
    call TriggerAddCondition(t, Condition(function IsUnitFoggedToAnyPlayer))
    call TriggerAddAction(t, function CreepRevealFoggedAttacker)
    call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_ATTACKED)
    set t = CreateTrigger()
    call TriggerAddCondition(t, Condition(function CreepApproachBuilding))
    call GroupEnumUnitsOfPlayer(g, udg_PlayerA[0], null)
    loop
        set u = FirstOfGroup(g)
    exitwhen u == null
        call GroupRemoveUnit(g, u)
        if IsUnitType(u, UNIT_TYPE_STRUCTURE) then
            call TriggerRegisterUnitInRange(t, u, 800.0, Filter(function CreepFilter))
        endif
    endloop
    call GroupEnumUnitsOfPlayer(g, udg_PlayerB[0], null)
    loop
        set u = FirstOfGroup(g)
    exitwhen u == null
        call GroupRemoveUnit(g, u)
        if IsUnitType(u, UNIT_TYPE_STRUCTURE) then
            call TriggerRegisterUnitInRange(t, u, 800.0, Filter(function CreepFilter))
        endif
    endloop
    call DestroyGroup(g)
    set g = null
    set t = null
endfunction

function InitTrig_Fix_Observer_Bug takes nothing returns nothing
endfunction