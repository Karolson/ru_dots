function YUKAEX takes nothing returns integer
    return 'A07P'
endfunction

function YUKAEX_MAX_FLOWERS takes nothing returns integer
    return 5
endfunction

function Yuka_Create_Temp_Flower takes unit caster, real x, real y, real duration, integer hp, integer dmg returns unit
    local unit flower = CreateUnit(GetOwningPlayer(caster), 'o00D', x, y, 225.0)
    call UnitAddMaxLife(flower, hp)
    call UnitAddAttackDamage(flower, dmg)
    call UnitAddAbility(flower, 'A0OX')
    call UnitApplyTimedLife(flower, 'BTLF', duration)
    call UnitRemoveAbility(flower, 'Amov')
    set bj_lastCreatedUnit = flower
    set flower = null
    return bj_lastCreatedUnit
endfunction

function YukaFlower_ID takes nothing returns boolean
    return GetUnitTypeId(GetSummonedUnit()) == 'o00C'
endfunction

function YukaFlowers_All takes nothing returns boolean
    if GetUnitTypeId(GetFilterUnit()) == 'o00C' or GetUnitTypeId(GetFilterUnit()) == 'o00D' then
        set bj_groupCountUnits = bj_groupCountUnits + 1
    endif
    return false
endfunction

function YukaFlower_Aura takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local group g = CreateGroup()
    local unit caster = LoadUnitHandle(udg_sht, task, 1)
    local boolexpr filter = LoadBooleanExprHandle(udg_sht, task, 2)
    local integer currentbonus = LoadInteger(udg_sht, task, 3)
    local integer delta
    set bj_groupCountUnits = 0
    call GroupEnumUnitsOfPlayer(g, GetOwningPlayer(caster), filter)
    set delta = bj_groupCountUnits * 2 - currentbonus
    set bj_groupCountUnits = 0
    if delta > 0 then
        call UnitAddAttackDamage(caster, delta)
        if udg_SK_Yuka_Unit != null then
            call UnitAddAttackDamage(udg_SK_Yuka_Unit, delta)
        endif
    elseif delta < 0 then
        call UnitReduceAttackDamage(caster, -delta)
        if udg_SK_Yuka_Unit != null then
            call UnitReduceAttackDamage(udg_SK_Yuka_Unit, -delta)
        endif
    endif
    call SaveInteger(udg_sht, task, 3, currentbonus + delta)
    call DestroyGroup(g)
    set t = null
    set g = null
    set caster = null
    set filter = null
endfunction

function YukaFlower_GetOldest takes nothing returns nothing
    local unit u = GetEnumUnit()
    local integer age
    if GetWidgetLife(u) > 0.405 and not IsUnitType(u, UNIT_TYPE_DEAD) and GetUnitTypeId(u) != 0 then
        set age = GetUnitUserData(u)
        if age < bj_forLoopAIndex then
            set bj_forLoopAIndex = age
            set bj_lastCreatedUnit = u
        endif
    endif
    set u = null
endfunction

function YukaFlower_GetYoungest takes nothing returns nothing
    local unit u = GetEnumUnit()
    local integer age
    if GetWidgetLife(u) > 0.405 and not IsUnitType(u, UNIT_TYPE_DEAD) and GetUnitTypeId(u) != 0 then
        set age = GetUnitUserData(u)
        if age > bj_forLoopAIndex then
            set bj_forLoopAIndex = age
        endif
    endif
    set u = null
endfunction

function YukaFlower_Count takes nothing returns nothing
    local unit u = GetEnumUnit()
    if GetWidgetLife(u) > 0.405 and not IsUnitType(u, UNIT_TYPE_DEAD) and GetUnitTypeId(u) != 0 then
        set bj_groupCountUnits = bj_groupCountUnits + 1
    else
        call GroupRemoveUnit(bj_groupRemoveGroupDest, u)
    endif
    set u = null
endfunction

function YukaFlower_Actions takes nothing returns nothing
    local unit caster = GetSummoningUnit()
    local unit flower = GetSummonedUnit()
    local integer ctask = GetHandleId(caster)
    local integer ttask = GetHandleId(GetTriggeringTrigger())
    local timer t
    local integer task
    local group g
    local boolexpr filter
    call AbilityCoolDownResetion(caster, 'A07P', 4)
    if HaveSavedHandle(udg_sht, ttask, ctask) then
        set g = LoadGroupHandle(udg_sht, ttask, ctask)
    else
        set g = CreateGroup()
        call SaveGroupHandle(udg_sht, ttask, ctask, g)
        set t = CreateTimer()
        set task = GetHandleId(t)
        set filter = Filter(function YukaFlowers_All)
        call SaveUnitHandle(udg_sht, task, 1, caster)
        call SaveBooleanExprHandle(udg_sht, task, 2, filter)
        call SaveInteger(udg_sht, task, 3, 0)
        call TimerStart(t, 0.5, true, function YukaFlower_Aura)
    endif
    set bj_groupCountUnits = 0
    set bj_groupRemoveGroupDest = g
    call ForGroup(g, function YukaFlower_Count)
    set bj_groupRemoveGroupDest = null
    if bj_groupCountUnits >= 5 then
        set bj_forLoopAIndex = 999999
        set bj_lastCreatedUnit = null
        call ForGroup(g, function YukaFlower_GetOldest)
        call GroupRemoveUnit(g, bj_lastCreatedUnit)
        call KillUnit(bj_lastCreatedUnit)
        set bj_lastCreatedUnit = null
    endif
    set bj_groupCountUnits = 0
    set bj_forLoopAIndex = 0
    call ForGroup(g, function YukaFlower_GetYoungest)
    call SetUnitUserData(flower, bj_forLoopAIndex + 1)
    set bj_forLoopAIndex = 0
    call SetUnitFacing(flower, 225.0)
    call SetUnitX(flower, GetUnitX(flower) / 64 * 64)
    call SetUnitY(flower, GetUnitY(flower) / 64 * 64)
    call UnitRemoveAbility(flower, 'Amov')
    call UnitAddAbility(flower, 'A00X')
    call GroupAddUnit(g, flower)
    call UnitAddMaxLife(flower, R2I(GetUnitState(caster, UNIT_STATE_MAX_LIFE) * 0.1))
    call UnitAddAttackDamage(flower, R2I(0.3 * GetUnitAttack(caster)))
    if udg_SK_Yuka_Unit != null then
        call SetUnitState(udg_SK_Yuka_Unit, UNIT_STATE_MANA, GetUnitState(udg_SK_Yuka_Unit, UNIT_STATE_MANA) - 20)
        call IssueImmediateOrderById(udg_SK_Yuka_Unit, 851972)
        call Yuka_Create_Temp_Flower(udg_SK_Yuka_Unit, GetUnitX(udg_SK_Yuka_Unit), GetUnitY(udg_SK_Yuka_Unit), 30.0, R2I(GetUnitState(udg_SK_Yuka_Unit, UNIT_STATE_MAX_LIFE) * 0.2), R2I(0.3 * GetUnitAttack(udg_SK_Yuka_Unit)))
    endif
    set filter = null
    set caster = null
    set flower = null
    set t = null
    set g = null
endfunction

function InitTrig_YukaFlower takes nothing returns nothing
endfunction