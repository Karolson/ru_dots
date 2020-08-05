function Trig_Initialing_Kisume_Actions takes nothing returns nothing
    local unit h = GetCharacterHandle('E01V')
    call FirstAbilityInit('A0GL')
    call FirstAbilityInit('A0R8')
    call FirstAbilityInit('A08L')
    call FirstAbilityInit('A0R9')
    call FirstAbilityInit('A0V4')
    call FirstAbilityInit('A0RA')
    call FirstAbilityInit('A0RB')
    if h == null then
        return
    endif
    call DebugMsg(GetHeroProperName(h) + " skill initialization completed")
    if not udg_Repick then
        call DestroyTrigger(GetTriggeringTrigger())
    endif
    call SetHeroLifeIncreaseValue(h, 30)
    call SetHeroManaIncreaseValue(h, 6)
    call SetHeroManaBaseRegenValue(h, 0.6)
    set gg_trg_Kisume01 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Kisume01, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Kisume01, Condition(function Trig_Kisume01_Conditions))
    call TriggerAddAction(gg_trg_Kisume01, function Trig_Kisume01_Actions)
    set gg_trg_Kisume02 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Kisume02, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Kisume02, Condition(function Trig_Kisume02_Conditions))
    call TriggerAddAction(gg_trg_Kisume02, function Trig_Kisume02_Actions)
    set gg_trg_Kisume03 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Kisume03, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Kisume03, Condition(function Trig_Kisume03_Conditions))
    call TriggerAddAction(gg_trg_Kisume03, function Trig_Kisume03_Actions)
    set gg_trg_Kisume04 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Kisume04, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Kisume04, Condition(function Trig_Kisume04_Conditions))
    call TriggerAddAction(gg_trg_Kisume04, function Trig_Kisume04_Actions)
    set h = null
endfunction

function InitTrig_Initialing_Kisume takes nothing returns nothing
    set gg_trg_Initialing_Kisume = CreateTrigger()
    call TriggerAddAction(gg_trg_Initialing_Kisume, function Trig_Initialing_Kisume_Actions)
endfunction