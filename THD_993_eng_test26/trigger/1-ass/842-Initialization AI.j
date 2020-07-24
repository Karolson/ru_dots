function AIDIFF takes unit h returns integer
    local integer i
    if GetAIDifficulty(GetOwningPlayer(h)) == AI_DIFFICULTY_NEWBIE then
        set i = 0
    endif
    if GetAIDifficulty(GetOwningPlayer(h)) == AI_DIFFICULTY_NORMAL then
        set i = 1
    endif
    if GetAIDifficulty(GetOwningPlayer(h)) == AI_DIFFICULTY_INSANE then
        set i = 2
    endif
    return i
endfunction

function AILUD takes unit h returns real
    return 0.25 * (4 - AIDIFF(h))
endfunction

function AI_WriteState takes integer page, integer field, integer index, integer value returns nothing
    set udg_AI_States[page * 512 + field * 16 + index] = value
endfunction

function AI_ReadState takes integer page, integer field, integer index returns integer
    return udg_AI_States[page * 512 + field * 16 + index]
endfunction

function AI_STATE_PHASE takes nothing returns integer
    return 0
endfunction

function AI_STATE_WAYPOINT takes nothing returns integer
    return 1
endfunction

function AI_STATE_DECISION takes nothing returns integer
    return 2
endfunction

function AI_IsLowHP takes unit u returns boolean
    local real HP = GetUnitState(u, UNIT_STATE_LIFE)
    local real percent = 100.0 * HP / GetUnitState(u, UNIT_STATE_MAX_LIFE)
    local real speed = GetUnitMoveSpeed(u)
    local real DC = RMinBJ(100.0, RMaxBJ(600.0 - GetUnitDefaultAcquireRange(u), 0.0))
    local boolean ret = false
    if percent <= 25.0 + DC / 20.0 then
        set ret = true
    endif
    if HP <= 180.0 + 3.0 * (320.0 - speed) + DC then
        set ret = ret and percent < 80.0
    endif
    if ret and GetUnitAbilityLevel(u, 'A1HL') == 0 then
        call DebugMsg("AI Order: Drink Tea")
        call THD_AddCredit(GetOwningPlayer(u), -75)
        call UnitBuffTarget(u, u, 15, 'A1HL', 0)
    endif
    return ret
endfunction

function AI_IsLowMP takes unit u returns boolean
    local real MP = GetUnitState(u, UNIT_STATE_MANA)
    local real percent = 100.0 * MP / GetUnitState(u, UNIT_STATE_MAX_MANA)
    local integer level = GetHeroLevel(u)
    local boolean ret = false
    if percent <= 15.0 then
        set ret = true
    endif
    if MP <= 60.0 + level * 3.0 then
        set ret = true
    endif
    if ret and GetUnitAbilityLevel(u, 'A1HM') == 0 then
        call DebugMsg("AI Order: Drink Tea(Red)")
        call THD_AddCredit(GetOwningPlayer(u), -75)
        call UnitBuffTarget(u, u, 20, 'A1HM', 0)
    endif
    return false
endfunction

function AI_IsTowerMoveOut takes unit u returns boolean
    return GetUnitAbilityLevel(u, 'A19L') >= 1
endfunction

function AI_IsCharacterCountering takes unit u returns boolean
    return GetUnitAbilityLevel(u, 'A19M') >= 1
endfunction

function Trig_AI_Action_All_Tactical_Units takes nothing returns boolean
    if GetUnitAbilityLevel(GetFilterUnit(), 'Aloc') != 0 then
        return false
    endif
    return GetUnitDefaultMoveSpeed(GetFilterUnit()) >= 80.0
endfunction

