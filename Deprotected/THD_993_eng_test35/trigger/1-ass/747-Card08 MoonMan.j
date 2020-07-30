function Trig_Card08_MoonMan_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A1G0'
endfunction

function Trig_Card08_MoonMan_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local player p = GetOwningPlayer(caster)
    local unit v = GetPlayerCharacter(p)
    local unit u = NewDummy(p, GetUnitX(caster), GetUnitY(caster), 0)
    local timer t = CreateTimer()
    local unit target = GetSpellTargetUnit()
    local integer task = GetHandleId(t)
    call SetCardAbility(caster, GetSpellAbilityId(), false)
    call SetUnitAnimation(caster, "attack")
    call UnitAddAbility(u, 'A1B7')
    call UnitAddAbility(u, 'A1B8')
    if caster == target then
        call SetUnitAbilityLevel(u, 'A1B8', 2)
    endif
    call IssueTargetOrder(u, "invisibility", target)
    call IssueTargetOrder(u, "bloodlust", target)
    call IssueTargetOrder(u, "invisibility", caster)
    call IssueTargetOrder(u, "bloodlust", caster)
    call UnitRemoveAbility(u, 'A1B8')
    call UnitRemoveAbility(u, 'A1B7')
    call ReleaseDummy(u)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call TimerStart(t, 0.5, true, function Invisible_at_night_clear)
    set t = CreateTimer()
    set task = GetHandleId(t)
    call SaveUnitHandle(udg_ht, task, 0, target)
    call TimerStart(t, 0.5, true, function Invisible_at_night_clear)
    set t = null
    set caster = null
    set v = null
    set u = null
    set p = null
    set caster = null
    return
endfunction

function InitTrig_Card08_MoonMan takes nothing returns nothing
    set gg_trg_Card08_MoonMan = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Card08_MoonMan, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(gg_trg_Card08_MoonMan, Condition(function Trig_Card08_MoonMan_Conditions))
    call TriggerAddAction(gg_trg_Card08_MoonMan, function Trig_Card08_MoonMan_Actions)
endfunction