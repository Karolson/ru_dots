function Trig_AgiInt05_Doll_Cast_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A019'
endfunction

function Trig_AgiInt05_Doll_Cast_Actions takes nothing returns nothing
    local unit u = GetTriggerUnit()
    call TriggerSleepAction(0.0)
    call UnitAddAbility(u, 'A03J')
    call IssueImmediateOrder(u, "windwalk")
    call UnitRemoveAbility(u, 'A03J')
    set u = null
endfunction

function InitTrig_AgiInt05_Doll_Cast takes nothing returns nothing
    set gg_trg_AgiInt05_Doll_Cast = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_AgiInt05_Doll_Cast, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_AgiInt05_Doll_Cast, Condition(function Trig_AgiInt05_Doll_Cast_Conditions))
    call TriggerAddAction(gg_trg_AgiInt05_Doll_Cast, function Trig_AgiInt05_Doll_Cast_Actions)
endfunction