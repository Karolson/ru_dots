function Trig_Initialing_Tokiko_Actions takes nothing returns nothing
    local unit h = GetCharacterHandle('E02E')
    local integer k
    if h == null then
        return
    endif
    call DebugMsg(GetHeroProperName(h) + " skill initialization completed")
    if not udg_Repick then
        call DestroyTrigger(GetTriggeringTrigger())
    endif
    call SetHeroLifeIncreaseValue(h, 34)
    call SetHeroManaIncreaseValue(h, 0)
    call SetHeroManaBaseRegenValue(h, 0.4)
    call UnitInitAddAttack(h)
    set k = GetPlayerId(GetOwningPlayer(h)) + 1
    set udg_SK_Tokiko[k] = h
    call DisableTrigger(gg_trg_TokikoEx)
    call DestroyTrigger(gg_trg_TokikoEx)
    set gg_trg_TokikoEx = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_TokikoEx, EVENT_PLAYER_UNIT_SELL_ITEM)
    call TriggerAddCondition(gg_trg_TokikoEx, Condition(function Trig_TokikoEx_Conditions))
    call TriggerAddAction(gg_trg_TokikoEx, function Trig_TokikoEx_Actions)
    call DisableTrigger(gg_trg_Tokiko01)
    call DestroyTrigger(gg_trg_Tokiko01)
    set gg_trg_Tokiko01 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Tokiko01, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Tokiko01, Condition(function Trig_Tokiko01_Conditions))
    call TriggerAddAction(gg_trg_Tokiko01, function Trig_Tokiko01_Actions)
    call DisableTrigger(gg_trg_Tokiko02)
    call DestroyTrigger(gg_trg_Tokiko02)
    set gg_trg_Tokiko02 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Tokiko02, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Tokiko02, Condition(function Trig_Tokiko02_Conditions))
    call TriggerAddAction(gg_trg_Tokiko02, function Trig_Tokiko02_Actions)
    set udg_SK_Tokiko03_Hashtable[k] = InitHashtable()
    call DisableTrigger(gg_trg_Tokiko03_Attack)
    call DestroyTrigger(gg_trg_Tokiko03_Attack)
    set gg_trg_Tokiko03_Attack = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Tokiko03_Attack, EVENT_PLAYER_UNIT_ATTACKED)
    call TriggerAddCondition(gg_trg_Tokiko03_Attack, Condition(function Trig_Tokiko03_Attack_Conditions))
    call TriggerAddAction(gg_trg_Tokiko03_Attack, function Trig_Tokiko03_Attack_Actions)
    set udg_SK_Tokiko03_Hashtable02[k] = InitHashtable()
    call DisableTrigger(gg_trg_Tokiko03_Damage)
    call DestroyTrigger(gg_trg_Tokiko03_Damage)
    set gg_trg_Tokiko03_Damage = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Tokiko03_Damage, h, EVENT_UNIT_DAMAGED)
    call TriggerAddCondition(gg_trg_Tokiko03_Damage, Condition(function Trig_Tokiko03_Damage_Conditions))
    call TriggerAddAction(gg_trg_Tokiko03_Damage, function Trig_Tokiko03_Damage_Actions)
    call DisableTrigger(gg_trg_Tokiko04)
    call DestroyTrigger(gg_trg_Tokiko04)
    set gg_trg_Tokiko04 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Tokiko04, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Tokiko04, Condition(function Trig_Tokiko04_Conditions))
    call TriggerAddAction(gg_trg_Tokiko04, function Trig_Tokiko04_Actions)
    call UnitAddAbility(h, 'A0ZO')
    call UnitAddAbility(h, 'A0ZP')
    call UnitAddAbility(h, 'A0ZQ')
    call UnitRemoveAbility(h, 'A0ZO')
    call UnitRemoveAbility(h, 'A0ZP')
    call UnitRemoveAbility(h, 'A0ZQ')
    set h = null
endfunction

function InitTrig_Initialing_Tokiko takes nothing returns nothing
    set gg_trg_Initialing_Tokiko = CreateTrigger()
    call TriggerAddAction(gg_trg_Initialing_Tokiko, function Trig_Initialing_Tokiko_Actions)
endfunction