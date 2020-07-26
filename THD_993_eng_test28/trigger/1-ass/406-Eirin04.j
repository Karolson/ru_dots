function HouraiElixir___Eirin04_clear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local trigger trg = LoadTriggerHandle(udg_ht, task, 0)
    local triggercondition trgcond = LoadTriggerConditionHandle(udg_ht, task, 1)
    local boolexpr c = LoadBooleanExprHandle(udg_ht, task, 2)
    local unit v = LoadUnitHandle(udg_ht, task, 3)
    call UnitRemoveAbility(v, 'A0WI')
    call UnitRemoveAbility(v, 'A0VK')
    if GetUnitAbilityLevel(v, 'B00B') > 0 then
        call UnitRemoveAbility(v, 'A0UF')
        call UnitRemoveAbility(v, 'B00B')
    endif
    call TriggerRemoveCondition(trg, trgcond)
    call DestroyBoolExpr(c)
    call DisableTrigger(trg)
    call DestroyTrigger(trg)
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    set t = null
    set trg = null
    set trg = null
    set trgcond = null
    set c = null
    set v = null
endfunction

function HouraiElixir___Eirin04_unitdamaged takes nothing returns boolean
    local real dmg = GetEventDamage()
    local unit u = GetTriggerUnit()
    local timer t
    local trigger trg
    if dmg >= GetWidgetLife(u) and GetUnitAbilityLevel(u, 'A0UF') > 0 and GetUnitAbilityLevel(u, 'A0MM') == 0 then
        call SetWidgetLife(u, GetUnitState(u, UNIT_STATE_MAX_LIFE))
        call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Human\\Resurrect\\ResurrectTarget.mdl", u, "origin"))
        call UnitRemoveAbility(u, 'A0UF')
        call UnitRemoveAbility(u, 'B00B')
        call DebugMsg("Erin04Apply")
        set trg = GetTriggeringTrigger()
        call DisableTrigger(trg)
        set t = LoadTimerHandle(udg_ht, GetHandleId(trg), 0)
        call TimerStart(t, 0.0, false, function HouraiElixir___Eirin04_clear)
        call FlushChildHashtable(udg_ht, GetHandleId(trg))
        set trg = null
        set t = null
    endif
    set u = null
    return false
endfunction

function HouraiElixir___Eirin04_ReAddEffect takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    call UnitAddAbility(caster, 'A0WI')
    call UnitMakeAbilityPermanent(caster, true, 'A0WI')
    call UnitAddAbility(caster, 'A0VK')
    call UnitMakeAbilityPermanent(caster, true, 'A0VK')
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_sht, task)
    set t = null
    set caster = null
endfunction

function Eirin04_bufftarget takes nothing returns boolean
    local unit u
    local unit v
    local integer abid
    local integer level
    local real hpinc
    local trigger trg
    local triggercondition trgcond
    local boolexpr c
    local timer t
    local timer t2
    local real cdtime
    local integer task2
    local integer task
    local real basicdeduce = 1.0
    if GetTriggerEventId() == EVENT_UNIT_HERO_SKILL then
        if GetLearnedSkill() == 'A088' and GetLearnedSkillLevel() == 1 then
        endif
        return false
    endif
    set abid = GetSpellAbilityId()
    if abid == 'A088' then
        set u = GetTriggerUnit()
        set v = GetSpellTargetUnit()
        set level = GetUnitAbilityLevel(u, 'A088')
        if level == 1 then
            set hpinc = 270.0
        elseif level == 2 then
            set hpinc = 380.0
        else
            set hpinc = 530.0
        endif
        set cdtime = 150.0 - 15.0 * level
        set t2 = CreateTimer()
        set task2 = GetHandleId(t2)
        call UnitRemoveAbility(u, 'A0WI')
        call UnitRemoveAbility(u, 'A0VK')
        if YDWEGetInventoryIndexOfItemTypeBJNull(u, 'I00H') > 0 then
            set basicdeduce = basicdeduce * 0.9
        endif
        if YDWEGetInventoryIndexOfItemTypeBJNull(u, 'I00E') > 0 then
            set basicdeduce = basicdeduce * 0.9
        endif
        if YDWEGetInventoryIndexOfItemTypeBJNull(u, 'I00B') > 0 then
            set basicdeduce = basicdeduce * 0.75
        endif
        set cdtime = basicdeduce * cdtime
        call SaveUnitHandle(udg_ht, task2, 0, u)
        call TimerStart(t2, cdtime, false, function HouraiElixir___Eirin04_ReAddEffect)
        call UnitHealingTarget(u, v, hpinc)
        call UnitAddAbility(v, 'A0UF')
        call UnitMakeAbilityPermanent(v, true, 'A0UF')
        call UnitAddAbility(v, 'A0WI')
        call UnitMakeAbilityPermanent(v, true, 'A0WI')
        call UnitAddAbility(v, 'A0VK')
        call UnitMakeAbilityPermanent(v, true, 'A0VK')
        call CastSpell(v, "Spell Card: Forbidden Drug 'Hourai Elixir'!")
        call VE_Spellcast(v)
        set trg = CreateTrigger()
        set c = Condition(function HouraiElixir___Eirin04_unitdamaged)
        call TriggerRegisterUnitEvent(trg, v, EVENT_UNIT_DAMAGED)
        set trgcond = TriggerAddCondition(trg, c)
        set t = CreateTimer()
        set task = GetHandleId(t)
        call SaveTriggerHandle(udg_ht, task, 0, trg)
        call SaveTriggerConditionHandle(udg_ht, task, 1, trgcond)
        call SaveBooleanExprHandle(udg_ht, task, 2, c)
        call SaveUnitHandle(udg_ht, task, 3, v)
        call TimerStart(t, 3.0 + 2.0 * level, false, function HouraiElixir___Eirin04_clear)
        call SaveTimerHandle(udg_ht, GetHandleId(trg), 0, t)
        call DebugMsg("Eirin04 Register")
        set u = null
        set v = null
        set t = null
        set trg = null
        set c = null
        set trgcond = null
        set t2 = null
    endif
    return false
endfunction

function InitTrig_Eirin04 takes nothing returns nothing
endfunction