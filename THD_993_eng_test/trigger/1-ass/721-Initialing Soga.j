function Trig_Initialing_Soga_Actions takes nothing returns nothing
    local unit h = GetCharacterHandle('H026')
    call FirstAbilityInit('A0PE')
    call FirstAbilityInit('A0PY')
    call FirstAbilityInit('A0PA')
    call FirstAbilityInit('A19X')
    call FirstAbilityInit('A19Y')
    call FirstAbilityInit('A00M')
    call FirstAbilityInit('A19Z')
    call FirstAbilityInit('A1A2')
    call FirstAbilityInit('A1A0')
    if h == null then
        return
    endif
    call DebugMsg(GetHeroProperName(h) + " skill initialization completed")
    if not udg_Repick then
        call DestroyTrigger(GetTriggeringTrigger())
    endif
    call SetHeroLifeIncreaseValue(h, 30)
    call SetHeroManaIncreaseValue(h, 3)
    call SetHeroManaBaseRegenValue(h, 0.5)
    call DisableTrigger(gg_trg_Soga01)
    call DestroyTrigger(gg_trg_Soga01)
    set gg_trg_Soga01 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Soga01, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Soga01, Condition(function Trig_Soga01_Conditions))
    call TriggerAddAction(gg_trg_Soga01, function Trig_Soga01_Actions)
    call DisableTrigger(gg_trg_Soga02)
    call DestroyTrigger(gg_trg_Soga02)
    set gg_trg_Soga02 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Soga02, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Soga02, Condition(function Trig_Soga02_Conditions))
    call TriggerAddAction(gg_trg_Soga02, function Trig_Soga02_Actions)
    call DisableTrigger(gg_trg_Soga03)
    call DestroyTrigger(gg_trg_Soga03)
    set gg_trg_Soga03 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Soga03, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Soga03, Condition(function Trig_Soga03_Conditions))
    call TriggerAddAction(gg_trg_Soga03, function Trig_Soga03_Actions)
    call DisableTrigger(gg_trg_Soga04)
    call DestroyTrigger(gg_trg_Soga04)
    set gg_trg_Soga04 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Soga04, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Soga04, Condition(function Trig_Soga04_Conditions))
    call TriggerAddAction(gg_trg_Soga04, function Trig_Soga04_Actions)
    set h = null
endfunction

function InitTrig_Initialing_Soga takes nothing returns nothing
    set gg_trg_Initialing_Soga = CreateTrigger()
    call TriggerAddAction(gg_trg_Initialing_Soga, function Trig_Initialing_Soga_Actions)
endfunction