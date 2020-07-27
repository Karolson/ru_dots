function Trig_Init_Lunar_Actions takes nothing returns nothing
    local unit h = GetCharacterHandle('E00O')
    if h == null then
        return
    endif
    call DebugMsg(GetHeroProperName(h) + " skill initialization completed")
    if not udg_Repick then
        call DestroyTrigger(GetTriggeringTrigger())
    endif
    call SetHeroLifeIncreaseValue(h, 28)
    call SetHeroManaIncreaseValue(h, 0)
    call SetHeroManaBaseRegenValue(h, 0)
    set udg_SK_Lunar = h
    call DisableTrigger(gg_trg_Lunar01)
    call DestroyTrigger(gg_trg_Lunar01)
    set gg_trg_Lunar01 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Lunar01, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Lunar01, Condition(function Trig_Lunar01_Conditions))
    call TriggerAddAction(gg_trg_Lunar01, function Trig_Lunar01_Actions)
    call DisableTrigger(gg_trg_Lunar02)
    call DestroyTrigger(gg_trg_Lunar02)
    set gg_trg_Lunar02 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Lunar02, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Lunar02, Condition(function Trig_Lunar02_Conditions))
    call TriggerAddAction(gg_trg_Lunar02, function Trig_Lunar02_Actions)
    call DisableTrigger(gg_trg_Lunar02Cast)
    call DestroyTrigger(gg_trg_Lunar02Cast)
    set gg_trg_Lunar02Cast = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Lunar02Cast, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(gg_trg_Lunar02Cast, Condition(function Trig_Lunar02Cast_Conditions))
    call TriggerAddAction(gg_trg_Lunar02Cast, function Trig_Lunar02Cast_Actions)
    call DisableTrigger(gg_trg_Lunar03)
    call DestroyTrigger(gg_trg_Lunar03)
    set gg_trg_Lunar03 = CreateTrigger()
    call RegisterAnyUnitDamage(gg_trg_Lunar03)
    call TriggerAddCondition(gg_trg_Lunar03, Condition(function Trig_Lunar03_Conditions))
    call TriggerAddAction(gg_trg_Lunar03, function Trig_Lunar03_Actions)
    call DisableTrigger(gg_trg_Lunar04)
    call DestroyTrigger(gg_trg_Lunar04)
    set gg_trg_Lunar04 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Lunar04, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Lunar04, Condition(function Trig_Lunar04_Conditions))
    call TriggerAddAction(gg_trg_Lunar04, function Trig_Lunar04_Actions)
    call FirstAbilityInit('A19U')
    call FirstAbilityInit('A19T')
    call AddingLBuff(0, 'A19T', 'B009')
    call AddingLBuff(0, 'A0BE', 0)
    set h = null
endfunction

function InitTrig_Init_Lunar takes nothing returns nothing
    set gg_trg_Init_Lunar = CreateTrigger()
    call TriggerAddAction(gg_trg_Init_Lunar, function Trig_Init_Lunar_Actions)
endfunction