function AI_IssueAttackOrder takes unit h returns boolean
    local player w = GetOwningPlayer(h)
    local group g = CreateGroup()
    local filterfunc f = Filter(function Trig_AI_Action_All_Tactical_Units)
    local location target
    local integer phase = udg_AI_States[GetPlayerId(w) * 512 + 0 * 16 + 0]
    local integer waypoint = udg_AI_States[GetPlayerId(w) * 512 + 1 * 16 + 0]
    local integer offset
    local integer addset
    call GroupEnumUnitsOfPlayer(g, w, f)
    call DestroyFilter(f)
    if GetUnitAbilityLevel(h, 'A19W') == 0 then
        call UnitAddAbility(h, 'A19W')
        call SetUnitAbilityLevel(h, 'A19W', 1)
    endif
    if GetUnitAbilityLevel(h, 'A1A4') == 0 then
        call UnitAddAbility(h, 'A1A4')
        if w == udg_PlayerA[1] or w == udg_PlayerB[1] then
            call SetUnitAbilityLevel(h, 'A1A4', 1)
        elseif w == udg_PlayerA[2] or w == udg_PlayerB[2] then
            call SetUnitAbilityLevel(h, 'A1A4', 2)
        elseif w == udg_PlayerA[3] or w == udg_PlayerB[3] then
            call SetUnitAbilityLevel(h, 'A1A4', 2)
        elseif w == udg_PlayerA[4] or w == udg_PlayerB[4] then
            call SetUnitAbilityLevel(h, 'A1A4', 3)
        elseif w == udg_PlayerA[5] or w == udg_PlayerB[5] then
            call SetUnitAbilityLevel(h, 'A1A4', 3)
        endif
    endif
    set addset = -8 + 8 * GetUnitAbilityLevel(h, 'A1A4')
    set offset = 32 * GetPlayerForceId(w)
    if udg_GameTime <= 102 and addset == 0 then
        if waypoint >= 2 then
            set waypoint = waypoint - 1
        endif
    elseif udg_GameTime <= 115 and addset > 0 then
        if waypoint >= 2 then
            set waypoint = waypoint - 1
        endif
    endif
    set target = udg_AI_Waypoints[offset + waypoint + 1 + addset]
    if target == null or waypoint >= 7 then
        set target = udg_AI_Waypoints[offset + waypoint + addset]
    endif
    call GroupPointOrderLoc(g, "attack", target)
    set udg_AI_States[GetPlayerId(w) * 512 + 2 * 16 + 0] = 1
    call DestroyGroup(g)
    set w = null
    set g = null
    set f = null
    set target = null
    return false
endfunction

function AI_Teleport takes unit h returns nothing
    local rect base
    if IsPlayerInForce(GetOwningPlayer(h), udg_TeamA) then
        set base = gg_rct_BaseA
    else
        set base = gg_rct_BaseB
    endif
    call UnitBuffTarget(h, h, 10, 'A07Y', 0)
    call IssuePointOrder(h, "massteleport", GetRectCenterX(base), GetRectCenterY(base))
    call THD_AddCredit(GetOwningPlayer(h), -85)
    set base = null
endfunction

function AI_IsTeleport takes unit h returns boolean
    local group g = CreateGroup()
    local unit v
    local boolean ret = true
    call GroupEnumUnitsInRange(g, GetUnitX(h), GetUnitY(h), 1100.0, null)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null or ret == false
        call GroupRemoveUnit(g, v)
        if IsUnitAlly(v, GetOwningPlayer(h)) == false and IsUnitType(v, UNIT_TYPE_HERO) or IsUnitType(v, UNIT_TYPE_STRUCTURE) then
            set ret = false
        endif
    endloop
    if udg_smodestat then
        set ret = false
    endif
    if AI_IsLowHP(h) == false then
        set ret = false
    endif
    if ret then
    else
    endif
    set g = null
    set v = null
    return ret
endfunction

