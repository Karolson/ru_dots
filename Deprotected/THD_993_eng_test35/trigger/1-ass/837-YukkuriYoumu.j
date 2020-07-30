function Trig_YukkuriYoumu_Conditions takes nothing returns boolean
    if GetUnitTypeId(GetAttacker()) != 'o001' then
        return false
    elseif IsUnitType(GetTriggerUnit(), UNIT_TYPE_STRUCTURE) then
        return false
    elseif IsUnitAlly(GetTriggerUnit(), GetOwningPlayer(GetAttacker())) then
        return false
    endif
    return true
endfunction

function Trig_YukkuriYoumu_Fade takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit target = LoadUnitHandle(udg_ht, task, 0)
    local integer i = LoadInteger(udg_ht, task, 1)
    local integer difflevel = LoadInteger(udg_ht, task, 2)
    local integer armorlevel
    if IsUnitDead(target) then
        call UnitRemoveAbility(target, 'A0RV')
        call UnitRemoveAbility(target, 'X000')
        call FlushChildHashtable(udg_ht, task)
        call ReleaseTimer(t)
    elseif i == 0 then
        set armorlevel = GetUnitAbilityLevel(target, 'A0RV') - difflevel
        if armorlevel <= 0 then
            call UnitRemoveAbility(target, 'A0RV')
        else
            call SetUnitAbilityLevel(target, 'A0RV', armorlevel)
        endif
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    else
        call SaveInteger(udg_ht, task, 1, i - 1)
    endif
    set t = null
    set target = null
endfunction

function Trig_YukkuriYoumu_Damaged takes nothing returns nothing
    local trigger trg = GetTriggeringTrigger()
    local integer task = GetHandleId(trg)
    local unit caster
    local unit target
    local unit u
    local timer t
    local boolean b
    local integer level
    local integer changelevel
    local integer armorlevel
    local integer oldlevel
    local integer difflevel
    if GetTriggerEventId() != EVENT_UNIT_DAMAGED then
        call TriggerRemoveAction(trg, LoadTriggerActionHandle(udg_ht, task, 1))
        call DestroyTrigger(trg)
        call FlushChildHashtable(udg_ht, task)
        set trg = null
        set caster = null
        set target = null
        set u = null
        set t = null
        return
    endif
    set caster = LoadUnitHandle(udg_ht, task, 0)
    if GetEventDamageSource() != caster then
        set trg = null
        set caster = null
        set target = null
        set u = null
        set t = null
        return
    endif
    set target = GetTriggerUnit()
    call DisableTrigger(trg)
    set b = false
    set level = 3
    set changelevel = level
    set oldlevel = GetUnitAbilityLevel(target, 'A0RV')
    set armorlevel = oldlevel + changelevel
    if armorlevel > level * 16 then
        set armorlevel = level * 16
    endif
    if armorlevel > oldlevel then
        set difflevel = armorlevel - oldlevel
        if GetUnitAbilityLevel(target, 'A0RV') == 0 then
            call UnitAddAbility(target, 'A0RV')
        endif
        call SetUnitAbilityLevel(target, 'A0RV', armorlevel)
        set b = true
    endif
    if b then
        set t = CreateTimer()
        call SaveUnitHandle(udg_ht, GetHandleId(t), 0, target)
        call SaveInteger(udg_ht, GetHandleId(t), 1, 8)
        call SaveInteger(udg_ht, GetHandleId(t), 2, difflevel)
        call TimerStart(t, 1.0, true, function Trig_YukkuriYoumu_Fade)
        set u = NewDummy(GetOwningPlayer(caster), GetUnitX(caster), GetUnitY(caster), 0)
        call UnitAddAbility(u, 'A063')
        call IssueTargetOrder(u, "innerfire", target)
        call UnitRemoveAbility(u, 'A063')
        call ReleaseDummy(u)
    endif
    call UnitPhysicalDamageTarget(caster, target, 20)
    call TriggerRemoveAction(trg, LoadTriggerActionHandle(udg_ht, task, 1))
    call DestroyTrigger(trg)
    call FlushChildHashtable(udg_ht, task)
    set trg = null
    set caster = null
    set target = null
    set u = null
    set t = null
endfunction

function Trig_YukkuriYoumu_Actions takes nothing returns nothing
    local unit caster = GetAttacker()
    local unit target = GetTriggerUnit()
    local trigger trg
    local triggeraction tga
    set trg = CreateTrigger()
    set tga = TriggerAddAction(trg, function Trig_YukkuriYoumu_Damaged)
    call SaveUnitHandle(udg_ht, GetHandleId(trg), 0, caster)
    call SaveTriggerActionHandle(udg_ht, GetHandleId(trg), 1, tga)
    call TriggerRegisterUnitEvent(trg, target, EVENT_UNIT_DAMAGED)
    call TriggerRegisterUnitEvent(trg, caster, EVENT_UNIT_ISSUED_ORDER)
    call TriggerRegisterUnitEvent(trg, caster, EVENT_UNIT_ISSUED_POINT_ORDER)
    call TriggerRegisterUnitEvent(trg, caster, EVENT_UNIT_ISSUED_TARGET_ORDER)
    set trg = null
    set tga = null
    set caster = null
    set target = null
endfunction

function InitTrig_YukkuriYoumu takes nothing returns nothing
    set gg_trg_YukkuriYoumu = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_YukkuriYoumu, EVENT_PLAYER_UNIT_ATTACKED)
    call TriggerAddCondition(gg_trg_YukkuriYoumu, Condition(function Trig_YukkuriYoumu_Conditions))
    call TriggerAddAction(gg_trg_YukkuriYoumu, function Trig_YukkuriYoumu_Actions)
endfunction