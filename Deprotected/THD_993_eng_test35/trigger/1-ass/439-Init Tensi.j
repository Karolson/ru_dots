function Trig_Init_Tensi_Actions takes nothing returns nothing
    local unit h = GetCharacterHandle('H002')
    if h == null then
        return
    endif
    call DebugMsg(GetHeroProperName(h) + " skill initialization completed")
    call SetHeroLifeIncreaseValue(h, 33)
    call SetHeroManaIncreaseValue(h, 9)
    call SetHeroManaBaseRegenValue(h, 0.4)
    set gg_trg_TensiDS = CreateTrigger()
    call TriggerRegisterPlayerEvent(gg_trg_TensiDS, GetOwningPlayer(h), EVENT_PLAYER_END_CINEMATIC)
    call TriggerAddCondition(gg_trg_TensiDS, Condition(function Trig_TensiDS_Conditions))
    call TriggerAddAction(gg_trg_TensiDS, function Trig_TensiDS_Actions)
    set gg_trg_TenshiEx = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_TenshiEx, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_TenshiEx, Condition(function TenshiEx_Condition))
    set gg_trg_Tensi01 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Tensi01, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Tensi01, Condition(function Trig_Tensi01_Conditions))
    call TriggerAddAction(gg_trg_Tensi01, function Trig_Tensi01_Actions)
    set gg_trg_Tensi02 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Tensi02, h, EVENT_UNIT_HERO_SKILL)
    call TriggerAddCondition(gg_trg_Tensi02, Condition(function Trig_Tensi02_Conditions))
    call TriggerAddAction(gg_trg_Tensi02, function Trig_Tensi02_Learn)
    set gg_trg_Tensi03 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Tensi03, h, EVENT_UNIT_HERO_SKILL)
    call TriggerAddCondition(gg_trg_Tensi03, Condition(function Trig_Tensi03_Conditions))
    call TriggerAddAction(gg_trg_Tensi03, function Trig_Tensi03_Actions)
    set gg_trg_Tensi04 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Tensi04, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerRegisterUnitEvent(gg_trg_Tensi04, h, EVENT_UNIT_SPELL_FINISH)
    call TriggerAddCondition(gg_trg_Tensi04, Condition(function Trig_Tensi04_Conditions))
    call TriggerAddAction(gg_trg_Tensi04, function Trig_Tensi04_Actions)
    call FirstAbilityInit('A072')
    call FirstAbilityInit('A0MK')
    call FirstAbilityInit('A0AL')
    call FirstAbilityInit('A0AK')
    set h = null
endfunction

function InitTrig_Init_Tensi takes nothing returns nothing
    set gg_trg_Init_Tensi = CreateTrigger()
    call TriggerAddAction(gg_trg_Init_Tensi, function Trig_Init_Tensi_Actions)
endfunction