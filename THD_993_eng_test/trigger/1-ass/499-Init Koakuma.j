function Trig_Init_Koakuma_Actions takes nothing returns nothing
    local unit h = GetCharacterHandle('E01E')
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call FirstAbilityInit('A05F')
    call FirstAbilityInit('A05A')
    call FirstAbilityInit('A0MT')
    call FirstAbilityInit('A0NO')
    call FirstAbilityInit('A15Y')
    call FirstAbilityInit('A15Z')
    call FirstAbilityInit('A160')
    call FirstAbilityInit('A161')
    call FirstAbilityInit('A162')
    call FirstAbilityInit('A163')
    call FirstAbilityInit('A164')
    call FirstAbilityInit('A165')
    call FirstAbilityInit('A166')
    call FirstAbilityInit('A167')
    call FirstAbilityInit('A168')
    call FirstAbilityInit('A169')
    call FirstAbilityInit('A16A')
    call FirstAbilityInit('A16B')
    call FirstAbilityInit('A16C')
    call FirstAbilityInit('A16D')
    call FirstAbilityInit('A16E')
    call FirstAbilityInit('A16F')
    call FirstAbilityInit('A16G')
    call FirstAbilityInit('A16H')
    call FirstAbilityInit('A16I')
    call FirstAbilityInit('A16J')
    call FirstAbilityInit('A16K')
    call FirstAbilityInit('A16L')
    call FirstAbilityInit('A0NH')
    call FirstAbilityInit('A15X')
    call FirstAbilityInit('A0NI')
    if h == null then
        return
    endif
    call DebugMsg(GetHeroProperName(h) + " skill initialization completed")
    if not udg_Repick then
        call DestroyTrigger(GetTriggeringTrigger())
    endif
    call SetHeroLifeIncreaseValue(h, 30)
    call SetHeroManaIncreaseValue(h, 5)
    call SetHeroManaBaseRegenValue(h, 0.5)
    call SaveUnitHandle(udg_ht, task, 0, h)
    call TimerStart(t, 1.0, true, function Trig_KoakumaLibrary_Actions)
    call DisableTrigger(gg_trg_Koakuma)
    call DestroyTrigger(gg_trg_Koakuma)
    set gg_trg_Koakuma = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Koakuma, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Koakuma, Condition(function Trig_Koakuma_Conditions))
    call TriggerAddAction(gg_trg_Koakuma, function Trig_Koakuma_Actions)
    call DisableTrigger(gg_trg_Koakuma03Cast)
    call DestroyTrigger(gg_trg_Koakuma03Cast)
    set gg_trg_Koakuma03Cast = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Koakuma03Cast, h, EVENT_UNIT_HERO_SKILL)
    call TriggerAddCondition(gg_trg_Koakuma03Cast, Condition(function Trig_Koakuma03Cast_Conditions))
    call TriggerAddAction(gg_trg_Koakuma03Cast, function Trig_Koakuma03Cast_Actions)
    call DisableTrigger(gg_trg_Koakuma04_Effect)
    call DestroyTrigger(gg_trg_Koakuma04_Effect)
    set gg_trg_Koakuma04_Effect = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Koakuma04_Effect, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Koakuma04_Effect, Condition(function Trig_Koakuma04_Effect_Conditions))
    call TriggerAddAction(gg_trg_Koakuma04_Effect, function Trig_Koakuma04_Effect_Actions)
    call UnitAddAbility(h, 'A0NO')
    call UnitRemoveAbility(h, 'A0NO')
    set h = null
endfunction

function InitTrig_Init_Koakuma takes nothing returns nothing
    set gg_trg_Init_Koakuma = CreateTrigger()
    call TriggerAddAction(gg_trg_Init_Koakuma, function Trig_Init_Koakuma_Actions)
endfunction