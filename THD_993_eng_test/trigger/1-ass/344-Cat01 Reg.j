function Cat_GetBodyCount takes unit u returns integer
    local integer ret = 0
    local integer i = 1
    if u == null then
        return 0
    endif
    loop
    exitwhen i > 4
        if GetUnitAbilityLevel(u, 'A1CV' + i) > 0 then
            set ret = i
        endif
        set i = i + 1
    endloop
    return ret
endfunction

function Cat_SetBodyCount takes unit u, integer lvl returns nothing
    local integer i = Cat_GetBodyCount(u)
    if lvl < 0 then
        set lvl = 0
    endif
    if u == null then
        return
    endif
    if i != 0 then
        call UnitRemoveAbility(u, 'A1CV' + i)
    endif
    if lvl != 0 then
        call UnitAddAbility(u, 'A1CV' + lvl)
    endif
endfunction

function Cat_GetMaxiumBody takes unit u returns integer
    local integer lvl = GetHeroLevel(u)
    return 4
endfunction

function Trig_Cat01_Active_Main takes nothing returns nothing
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
    local real a = LoadReal(udg_ht, task, 5) + 0.002
    local real ax = v * CosBJ(angle)
    local real ay = v * SinBJ(angle)
    local real multi = LoadReal(udg_ht, task, 8)
    local integer cnt = LoadInteger(udg_ht, task, 7) - 1
    call SaveInteger(udg_ht, task, 7, cnt)
    call SaveReal(udg_ht, task, 5, a)
    if cnt < 0 then
        set a = a * 2
    endif
    if cnt > 0 then
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
    else
        if IsTerrainPathable(tx - (dis - 25 + a * 4) * CosBJ(anglea), ty - (dis - 25 + a * 4) * SinBJ(anglea), PATHING_TYPE_FLYABILITY) == false then
            call SetUnitX(u, tx - (dis - 35 + a * 4) * CosBJ(anglea))
            call SetUnitY(u, ty - (dis - 35 + a * 4) * SinBJ(anglea))
        endif
    endif
    if dis <= 50 or dis <= 100 or GetWidgetLife(target) >= 0.405 == false or dis >= 3600 then
        call DebugMsg("End")
        call DestroyEffect(AddSpecialEffect("units\\nightelf\\Wisp\\Wisp.mdl", GetUnitX(target), GetUnitY(target)))
        if GetWidgetLife(target) < 0.405 then
            call LaunchProjectileToUnit("GhostBall.MDL", 1.0, u, 1000, caster, "Cat01Ex2_OnFunc")
        else
            call UnitMagicDamageTarget(caster, target, (GetHeroLevel(caster) * 15 + 1.6 * GetHeroInt(caster, true) + 50.0) * 1.0 * multi, 1)
        endif
        call ReleaseTimer(t)
        call KillUnit(u)
        if multi > 0.76 then
            set u = CreateUnit(udg_PlayerB[0], udg_SU_ID_B[0], tx, ty, 0)
            call addlife(u, GetPlayerTechCount(udg_PlayerB[0], 'R003', true) * 22)
            call KillUnit(u)
        endif
        call FlushChildHashtable(udg_ht, task)
    endif
    set u = null
    set t = null
    set caster = null
    set target = null
endfunction

function Cat01_Danmaku takes unit caster, unit target returns nothing
    local timer t
    local integer task
    local unit u
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real tx = GetUnitX(target)
    local real ty = GetUnitY(target)
    local real a = GetRandomInt(0, 360)
    set t = CreateTimer()
    set task = GetHandleId(t)
    set u = CreateUnit(GetOwningPlayer(caster), 'n04W', ox, oy, bj_RADTODEG * a + 150)
    call SetUnitPathing(u, false)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveInteger(udg_ht, task, 1, GetRandomInt(1, 12))
    call SaveUnitHandle(udg_ht, task, 2, u)
    call SaveUnitHandle(udg_ht, task, 3, target)
    call SaveReal(udg_ht, task, 4, 20)
    call SaveReal(udg_ht, task, 5, 0.45)
    call SaveReal(udg_ht, task, 6, bj_RADTODEG * a + 160 + GetRandomInt(0, 40))
    call SaveInteger(udg_ht, task, 7, 15)
    if Cat_GetBodyCount(caster) == 0 then
        call SaveReal(udg_ht, task, 8, 0.5)
    else
        call SaveReal(udg_ht, task, 8, 1.0)
    endif
    call TimerStart(t, 0.02, true, function Trig_Cat01_Active_Main)
endfunction

function Trig_Cat01_Reg_Conditions takes nothing returns boolean
    if GetSpellAbilityId() == 'A0X8' or GetSpellAbilityId() == 'A1CQ' or GetSpellAbilityId() == 'A0IU' then
        return true
    endif
    return false
