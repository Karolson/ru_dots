function Trig_Cross_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A03L'
endfunction

function Trig_Cross_Clear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    call UnitRemoveAbility(caster, 'A03I')
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    set t = null
    set caster = null
endfunction

function Trig_Cross_Actions takes nothing returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local unit caster = GetTriggerUnit()
    call UnitAddAbility(caster, 'A03I')
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call TimerStart(t, 4.0, false, function Trig_Cross_Clear)
    set t = null
    set caster = null
endfunction

function InitTrig_Cross takes nothing returns nothing
    set gg_trg_Cross = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Cross, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Cross, Condition(function Trig_Cross_Conditions))
    call TriggerAddAction(gg_trg_Cross, function Trig_Cross_Actions)
endfunction