function AI_IssueRetreatOrder takes unit h returns boolean
    local player w = GetOwningPlayer(h)
    local group g = CreateGroup()
    local filterfunc f = Filter(function Trig_AI_Action_All_Tactical_Units)
    local location target
    local integer phase = udg_AI_States[GetPlayerId(w) * 512 + 0 * 16 + 0]
    local integer waypoint = udg_AI_States[GetPlayerId(w) * 512 + 1 * 16 + 0]
    local integer offset
    local integer addset
    call GroupEnumUnitsOfPlayer(g, w, f)
    call DestroyFilter(f)
    if GetUnitAbilityLevel(h, 'A19W') == 0 then
        call UnitAddAbility(h, 'A19W')
        call SetUnitAbilityLevel(h, 'A19W', 2)
    endif
    if GetUnitAbilityLevel(h, 'A1A4') == 0 then
        call UnitAddAbility(h, 'A1A4')
        if w == udg_PlayerA[1] or w == udg_PlayerB[1] then
            call SetUnitAbilityLevel(h, 'A1A4', 1)
        elseif w == udg_PlayerA[2] or w == udg_PlayerB[2] then
            call SetUnitAbilityLevel(h, 'A1A4', 2)
        elseif w == udg_PlayerA[3] or w == udg_PlayerB[3] then
            call SetUnitAbilityLevel(h, 'A1A4', 2)
        elseif w == udg_PlayerA[4] or w == udg_PlayerB[4] then
            call SetUnitAbilityLevel(h, 'A1A4', 3)
        elseif w == udg_PlayerA[5] or w == udg_PlayerB[5] then
            call SetUnitAbilityLevel(h, 'A1A4', 3)
        endif
    endif
    set addset = -8 + 8 * GetUnitAbilityLevel(h, 'A1A4')
    set offset = 32 * GetPlayerForceId(w)
    if waypoint > 0 then
        set target = udg_AI_Waypoints[offset + waypoint - 1 + addset]
    else
        set target = GetPlayerShelter(w)
    endif
    call DebugMsg("AI - Move")
    call GroupPointOrderLoc(g, "move", target)
    set udg_AI_States[GetPlayerId(w) * 512 + 2 * 16 + 0] = 2
    call DestroyGroup(g)
    set w = null
    set f = null
    set g = null
    set target = null
    return false
endfunction

function AI_GetPowerUp_Take takes nothing returns nothing
    local item w = GetEnumItem()
    if bj_lastRemovedItem == null then
        call IssueTargetOrder(bj_lastLoadedUnit, "smart", w)
        set bj_lastRemovedItem = w
    endif
    set w = null
endfunction

function AI_GetPowerUp_Type takes nothing returns boolean
    local integer d = GetItemTypeId(GetFilterItem())
    if d == 'I03H' then
        return true
    elseif d == 'I03F' then
        return GetRandomReal(0, 100.0) < 50.0
    elseif 'I03C' <= d and d <= 'I03E' then
        return true
    endif
    return false
endfunction

function AI_GetPowerUp takes unit h returns nothing
    local real ox = GetUnitX(h)
    local real oy = GetUnitY(h)
    local rect r = Rect(ox - 200.0, oy - 200.0, ox + 200.0, oy + 200.0)
    local boolexpr f = Filter(function AI_GetPowerUp_Type)
    set bj_lastRemovedItem = null
    set bj_lastLoadedUnit = h
    call EnumItemsInRect(r, f, function AI_GetPowerUp_Take)
    set bj_lastRemovedItem = null
    set bj_lastLoadedUnit = null
    call RemoveRect(r)
    call DestroyBoolExpr(f)
    set r = null
    set f = null
endfunction

function Trig_AI_Action_Maintain takes unit h returns boolean
    local integer ID = GetUnitCurrentOrder(h)
    if ID == OrderId("voodoo") then
        return true
    elseif ID == OrderId("blink") then
        return true
    elseif ID == OrderId("massteleport") then
        return true
    endif
    return false
endfunction

