function Trig_Hourai_Elixir_Conditions takes nothing returns boolean
    local integer d = GetItemTypeId(GetManipulatedItem())
    return 'I03C' <= d and d <= 'I03E'
endfunction

function Trig_Hourai_Elixir_Active takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local timer t
    local trigger trg
    if GetTriggerEventId() == EVENT_UNIT_DAMAGED then
        if GetUnitAbilityLevel(caster, 'B00B') > 0 and GetUnitAbilityLevel(caster, 'A0MM') == 0 then
            if GetEventDamage() < GetUnitState(caster, UNIT_STATE_LIFE) - 50.0 then
                set caster = null
                set t = null
                set trg = null
                return
            endif
            call SetUnitState(caster, UNIT_STATE_LIFE, GetUnitState(caster, UNIT_STATE_MAX_LIFE))
            call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Human\\Resurrect\\ResurrectTarget.mdl", caster, "origin"))
        endif
        set trg = GetTriggeringTrigger()
        set t = LoadTimerHandle(udg_ht, GetHandleId(trg), 0)
    else
        set trg = GetTriggeringTrigger()
        set t = GetExpiredTimer()
    endif
    call DebugMsg("Hourai Elixir effect has ended")
    call UnitRemoveAbility(caster, 'B00B')
    call TriggerRemoveAction(trg, LoadTriggerActionHandle(udg_ht, GetHandleId(trg), 1))
    call DestroyTrigger(trg)
    call ReleaseTimer(t)
    set caster = null
    set trg = null
    set t = null
endfunction

function Trig_Hourai_Elixir_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer level
    local integer d
    local timer t = CreateTimer()
    local trigger trg
    local triggeraction tga
    set level = GetItemTypeId(GetManipulatedItem()) - 'I03C' + 1
    if level == 1 then
        set d = 270
    elseif level == 2 then
        set d = 380
    else
        set d = 530
    endif
    call DebugMsg("Hourai Elixir Level: " + I2S(level))
    call SetUnitState(caster, UNIT_STATE_LIFE, d + GetUnitState(caster, UNIT_STATE_LIFE))
    call TimerStart(t, 3.0 + 2.0 * level, false, null)
    set trg = CreateTrigger()
    call TriggerRegisterTimerExpireEvent(trg, t)
    call TriggerRegisterUnitEvent(trg, caster, EVENT_UNIT_DAMAGED)
    set tga = TriggerAddAction(trg, function Trig_Hourai_Elixir_Active)
    call SaveTimerHandle(udg_ht, GetHandleId(trg), 0, t)
    call SaveTriggerActionHandle(udg_ht, GetHandleId(trg), 1, tga)
    set caster = null
    set trg = null
    set tga = null
    set t = null
endfunction

function InitTrig_Hourai_Elixir takes nothing returns nothing
    set gg_trg_Hourai_Elixir = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Hourai_Elixir, EVENT_PLAYER_UNIT_USE_ITEM)
    call TriggerAddCondition(gg_trg_Hourai_Elixir, Condition(function Trig_Hourai_Elixir_Conditions))
    call TriggerAddAction(gg_trg_Hourai_Elixir, function Trig_Hourai_Elixir_Actions)
endfunction