function REMILIA03 takes nothing returns integer
    return 'A0RK'
endfunction

function REMILIA03_BUFF takes nothing returns integer
    return 'A066'
endfunction

function REMILIA03_BUFF_DURATION takes nothing returns real
    return 8.0
endfunction

function REMILIA03_LIGHTNING takes nothing returns string
    return "TCLE"
endfunction

function REMILIA03_LIGHTNING_FADE_TIME takes nothing returns real
    return 0.5
endfunction

function REMILIA03_TICKRATE takes nothing returns real
    return 0.005
endfunction

function REMILIA03_DASH_SPEED takes nothing returns real
    return 4000.0
endfunction

function Remilia03_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0RK'
endfunction

function Remilia03_Stage1_Filter takes nothing returns boolean
    local unit u = GetFilterUnit()
    if GetWidgetLife(u) > 0.405 and IsUnitEnemy(u, bj_groupEnumOwningPlayer) and not IsUnitInGroup(u, bj_groupAddGroupDest) and not IsUnitType(u, UNIT_TYPE_STRUCTURE) then
        call UnitMagicDamageTarget(bj_lastCreatedUnit, u, bj_enumDestructableRadius, 1)
        call GroupAddUnit(bj_groupAddGroupDest, u)
    endif
    set u = null
    return false
endfunction

function Remilia03_Lightning_Clear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local lightning e = LoadLightningHandle(udg_ht, task, 0)
    local real timeleft = LoadReal(udg_ht, task, 0)
    local real fadetime = LoadReal(udg_ht, task, 1)
    local real r = LoadReal(udg_ht, task, 2)
    local real g = LoadReal(udg_ht, task, 3)
    local real b = LoadReal(udg_ht, task, 4)
    if timeleft >= 0 then
        call SetLightningColor(e, r, g, b, timeleft / fadetime)
        set timeleft = timeleft - 0.1
        call SaveReal(udg_ht, task, 0, timeleft)
    else
        call DestroyLightning(e)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set e = null
endfunction

function Remilia03_Fade_Lightning takes lightning e, real fadetime returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local real r = GetLightningColorR(e)
    local real g = GetLightningColorG(e)
    local real b = GetLightningColorB(e)
    call SaveLightningHandle(udg_ht, task, 0, e)
    call SaveReal(udg_ht, task, 0, fadetime)
    call SaveReal(udg_ht, task, 1, fadetime)
    call SaveReal(udg_ht, task, 2, r)
    call SaveReal(udg_ht, task, 3, g)
    call SaveReal(udg_ht, task, 4, b)
    call TimerStart(t, 0.1, true, function Remilia03_Lightning_Clear)
    set t = null
endfunction

function Remilia03_Dash_Stage2 takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local real d = LoadReal(udg_sht, task, 0)
    local unit caster = LoadUnitHandle(udg_sht, task, 0)
    local group g = LoadGroupHandle(udg_sht, task, 1)
    local group tmpgrp = LoadGroupHandle(udg_sht, task, 2)
    local lightning e = LoadLightningHandle(udg_sht, task, 3)
    local effect fx = LoadEffectHandle(udg_sht, task, 4)
    local real damage = LoadReal(udg_sht, task, 1)
    local real sx = LoadReal(udg_sht, task, 2)
    local real sy = LoadReal(udg_sht, task, 3)
    local real sz = LoadReal(udg_sht, task, 4)
    local real dx = LoadReal(udg_sht, task, 7)
    local real dy = LoadReal(udg_sht, task, 8)
    local real cx = LoadReal(udg_sht, task, 5) + dx
    local real cy = LoadReal(udg_sht, task, 6) + dy
    local real cz = GetPositionZ(cx, cy) + 80.0
    local real tx = LoadReal(udg_sht, task, 9)
    local real ty = LoadReal(udg_sht, task, 10)
    local unit u
    local unit v
    local player p = GetOwningPlayer(caster)
    if GetWidgetLife(caster) > 0.405 then
        if IsTerrainPathable(cx, cy, PATHING_TYPE_FLYABILITY) == false and not IsUnitInRangeXY(caster, tx, ty, d) then
            call SetUnitX(caster, cx)
            call SetUnitY(caster, cy)
            call MoveLightningEx(e, true, sx, sy, sz, cx, cy, cz)
            call GroupEnumUnitsInRange(g, cx, cy, 160.0, null)
            loop
                set v = FirstOfGroup(g)
            exitwhen v == null
                call GroupRemoveUnit(g, v)
                if GetWidgetLife(v) > 0.405 and IsUnitEnemy(v, p) and not IsUnitInGroup(v, tmpgrp) and IsUnitType(v, UNIT_TYPE_HERO) then
                    call UnitMagicDamageTarget(caster, v, damage, 1)
                    call GroupAddUnit(tmpgrp, v)
                endif
            endloop
            set u = FirstOfGroup(tmpgrp)
            call SaveReal(udg_sht, task, 5, cx)
            call SaveReal(udg_sht, task, 6, cy)
            if u != null then
                call ReleaseTimer(t)
                call DestroyGroup(g)
                call DestroyGroup(tmpgrp)
                call Remilia03_Fade_Lightning(e, 0.5)
                call SetUnitPathing(caster, true)
                call DestroyEffect(fx)
                call FlushChildHashtable(udg_sht, task)
                call UnitBuffTarget(caster, caster, 8.0, 'A066', 0)
                call DMG_DamageReduce(caster, 1.0 - (0.05 + GetUnitAbilityLevel(caster, 'A066') * 0.05), 8.0, "All")
                call AddTimedAbilityToUnit(caster, 'A08J', 1, 8.0)
                call SetUnitAbilityLevel(caster, 'A066', GetUnitAbilityLevel(caster, 'A0RK'))
            endif
        else
            call SetUnitPathing(caster, true)
            call IssueImmediateOrder(caster, "stop")
            call DestroyEffect(fx)
            call Remilia03_Fade_Lightning(e, 0.5)
            call ReleaseTimer(t)
            call DestroyGroup(g)
            call DestroyGroup(tmpgrp)
            call FlushChildHashtable(udg_sht, task)
        endif
    else
        call SetUnitPathing(caster, true)
        call DestroyEffect(fx)
        call Remilia03_Fade_Lightning(e, 0.5)
        call ReleaseTimer(t)
        call DestroyGroup(g)
        call DestroyGroup(tmpgrp)
        call FlushChildHashtable(udg_sht, task)
    endif
    set g = null
    set tmpgrp = null
    set t = null
    set caster = null
    set fx = null
    set e = null
    set u = null
    set v = null
    set p = null
