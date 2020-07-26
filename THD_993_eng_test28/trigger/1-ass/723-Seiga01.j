function Seiga01 takes nothing returns integer
    return 'A1FJ'
endfunction

function Seiga01_Buff takes nothing returns integer
    return 'A1FI'
endfunction

function Trig_Seiga01_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A1FJ'
endfunction

function Seiga01_Conditions takes nothing returns boolean
    local unit target = GetTriggerUnit()
    local unit caster = GetEventDamageSource()
    local trigger trg = GetTriggeringTrigger()
    local integer task = GetHandleId(trg)
    local unit a = LoadUnitHandle(udg_ht, task, 0)
    local unit b = LoadUnitHandle(udg_ht, task, 1)
    if caster != a and caster != b then
        set target = null
        set caster = null
        set trg = null
        set a = null
        set b = null
        return false
    endif
    if IsDamageNotUnitAttack(a) and IsDamageNotUnitAttack(b) then
        set target = null
        set caster = null
        set trg = null
        set a = null
        set b = null
        return false
    endif
    if IsUnitType(target, UNIT_TYPE_MECHANICAL) or IsUnitType(target, UNIT_TYPE_ANCIENT) or GetEventDamage() <= 0 then
        set target = null
        set caster = null
        set trg = null
        set a = null
        set b = null
        return false
    endif
    if IsUnitAlly(target, GetOwningPlayer(caster)) then
        set target = null
        set caster = null
        set trg = null
        set a = null
        set b = null
        return false
    endif
    return true
endfunction

function Seiga01_Main takes nothing returns nothing
    local trigger trg = GetTriggeringTrigger()
    local integer task = GetHandleId(trg)
    local unit u = GetTriggerUnit()
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit target = LoadUnitHandle(udg_ht, task, 1)
    local integer level = GetUnitAbilityLevel(caster, 'A1FJ')
    local real damage = 15.0 * level + 15.0
    if GetEventDamageSource() == caster then
        call BJDebugMsg(R2S(damage + GetUnitAttack(target) * 0.5))
        call UnitMagicDamageTarget(caster, u, damage + GetUnitAttack(target) * 0.5, 1)
    endif
    if GetEventDamageSource() == target then
        call UnitMagicDamageTarget(caster, u, damage + GetHeroInt(caster, true) * 0.5, 1)
    endif
    set u = null
    set caster = null
    set target = null
    set trg = null
endfunction

function Seiga01_Clear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task2 = GetHandleId(t)
    local trigger trg = LoadTriggerHandle(udg_ht, task2, 0)
    local integer task = GetHandleId(trg)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit target = LoadUnitHandle(udg_ht, task, 1)
    call UnitRemoveAbility(caster, 'A1FI')
    call UnitRemoveAbility(target, 'A1FI')
    call DestroyTrigger(trg)
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    call FlushChildHashtable(udg_ht, task2)
    set caster = null
    set target = null
    set trg = null
    set t = null
endfunction

function Trig_Seiga01_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local trigger trg = CreateTrigger()
    local integer task = GetHandleId(trg)
    local timer t = CreateTimer()
    local integer task2 = GetHandleId(t)
    call AbilityCoolDownResetion(caster, 'A1FJ', 10)
    call UnitAddAbility(caster, 'A1FI')
    call UnitAddAbility(target, 'A1FI')
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, target)
    call SaveTriggerHandle(udg_ht, task2, 0, trg)
    call RegisterAnyUnitDamage(trg)
    call TriggerAddCondition(trg, Condition(function Seiga01_Conditions))
    call TriggerAddAction(trg, function Seiga01_Main)
    call TimerStart(t, 5.0, false, function Seiga01_Clear)
    set caster = null
    set t = null
    set target = null
    set trg = null
endfunction

function InitTrig_Seiga01 takes nothing returns nothing
endfunction