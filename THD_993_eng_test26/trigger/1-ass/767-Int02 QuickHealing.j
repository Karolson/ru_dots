function Trig_Int02_QuickHealing_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0VF'
endfunction

function Trig_Int02_QuickHealing_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local integer i = LoadInteger(udg_ht, task, 1)
    set i = i + 1
    call SaveInteger(udg_ht, task, 1, i)
    if i >= 10 and i < 15 then
        call SetUnitState(caster, UNIT_STATE_LIFE, RMaxBJ(GetWidgetLife(caster) - (200 + GetUnitState(caster, UNIT_STATE_MAX_MANA) * 0.14) * 0.2, 10))
    endif
    if i == 15 then
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
endfunction

function Trig_Int02_QuickHealing_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call UnitHealingTarget(caster, caster, 200 + GetUnitState(caster, UNIT_STATE_MAX_MANA) * 0.14)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveInteger(udg_ht, task, 1, 0)
    call TimerStart(t, 1.0, true, function Trig_Int02_QuickHealing_Main)
    set t = null
    set caster = null
endfunction

function InitTrig_Int02_QuickHealing takes nothing returns nothing
    set gg_trg_Int02_QuickHealing = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Int02_QuickHealing, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Int02_QuickHealing, Condition(function Trig_Int02_QuickHealing_Conditions))
    call TriggerAddAction(gg_trg_Int02_QuickHealing, function Trig_Int02_QuickHealing_Actions)
endfunction