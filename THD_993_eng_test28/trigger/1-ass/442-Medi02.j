function MEDI02 takes nothing returns integer
    return 'A0EF'
endfunction

function MEDI02_COOLDOWN takes nothing returns real
    return 10.0
endfunction

function MEDI02_EFFECT_SKILL takes nothing returns integer
    return 'A07X'
endfunction

function MEDI02_SLOW_SKILL takes nothing returns integer
    return 'A15U'
endfunction

function MEDI02_BUFFID takes nothing returns integer
    return 'B01N'
endfunction

function MEDI02_RADIUS takes nothing returns real
    return 250.0
endfunction

function Medi02_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0EF'
endfunction

function Medi02_Filter takes nothing returns boolean
    if GetWidgetLife(GetFilterUnit()) > 0.405 and IsUnitEnemy(GetFilterUnit(), bj_groupEnumOwningPlayer) and GetUnitAbilityLevel(GetFilterUnit(), 'Aloc') <= 0 and GetUnitAbilityLevel(GetFilterUnit(), 'Avul') <= 0 and not IsUnitType(GetFilterUnit(), UNIT_TYPE_STRUCTURE) then
        call GroupAddUnit(bj_groupAddGroupDest, GetFilterUnit())
    endif
    return false
endfunction

function Medi02_Get_Oldest takes group g returns unit
    local unit u
    local group tmpgrp = CreateGroup()
    local integer age = 0
    local integer i = 0
    set bj_groupAddGroupDest = tmpgrp
    call ForGroup(g, function GroupAddGroupEnum)
    set bj_groupAddGroupDest = null
    set u = FirstOfGroup(tmpgrp)
    set bj_lastCreatedUnit = u
    set age = GetUnitUserData(u)
    call GroupRemoveUnit(tmpgrp, u)
    loop
        set u = FirstOfGroup(tmpgrp)
    exitwhen u == null
        call GroupRemoveUnit(tmpgrp, u)
        set i = GetUnitUserData(u)
        if i < age then
            set age = i
            set bj_lastCreatedUnit = u
        endif
    endloop
    call DestroyGroup(tmpgrp)
    set u = null
    set tmpgrp = null
    return bj_lastCreatedUnit
endfunction

function Medi02_Get_Youngest_Age takes group g returns integer
    local unit u
    local group tmpgrp = CreateGroup()
    local integer age = 0
    local integer i = 0
    set bj_groupAddGroupDest = tmpgrp
    call ForGroup(g, function GroupAddGroupEnum)
    set bj_groupAddGroupDest = null
    set u = FirstOfGroup(tmpgrp)
    set age = GetUnitUserData(u)
    call GroupRemoveUnit(tmpgrp, u)
    loop
        set u = FirstOfGroup(tmpgrp)
    exitwhen u == null
        call GroupRemoveUnit(tmpgrp, u)
        set i = GetUnitUserData(u)
        if i > age then
            set age = i
        endif
    endloop
    call DestroyGroup(tmpgrp)
    set u = null
    set tmpgrp = null
    return age
endfunction

function Medi02_Get_Damage_Units takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_sht, task, 1)
    local unit u = GetEnumUnit()
    local group tmpgrp = LoadGroupHandle(udg_sht, task, 2)
    local group dmggrp = LoadGroupHandle(udg_sht, task, 3)
    local boolexpr f = LoadBooleanExprHandle(udg_sht, task, 4)
    local player p = GetOwningPlayer(caster)
    local unit v
    call GroupEnumUnitsInRange(tmpgrp, GetUnitX(u), GetUnitY(u), 250.0, null)
    loop
        set v = FirstOfGroup(tmpgrp)
    exitwhen v == null
        call GroupRemoveUnit(tmpgrp, v)
        if GetWidgetLife(v) > 0.405 and IsUnitEnemy(v, p) and GetUnitAbilityLevel(v, 'Aloc') <= 0 and GetUnitAbilityLevel(v, 'Avul') <= 0 and not IsUnitType(v, UNIT_TYPE_STRUCTURE) then
            call GroupAddUnit(dmggrp, v)
        endif
    endloop
    call GroupClear(tmpgrp)
    set caster = null
    set u = null
    set tmpgrp = null
    set dmggrp = null
    set f = null
