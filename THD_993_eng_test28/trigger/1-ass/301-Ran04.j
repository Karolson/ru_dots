function Trig_Ran_04_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0EH'
endfunction

function Ran04_Filter takes nothing returns boolean
    return GetWidgetLife(GetFilterUnit()) > 0.405 and IsUnitAlly(GetFilterUnit(), bj_groupEnumOwningPlayer) and not IsUnitType(GetFilterUnit(), UNIT_TYPE_STRUCTURE)
endfunction

function Ran04_Check takes nothing returns nothing
    local unit u = GetEnumUnit()
    local integer task = GetHandleId(GetExpiredTimer())
    local unit caster = LoadUnitHandle(udg_sht, task, 0)
    local group oldgrp = LoadGroupHandle(udg_sht, task, 2)
    if not IsUnitInRange(u, caster, 500.0) then
        call GroupRemoveUnit(oldgrp, u)
        call UnitAddBonusArm(u, -15)
        call UnitRemoveAbility(u, 'A0DO')
    endif
    set u = null
    set caster = null
    set oldgrp = null
endfunction

function Ran04_Heal takes nothing returns nothing
    local unit u = GetEnumUnit()
    local integer task = GetHandleId(GetExpiredTimer())
    local group oldgrp = LoadGroupHandle(udg_sht, task, 2)
    local real heal = LoadReal(udg_sht, task, 1)
    call UnitHealingTarget(u, u, heal)
    if not IsUnitInGroup(u, oldgrp) then
        call UnitAddBonusArm(u, 15)
        call UnitAddAbility(u, 'A0DO')
        call UnitMakeAbilityPermanent(u, true, 'A0DO')
    endif
    set u = null
    set oldgrp = null
endfunction

function Ran04_Clear takes nothing returns nothing
    local unit u = GetEnumUnit()
    call UnitAddBonusArm(u, -15)
    call UnitRemoveAbility(u, 'A0DO')
    set u = null
endfunction

function Ran04_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_sht, task, 0)
    local group tmpgrp = LoadGroupHandle(udg_sht, task, 1)
    local group oldgrp = LoadGroupHandle(udg_sht, task, 2)
    local boolexpr f = LoadBooleanExprHandle(udg_sht, task, 3)
    local real elapsed = LoadReal(udg_sht, task, 0)
    local real heal = LoadReal(udg_sht, task, 1)
    local real x = GetUnitX(caster)
    local real y = GetUnitY(caster)
    set elapsed = elapsed + 0.04
    if elapsed <= 9.0 and GetWidgetLife(caster) > 0.405 then
        call ForGroup(oldgrp, function Ran04_Check)
        set bj_groupEnumOwningPlayer = GetOwningPlayer(caster)
        call GroupEnumUnitsInRange(tmpgrp, x, y, 500.0, f)
        set bj_groupEnumOwningPlayer = null
        call ForGroup(tmpgrp, function Ran04_Heal)
        call GroupAddGroup(tmpgrp, oldgrp)
        call GroupClear(tmpgrp)
        call SaveReal(udg_sht, task, 0, elapsed)
    else
        call UnRegisterAreaShow(caster, 'A0EH')
        call UnitRemoveAbility(caster, 'A0OM')
        call UnitRemoveAbility(caster, 'A0EO')
        call UnitRemoveAbility(caster, 'B03C')
        call UnitRemoveAbility(caster, 'B03D')
        call ForGroup(oldgrp, function Ran04_Clear)
        call ReleaseTimer(t)
        call DestroyGroup(tmpgrp)
        call DestroyGroup(oldgrp)
        call DestroyBoolExpr(f)
        call FlushChildHashtable(udg_sht, task)
    endif
    set t = null
    set caster = null
    set tmpgrp = null
    set oldgrp = null
    set f = null
endfunction

function Ran04_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local integer level = GetUnitAbilityLevel(caster, 'A0EH')
    local group tmpgrp = CreateGroup()
    local group oldgrp = CreateGroup()
    local boolexpr f = Filter(function Ran04_Filter)
    call RegisterAreaShow(caster, 'A0EH', 500, 5, 0, "Abilities\\Spells\\Other\\HealingSpray\\HealBottleMissile.mdl", 0.02)
    call AbilityCoolDownResetion(caster, 'A0EH', 100)
    call UnitAddAbility(caster, 'A0OM')
    call UnitAddAbility(caster, 'A0EO')
    call SetUnitAbilityLevel(caster, 'A0EM', level)
    call SetUnitAbilityLevel(caster, 'A0EN', level)
    call SaveUnitHandle(udg_sht, task, 0, caster)
    call SaveGroupHandle(udg_sht, task, 1, tmpgrp)
    call SaveGroupHandle(udg_sht, task, 2, oldgrp)
    call SaveBooleanExprHandle(udg_sht, task, 3, f)
    call SaveReal(udg_sht, task, 0, 0.04)
    call SaveReal(udg_sht, task, 1, (20.0 + 20.0 * level + 0.2 * GetHeroInt(caster, true)) * 0.04)
    call TimerStart(t, 0.04, true, function Ran04_Main)
    call VE_Spellcast(caster)
    set caster = null
    set t = null
    set tmpgrp = null
    set oldgrp = null
    set f = null
endfunction

function InitTrig_Ran04 takes nothing returns nothing
endfunction