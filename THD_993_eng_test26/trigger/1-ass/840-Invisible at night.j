function Trig_Invisible_at_night_Conditions takes nothing returns boolean
    if not (GetSpellAbilityId() == 'A1B6') then
        return false
    endif
    return true
endfunction

function Trig_Invisible_at_night_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local player p = GetOwningPlayer(caster)
    local unit v = GetPlayerCharacter(p)
    local unit u = NewDummy(p, GetUnitX(caster), GetUnitY(caster), 0)
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    set t = null
    set caster = null
    set v = null
    set u = null
    set p = null
    return
    call UnitAddAbility(u, 'A1B7')
    call IssueTargetOrder(u, "invisibility", v)
    call UnitRemoveAbility(u, 'A1B7')
    call UnitAddAbility(u, 'A1B8')
    call IssueTargetOrder(u, "bloodlust", v)
    call UnitRemoveAbility(u, 'A1B8')
    call ReleaseDummy(u)
    call SaveUnitHandle(udg_ht, task, 0, v)
    set t = null
    set caster = null
    set v = null
    set u = null
    set p = null
endfunction

function InitTrig_Invisible_at_night takes nothing returns nothing
    set gg_trg_Invisible_at_night = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Invisible_at_night, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Invisible_at_night, Condition(function Trig_Invisible_at_night_Conditions))
    call TriggerAddAction(gg_trg_Invisible_at_night, function Trig_Invisible_at_night_Actions)
endfunction