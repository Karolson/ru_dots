function Trig_Eirin02_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A083'
endfunction

function Trig_Eirin02_Target takes nothing returns boolean
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

function Trig_Eirin02_Damage takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 1)
    local real x = LoadReal(udg_ht, task, 3)
    local real y = LoadReal(udg_ht, task, 4)
    local real damage = LoadReal(udg_ht, task, 2)
    local integer count = LoadInteger(udg_ht, task, 5) + 1
    local unit u = LoadUnitHandle(udg_ht, task, 6)
    local group g
    local unit v
    set g = CreateGroup()
    call GroupEnumUnitsInRange(g, x, y, 250.0, null)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if IsUnitType(v, UNIT_TYPE_DEAD) == false and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false and IsUnitAlly(caster, GetOwningPlayer(v)) and GetUnitAbilityLevel(v, 'A0IL') > 0 == false then
            call UnitHealingTarget(caster, v, damage)
        endif
    endloop
    call DestroyGroup(g)
    call UnitMagicDamageArea(caster, x, y, 300, damage, 6)
    call SaveInteger(udg_ht, task, 5, count)
    if count >= 10 then
        call UnitRemoveAbility(u, 'A085')
        call ReleaseDummy(u)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
endfunction

function Trig_Eirin02_Main takes nothing returns nothing
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
    local real dx = GetUnitX(caster) - ox
    local real dy = GetUnitY(caster) - oy
    local real stuntime
    local timer t2
    local integer task2
    local integer level = LoadInteger(udg_ht, task, 0)
    local integer i = LoadInteger(udg_ht, task, 1)
    local group g = CreateGroup()
    local boolexpr f = Filter(function Trig_Eirin02_Target)
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
        set stuntime = SquareRoot(dx * dx + dy * dy) * 0.0015
        if stuntime >= 2 then
            set stuntime = 2
        endif
        if IsUnitEnemy(v, GetOwningPlayer(caster)) then
            call UnitAbsDamageTarget(caster, v, 30.0 * level + 1.4 * GetHeroInt(caster, true))
            call UnitStunTarget(caster, v, stuntime, 0, 0)
        else
            call UnitHealingTarget(caster, v, 30.0 * level + 1.4 * GetHeroInt(caster, true))
        endif
        set u = NewDummy(GetOwningPlayer(caster), ox, oy, 180.0)
        call UnitAddAbility(u, 'A085')
        call SetUnitAbilityLevel(u, 'A085', level)
        call IssuePointOrder(u, "healingspray", ox, oy)
        set t2 = CreateTimer()
        set task2 = GetHandleId(t2)
        call SaveUnitHandle(udg_ht, task2, 1, caster)
        call SaveReal(udg_ht, task2, 2, 7.5 * level + 0.06 * GetHeroInt(caster, true))
        call SaveReal(udg_ht, task2, 3, ox)
        call SaveReal(udg_ht, task2, 4, oy)
        call SaveInteger(udg_ht, task2, 5, 0)
        call SaveUnitHandle(udg_ht, task2, 6, u)
        call TimerStart(t2, 0.3, true, function Trig_Eirin02_Damage)
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
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set u = null
    set v = null
    set g = null
    set f = null
    set t2 = null
endfunction

function Trig_Eirin02_Actions takes nothing returns nothing
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
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 20)
    call UnitMagicDamageTarget(caster, caster, 50, 1)
    set px = ox + 100.0 * CosBJ(a)
    set py = oy + 100.0 * SinBJ(a)
    set u = CreateUnit(GetOwningPlayer(caster), 'e00K', px, py, a)
    set u2 = CreateUnit(GetOwningPlayer(caster), 'e021', px, py, a)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, u)
    call SaveUnitHandle(udg_ht, task, 2, u2)
    call SaveInteger(udg_ht, task, 0, level)
    call SaveInteger(udg_ht, task, 1, 116)
    call SaveReal(udg_ht, task, 0, a)
    call TimerStart(t, 0.02, true, function Trig_Eirin02_Main)
    set caster = null
    set u = null
    set u2 = null
    set t = null
endfunction

function InitTrig_Eirin02 takes nothing returns nothing
endfunction