endfunction

function Medi02_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_sht, task, 1)
    local group g = LoadGroupHandle(udg_sht, task, 0)
    local group dmggrp = LoadGroupHandle(udg_sht, task, 3)
    local unit u
    local real damage
    local integer count
    set bj_wantDestroyGroup = false
    set count = CountUnitsInGroup(g)
    if count > 0 then
        call ForGroup(g, function Medi02_Get_Damage_Units)
        set damage = 0.5 * ABCIAllInt(caster, 20, 0.15)
        loop
            set u = FirstOfGroup(dmggrp)
        exitwhen u == null
            call GroupRemoveUnit(dmggrp, u)
            call UnitMagicDamageTarget(caster, u, damage, 5)
            call CE_Input(caster, u, 15)
            if udg_NewDebuffSys then
                call UnitSlowTargetMspd(caster, u, 20, 0.5, 3, 'A0A0')
            else
                call UnitSlowTarget(caster, u, 0.5, 'A15U', 'B01N')
            endif
        endloop
    else
        call DestroyGroup(g)
        call DestroyGroup(dmggrp)
        call DestroyGroup(LoadGroupHandle(udg_sht, task, 2))
        call DestroyBoolExpr(LoadBooleanExprHandle(udg_sht, task, 4))
        call ReleaseTimer(t)
        call RemoveSavedHandle(udg_sht, StringHash("Medi02"), GetHandleId(caster))
        call FlushChildHashtable(udg_sht, task)
    endif
    set t = null
    set caster = null
    set g = null
    set dmggrp = null
    set u = null
endfunction

function Medi02_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer ctask = GetHandleId(caster)
    local integer level = GetUnitAbilityLevel(caster, 'A0EF')
    local integer stask = StringHash("Medi02")
    local timer t
    local integer task
    local real x = GetSpellTargetX()
    local real y = GetSpellTargetY()
    local unit u
    local group g
    local integer count = 0
    call AbilityCoolDownResetion(caster, 'A0EF', 10.0)
    if HaveSavedHandle(udg_sht, stask, ctask) then
        set t = LoadTimerHandle(udg_sht, stask, ctask)
        set task = GetHandleId(t)
        set g = LoadGroupHandle(udg_sht, task, 0)
        set bj_wantDestroyGroup = false
        set count = CountUnitsInGroup(g)
    else
        set t = CreateTimer()
        set task = GetHandleId(t)
        call SaveTimerHandle(udg_sht, stask, ctask, t)
        set g = CreateGroup()
        call SaveGroupHandle(udg_sht, task, 0, g)
        call TimerStart(t, 0.5, true, function Medi02_Main)
        call SaveUnitHandle(udg_sht, task, 1, caster)
        call SaveGroupHandle(udg_sht, task, 2, CreateGroup())
        call SaveGroupHandle(udg_sht, task, 3, CreateGroup())
        call SaveBooleanExprHandle(udg_sht, task, 4, Filter(function Medi02_Filter))
    endif
    if count < level then
        set u = CreateUnit(GetOwningPlayer(caster), 'n01M', x, y, 0.0)
        call UnitRemoveAbility(u, 'Amov')
        call SetUnitUserData(u, Medi02_Get_Youngest_Age(g) + 1)
        call GroupAddUnit(g, u)
    else
        set u = Medi02_Get_Oldest(g)
        call SetUnitUserData(u, Medi02_Get_Youngest_Age(g) + 1)
        call SetUnitX(u, x)
        call SetUnitY(u, y)
    endif
    set caster = null
    set t = null
    set u = null
    set g = null
endfunction

function InitTrig_Medi02 takes nothing returns nothing
endfunction