function Trig_AI_Action_Offensive takes player who, unit h returns nothing
    local group g
    local filterfunc f
    local unit v
    local integer i
    local location target
    local rect base
    local group enemy
    local location shelter
    local boolean LowHP = AI_IsLowHP(h)
    local boolean LowMP = AI_IsLowMP(h)
    local boolean HighHP = GetUnitLifePercent(h) >= 50.0
    local boolean HighMP = GetUnitManaPercent(h) >= 50.0
    if IsPlayerInForce(who, udg_TeamA) then
        set base = gg_rct_BaseA
        set enemy = udg_AI_Groups[3]
        set shelter = udg_RecoverPoint[0]
        set target = GetRectCenter(gg_rct_SpawnB0)
    else
        set base = gg_rct_BaseB
        set enemy = udg_AI_Groups[2]
        set shelter = udg_RecoverPoint[1]
        set target = GetRectCenter(gg_rct_SpawnA2)
    endif
    if GetUnitAbilityLevel(h, 'A19L') >= 1 then
        set HighHP = false
        set HighMP = false
    endif
    if RectContainsUnit(base, h) then
        call DebugMsg("AI " + GetPlayerName(GetOwningPlayer(h)) + " - In Base")
        if HighHP and HighMP then
            set i = 0
            loop
                set v = GroupPickRandomUnit(enemy)
                if IsUnitEnemy(v, who) and GetWidgetLife(v) > 0.405 then
                    call RemoveLocation(target)
                    set target = GetUnitLoc(v)
                exitwhen true
                endif
                set i = i + 1
            exitwhen i >= 10
            endloop
            call AI_IssueAttackOrder(h)
        endif
    else
        if LowHP then
            if not Trig_AI_Action_Maintain(h) then
                call AI_IssueRetreatOrder(h)
                call UnitBuffTarget(h, h, 10, 'A19L', 0)
            endif
        else
            set i = 0
            loop
                set v = GroupPickRandomUnit(enemy)
                if IsUnitEnemy(v, who) and GetWidgetLife(v) > 0.405 then
                    call RemoveLocation(target)
                    set target = GetUnitLoc(v)
                exitwhen true
                endif
                set i = i + 1
            exitwhen i >= 10
            endloop
            set g = CreateGroup()
            set f = Filter(function Trig_AI_Action_All_Tactical_Units)
            call GroupEnumUnitsOfPlayer(g, who, f)
            call DestroyFilter(f)
            call AI_IssueAttackOrder(h)
            call DestroyGroup(g)
        endif
    endif
    call RemoveLocation(target)
    set f = null
    set who = null
    set h = null
    set v = null
    set g = null
    set target = null
    set base = null
    set enemy = null
    set shelter = null
endfunction

function Trig_AI_Action_Defensive takes player who, unit h returns nothing
    local location target
    local rect base
    local group enemy
    local location shelter
    local boolean LowHP = AI_IsLowHP(h)
    local boolean LowMP = AI_IsLowMP(h)
    local boolean HighHP = GetUnitLifePercent(h) >= 50.0
    local boolean HighMP = GetUnitManaPercent(h) >= 50.0
    if IsPlayerInForce(who, udg_TeamA) then
        set base = gg_rct_BaseA
        set enemy = udg_AI_Groups[3]
        set shelter = udg_RecoverPoint[0]
    else
        set base = gg_rct_BaseB
        set enemy = udg_AI_Groups[2]
        set shelter = udg_RecoverPoint[1]
    endif
    set target = GetUnitLoc(h)
    if GetUnitAbilityLevel(h, 'A19L') >= 1 then
        set HighHP = false
        set HighMP = false
    endif
    if LowHP then
        call AI_IssueRetreatOrder(h)
    elseif DistanceBetweenPoints(shelter, target) < 4800.0 and not (HighHP and HighMP) then
        call AI_IssueRetreatOrder(h)
    elseif GetUnitCurrentOrder(h) <= 852032 then
        call AI_GetPowerUp(h)
    endif
    call RemoveLocation(target)
    set who = null
    set h = null
    set target = null
    set base = null
    set enemy = null
    set shelter = null
endfunction

function AI_TowerRetreatOrderation takes unit h, unit tower returns nothing
    local group g = CreateGroup()
    local unit v
    local real retreatime
    call GroupEnumUnitsInRange(g, GetUnitX(h), GetUnitY(h), 600.0, null)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if IsUnitAlly(v, GetOwningPlayer(h)) and IsUnitType(v, UNIT_TYPE_HERO) == false and GetUnitAbilityLevel(v, 'A0IL') > 0 == false then
            if IsUnitType(v, UNIT_TYPE_STRUCTURE) == false and GetUnitAbilityLevel(v, 'A0ZU') > 0 == false then
                set retreatime = 3
            endif
        endif
    endloop
    if retreatime > 0 then
        call UnitBuffTarget(h, h, retreatime, 'A19L', 0)
        call AI_IssueRetreatOrder(h)
        set g = null
        set v = null
        return
    endif
    call GroupEnumUnitsInRange(g, GetUnitX(h), GetUnitY(h), 1200.0, null)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if IsUnitAlly(v, GetOwningPlayer(h)) and IsUnitType(v, UNIT_TYPE_HERO) == false and GetUnitAbilityLevel(v, 'A0IL') > 0 == false then
            if IsUnitType(v, UNIT_TYPE_STRUCTURE) == false and GetUnitAbilityLevel(v, 'A0ZU') > 0 == false then
                set retreatime = 5
            endif
        endif
    endloop
    if retreatime > 0 then
        call UnitBuffTarget(h, h, retreatime, 'A19L', 0)
        call AI_IssueRetreatOrder(h)
        set g = null
        set v = null
        return
    endif
    call GroupEnumUnitsInRange(g, GetUnitX(h), GetUnitY(h), 1800.0, null)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if IsUnitAlly(v, GetOwningPlayer(h)) and IsUnitType(v, UNIT_TYPE_HERO) == false and GetUnitAbilityLevel(v, 'A0IL') > 0 == false then
            if IsUnitType(v, UNIT_TYPE_STRUCTURE) == false and GetUnitAbilityLevel(v, 'A0ZU') > 0 == false then
                set retreatime = 8
            endif
        endif
    endloop
    call DestroyGroup(g)
    if retreatime > 0 then
        call UnitBuffTarget(h, h, retreatime, 'A19L', 0)
        call AI_IssueRetreatOrder(h)
        set g = null
        set v = null
        return
    endif
    set retreatime = 11
    call UnitBuffTarget(h, h, retreatime, 'A19L', 0)
    call AI_IssueRetreatOrder(h)
    set g = null
    set v = null