endfunction

function Remilia03_Stage2 takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_sht, task, 0)
    local real damage = 40.0 * GetUnitAbilityLevel(caster, 'A0RK') + 1.5 * GetHeroInt(caster, true)
    local real sx = LoadReal(udg_sht, task, 2)
    local real sy = LoadReal(udg_sht, task, 3)
    local real cx = GetUnitX(caster)
    local real cy = GetUnitY(caster)
    local real cz = GetPositionZ(cx, cy) + 80.0
    local real a = Atan2(sy - cy, sx - cx)
    local real d = LoadReal(udg_sht, task, 0)
    local real dx = d * Cos(a)
    local real dy = d * Sin(a)
    local lightning e
    local effect fx
    local group g
    local group tmpgrp
    if GetUnitAbilityLevel(caster, 'A0V4') == 1 or GetUnitAbilityLevel(caster, 'A0A1') == 1 or IsUnitHidden(caster) then
        call ReleaseTimer(t)
        set g = LoadGroupHandle(udg_sht, task, 1)
        set tmpgrp = LoadGroupHandle(udg_sht, task, 2)
        call DestroyGroup(g)
        call DestroyGroup(tmpgrp)
        call FlushChildHashtable(udg_sht, task)
        set fx = null
        set g = null
        set tmpgrp = null
        set t = null
        set caster = null
        set e = null
        return
    endif
    call SetUnitFacing(caster, 57.29578 * a)
    call SetUnitPathing(caster, false)
    set fx = AddSpecialEffect("Abilities\\Spells\\Demon\\DemonBoltImpact\\DemonBoltImpact.mdl", cx, cy)
    set e = AddLightningEx("TCLE", true, cx, cy, cz, cx, cy, cz)
    call SaveLightningHandle(udg_sht, task, 3, e)
    call SaveEffectHandle(udg_sht, task, 4, fx)
    call SaveReal(udg_sht, task, 1, damage)
    call SaveReal(udg_sht, task, 2, cx)
    call SaveReal(udg_sht, task, 3, cy)
    call SaveReal(udg_sht, task, 4, cz)
    call SaveReal(udg_sht, task, 5, cx)
    call SaveReal(udg_sht, task, 6, cy)
    call SaveReal(udg_sht, task, 7, dx)
    call SaveReal(udg_sht, task, 8, dy)
    call SaveReal(udg_sht, task, 9, sx)
    call SaveReal(udg_sht, task, 10, sy)
    call TimerStart(t, 0.005, true, function Remilia03_Dash_Stage2)
    set t = null
    set caster = null
    set g = null
    set tmpgrp = null
    set fx = null
    set e = null
endfunction

