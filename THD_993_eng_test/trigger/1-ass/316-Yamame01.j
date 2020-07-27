function YAMAME01 takes nothing returns integer
    return 'A08F'
endfunction

function YAMAME01_COOLDOWN takes nothing returns integer
    return 14
endfunction

function YAMAME01_AREA takes integer slvl returns real
    return 150.0 + 25.0 * slvl
endfunction

function YAMAME01_WEB_DURATION takes nothing returns real
    return 8.0
endfunction

function YAMAME01_STUN_DURATION takes integer slvl returns real
    return 0.8 + 0.4 * slvl
endfunction

function YAMAME01_PROJECTILE takes nothing returns string
    return "Abilities\\Weapons\\ChimaeraAcidMissile\\ChimaeraAcidMissile.mdl"
endfunction

function YAMAME01_PROJECTILE_SPEED takes nothing returns real
    return 800.0
endfunction

function YAMAME01_WEB_ABILITY takes nothing returns integer
    return 'A08G'
endfunction

function YAMAME01_WEB_ORDER_STRING takes nothing returns string
    return "entanglingroots"
endfunction

function Yamame01_Filter takes nothing returns boolean
    return IsUnitEnemy(GetFilterUnit(), bj_groupEnumOwningPlayer) and GetUnitAbilityLevel(GetFilterUnit(), 'Aloc') <= 0 and not IsUnitType(GetFilterUnit(), UNIT_TYPE_STRUCTURE)
endfunction

function Yamame01_Web_Area takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_sht, task, 0)
    local unit u = LoadUnitHandle(udg_sht, task, 1)
    local group g = LoadGroupHandle(udg_sht, task, 2)
    local group tmpgrp = LoadGroupHandle(udg_sht, task, 3)
    local boolexpr f = LoadBooleanExprHandle(udg_sht, task, 4)
    local integer level = LoadInteger(udg_sht, task, 0)
    local real x = LoadReal(udg_sht, task, 1)
    local real y = LoadReal(udg_sht, task, 2)
    local real elapsed = LoadReal(udg_sht, task, 3)
    local unit v
    set bj_groupEnumOwningPlayer = GetOwningPlayer(caster)
    call GroupEnumUnitsInRange(g, x, y, 150.0 + 25.0 * level, f)
    set bj_groupEnumOwningPlayer = null
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if not IsUnitInGroup(v, tmpgrp) then
            if udg_NewDebuffSys then
                call UnitDebuffTarget(caster, v, 0.8 + 0.4 * level, 0, true, 'A06W', 1, 'B01R', "entanglingroots", 0, "")
            else
                call UnitCurseTarget(caster, v, 0.8 + 0.4 * level, 'A08G', "entanglingroots")
            endif
            call CE_Input(caster, v, 150)
            call GroupAddUnit(tmpgrp, v)
        endif
    endloop
    set elapsed = elapsed + 0.03125
    if elapsed <= 8.0 then
        call SaveReal(udg_sht, task, 3, elapsed)
    else
        call KillUnit(u)
        call DestroyBoolExpr(f)
        call DestroyGroup(g)
        call DestroyGroup(tmpgrp)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_sht, task)
    endif
    set caster = null
    set g = null
    set tmpgrp = null
    set f = null
    set t = null
    set u = null
endfunction

function Yamame01_Launch_Web takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_sht, task, 0)
    local unit u = LoadUnitHandle(udg_sht, task, 1)
    local effect e = LoadEffectHandle(udg_sht, task, 2)
    local integer level = LoadInteger(udg_sht, task, 0)
    local real cx = LoadReal(udg_sht, task, 1)
    local real cy = LoadReal(udg_sht, task, 2)
    local real tx = LoadReal(udg_sht, task, 3)
    local real ty = LoadReal(udg_sht, task, 4)
    local real dx = LoadReal(udg_sht, task, 5)
    local real dy = LoadReal(udg_sht, task, 6)
    local group g
    local group tmpgrp
    local boolexpr f
    set cx = cx + dx
    set cy = cy + dy
    if not IsUnitInRangeXY(u, tx, ty, 800.0 * 0.03125) then
        call SetUnitXY(u, cx, cy)
        call SaveReal(udg_sht, task, 1, cx)
        call SaveReal(udg_sht, task, 2, cy)
    else
        call DestroyEffect(e)
        call ReleaseDummy(u)
        set u = CreateUnit(GetOwningPlayer(caster), 'e00M', cx, cy, 0.0)
        call SetUnitAnimation(u, "birth")
        call SaveUnitHandle(udg_sht, task, 1, u)
        set g = CreateGroup()
        set tmpgrp = CreateGroup()
        set f = Filter(function Yamame01_Filter)
        call SaveGroupHandle(udg_sht, task, 2, g)
        call SaveGroupHandle(udg_sht, task, 3, tmpgrp)
        call SaveBooleanExprHandle(udg_sht, task, 4, f)
        call SaveReal(udg_sht, task, 1, cx)
        call SaveReal(udg_sht, task, 2, cy)
        call SaveReal(udg_sht, task, 3, 0.03125)
        call TimerStart(t, 0.03125, true, function Yamame01_Web_Area)
    endif
    set t = null
    set caster = null
    set u = null
    set e = null
    set g = null
    set tmpgrp = null
    set f = null
endfunction

function Yamame01_Conditions takes nothing returns boolean
    local unit caster
    local real ox
    local real oy
    local real tx
    local real ty
    local real a
    local unit u
    local timer t
    local effect e
    local integer task
    if GetSpellAbilityId() == 'A08F' then
        set caster = GetTriggerUnit()
        set ox = GetUnitX(caster)
        set oy = GetUnitY(caster)
        set tx = GetSpellTargetX()
        set ty = GetSpellTargetY()
        set a = Atan2(ty - oy, tx - ox)
        set u = NewSpecialDummy(GetOwningPlayer(caster), ox, oy, 57.29578 * a)
        set e = AddSpecialEffectTarget("Abilities\\Weapons\\ChimaeraAcidMissile\\ChimaeraAcidMissile.mdl", u, "origin")
        set t = CreateTimer()
        set task = GetHandleId(t)
        call AbilityCoolDownResetion(caster, 'A08F', 14)
        call SaveUnitHandle(udg_sht, task, 0, caster)
        call SaveUnitHandle(udg_sht, task, 1, u)
        call SaveEffectHandle(udg_sht, task, 2, e)
        call SaveInteger(udg_sht, task, 0, GetUnitAbilityLevel(caster, 'A08F'))
        call SaveReal(udg_sht, task, 1, ox)
        call SaveReal(udg_sht, task, 2, oy)
        call SaveReal(udg_sht, task, 3, tx)
        call SaveReal(udg_sht, task, 4, ty)
        call SaveReal(udg_sht, task, 5, 800.0 * 0.03125 * Cos(a))
        call SaveReal(udg_sht, task, 6, 800.0 * 0.03125 * Sin(a))
        call TimerStart(t, 0.03125, true, function Yamame01_Launch_Web)
    endif
    set caster = null
    set u = null
    set t = null
    set e = null
    return false
endfunction

function InitTrig_Yamame01 takes nothing returns nothing
endfunction