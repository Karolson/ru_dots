function Seiga02 takes nothing returns integer
    return 'A1FK'
endfunction

function Seiga02_Buff takes nothing returns integer
    return 'A1FL'
endfunction

function Trig_Seiga02_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A1FK'
endfunction

function Seiga02_Main takes nothing returns nothing
    local trigger trg = GetTriggeringTrigger()
    local integer task = GetHandleId(trg)
    local unit u = GetTriggerUnit()
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit target = LoadUnitHandle(udg_ht, task, 1)
    local integer level = GetUnitAbilityLevel(caster, 'A1FK')
    local real s = GetUnitFacing(u) * 3.1415926 / 180
    local real x = GetUnitX(u) + Cos(s) * 100.0
    local real y = GetUnitY(u) + Sin(s) * 100.0
    if GetAttacker() == target and GetRandomInt(1, 100) <= level * 10 + 40 then
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Human\\Polymorph\\PolyMorphTarget.mdl", GetUnitX(target), GetUnitY(target)))
        call SetUnitX(target, x)
        call SetUnitY(target, y)
        call YDWESetUnitFacingToFaceUnitTimedNull(target, u, 0)
        call IssueTargetOrder(target, "attack", u)
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Human\\Polymorph\\PolyMorphTarget.mdl", x, y))
    endif
    set u = null
    set caster = null
    set target = null
    set trg = null
endfunction

function Seiga02_Clear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task2 = GetHandleId(t)
    local trigger trg = LoadTriggerHandle(udg_ht, task2, 0)
    local integer task = GetHandleId(trg)
    local unit target = LoadUnitHandle(udg_ht, task, 1)
    call UnitRemoveAbility(target, 'A1FL')
    call DestroyTrigger(trg)
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    call FlushChildHashtable(udg_ht, task2)
    set trg = null
    set target = null
    set t = null
endfunction

function Trig_Seiga02_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local trigger trg = CreateTrigger()
    local integer task = GetHandleId(trg)
    local timer t = CreateTimer()
    local integer task2 = GetHandleId(t)
    local integer level = GetUnitAbilityLevel(caster, 'A1FK')
    call AbilityCoolDownResetion(caster, 'A1FK', 22 - 2 * level)
    call UnitAddAbility(target, 'A1FL')
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, target)
    call SaveTriggerHandle(udg_ht, task2, 0, trg)
    call TriggerRegisterAnyUnitEventBJ(trg, EVENT_PLAYER_UNIT_ATTACKED)
    call TriggerAddAction(trg, function Seiga02_Main)
    call TimerStart(t, 5.0, false, function Seiga02_Clear)
    set caster = null
    set t = null
    set target = null
    set trg = null
endfunction

function InitTrig_Seiga02 takes nothing returns nothing
endfunction