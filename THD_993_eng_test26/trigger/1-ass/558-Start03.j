function Start03 takes nothing returns integer
    return 'A10S'
endfunction

function Start03_Vest takes nothing returns integer
    return 'n052'
endfunction

function Trig_Start03_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A10S'
endfunction

function Trig_Start03_Main takes nothing returns nothing
    local trigger trg = GetTriggeringTrigger()
    local integer task = GetHandleId(trg)
    local unit u = GetTriggerUnit()
    local integer i = LoadInteger(udg_ht, task, 0)
    if GetTriggerEventId() == EVENT_UNIT_DEATH then
        call FlushChildHashtable(udg_ht, task)
        call DestroyTrigger(trg)
        set trg = null
        set u = null
        return
    endif
    if IsDamageMagicDamage(u) then
        call SaveInteger(udg_ht, task, 0, i + 1)
        if i > 2 then
            call KillUnit(u)
            call FlushChildHashtable(udg_ht, task)
            call DestroyTrigger(trg)
        endif
    endif
    set u = null
    set trg = null
endfunction

function Trig_Start03_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A10S')
    local unit u = CreateUnit(GetOwningPlayer(caster), 'n052', GetUnitX(caster), GetUnitY(caster), 0.0)
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 75)
    call UnitRemoveAbility(u, 'Amov')
    call UnitApplyTimedLife(u, 'BTLF', 80.0 + level * 40.0)
    set u = null
    set caster = null
endfunction

function InitTrig_Start03 takes nothing returns nothing
    set gg_trg_Start03 = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Start03, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Start03, Condition(function Trig_Start03_Conditions))
    call TriggerAddAction(gg_trg_Start03, function Trig_Start03_Actions)
endfunction