endfunction

function Trig_Cat01_New_Damage takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 1)
    local real x = LoadReal(udg_ht, task, 3)
    local real y = LoadReal(udg_ht, task, 4)
    local real countset = LoadReal(udg_ht, task, 2)
    local real a
    local integer count = LoadInteger(udg_ht, task, 5) - 2
    local group g
    local group g2
    local group g3
    local unit v
    local integer level = GetUnitAbilityLevel(caster, 'A1CQ')
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
    call GroupEnumUnitsInRange(g, x, y, count, iff)
    call GroupClear(g3)
    call GroupEnumUnitsInRange(g3, x, y, count, iff)
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
            call SetUnitX(v, x + Cos(a) * (count - 50))
            call SetUnitY(v, y + Sin(a) * (count - 50))
            call DebugMsg("call back")
            call UnitMagicDamageTarget(caster, v, 2 * level + GetHeroInt(caster, true) * 0.2, 5)
        endif
    endloop
    call SaveReal(udg_ht, GetHandleId(LoadTimerHandle(udg_Hashtable_CastSq, GetHandleId(caster), 'A1CQ')), 3, I2R(count))
    call SaveInteger(udg_ht, task, 5, count)
    call DestroyGroup(g)
    call DestroyGroup(g2)
    if count <= countset then
        call DebugMsg("Clear")
        call UnRegisterAreaShow(caster, 'A1CQ')
        call UnRegisterAreaShow(caster, 'A0X8')
        call DestroyGroup(g3)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set g = null
    set g2 = null
    set g3 = null
    set caster = null
    set v = null
    set iff = null
endfunction

function Trig_Cat01_New_Register takes unit caster, real ox, real oy returns nothing
    local timer t2
    local integer task2
    local group g3 = CreateGroup()
    local integer level = GetUnitAbilityLevel(caster, 'A1CQ')
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    call RegisterAreaShowXY(caster, 'A1CQ', ox, oy, 300 + level * 25, 8, 0, "GhostBall.MDL", 0.02)
    call RegisterAreaShowXY(caster, 'A0X8', ox, oy, 200, 8, 0, "GhostBall.MDL", 0.02)
    set t2 = CreateTimer()
    set task2 = GetHandleId(t2)
    call SaveUnitHandle(udg_ht, task2, 1, caster)
    call SaveReal(udg_ht, task2, 2, 200)
    call SaveReal(udg_ht, task2, 3, ox)
    call SaveReal(udg_ht, task2, 4, oy)
    call SaveInteger(udg_ht, task2, 5, 300 + level * 25)
    call GroupEnumUnitsInRange(g3, ox, oy, 300 + level * 25, iff)
    call SaveGroupHandle(udg_ht, task2, 0, g3)
    call TimerStart(t2, 0.02, true, function Trig_Cat01_New_Damage)
    set g3 = null
    set t2 = null
    set iff = null
endfunction

function Cat01Ex2_OnFunc takes nothing returns nothing
    local unit caster = udg_PS_Target
    if Cat_GetMaxiumBody(caster) > Cat_GetBodyCount(caster) then
        call Cat_SetBodyCount(caster, Cat_GetBodyCount(caster) + 1)
    endif
    set caster = null
endfunction

function Trig_Cat01_Reg_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local integer cnt = Cat_GetBodyCount(caster)
    if GetSpellAbilityId() == 'A0X8' then
        if cnt == -1 then
            call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 0.5)
            call SetUnitState(caster, UNIT_STATE_MANA, GetUnitState(caster, UNIT_STATE_MANA) + 20)
        else
            if IsUnitAlly(target, GetOwningPlayer(caster)) == false then
                call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 5)
                call Cat01_Danmaku(caster, target)
                call Cat_SetBodyCount(caster, Cat_GetBodyCount(caster) - 1)
            else
                if GetUnitAbilityLevel(target, 'A0WJ') != 0 then
                    call KillUnit(target)
                    call LaunchProjectileToUnit("GhostBall.MDL", 1.0, target, 1000, caster, "Cat01Ex2_OnFunc")
                else
                    call DisplayTextToPlayer(GetOwningPlayer(caster), 0, 0, "目_不属于_尸妖精!")
                endif
            endif
        endif
    elseif GetSpellAbilityId() == 'A1CQ' then
        call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 12)
        call Trig_Cat01_New_Register(caster, GetSpellTargetX(), GetSpellTargetY())
    endif
    set caster = null
    set target = null
endfunction

function InitTrig_Cat01_Reg takes nothing returns nothing
endfunction