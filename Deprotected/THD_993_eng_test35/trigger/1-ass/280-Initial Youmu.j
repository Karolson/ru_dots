function Trig_Initial_Youmu_Actions takes nothing returns nothing
    local unit h = GetCharacterHandle('O00B')
    if h == null then
        return
    endif
    call DebugMsg(GetHeroProperName(h) + " skill initialization completed")
    call SetHeroLifeIncreaseValue(h, 28)
    call SetHeroManaIncreaseValue(h, 8)
    call SetHeroManaBaseRegenValue(h, 0.7)
    set gg_trg_YoumuEx = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_YoumuEx, h, EVENT_UNIT_ISSUED_ORDER)
    call TriggerRegisterUnitEvent(gg_trg_YoumuEx, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_YoumuEx, Condition(function Trig_YoumuEx_Conditions))
    set gg_trg_Youmu01 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Youmu01, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Youmu01, Condition(function Trig_Youmu01_Conditions))
    call TriggerAddAction(gg_trg_Youmu01, function Trig_Youmu01_Actions)
    if gg_trg_Youmu02 == null then
        set gg_trg_Youmu02 = CreateTrigger()
        call RegisterAnyUnitDamage(gg_trg_Youmu02)
        call TriggerAddCondition(gg_trg_Youmu02, Condition(function Trig_Youmu02_Conditions))
        call TriggerAddAction(gg_trg_Youmu02, function Trig_Youmu02_Actions)
    endif
    set gg_trg_Youmu03 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Youmu03, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerRegisterPlayerUnitEvent(gg_trg_Youmu03, GetOwningPlayer(h), EVENT_PLAYER_UNIT_SUMMON, null)
    call TriggerRegisterPlayerUnitEvent(gg_trg_Youmu03, GetOwningPlayer(h), EVENT_PLAYER_UNIT_DEATH, null)
    call TriggerAddCondition(gg_trg_Youmu03, Condition(function Trig_Youmu03_Conditions))
    call TriggerAddAction(gg_trg_Youmu03, function Trig_Youmu03_Actions)
    call Trig_Youmu03_Init(h, false)
    set gg_trg_Youmu03 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Youmu03, h, EVENT_UNIT_ISSUED_ORDER)
    call TriggerRegisterUnitEvent(gg_trg_Youmu03, h, EVENT_UNIT_ISSUED_POINT_ORDER)
    call TriggerRegisterUnitEvent(gg_trg_Youmu03, h, EVENT_UNIT_ISSUED_TARGET_ORDER)
    call TriggerAddAction(gg_trg_Youmu03, function Trig_Youmu03_Duplicate_Order)
    call DisableTrigger(gg_trg_Youmu03)
    set gg_trg_Youmu04 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Youmu04, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerRegisterUnitEvent(gg_trg_Youmu04, h, EVENT_UNIT_SPELL_CAST)
    call TriggerAddCondition(gg_trg_Youmu04, Condition(function Trig_Youmu04_Conditions))
    call TriggerAddAction(gg_trg_Youmu04, function Trig_Youmu04_Actions)
    call UnitAddAbility(h, 'A1IF')
    call FirstAbilityInit('A0E1')
    call FirstAbilityInit('A063')
    call FirstAbilityInit('A0RV')
    call FirstAbilityInit('A0E0')
    set h = null
endfunction

function InitTrig_Initial_Youmu takes nothing returns nothing
    set gg_trg_Initial_Youmu = CreateTrigger()
    call TriggerAddAction(gg_trg_Initial_Youmu, function Trig_Initial_Youmu_Actions)
endfunction