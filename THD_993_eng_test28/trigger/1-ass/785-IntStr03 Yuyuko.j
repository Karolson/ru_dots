function Trig_IntStr03_Yuyuko_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A146'
endfunction

function Trig_IntStr03_Yuyuko_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real tx = GetSpellTargetX()
    local real ty = GetSpellTargetY()
    local unit u = NewDummy(GetOwningPlayer(caster), ox, oy, 0.0)
    call UnitAddAbility(u, 'A147')
    call IssuePointOrder(u, "carrionswarm", tx, ty)
    call TriggerSleepAction(2.0)
    call UnitRemoveAbility(u, 'A147')
    call ReleaseDummy(u)
    set u = null
    set caster = null
endfunction

function InitTrig_IntStr03_Yuyuko takes nothing returns nothing
    set gg_trg_IntStr03_Yuyuko = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_IntStr03_Yuyuko, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_IntStr03_Yuyuko, Condition(function Trig_IntStr03_Yuyuko_Conditions))
    call TriggerAddAction(gg_trg_IntStr03_Yuyuko, function Trig_IntStr03_Yuyuko_Actions)
endfunction