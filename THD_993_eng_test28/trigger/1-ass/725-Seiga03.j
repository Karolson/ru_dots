function Seiga03 takes nothing returns integer
    return 'A1FH'
endfunction

function Seiga03_Buff takes nothing returns integer
    return 'B0A1'
endfunction

function Trig_Seiga03_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A1FH'
endfunction

function Seiga03_Main takes nothing returns nothing
    local trigger trg = GetTriggeringTrigger()
    local integer task = GetHandleId(trg)
    local unit target = GetTriggerUnit()
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local integer level = GetUnitAbilityLevel(caster, 'A1FH')
    if UnitHasBuffBJ(target, 'B0A1') then
        call DestroyEffect(AddSpecialEffect("Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl", GetUnitX(target), GetUnitY(target)))
        call UnitMagicDamageTarget(caster, target, 70.0 + 30.0 * level, 1)
        call UnitStunTarget(caster, target, 0.8 + 0.2 * level, 0, 0)
    endif
    set target = null
    set caster = null
    set trg = null
endfunction

function Seiga03_Clear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task2 = GetHandleId(t)
    local trigger trg = LoadTriggerHandle(udg_ht, task2, 0)
    local integer task = GetHandleId(trg)
    call DestroyTrigger(trg)
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    call FlushChildHashtable(udg_ht, task2)
    set trg = null
    set t = null
endfunction

function Trig_Seiga03_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local trigger trg = CreateTrigger()
    local integer task = GetHandleId(trg)
    local timer t = CreateTimer()
    local integer task2 = GetHandleId(t)
    local integer level = GetUnitAbilityLevel(caster, 'A1FH')
    call AbilityCoolDownResetion(caster, 'A1FH', 24 - 3 * level)
    if IsUnitType(GetSpellTargetUnit(), UNIT_TYPE_HERO) and udg_SK_BLTalismanicAvaliable[GetConvertedPlayerId(GetOwningPlayer(GetSpellTargetUnit()))] and IsUnitIllusionBJ(GetSpellTargetUnit()) == false then
        call Item_BLTalismanicRunningCD(GetSpellTargetUnit())
        set caster = null
        set t = null
        set target = null
        set trg = null
        return
    endif
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveTriggerHandle(udg_ht, task2, 0, trg)
    call TriggerRegisterUnitEvent(trg, target, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddAction(trg, function Seiga03_Main)
    call TimerStart(t, 2.0 + 0.5 * level, false, function Seiga03_Clear)
    set caster = null
    set t = null
    set target = null
    set trg = null
endfunction

function InitTrig_Seiga03 takes nothing returns nothing
endfunction