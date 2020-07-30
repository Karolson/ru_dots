function Trig_Sakuya02_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A1IA'
endfunction

function Trig_Sakuya02_SectorDamage takes unit caster, real damage, real ox, real oy, real a, real f, real r returns nothing
    local real e
    local real d
    local real dx
    local real dy
    local unit v
    local group g = CreateGroup()
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    call GroupEnumUnitsInRange(g, ox, oy, r, iff)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if GetWidgetLife(v) > 0.405 and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false and GetUnitAbilityLevel(v, 'A0IL') > 0 == false then
            set dx = GetUnitX(v) - ox
            set dy = GetUnitY(v) - oy
            set d = SquareRoot(dx * dx + dy * dy)
            set e = RAbsBJ(YawError(a, bj_RADTODEG * Atan2(dy, dx)))
            if e <= f + 0.03 * (800.0 - d) then
                call UnitMagicDamageTarget(caster, v, damage, 5)
                call VE_Sword(v)
            endif
        endif
    endloop
    call DestroyGroup(g)
    set v = null
    set g = null
    set iff = null
endfunction

function Sakuya02_Danmaku_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit u = LoadUnitHandle(udg_ht, task, 2)
    local unit target = LoadUnitHandle(udg_ht, task, 3)
    local integer level = LoadInteger(udg_ht, task, 1)
    local real ox = GetUnitX(u)
    local real oy = GetUnitY(u)
    local real tx = GetUnitX(target)
    local real ty = GetUnitY(target)
    local real dis = SquareRoot((ty - oy) * (ty - oy) + (tx - ox) * (tx - ox))
    local real anglea = bj_RADTODEG * Atan2(ty - oy, tx - ox)
    local real angle = LoadReal(udg_ht, task, 6)
    local real v = LoadReal(udg_ht, task, 4)
    local real a = LoadReal(udg_ht, task, 5) + 0.0004
    local real ax = v * CosBJ(angle)
    local real ay = v * SinBJ(angle)
    local real angledelta = LoadReal(udg_ht, task, 9)
    local integer cnt = LoadInteger(udg_ht, task, 7) - 1
    call SaveInteger(udg_ht, task, 7, cnt)
    call SaveReal(udg_ht, task, 5, a)
    if cnt < 0 then
        set a = a * 2
    endif
    if cnt < 0 then
        if cnt < -50 then
            call SetUnitX(u, tx - (dis - 18) * CosBJ(anglea))
            call SetUnitY(u, ty - (dis - 18) * SinBJ(anglea))
            call SetUnitFacing(u, anglea)
        else
            if anglea < 0 then
                set anglea = anglea + 360
            endif
            set ax = ax + a * CosBJ(anglea)
            set ay = ay + a * SinBJ(anglea)
            set angle = bj_RADTODEG * Atan2(ay, ax)
            if angle < 0 then
                set angle = angle + 360
            endif
            set v = SquareRoot(ax * ax + ay * ay)
            call SaveReal(udg_ht, task, 4, v)
            call SaveReal(udg_ht, task, 6, angle)
            if IsTerrainPathable(ox + v * CosBJ(angle), oy + v * SinBJ(angle), PATHING_TYPE_FLYABILITY) == false then
                call SetUnitX(u, ox + v * CosBJ(angle))
                call SetUnitY(u, oy + v * SinBJ(angle))
            endif
            call SetUnitFacing(u, angle)
        endif
    else
        if IsTerrainPathable(GetUnitX(caster) - (150 - cnt * 3) * 1.7 * CosBJ(cnt * 5.0 + angledelta), GetUnitY(caster) - (150 - cnt * 3) * 1.7 * SinBJ(cnt * 5.0 + angledelta), PATHING_TYPE_FLYABILITY) == false then
            call SetUnitX(u, GetUnitX(caster) - (150 - cnt * 3) * 1.7 * CosBJ(cnt * 5.0 + angledelta))
            call SetUnitY(u, GetUnitY(caster) - (150 - cnt * 3) * 1.7 * SinBJ(cnt * 5.0 + angledelta))
            call SetUnitFacing(u, cnt * 1.4 + angledelta + 90)
        endif
        call SaveReal(udg_ht, task, 6, anglea)
        set u = null
        set t = null
        set caster = null
        set target = null
        return
    endif
    if GetWidgetLife(target) >= 0.405 == false or GetWidgetLife(caster) >= 0.405 == false or GetWidgetLife(u) >= 0.405 == false or u == null or dis >= 3600 then
        call DebugMsg("End")
        call KillUnit(u)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    elseif dis < 80 then
        if target != caster then
            call UnitMagicDamageTarget(caster, target, ABCIAllInt(caster, 15 + 35 * level, 0.8), 5)
        endif
        if IsUnitType(target, UNIT_TYPE_HERO) == false then
            call UnitStunTarget(caster, target, 2.0, 0, 0)
        endif
        call KillUnit(u)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set u = null
    set t = null
    set caster = null
    set target = null
endfunction

function Sakuya02_Danmaku takes unit caster, unit target, real angledelta, integer level returns nothing
    local timer t
    local integer task
    local unit u
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real tx = GetUnitX(target)
    local real ty = GetUnitY(target)
    local real a = Atan2(ty - oy, tx - ox)
    local unit eu = CreateUnit(GetOwningPlayer(caster), 'o00T', ox, oy, 0)
    set t = CreateTimer()
    set task = GetHandleId(t)
    set u = eu
    call SetUnitPathing(u, false)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveInteger(udg_ht, task, 1, level)
    call SaveUnitHandle(udg_ht, task, 2, u)
    call SaveUnitHandle(udg_ht, task, 3, target)
    call SaveReal(udg_ht, task, 4, 25)
    call SaveReal(udg_ht, task, 5, 0.75)
    call SaveReal(udg_ht, task, 6, GetRandomInt(0, 360))
    call SaveInteger(udg_ht, task, 7, 50)
    call SaveReal(udg_ht, task, 9, angledelta)
    call TimerStart(t, 0.02, true, function Sakuya02_Danmaku_Main)
    set t = null
    set u = null
    set eu = null