endfunction

function Trig_Initialization_AIActions takes nothing returns nothing
    local integer i
    local unit u
    set i = 0
    loop
    exitwhen i >= 8192
        set udg_AI_States[i] = 0
        set i = i + 1
    endloop
    call TriggerSleepAction(0.3)
    set i = 0
    loop
    exitwhen i >= 64
        set udg_AI_Waypoints[i] = null
        set i = i + 1
    endloop
    if udg_TestMode then
    else
        call DoNothing()
    endif
    set i = 0
    set udg_AI_Waypoints[i] = GetRectCenter(gg_rct_BaseA)
    set i = i + 1
    set udg_AI_Waypoints[i] = GetRectCenter(gg_rct_AI_Waypoint_00)
    set i = i + 1
    set udg_AI_Waypoints[i] = GetRectCenter(gg_rct_AI_Waypoint_01)
    set i = i + 1
    set udg_AI_Waypoints[i] = GetRectCenter(gg_rct_AI_Waypoint_02)
    set i = i + 1
    set udg_AI_Waypoints[i] = GetRectCenter(gg_rct_AI_Waypoint_03)
    set i = i + 1
    set udg_AI_Waypoints[i] = GetRectCenter(gg_rct_AI_Waypoint_04)
    set i = i + 1
    set udg_AI_Waypoints[i] = GetRectCenter(gg_rct_AI_Waypoint_05)
    set i = i + 1
    set udg_AI_Waypoints[i] = GetRectCenter(gg_rct_BaseB)
    set i = i + 1
    set udg_AI_Waypoints[i] = GetRectCenter(gg_rct_BaseA)
    set i = i + 1
    set udg_AI_Waypoints[i] = GetRectCenter(gg_rct_AI_Waypoint_B0)
    set i = i + 1
    set udg_AI_Waypoints[i] = GetRectCenter(gg_rct_AI_Waypoint_B1)
    set i = i + 1
    set udg_AI_Waypoints[i] = GetRectCenter(gg_rct_AI_Waypoint_B2)
    set i = i + 1
    set udg_AI_Waypoints[i] = GetRectCenter(gg_rct_AI_Waypoint_B3)
    set i = i + 1
    set udg_AI_Waypoints[i] = GetRectCenter(gg_rct_AI_Waypoint_B4)
    set i = i + 1
    set udg_AI_Waypoints[i] = GetRectCenter(gg_rct_AI_Waypoint_B5)
    set i = i + 1
    set udg_AI_Waypoints[i] = GetRectCenter(gg_rct_BaseB)
    set i = i + 1
    set udg_AI_Waypoints[i] = GetRectCenter(gg_rct_BaseA)
    set i = i + 1
    set udg_AI_Waypoints[i] = GetRectCenter(gg_rct_AI_Waypoint_C0)
    set i = i + 1
    set udg_AI_Waypoints[i] = GetRectCenter(gg_rct_AI_Waypoint_C1)
    set i = i + 1
    set udg_AI_Waypoints[i] = GetRectCenter(gg_rct_AI_Waypoint_C2)
    set i = i + 1
    set udg_AI_Waypoints[i] = GetRectCenter(gg_rct_AI_Waypoint_C3)
    set i = i + 1
    set udg_AI_Waypoints[i] = GetRectCenter(gg_rct_AI_Waypoint_C4)
    set i = i + 1
    set udg_AI_Waypoints[i] = GetRectCenter(gg_rct_AI_Waypoint_C5)
    set i = i + 1
    set udg_AI_Waypoints[i] = GetRectCenter(gg_rct_BaseB)
    set i = 32
    set udg_AI_Waypoints[i] = GetRectCenter(gg_rct_BaseB)
    set i = i + 1
    set udg_AI_Waypoints[i] = GetRectCenter(gg_rct_AI_Waypoint_05)
    set i = i + 1
    set udg_AI_Waypoints[i] = GetRectCenter(gg_rct_AI_Waypoint_04)
    set i = i + 1
    set udg_AI_Waypoints[i] = GetRectCenter(gg_rct_AI_Waypoint_03)
    set i = i + 1
    set udg_AI_Waypoints[i] = GetRectCenter(gg_rct_AI_Waypoint_02)
    set i = i + 1
    set udg_AI_Waypoints[i] = GetRectCenter(gg_rct_AI_Waypoint_01)
    set i = i + 1
    set udg_AI_Waypoints[i] = GetRectCenter(gg_rct_AI_Waypoint_00)
    set i = i + 1
    set udg_AI_Waypoints[i] = GetRectCenter(gg_rct_BaseA)
    set i = i + 1
    set udg_AI_Waypoints[i] = GetRectCenter(gg_rct_BaseB)
    set i = i + 1
    set udg_AI_Waypoints[i] = GetRectCenter(gg_rct_AI_Waypoint_B5)
    set i = i + 1
    set udg_AI_Waypoints[i] = GetRectCenter(gg_rct_AI_Waypoint_B4)
    set i = i + 1
    set udg_AI_Waypoints[i] = GetRectCenter(gg_rct_AI_Waypoint_B3)
    set i = i + 1
    set udg_AI_Waypoints[i] = GetRectCenter(gg_rct_AI_Waypoint_B2)
    set i = i + 1
    set udg_AI_Waypoints[i] = GetRectCenter(gg_rct_AI_Waypoint_B1)
    set i = i + 1
    set udg_AI_Waypoints[i] = GetRectCenter(gg_rct_AI_Waypoint_B0)
    set i = i + 1
    set udg_AI_Waypoints[i] = GetRectCenter(gg_rct_BaseA)
    set i = i + 1
    set udg_AI_Waypoints[i] = GetRectCenter(gg_rct_BaseB)
    set i = i + 1
    set udg_AI_Waypoints[i] = GetRectCenter(gg_rct_AI_Waypoint_C5)
    set i = i + 1
    set udg_AI_Waypoints[i] = GetRectCenter(gg_rct_AI_Waypoint_C4)
    set i = i + 1
    set udg_AI_Waypoints[i] = GetRectCenter(gg_rct_AI_Waypoint_C3)
    set i = i + 1
    set udg_AI_Waypoints[i] = GetRectCenter(gg_rct_AI_Waypoint_C2)
    set i = i + 1
    set udg_AI_Waypoints[i] = GetRectCenter(gg_rct_AI_Waypoint_C1)
    set i = i + 1
    set udg_AI_Waypoints[i] = GetRectCenter(gg_rct_AI_Waypoint_C0)
    set i = i + 1
    set udg_AI_Waypoints[i] = GetRectCenter(gg_rct_BaseA)
    set i = 0
    loop
    exitwhen i >= 64
        if udg_AI_Waypoints[i] != null then
            set u = CreateUnitAtLoc(Player(15), 'n004', udg_AI_Waypoints[i], 270.0)
            call TriggerRegisterUnitInRange(gg_trg_AI_Waypoints, u, 300.0, null)
        endif
        set i = i + 1
    endloop
    set u = null
endfunction

function InitTrig_Initialization_AI takes nothing returns nothing
    set gg_trg_Initialization_AI = CreateTrigger()
    call TriggerAddAction(gg_trg_Initialization_AI, function Trig_Initialization_AIActions)
endfunction