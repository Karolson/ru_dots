function Trig_Def08_Contact_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A07V'
endfunction

function Trig_Def08_Contact_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit target = LoadUnitHandle(udg_ht, task, 1)
    local real oldhp = LoadReal(udg_ht, task, 2)
    local integer i = LoadInteger(udg_ht, task, 3)
    local real newhp
    local real nowhp
    if i >= 0 then
        set nowhp = GetUnitState(target, UNIT_STATE_LIFE)
        if nowhp > oldhp then
            set newhp = nowhp - (nowhp - oldhp) * 0.5
            call SetUnitState(target, UNIT_STATE_LIFE, newhp)
        endif
        call SaveReal(udg_ht, task, 2, GetUnitState(target, UNIT_STATE_LIFE))
    endif
    set i = i + 1
    call SaveInteger(udg_ht, task, 3, i)
    if i / 100 * 100 == i then
        call UnitMagicDamageTarget(caster, target, 50, 4)
    endif
    if i >= 1000 or GetUnitAbilityLevel(target, 'B07C') == 0 then
        call UnitRemoveAbility(target, 'A082')
        call UnitRemoveAbility(target, 'B07C')
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set target = null
endfunction

function Trig_Def08_Contact_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local timer t
    local integer task
    call UnitSlowTarget(caster, target, 5.0, 'A082', 'B07C')
    set t = CreateTimer()
    set task = GetHandleId(t)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, target)
    call SaveReal(udg_ht, task, 2, GetUnitState(target, UNIT_STATE_LIFE))
    call SaveInteger(udg_ht, task, 3, 0)
    call TimerStart(t, 0.01, true, function Trig_Def08_Contact_Main)
    set caster = null
    set target = null
    set t = null
endfunction

function InitTrig_Def08_Contact takes nothing returns nothing
    set gg_trg_Def08_Contact = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Def08_Contact, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Def08_Contact, Condition(function Trig_Def08_Contact_Conditions))
    call TriggerAddAction(gg_trg_Def08_Contact, function Trig_Def08_Contact_Actions)
endfunction