endfunction

function Trig_Sakuya02_New_CallBack takes nothing returns nothing
    local unit caster = udg_PS_Source
    local unit target = udg_PS_Target
    local integer level = GetUnitAbilityLevel(caster, 'A1IA')
    local real damage = ABCIAllInt(caster, 15 + 35 * level, 0.8)
    if target != caster then
        call UnitMagicDamageTarget(caster, target, damage, 5)
        if IsUnitType(target, UNIT_TYPE_HERO) then
            call UnitDamageTarget(caster, GetEnteringUnit(), 1.5, true, false, ATTACK_TYPE_HERO, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
        endif
    endif
    if IsUnitType(target, UNIT_TYPE_HERO) == false then
        call UnitStunTarget(caster, target, 2.5, 0, 0)
    endif
    call VE_Sword(target)
endfunction

function Trig_Sakuya02_New_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local integer i = 0
    local real x
    local real y
    local unit v
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local integer max = LoadInteger(udg_ht, task, -1)
    loop
    exitwhen i >= max
        set x = LoadReal(udg_ht, task, 10 * i + 1)
        set y = LoadReal(udg_ht, task, 10 * i + 2)
        set v = LoadUnitHandle(udg_ht, task, 10 * i + 3)
        if GetWidgetLife(v) >= 0.405 then
            call DestroyEffect(AddSpecialEffect("Shot_02.mdx", x, y))
            call LaunchProjectileToUnitEx("dagger.mdl", 1.2, caster, x, y, 1400, v, "Trig_Sakuya02_New_CallBack")
        endif
        set i = i + 1
    endloop
    set v = null
    set caster = null
    set t = null
endfunction

function Trig_Sakuya02_New_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real rx
    local real ry
    local real a = GetUnitFacing(caster) + 180 - 60
    local integer i = 0
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    local group g = CreateGroup()
    local unit v
    local integer k = GetPlayerId(GetOwningPlayer(GetTriggerUnit())) + 1
    if udg_SK_Sakuya04_Mana02[k] != 0 then
        call SetUnitState(caster, UNIT_STATE_MANA, RMaxBJ(GetUnitState(caster, UNIT_STATE_MANA) - (40 + level * 15) * 0.75, 0))
    endif
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 18 - level * 3)
    call GroupEnumUnitsInRange(g, ox, oy, 400, iff)
    loop
        set v = null
        loop
            set v = FirstOfGroup(g)
            call GroupRemoveUnit(g, v)
        exitwhen (GetWidgetLife(v) >= 0.405 and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false) or v == null
            set v = null
        endloop
    exitwhen i >= 5
        set rx = ox + Cos(a * bj_DEGTORAD) * (150 + 100)
        set ry = oy + Sin(a * bj_DEGTORAD) * (150 + 100)
        call DestroyEffect(AddSpecialEffect("Shot_02.mdx", rx, ry))
        if v != null then
            call LaunchProjectileToUnitEx("dagger.mdl", 1.2, caster, rx, ry, 1400, v, "Trig_Sakuya02_New_CallBack")
        else
            call LaunchProjectileToUnitEx("dagger.mdl", 1.2, caster, rx, ry, 1400, caster, "Trig_Sakuya02_New_CallBack")
        endif
        set a = a + 30
        set i = i + 1
    endloop
    call DestroyGroup(g)
    set g = null
    set iff = null
    set caster = null
endfunction

function Trig_Sakuya02_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit u
    local player w = GetOwningPlayer(caster)
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real tx = GetSpellTargetX()
    local real ty = GetSpellTargetY()
    local real dx = tx - ox
    local real dy = ty - oy
    local real a = 57.29578 * Atan2(dy, dx)
    local real f
    local real damage
    local integer level = GetUnitAbilityLevel(caster, 'A099')
    local integer i
    local integer n
    local integer k = GetPlayerId(GetOwningPlayer(GetTriggerUnit())) + 1
    call AbilityCoolDownResetion(caster, 'A099', 6)
    set damage = (20.0 + 25.0 * level + GetUnitAttack(caster) * 0.8) * (1 + GetHeroInt(caster, true) * 0.002)
    set f = 10.0 + 20.0 * level
    call Trig_Sakuya02_SectorDamage(caster, damage, ox, oy, a, f * 0.5, 600.0)
    set n = 2 * level + 1
    set i = 1
    set u = NewDummy(w, ox, oy, a)
    call UnitAddAbility(u, 'A09G')
    set a = a - 10 * level
    set tx = ox + 200.0 * Cos(a * 0.017454)
    set ty = oy + 200.0 * Sin(a * 0.017454)
    set i = 1
    loop
    exitwhen i > n
        call IssuePointOrder(u, "carrionswarm", tx, ty)
        set a = a + 10
        set tx = ox + 200.0 * Cos(a * 0.017454)
        set ty = oy + 200.0 * Sin(a * 0.017454)
        set i = i + 1
    endloop
    call UnitRemoveAbility(u, 'A09G')
    call ReleaseDummy(u)
    set u = null
    set caster = null
    set w = null
endfunction

function InitTrig_Sakuya02 takes nothing returns nothing
endfunction