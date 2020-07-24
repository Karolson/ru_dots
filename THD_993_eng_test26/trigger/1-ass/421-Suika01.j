function Trig_Suika01_Use_Conditions takes nothing returns boolean
    if GetSpellAbilityId() == 'A10B' then
        return false
    endif
    return GetSpellAbilityId() == 'A05R'
endfunction

function Trig_Suika01_Use_Actions_Sources_Filter takes nothing returns boolean
    if IsUnitType(GetFilterUnit(), UNIT_TYPE_ANCIENT) then
        return false
    elseif IsUnitType(GetFilterUnit(), UNIT_TYPE_STRUCTURE) then
        return false
    elseif IsUnitType(GetFilterUnit(), UNIT_TYPE_FLYING) then
        return false
    elseif GetFilterUnit() == GetSpellAbilityUnit() then
        return false
    elseif GetWidgetLife(GetFilterUnit()) < 0.405 then
        return false
    elseif IsUnitType(GetFilterUnit(), UNIT_TYPE_DEAD) then
        return false
    elseif IsUnitVisible(GetFilterUnit(), GetOwningPlayer(GetSpellAbilityUnit())) == false then
        return false
    elseif GetUnitAbilityLevel(GetFilterUnit(), 'Aloc') != 0 then
        return false
    elseif GetUnitAbilityLevel(GetFilterUnit(), 'Avul') != 0 then
        return false
    elseif GetUnitTypeId(GetFilterUnit()) == 'n001' or GetUnitTypeId(GetFilterUnit()) == 'n004' then
        return false
    elseif GetUnitAbilityLevel(GetFilterUnit(), 'Avul') != 0 then
        return false
    endif
    return IsMobileUnit(GetFilterUnit())
endfunction

function Trig_Suika01_Use_Actions_Kill_Trees takes nothing returns nothing
    call KillDestructable(GetEnumDestructable())
endfunction

function Trig_Suika01_Use_Actions_Loop takes nothing returns nothing
    local timer tm = GetExpiredTimer()
    local integer task = GetHandleId(tm)
    local integer i = LoadInteger(udg_sht, task, 5)
    local unit suika
    local unit obj = LoadUnitHandle(udg_sht, task, 1)
    local unit m
    local real h = (i - 25) * (i - 25)
    local real ux = LoadReal(udg_sht, task, 0)
    local real uy = LoadReal(udg_sht, task, 1)
    local real lx = LoadReal(udg_sht, task, 2)
    local real ly = LoadReal(udg_sht, task, 3)
    local real x = GetUnitX(obj)
    local real y = GetUnitY(obj)
    local real damage
    local group g
    local boolexpr iff
    local location loc = Location(x, y)
    call DebugMsg("Timer udg_Run " + I2S(i))
    if IsTerrainPathable(lx, ly, PATHING_TYPE_WALKABILITY) == false then
        call SetUnitX(obj, ux + (lx - ux) / 50 * i)
        call SetUnitY(obj, uy + (ly - uy) / 50 * i)
    else
        if IsTerrainPathable(x, y, PATHING_TYPE_WALKABILITY) == false then
            call SetUnitX(obj, ux + (lx - ux) / 50 * i)
            call SetUnitY(obj, uy + (ly - uy) / 50 * i)
        else
            call SetUnitX(obj, x)
            call SetUnitY(obj, y)
        endif
    endif
    call SetUnitFlyHeight(obj, 775 - h, 0)
    call SaveInteger(udg_sht, task, 5, i + 1)
    if i > 50 then
        call SetUnitFlyHeight(obj, GetUnitDefaultFlyHeight(obj), 0)
        call PauseUnit(obj, false)
        call SetUnitPathing(obj, true)
        call SetUnitFlag(obj, 4, false)
        call SetUnitFlag(obj, 3, false)
        call TerrainDeformationRippleBJ(0.2, true, loc, 1.0, 300.0, 96.0, 1, 64.0)
        set suika = LoadUnitHandle(udg_sht, task, 0)
        set damage = LoadReal(udg_sht, task, 4)
        call UnitPhysicalDamageTarget(suika, obj, 0.5 * damage)
        if IsUnitAlly(obj, GetOwningPlayer(suika)) then
            call UnitPhysicalDamageTarget(suika, obj, 0.5 * damage)
        else
            call UnitPhysicalDamageTarget(suika, obj, 1.5 * damage * 0.2)
            call UnitPhysicalDamageTarget(suika, obj, 1.5 * damage * 0.2)
            call UnitPhysicalDamageTarget(suika, obj, 1.5 * damage * 0.2)
            call UnitPhysicalDamageTarget(suika, obj, 1.5 * damage * 0.2)
            call UnitPhysicalDamageTarget(suika, obj, 1.5 * damage * 0.2)
        endif
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Orc\\WarStomp\\WarStompCaster.mdl", GetUnitX(obj), GetUnitY(obj)))
        set iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(suika))]
        set g = CreateGroup()
        call GroupEnumUnitsInRange(g, x, y, 220, iff)
        loop
            set m = FirstOfGroup(g)
        exitwhen m == null
            if m != obj and GetWidgetLife(m) > 0.405 and not (GetUnitAbilityLevel(m, 'A0IL') > 0) and not IsUnitType(m, UNIT_TYPE_STRUCTURE) then
                call UnitPhysicalDamageTarget(suika, m, damage * 0.2)
                call UnitPhysicalDamageTarget(suika, m, damage * 0.2)
                call UnitPhysicalDamageTarget(suika, m, damage * 0.2)
                call UnitPhysicalDamageTarget(suika, m, damage * 0.2)
                call UnitPhysicalDamageTarget(suika, m, damage * 0.2)
            endif
            call GroupRemoveUnit(g, m)
        endloop
        call DestroyGroup(g)
        set iff = null
        call YDWEEnumDestructablesInCircleBJNull(300, loc, function Trig_Suika01_Use_Actions_Kill_Trees)
        call FlushChildHashtable(udg_sht, task)
        call ReleaseTimer(tm)
    endif
    call RemoveLocation(loc)
    set tm = null
    set suika = null
    set obj = null
    set loc = null
    set g = null
    set m = null
