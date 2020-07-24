function StartEX takes nothing returns integer
    return 'A10V'
endfunction

function StartEX_Vest takes nothing returns integer
    return 'o00Q'
endfunction

function Trig_StartEX_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A10V'
endfunction

function Trig_StartEX_iff takes nothing returns boolean
    if GetUnitState(GetFilterUnit(), UNIT_STATE_LIFE) <= 0 then
        return false
    endif
    if GetUnitAbilityLevel(GetFilterUnit(), 'Aloc') != 0 then
        return false
    endif
    if IsUnitAlly(GetFilterUnit(), GetOwningPlayer(LoadUnitHandle(udg_ht, GetHandleId(GetExpiredTimer()), 0))) then
        return false
    endif
    if IsUnitType(GetFilterUnit(), UNIT_TYPE_MECHANICAL) or GetUnitAbilityLevel(GetFilterUnit(), 'A0IL') > 0 or IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) then
        return false
    endif
    return true
endfunction

function Trig_StartEX_Main takes nothing returns boolean
    local trigger trg = GetTriggeringTrigger()
    local integer task2 = GetHandleId(trg)
    local unit caster = LoadUnitHandle(udg_ht, task2, 0)
    local unit target = GetTriggerUnit()
    if GetUnitTypeId(GetEventDamageSource()) == 'o00Q' then
        call UnitMagicDamageTarget(caster, target, (500.0 + 0.5 * GetHeroInt(caster, true)) / 40.0, 1)
        call UnitHealingTarget(caster, caster, (150 + 1.5 * GetHeroInt(caster, true)) / 40.0)
        call DestroyTrigger(trg)
    endif
    set trg = null
    set target = null
    set caster = null
    return false
endfunction

function Trig_StartEX_time takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local boolexpr iff = Filter(function Trig_StartEX_iff)
    local group g = CreateGroup()
    local real x = GetUnitX(caster)
    local real y = GetUnitY(caster)
    local unit target
    local unit u
    local trigger trg
    local integer task2
    local real ranX = GetRandomReal(-500, 500)
    local real ranY = GetRandomReal(-500, 500)
    if GetUnitCurrentOrder(caster) == OrderId("channel") then
        call GroupEnumUnitsInRange(g, x, y, 600.0, iff)
        set target = GroupPickRandomUnit(g)
        set u = CreateUnit(GetOwningPlayer(caster), 'o00Q', x + ranX, y + ranY, 0.0)
        call UnitApplyTimedLife(u, 'BTLF', 8.0)
        call IssueTargetOrder(u, "shadowstrike", target)
        set trg = CreateTrigger()
        set task2 = GetHandleId(trg)
        call SaveUnitHandle(udg_ht, task2, 0, caster)
        call TriggerRegisterUnitEvent(trg, target, EVENT_UNIT_DAMAGED)
        call TriggerAddCondition(trg, Condition(function Trig_StartEX_Main))
        call GroupClear(g)
        call DestroyGroup(g)
    else
        call UnRegisterAreaShow(caster, 'A10V')
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set trg = null
    set t = null
    set caster = null
    set g = null
    set iff = null
    set u = null
    set target = null
endfunction

function Trig_StartEX_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SetUnitAnimation(caster, "spell channel")
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 13)
    call RegisterAreaShow(caster, 'A10V', 600, 6, 0, "Abilities\\Weapons\\ColdArrow\\ColdArrowMissile.mdl", 0.02)
    call TimerStart(t, 0.1, true, function Trig_StartEX_time)
    set t = null
    set caster = null
endfunction

function InitTrig_StartEX takes nothing returns nothing
    set gg_trg_StartEX = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_StartEX, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_StartEX, Condition(function Trig_StartEX_Conditions))
    call TriggerAddAction(gg_trg_StartEX, function Trig_StartEX_Actions)
endfunction