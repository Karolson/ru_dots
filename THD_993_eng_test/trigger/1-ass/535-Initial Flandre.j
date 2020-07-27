function Trig_Initial_Flandre_Actions takes nothing returns nothing
    local unit h = GetCharacterHandle('U007')
    if h == null then
        set h = GetCharacterHandle('U00W')
    endif
    if h == null then
        return
    endif
    call DebugMsg(GetHeroProperName(h) + " skill initialization completed")
    if not udg_Repick then
        call DestroyTrigger(GetTriggeringTrigger())
    endif
    call SetHeroLifeIncreaseValue(h, 25)
    call SetHeroManaIncreaseValue(h, 8)
    call SetHeroManaBaseRegenValue(h, 0.4)
    call UnitAddAbility(h, 'A062')
    call UnitRemoveAbility(h, 'A062')
    call DisableTrigger(gg_trg_Flandre01)
    call DestroyTrigger(gg_trg_Flandre01)
    set gg_trg_Flandre01 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Flandre01, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Flandre01, Condition(function Trig_Flandre01_Conditions))
    call TriggerAddAction(gg_trg_Flandre01, function Trig_Flandre01_Actions)
    call DisableTrigger(gg_trg_Flandre02)
    call DestroyTrigger(gg_trg_Flandre02)
    set gg_trg_Flandre02 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Flandre02, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Flandre02, Condition(function Flandre02_Conditions))
    call TriggerAddAction(gg_trg_Flandre02, function Flandre02_Actions)
    call AddingLBuff(0, 'A0EI', 'B012')
    call AddingLBuff(0, 'A0EJ', 'B012')
    call AddingLBuff(0, 'A0EK', 'B012')
    call AddingLBuff(0, 'A0EQ', 'B012')
    call DisableTrigger(gg_trg_Flandre03)
    call DestroyTrigger(gg_trg_Flandre03)
    set gg_trg_Flandre03 = CreateTrigger()
    call RegisterAnyUnitDamage(gg_trg_Flandre03)
    call TriggerRegisterUnitEvent(gg_trg_Flandre03, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Flandre03, Condition(function Flandre03_Conditions))
    call DisableTrigger(gg_trg_Flandre04)
    call DestroyTrigger(gg_trg_Flandre04)
    set gg_trg_Flandre04 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Flandre04, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Flandre04, Condition(function Flandre04_Conditions))
    call TriggerAddAction(gg_trg_Flandre04, function Flandre04_Actions)
    call DisableTrigger(gg_trg_Flandre04_Attack)
    call DestroyTrigger(gg_trg_Flandre04_Attack)
    set gg_trg_Flandre04_Attack = CreateTrigger()
    call RegisterAnyUnitDamage(gg_trg_Flandre04_Attack)
    call TriggerAddCondition(gg_trg_Flandre04_Attack, Condition(function Trig_Flandre04_Attack_Conditions))
    call TriggerAddAction(gg_trg_Flandre04_Attack, function Trig_Flandre04_Attack_Actions)
    call DisableTrigger(gg_trg_Flandre04_Attack)
    set h = null
endfunction

function InitTrig_Initial_Flandre takes nothing returns nothing
    set gg_trg_Initial_Flandre = CreateTrigger()
    call TriggerAddAction(gg_trg_Initial_Flandre, function Trig_Initial_Flandre_Actions)
endfunction