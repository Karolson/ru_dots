function Start02 takes nothing returns integer
    return 'A10N'
endfunction

function Start02_Buff takes nothing returns integer
    return 'B09A'
endfunction

function Trig_Start02_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A10N'
endfunction

function Trig_Start02_Clean takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit u = LoadUnitHandle(udg_ht, task, 1)
    local unit caster = LoadUnitHandle(udg_ht, task, 2)
    local unit e
    local real tx = GetUnitX(u)
    local real ty = GetUnitY(u)
    set e = CreateUnit(GetOwningPlayer(caster), 'n03N', tx, ty, GetRandomInt(0, 360))
    call SetUnitPathing(e, false)
    call SetUnitXY(e, tx, ty)
    call SetUnitFlyHeight(e, 0, 0)
    call KillUnit(e)
    set e = CreateUnit(GetOwningPlayer(caster), 'n03N', tx, ty, GetRandomInt(0, 360))
    call SetUnitPathing(e, false)
    call SetUnitXY(e, tx, ty)
    call SetUnitFlyHeight(e, 100, 0)
    call KillUnit(e)
    set e = CreateUnit(GetOwningPlayer(caster), 'n03N', tx, ty, GetRandomInt(0, 360))
    call SetUnitPathing(e, false)
    call SetUnitXY(e, tx, ty)
    call SetUnitFlyHeight(e, 200, 0)
    call KillUnit(e)
    if GetUnitAbilityLevel(u, 'B09A') == 0 then
        call FlushChildHashtable(udg_ht, task)
        call ReleaseTimer(t)
    endif
    set e = null
    set u = null
    set caster = null
    set t = null
endfunction

function Trig_Start02_Main takes nothing returns boolean
    local unit target = GetTriggerUnit()
    local trigger trg = GetTriggeringTrigger()
    local integer task2 = GetHandleId(trg)
    local unit caster = LoadUnitHandle(udg_ht, task2, 0)
    local real damage
    local integer level = LoadInteger(udg_ht, task2, 0)
    local real per = level * 0.05 + 0.1
    if GetUnitAbilityLevel(target, GetSpellAbilityId()) == 0 then
        set target = null
        set caster = null
        set trg = null
        return false
    endif
    if GetUnitAbilityLevel(target, 'B09A') > 0 then
        call UnitRemoveAbility(target, 'B09A')
        if GetUnitState(target, UNIT_STATE_MAX_MANA) * per > GetUnitState(target, UNIT_STATE_MANA) then
            set damage = GetUnitState(target, UNIT_STATE_MANA)
        else
            set damage = GetUnitState(target, UNIT_STATE_MAX_MANA) * per
        endif
        call SetUnitState(target, UNIT_STATE_MANA, GetUnitState(target, UNIT_STATE_MANA) - damage)
        call UnitMagicDamageTarget(caster, target, damage, 1)
    endif
    call ReleaseTimer(LoadTimerHandle(udg_ht, task2, 1))
    call FlushChildHashtable(udg_ht, GetHandleId(LoadTimerHandle(udg_ht, task2, 1)))
    call FlushChildHashtable(udg_ht, task2)
    call DestroyTrigger(trg)
    set target = null
    set caster = null
    set trg = null
    return false
endfunction

function Star02_RemoveEnsnare takes nothing returns nothing
    local unit u = LoadUnitHandle(udg_ht, GetHandleId(GetExpiredTimer()), 0)
    call FlushChildHashtable(udg_ht, GetHandleId(GetExpiredTimer()))
    call ReleaseTimer(GetExpiredTimer())
    call UnitRemoveAbility(u, 'B09A')
    set u = null
endfunction

function Trig_Start02_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local trigger trg = CreateTrigger()
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local integer task2 = GetHandleId(trg)
    local integer level = GetUnitAbilityLevel(caster, 'A10N')
    local unit u = NewDummy(GetOwningPlayer(caster), GetUnitX(target), GetUnitY(target), 0.0)
    local real duration = 1.0 + 0.5 * level
    local timer t2 = CreateTimer()
    set duration = DebuffDuration(target, duration)
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 23 - level * 3)
    if IsUnitType(target, UNIT_TYPE_HERO) and udg_SK_BLTalismanicAvaliable[GetConvertedPlayerId(GetOwningPlayer(target))] and IsUnitIllusionBJ(target) == false then
        call Item_BLTalismanicRunningCD(target)
        set t = null
        set caster = null
        set target = null
        set trg = null
        return
    endif
    call RestrictTarget(caster, target, duration)
    if not IsUnitCCImmune(target) then
        call UnitAddAbility(u, 'A20W')
        call IssueTargetOrder(u, "ensnare", target)
        call UnitRemoveAbility(u, 'A20W')
    endif
    call ReleaseDummy(u)
    set u = null
    call SaveUnitHandle(udg_ht, GetHandleId(t2), 0, target)
    call TimerStart(t2, duration, false, function Star02_RemoveEnsnare)
    set t2 = null
    call SaveUnitHandle(udg_ht, task2, 0, caster)
    call SaveTimerHandle(udg_ht, task2, 1, t)
    call SaveInteger(udg_ht, task2, 0, level)
    call TriggerRegisterUnitEvent(trg, target, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(trg, Condition(function Trig_Start02_Main))
    call SaveUnitHandle(udg_ht, task, 1, target)
    call SaveUnitHandle(udg_ht, task, 2, caster)
    call TimerStart(t, 0.25, true, function Trig_Start02_Clean)
    set t = null
    set caster = null
    set target = null
    set trg = null
endfunction

function InitTrig_Start02 takes nothing returns nothing
endfunction