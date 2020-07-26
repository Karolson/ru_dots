function Trig_Initial_Kumoi_Actions takes nothing returns nothing
    local unit h = GetCharacterHandle('E03K')
    if h == null then
        return
    endif
    call DebugMsg(GetHeroProperName(h) + " skill initialization completed")
    if not udg_Repick then
        call DestroyTrigger(GetTriggeringTrigger())
    endif
    set udg_SK_Kumoi03 = 0
    call SetHeroLifeIncreaseValue(h, 18)
    call SetHeroManaIncreaseValue(h, 9)
    call SetHeroManaBaseRegenValue(h, 0.8)
    call DisableTrigger(gg_trg_Kumoi01)
    call DestroyTrigger(gg_trg_Kumoi01)
    set gg_trg_Kumoi01 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Kumoi01, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Kumoi01, Condition(function Trig_Kumoi01_Conditions))
    call TriggerAddAction(gg_trg_Kumoi01, function Trig_Kumoi01_Actions)
    call DisableTrigger(gg_trg_Kumoi02)
    call DestroyTrigger(gg_trg_Kumoi02)
    set gg_trg_Kumoi02 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Kumoi02, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Kumoi02, Condition(function Trig_Kumoi02_Conditions))
    call TriggerAddAction(gg_trg_Kumoi02, function Trig_Kumoi02_Actions)
    call DisableTrigger(gg_trg_Kumoi03)
    call DestroyTrigger(gg_trg_Kumoi03)
    set gg_trg_Kumoi03 = CreateTrigger()
    call RegisterAnyUnitDamage(gg_trg_Kumoi03)
    call TriggerAddCondition(gg_trg_Kumoi03, Condition(function Trig_Kumoi03_Conditions))
    call TriggerAddAction(gg_trg_Kumoi03, function Trig_Kumoi03_Actions)
    call DisableTrigger(gg_trg_Kumoi04)
    call DestroyTrigger(gg_trg_Kumoi04)
    set gg_trg_Kumoi04 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Kumoi04, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Kumoi04, Condition(function Trig_Kumoi04_Conditions))
    call TriggerAddAction(gg_trg_Kumoi04, function Trig_Kumoi04_Actions)
    call SaveInteger(udg_ht, StringHash("Stupids Utopia"), 0, 0)
    set h = null
endfunction

function InitTrig_Initial_Kumoi takes nothing returns nothing
    set gg_trg_Initial_Kumoi = CreateTrigger()
    call TriggerAddAction(gg_trg_Initial_Kumoi, function Trig_Initial_Kumoi_Actions)
endfunction