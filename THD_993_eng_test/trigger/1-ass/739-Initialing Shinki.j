function Trig_Initialing_Shinki_Actions takes nothing returns nothing
    local unit h = GetCharacterHandle('H02J')
    call FirstAbilityInit('A1DV')
    call FirstAbilityInit('A1EZ')
    call FirstAbilityInit('A1DW')
    call FirstAbilityInit('A0IL')
    call FirstAbilityInit('A013')
    call FirstAbilityInit('A1DX')
    call FirstAbilityInit('A1DY')
    call FirstAbilityInit('A1F0')
    call FirstAbilityInit('A1DZ')
    if h == null then
        return
    endif
    call DebugMsg(GetHeroProperName(h) + " skill initialization completed")
    if not udg_Repick then
        call DestroyTrigger(GetTriggeringTrigger())
    endif
    call SetHeroLifeIncreaseValue(h, 30)
    call SetHeroManaIncreaseValue(h, 5)
    set udg_SK_Shinki = h
    call UnitAddAbility(h, 'A1F1')
    call SetPlayerAbilityAvailable(GetOwningPlayer(h), 'A1F1', false)
    call DestroyTrigger(gg_trg_Shinki01)
    set gg_trg_Shinki01 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Shinki01, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Shinki01, Condition(function Trig_Shinki01_Conditions))
    call TriggerAddAction(gg_trg_Shinki01, function Trig_Shinki01_Actions)
    call DisableTrigger(gg_trg_Shinki02)
    set gg_trg_Shinki02 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Shinki02, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Shinki02, Condition(function Trig_Shinki02_Conditions))
    call TriggerAddAction(gg_trg_Shinki02, function Trig_Shinki02_Actions)
    call DisableTrigger(gg_trg_Shinki03)
    set gg_trg_Shinki03 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Shinki03, h, EVENT_UNIT_HERO_SKILL)
    call TriggerAddCondition(gg_trg_Shinki03, Condition(function Trig_Shinki03_Conditions))
    call TriggerAddAction(gg_trg_Shinki03, function Trig_Shinki03_Actions)
    call DisableTrigger(gg_trg_Shinki04)
    set gg_trg_Shinki04 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Shinki04, h, EVENT_UNIT_SUMMON)
    call TriggerAddCondition(gg_trg_Shinki04, Condition(function Trig_Shinki04_Conditions))
    call TriggerAddAction(gg_trg_Shinki04, function Trig_Shinki04_Actions)
    set h = null
endfunction

function InitTrig_Initialing_Shinki takes nothing returns nothing
    set gg_trg_Initialing_Shinki = CreateTrigger()
    call TriggerAddAction(gg_trg_Initialing_Shinki, function Trig_Initialing_Shinki_Actions)
endfunction