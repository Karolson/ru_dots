function Trig_Wriggle02_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A09R'
endfunction

function Wriggle02_Filter takes nothing returns boolean
    local integer i = GetUnitTypeId(GetFilterUnit())
    if i == 'u00B' or i == 'u00O' or i == 'u00P' or i == 'u00Q' then
        call UnitAddAttackDamage(GetFilterUnit(), R2I(0.2 * (GetUnitAttack(bj_lastCreatedUnit) - GetUnitBaseAttack(bj_lastCreatedUnit))))
    endif
    return false
endfunction

function Wriggle02_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_sht, task, 0)
    local integer dmg = R2I(0.2 * (GetUnitAttack(caster) - GetUnitBaseAttack(caster)))
    local group g = CreateGroup()
    local unit u
    local integer i
    call GroupEnumUnitsOfPlayer(g, GetOwningPlayer(caster), null)
    loop
        set u = FirstOfGroup(g)
    exitwhen u == null
        call GroupRemoveUnit(g, u)
        set i = GetUnitTypeId(u)
        if i == 'u00B' or i == 'u00O' or i == 'u00P' or i == 'u00Q' then
            call UnitAddAttackDamage(u, dmg)
        endif
    endloop
    set u = null
    call DestroyGroup(g)
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_sht, task)
    set g = null
    set caster = null
endfunction

function Trig_Wriggle02_Damage takes nothing returns boolean
    local integer i = GetUnitTypeId(GetEventDamageSource())
    local trigger trg
    local integer task
    local unit caster
    if i == 'u00B' or i == 'u00O' or i == 'u00P' or i == 'u00Q' then
        set trg = GetTriggeringTrigger()
        set task = GetHandleId(trg)
        set caster = LoadUnitHandle(udg_ht, task, 0)
        call UnitHealingTarget(caster, caster, GetEventDamage() * 0.4)
    endif
    set trg = null
    set caster = null
    return false
endfunction

function Trig_Wriggle02_lala takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local trigger trg = LoadTriggerHandle(udg_ht, task, 0)
    local integer task2 = LoadInteger(udg_ht, task, 0)
    call DestroyTrigger(trg)
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    call FlushChildHashtable(udg_ht, task2)
    set t = null
endfunction

function Trig_Wriggle02_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local trigger trg = CreateTrigger()
    local integer task3 = GetHandleId(trg)
    local timer t2 = CreateTimer()
    local integer task2 = GetHandleId(t2)
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 35 - GetUnitAbilityLevel(caster, GetSpellAbilityId()) * 5)
    call SaveUnitHandle(udg_sht, task, 0, caster)
    call RegisterAnyUnitDamage(trg)
    call SaveUnitHandle(udg_ht, task3, 0, caster)
    call TriggerAddCondition(trg, Condition(function Trig_Wriggle02_Damage))
    call SaveInteger(udg_ht, task2, 0, task3)
    call SaveTriggerHandle(udg_ht, task2, 0, trg)
    call TimerStart(t2, 8.0, false, function Trig_Wriggle02_lala)
    call TimerStart(t, 0.1, false, function Wriggle02_Main)
    set t = null
    set caster = null
    set t2 = null
    set trg = null
endfunction

function InitTrig_Wriggle02 takes nothing returns nothing
endfunction