function Trig_Miko04_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A187'
endfunction

function Trig_Miko04_Target takes nothing returns boolean
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

function Trig_Miko04_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit target = LoadUnitHandle(udg_ht, task, 1)
    local real x = GetUnitX(target)
    local real y = GetUnitY(target)
    local integer level = LoadInteger(udg_ht, task, 0)
    local integer i = LoadInteger(udg_ht, task, 1)
    local unit u
    local group g
    local unit v
    local boolexpr iff
    if GetUnitCurrentOrder(caster) == OrderId("curse") and GetWidgetLife(target) > 0.403 then
        set iff = Filter(function Trig_Miko04_Target)
        call SaveInteger(udg_ht, task, 1, 1 + i)
        call UnitHealingTarget(caster, target, ABCIAllInt(caster, -100 + 150 * level, 3.4) * 0.05 * 0.5)
        call UnitHealingTarget(caster, caster, ABCIAllInt(caster, -100 + 150 * level, 3.4) * 0.05 * 0.5)
        if i / 4 * 4 == i then
            call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Human\\Resurrect\\ResurrectTarget.mdl", x, y))
        endif
    else
        if i > 59 then
            call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Human\\Resurrect\\ResurrectCaster.mdl", x, y))
            call SetUnitXYGround(caster, x, y)
        endif
        call UnitRemoveAbility(target, 'A1I2' + level)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set target = null
    set u = null
    set g = null
    set v = null
    set iff = null
endfunction

function Trig_Miko04_Actions takes nothing returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A187')
    call AbilityCoolDownResetion(caster, 'A187', 120 - 0 * level)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, target)
    call SaveInteger(udg_ht, task, 0, level)
    call SaveInteger(udg_ht, task, 1, 0)
    call VE_Spellcast(caster)
    call UnitAddAbility(target, 'A1I2' + level)
    call TimerStart(t, 0.05, true, function Trig_Miko04_Main)
    set caster = null
    set target = null
    set t = null
endfunction

function InitTrig_Miko04 takes nothing returns nothing
endfunction