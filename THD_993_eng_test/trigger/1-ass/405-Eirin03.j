function Trig_Eirin03_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A086'
endfunction

function Trig_Eirin03_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit target = LoadUnitHandle(udg_ht, task, 0)
    local integer level = LoadInteger(udg_ht, task, 1)
    local integer i = LoadInteger(udg_ht, task, 2)
    if GetUnitAbilityLevel(target, 'B01P') == 0 then
        call UnitAddAbility(target, 'A0YZ')
        call SetUnitAbilityLevel(target, 'A0YZ', level)
        call UnitRemoveAbility(target, 'A12M')
    endif
    set i = i - 1
    if i == 0 then
        call UnitRemoveAbility(target, 'A12M')
        call UnitRemoveAbility(target, 'A0Z0')
        call UnitRemoveAbility(target, 'A0YZ')
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    call SaveInteger(udg_ht, task, 2, i)
    set t = null
    set target = null
endfunction

function Trig_Eirin03_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local integer level = GetUnitAbilityLevel(caster, 'A086')
    local unit u = NewDummy(GetOwningPlayer(caster), GetUnitX(target), GetUnitY(target), 0)
    local timer t
    local integer task
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 15)
    call UnitMagicDamageTarget(caster, caster, 50, 1)
    call UnitAddAbility(u, 'A087')
    call SetUnitAbilityLevel(u, 'A087', level)
    call IssueTargetOrder(u, "invisibility", target)
    call UnitRemoveAbility(u, 'A087')
    call ReleaseDummy(u)
    call UnitAddAbility(target, 'A12M')
    call SetUnitAbilityLevel(target, 'A12L', level)
    call UnitAddAbility(target, 'A0Z0')
    call SetUnitAbilityLevel(target, 'A0Z0', level)
    set t = CreateTimer()
    set task = GetHandleId(t)
    call SaveUnitHandle(udg_ht, task, 0, target)
    call SaveInteger(udg_ht, task, 1, level)
    call SaveInteger(udg_ht, task, 2, 45 + level * 15)
    call TimerStart(t, 0.1, true, function Trig_Eirin03_Main)
    set caster = null
    set target = null
    set u = null
endfunction

function InitTrig_Eirin03 takes nothing returns nothing
endfunction