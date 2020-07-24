function Start01 takes nothing returns integer
    return 'A10M'
endfunction

function Start01_Dammy takes nothing returns integer
    return 'n051'
endfunction

function Trig_Start01_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A10M'
endfunction

function Trig_StartFall_Conditions takes nothing returns boolean
    if GetUnitState(GetFilterUnit(), UNIT_STATE_LIFE) <= 0 then
        return false
    endif
    if GetUnitAbilityLevel(GetFilterUnit(), 'Aloc') != 0 then
        return false
    endif
    if IsUnitAlly(GetFilterUnit(), GetOwningPlayer(LoadUnitHandle(udg_ht, GetHandleId(GetExpiredTimer()), 0))) then
        return false
    endif
    if IsUnitType(GetFilterUnit(), UNIT_TYPE_MECHANICAL) then
        return false
    endif
    return true
endfunction

function Trig_StarFall_time takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit u = LoadUnitHandle(udg_ht, task, 0)
    local unit caster = LoadUnitHandle(udg_ht, task, 1)
    local real high = GetUnitFlyHeight(u)
    local real fall = LoadReal(udg_ht, task, 1)
    local real damage = LoadReal(udg_ht, task, 2)
    local real time = LoadReal(udg_ht, task, 4)
    local real range = LoadReal(udg_ht, task, 3)
    local boolexpr iff
    local real x
    local real y
    local group g = CreateGroup()
    local unit v
    call SetUnitFlyHeight(u, high - fall, 0.0)
    if high < 20.0 then
        set x = GetUnitX(u)
        set y = GetUnitY(u)
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Human\\Thunderclap\\ThunderClapCaster.mdl", x, y))
        call RemoveUnit(u)
        set iff = Filter(function Trig_StartFall_Conditions)
        call GroupEnumUnitsInRange(g, x, y, range, iff)
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            call UnitMagicDamageTarget(caster, v, damage, 1)
            call UnitStunTarget(caster, v, time, 0, 0)
        endloop
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set u = null
    set caster = null
    set iff = null
    set g = null
    set v = null
endfunction

function Trig_StarFall takes unit caster, real x, real y, real falltime, real range, real damage, real time, integer dammy returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local unit u = CreateUnit(GetOwningPlayer(caster), dammy, x, y, 0.0)
    call SetUnitFlyHeight(u, 1200.0, 0.0)
    call SaveUnitHandle(udg_ht, task, 0, u)
    call SaveUnitHandle(udg_ht, task, 1, caster)
    call SaveReal(udg_ht, task, 1, 1200.0 * 0.02 / falltime)
    call SaveReal(udg_ht, task, 2, damage)
    call SaveReal(udg_ht, task, 3, range)
    call SaveReal(udg_ht, task, 4, time)
    call TimerStart(t, 0.02, true, function Trig_StarFall_time)
    set t = null
    set u = null
endfunction

function Trig_Start01_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A10M')
    local real x = GetSpellTargetX()
    local real y = GetSpellTargetY()
    local real time = 0.95 + 0.15 * level
    local real damage = 40.0 + 40.0 * level + 1.8 * GetHeroInt(caster, true)
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 9 - level)
    call Trig_StarFall(caster, x, y, 0.6, 150.0, damage, time, 'n051')
    set caster = null
endfunction

function InitTrig_Start01 takes nothing returns nothing
    set gg_trg_Start01 = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Start01, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Start01, Condition(function Trig_Start01_Conditions))
    call TriggerAddAction(gg_trg_Start01, function Trig_Start01_Actions)
endfunction