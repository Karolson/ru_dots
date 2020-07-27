function Trig_Eirin01_New_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A1BA'
endfunction

function Trig_Eirin01_New_Target takes nothing returns boolean
    if GetWidgetLife(GetFilterUnit()) < 0.405 then
        return false
    endif
    if IsUnitType(GetFilterUnit(), UNIT_TYPE_STRUCTURE) then
        return false
    endif
    if not IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) and not IsUnitAlly(GetFilterUnit(), GetOwningPlayer(GetTriggerUnit())) then
        return false
    endif
    if GetUnitAbilityLevel(GetFilterUnit(), 'Aloc') > 0 then
        return false
    endif
    return true
endfunction

function Trig_Eirin01_New_Damage takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit mcaster = LoadUnitHandle(udg_ht, task, 0)
    local unit caster = LoadUnitHandle(udg_ht, task, 1)
    local real x = LoadReal(udg_ht, task, 3)
    local real y = LoadReal(udg_ht, task, 4)
    local real countset = LoadReal(udg_ht, task, 2)
    local real a
    local integer count = LoadInteger(udg_ht, task, 5) + 1
    local unit u = LoadUnitHandle(udg_ht, task, 6)
    local group g
    local group g2
    local group g3
    local unit v
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    set g = CreateGroup()
    set g2 = CreateGroup()
    set g3 = LoadGroupHandle(udg_ht, task, 0)
    loop
        set v = FirstOfGroup(g3)
    exitwhen v == null
        call GroupRemoveUnit(g3, v)
        call GroupAddUnit(g2, v)
    endloop
    call GroupEnumUnitsInRange(g, x, y, 300.0, iff)
    call GroupClear(g3)
    call GroupEnumUnitsInRange(g3, x, y, 300.0, iff)
    call SaveGroupHandle(udg_ht, task, 0, g3)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g2, v)
        call GroupRemoveUnit(g, v)
    endloop
    loop
        set v = FirstOfGroup(g2)
    exitwhen v == null
        call GroupRemoveUnit(g2, v)
        call DebugMsg("notype call back")
        if IsUnitType(v, UNIT_TYPE_DEAD) == false and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false and GetUnitAbilityLevel(v, 'A0IL') > 0 == false then
            set a = Atan2(GetUnitY(v) - y, GetUnitX(v) - x)
            call SetUnitX(v, x + Cos(a) * 250)
            call SetUnitY(v, y + Sin(a) * 250)
            call DebugMsg("call back")
        endif
    endloop
    call SaveInteger(udg_ht, task, 5, count)
    call DestroyGroup(g)
    call DestroyGroup(g2)
    if count >= countset then
        call DebugMsg("Clear")
        call UnRegisterAreaShow(caster, 'A1BA')
        call UnitRemoveAbility(u, 'A1BB')
        call DestroyGroup(g3)
        call ReleaseDummy(u)
        set udg_SK_EirinD = false
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set g = null
    set g2 = null
    set g3 = null
    set caster = null
endfunction

function Trig_Eirin01_New_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit u = LoadUnitHandle(udg_ht, task, 1)
    local unit u2 = LoadUnitHandle(udg_ht, task, 2)
    local unit v
    local real a = LoadReal(udg_ht, task, 0)
    local real ox = GetUnitX(u)
    local real oy = GetUnitY(u)
    local real px
    local real py
    local timer t2
    local integer task2
    local integer level = LoadInteger(udg_ht, task, 0)
    local integer i = LoadInteger(udg_ht, task, 1)
    local group g = CreateGroup()
    local group g3 = CreateGroup()
    local boolexpr f = Filter(function Trig_Eirin01_New_Target)
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    call GroupEnumUnitsInRange(g, ox, oy, 80.0, f)
    call DestroyBoolExpr(f)
    set v = FirstOfGroup(g)
    call DestroyGroup(g)
    if v != null then
        call KillUnit(u)
        call KillUnit(u2)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
        set i = -1
        if IsUnitAlly(v, GetOwningPlayer(caster)) == false then
            if IsUnitType(v, UNIT_TYPE_HERO) and udg_SK_BLTalismanicAvaliable[GetConvertedPlayerId(GetOwningPlayer(v))] and IsUnitIllusionBJ(v) == false then
                call Item_BLTalismanicRunningCD(v)
                call DestroyGroup(g)
                call ReleaseTimer(t)
                call FlushChildHashtable(udg_ht, task)
                set t = null
                set caster = null
                set u = null
                set u2 = null
                set v = null
                set g = null
                set f = null
                return
            endif
        endif
        set u = NewDummy(GetOwningPlayer(caster), ox, oy, 180.0)
        call UnitAddAbility(u, 'A1BB')
        call SetUnitAbilityLevel(u, 'A1BB', level)
        call IssuePointOrder(u, "healingspray", ox, oy)
        call RegisterAreaShowXY(caster, 'A1BA', GetUnitX(v), GetUnitY(v), 300, 5, 0, "Abilities\\Weapons\\SpiritOfVengeanceMissile\\SpiritOfVengeanceMissile.mdl", 0.02)
        set t2 = CreateTimer()
        set task2 = GetHandleId(t2)
        call SaveUnitHandle(udg_ht, task2, 1, caster)
        call SaveReal(udg_ht, task2, 2, (1.0 + level * 0.5) / 0.02)
        call SaveReal(udg_ht, task2, 3, ox)
        call SaveReal(udg_ht, task2, 4, oy)
        call SaveInteger(udg_ht, task2, 5, 0)
        call GroupEnumUnitsInRange(g3, ox, oy, 300.0, iff)
        call SaveGroupHandle(udg_ht, task2, 0, g3)
        call TimerStart(t2, 0.02, true, function Trig_Eirin01_New_Damage)
    elseif i > 0 then
        set px = ox + 25.0 * CosBJ(a)
        set py = oy + 25.0 * SinBJ(a)
        if SetUnitXYFly(u, px, py) then
            call SetUnitXYFly(u2, px, py)
            call SaveInteger(udg_ht, task, 1, i - 1)
        else
            call SaveInteger(udg_ht, task, 1, 0)
        endif
    else
        if i == 0 then
            call KillUnit(u)
            call KillUnit(u2)
        endif
        set udg_SK_EirinD = false
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set u = null
    set v = null
    set g = null
    set g3 = null
    set f = null
    set t2 = null
endfunction

function Trig_Eirin01_New_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit u
    local unit u2
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real tx = GetSpellTargetX()
    local real ty = GetSpellTargetY()
    local real px
    local real py
    local real a = bj_RADTODEG * Atan2(ty - oy, tx - ox)
    local integer level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 16)
    call UnitMagicDamageTarget(caster, caster, 50, 1)
    set udg_SK_EirinD = true
    set px = ox + 100.0 * CosBJ(a)
    set py = oy + 100.0 * SinBJ(a)
    set u = CreateUnit(GetOwningPlayer(caster), 'e03P', px, py, a)
    set u2 = CreateUnit(GetOwningPlayer(caster), 'e021', px, py, a)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, u)
    call SaveUnitHandle(udg_ht, task, 2, u2)
    call SaveInteger(udg_ht, task, 0, level)
    call SaveInteger(udg_ht, task, 1, 116)
    call SaveReal(udg_ht, task, 0, a)
    call TimerStart(t, 0.02, true, function Trig_Eirin01_New_Main)
    set caster = null
    set u = null
    set u2 = null
    set t = null
endfunction

function InitTrig_Eirin01_New takes nothing returns nothing
endfunction