endfunction

function Trig_Suika01_Use_Actions takes nothing returns nothing
    local timer tm
    local integer task
    local group g
    local boolexpr f
    local unit u = GetTriggerUnit()
    local unit obj
    if GetTriggerEventId() == EVENT_UNIT_SPELL_CAST then
        set g = CreateGroup()
        set f = Filter(function Trig_Suika01_Use_Actions_Sources_Filter)
        call GroupEnumUnitsInRange(g, GetUnitX(u), GetUnitY(u), 300, f)
        set obj = GetClosestUnitInGroup(GetUnitX(u), GetUnitY(u), g)
        call DestroyBoolExpr(f)
        call DestroyGroup(g)
        if obj == null then
            call DisplayTextToPlayer(GetOwningPlayer(u), 0, 0, "No throwable target")
            call PauseUnit(u, true)
            call IssueImmediateOrder(u, "stop")
            call PauseUnit(u, false)
        else
            call SaveUnitHandle(udg_ht, GetHandleId(GetTriggeringTrigger()), 1, obj)
        endif
    else
        set obj = LoadUnitHandle(udg_ht, GetHandleId(GetTriggeringTrigger()), 1)
        if obj != null and GetUnitAbilityLevel(obj, 'Avul') == 0 then
            call AbilityCoolDownResetion(u, GetSpellAbilityId(), 14)
            call SetUnitAnimationByIndex(u, 4)
            call PauseUnit(obj, true)
            call SetUnitPathing(obj, false)
            call EnableHeight(obj)
            call SetUnitFlag(obj, 4, true)
            call SetUnitFlag(obj, 3, true)
            set tm = CreateTimer()
            set task = GetHandleId(tm)
            call SaveUnitHandle(udg_sht, task, 0, u)
            call SaveUnitHandle(udg_sht, task, 1, obj)
            call SaveReal(udg_sht, task, 0, GetUnitX(u))
            call SaveReal(udg_sht, task, 1, GetUnitY(u))
            call SaveReal(udg_sht, task, 2, GetSpellTargetX())
            call SaveReal(udg_sht, task, 3, GetSpellTargetY())
            call SaveReal(udg_sht, task, 4, 60.0 * GetUnitAbilityLevel(u, 'A05R') - 45 + 1.2 * GetUnitAttack(u))
            call SaveInteger(udg_sht, task, 5, 1)
            call TimerStart(tm, 0.02, true, function Trig_Suika01_Use_Actions_Loop)
        endif
    endif
    set f = null
    set tm = null
    set g = null
    set u = null
    set obj = null
endfunction

function InitTrig_Suika01 takes nothing returns nothing
endfunction