function Remilia03_Dash takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local real d = LoadReal(udg_sht, task, 0)
    local unit caster = LoadUnitHandle(udg_sht, task, 0)
    local group g = LoadGroupHandle(udg_sht, task, 1)
    local group tmpgrp = LoadGroupHandle(udg_sht, task, 2)
    local lightning e = LoadLightningHandle(udg_sht, task, 3)
    local effect fx = LoadEffectHandle(udg_sht, task, 4)
    local real damage = LoadReal(udg_sht, task, 1)
    local real sx = LoadReal(udg_sht, task, 2)
    local real sy = LoadReal(udg_sht, task, 3)
    local real sz = LoadReal(udg_sht, task, 4)
    local real dx = LoadReal(udg_sht, task, 7)
    local real dy = LoadReal(udg_sht, task, 8)
    local real cx = LoadReal(udg_sht, task, 5) + dx
    local real cy = LoadReal(udg_sht, task, 6) + dy
    local real cz = GetPositionZ(cx, cy) + 80.0
    local real tx = LoadReal(udg_sht, task, 9)
    local real ty = LoadReal(udg_sht, task, 10)
    local player p = GetOwningPlayer(caster)
    local unit u
    if GetWidgetLife(caster) > 0.405 then
        if IsTerrainPathable(cx, cy, PATHING_TYPE_FLYABILITY) == false and not IsUnitInRangeXY(caster, tx, ty, d) then
            call SetUnitX(caster, cx)
            call SetUnitY(caster, cy)
            call MoveLightningEx(e, true, sx, sy, sz, cx, cy, cz)
            call GroupEnumUnitsInRange(g, cx, cy, 160.0, null)
            loop
                set u = FirstOfGroup(g)
            exitwhen u == null
                call GroupRemoveUnit(g, u)
                if GetWidgetLife(u) > 0.405 and IsUnitEnemy(u, p) and not IsUnitInGroup(u, tmpgrp) and not IsUnitType(u, UNIT_TYPE_STRUCTURE) then
                    call UnitMagicDamageTarget(caster, u, damage, 1)
                    call GroupAddUnit(tmpgrp, u)
                endif
            endloop
            call SaveReal(udg_sht, task, 5, cx)
            call SaveReal(udg_sht, task, 6, cy)
        else
            call Remilia03_Fade_Lightning(e, 0.5)
            call DestroyEffect(fx)
            call RemoveSavedHandle(udg_sht, task, 4)
            call RemoveSavedHandle(udg_sht, task, 3)
            call RemoveSavedReal(udg_sht, task, 9)
            call RemoveSavedReal(udg_sht, task, 10)
            call SetUnitPathing(caster, true)
            call IssueImmediateOrder(caster, "stop")
            call GroupClear(tmpgrp)
            call PauseTimer(t)
            call TimerStart(t, 1.5, false, function Remilia03_Stage2)
        endif
    else
        call DestroyEffect(fx)
        call Remilia03_Fade_Lightning(e, 0.5)
        call ReleaseTimer(t)
        call DestroyGroup(g)
        call DestroyGroup(tmpgrp)
        call FlushChildHashtable(udg_sht, task)
    endif
    set g = null
    set tmpgrp = null
    set t = null
    set caster = null
    set fx = null
    set e = null
    set u = null
endfunction

function Remilia03_Actions takes nothing returns nothing
    local timer t
    local integer task
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A0RK')
    local real x = GetUnitX(caster)
    local real y = GetUnitY(caster)
    local real z = GetPositionZ(x, y) + 80.0
    local real tx = GetSpellTargetX()
    local real ty = GetSpellTargetY()
    local real d = 4000.0 * 0.005
    local real a = Atan2(ty - y, tx - x)
    local real dx = d * Cos(a)
    local real dy = d * Sin(a)
    local lightning e
    local group g
    local group tmpgrp
    local effect fx
    local real damage = 20.0 + 20.0 * level + 0.9 * GetHeroInt(caster, true)
    call AbilityCoolDownResetion(caster, 'A0RK', 19.5 - 2.5 * level)
    if GetUnitAbilityLevel(caster, 'A0V4') == 1 or GetUnitAbilityLevel(caster, 'A0A1') == 1 then
        set t = null
        set caster = null
        set g = null
        set fx = null
        set tmpgrp = null
        set e = null
        return
    endif
    set fx = AddSpecialEffect("Abilities\\Spells\\Demon\\DemonBoltImpact\\DemonBoltImpact.mdl", x, y)
    call SetUnitFacing(caster, 57.29578 * a)
    call SetUnitPathing(caster, false)
    set t = CreateTimer()
    set task = GetHandleId(t)
    set g = CreateGroup()
    set tmpgrp = CreateGroup()
    set e = AddLightningEx("TCLE", true, x, y, z, x, y, z)
    call SaveUnitHandle(udg_sht, task, 0, caster)
    call SaveGroupHandle(udg_sht, task, 1, g)
    call SaveGroupHandle(udg_sht, task, 2, tmpgrp)
    call SaveLightningHandle(udg_sht, task, 3, e)
    call SaveEffectHandle(udg_sht, task, 4, fx)
    call SaveReal(udg_sht, task, 0, d)
    call SaveReal(udg_sht, task, 1, damage)
    call SaveReal(udg_sht, task, 2, x)
    call SaveReal(udg_sht, task, 3, y)
    call SaveReal(udg_sht, task, 4, z)
    call SaveReal(udg_sht, task, 5, x)
    call SaveReal(udg_sht, task, 6, y)
    call SaveReal(udg_sht, task, 7, dx)
    call SaveReal(udg_sht, task, 8, dy)
    call SaveReal(udg_sht, task, 9, tx)
    call SaveReal(udg_sht, task, 10, ty)
    call TimerStart(t, 0.005, true, function Remilia03_Dash)
    set t = null
    set caster = null
    set g = null
    set tmpgrp = null
    set fx = null
    set e = null
endfunction

function InitTrig_Remilia03 takes nothing returns nothing
endfunction