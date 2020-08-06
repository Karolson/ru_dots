function Trig_Initial_Umbrella_Actions takes nothing returns nothing
    local unit h = GetCharacterHandle('E00X')
    local timer t
    local integer task
    call FirstAbilityInit('A0C3')
    call FirstAbilityInit('A1GA')
    call FirstAbilityInit('A1G9')
    call FirstAbilityInit('A0C4')
    call FirstAbilityInit('A0LS')
    call FirstAbilityInit('A0IL')
    call FirstAbilityInit('A0C8')
    call FirstAbilityInit('A0LT')
    call FirstAbilityInit('A0Z7')
    call FirstAbilityInit('A0C7')
    call FirstAbilityInit('Abun')
    if h == null then
        set h = GetCharacterHandle('E03D')
    endif
    if h == null then
        return
    endif
    call DebugMsg(GetHeroProperName(h) + " skill initialization completed")
    if not udg_Repick then
        call DestroyTrigger(GetTriggeringTrigger())
    endif
    set udg_SK_Kogasa = h
    call SetHeroLifeIncreaseValue(h, 26)
    call SetHeroManaIncreaseValue(h, 5)
    call SetHeroManaBaseRegenValue(h, 0.5)
    set t = CreateTimer()
    set task = GetHandleId(t)
    call SaveUnitHandle(udg_ht, task, 0, h)
    call TimerStart(t, 1.0, true, function Trig_KogasaEx_Actions)
    call DisableTrigger(gg_trg_Kogasa01)
    call DestroyTrigger(gg_trg_Kogasa01)
    set gg_trg_Kogasa01 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Kogasa01, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Kogasa01, Condition(function Trig_Kogasa01_Conditions))
    call TriggerAddAction(gg_trg_Kogasa01, function Trig_Kogasa01_Actions)
    call DisableTrigger(gg_trg_Kogasa02)
    call DestroyTrigger(gg_trg_Kogasa02)
    set gg_trg_Kogasa02 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Kogasa02, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Kogasa02, Condition(function Trig_Kogasa02_Conditions))
    call TriggerAddAction(gg_trg_Kogasa02, function Trig_Kogasa02_Actions)
    call DisableTrigger(gg_trg_Kogasa03)
    call DestroyTrigger(gg_trg_Kogasa03)
    set gg_trg_Kogasa03 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Kogasa03, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Kogasa03, Condition(function Trig_Kogasa03_Conditions))
    call TriggerAddAction(gg_trg_Kogasa03, function Trig_Kogasa03_Actions)
    call DisableTrigger(gg_trg_Kogasa03_Learn)
    call DestroyTrigger(gg_trg_Kogasa03_Learn)
    set gg_trg_Kogasa03_Learn = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Kogasa03_Learn, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_Kogasa03_Learn, Condition(function Trig_Kogasa03_Learn_Conditions))
    call TriggerAddAction(gg_trg_Kogasa03_Learn, function Trig_Kogasa03_Learn_Actions)
    call DisableTrigger(gg_trg_Kogasa04_Check)
    call DestroyTrigger(gg_trg_Kogasa04_Check)
    set gg_trg_Kogasa04_Check = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Kogasa04_Check, h, EVENT_UNIT_SPELL_CAST)
    call TriggerAddCondition(gg_trg_Kogasa04_Check, Condition(function Trig_Kogasa04_Check_Conditions))
    call TriggerAddAction(gg_trg_Kogasa04_Check, function Trig_Kogasa04_Check_Actions)
    call DisableTrigger(gg_trg_Kogasa04)
    call DestroyTrigger(gg_trg_Kogasa04)
    set gg_trg_Kogasa04 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Kogasa04, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Kogasa04, Condition(function Trig_Kogasa04_Conditions))
    call TriggerAddAction(gg_trg_Kogasa04, function Trig_Kogasa04_Actions)
    call DisableTrigger(gg_trg_Kogasa04_Cancel)
    call DestroyTrigger(gg_trg_Kogasa04_Cancel)
    set gg_trg_Kogasa04_Cancel = CreateTrigger()
    call DisableTrigger(gg_trg_Kogasa04_Cancel)
    call TriggerRegisterUnitEvent(gg_trg_Kogasa04_Cancel, h, EVENT_UNIT_ISSUED_TARGET_ORDER)
    call TriggerRegisterUnitEvent(gg_trg_Kogasa04_Cancel, h, EVENT_UNIT_ISSUED_POINT_ORDER)
    call TriggerAddCondition(gg_trg_Kogasa04_Cancel, Condition(function Trig_Kogasa04_Cancel_Condition))
    set h = null
endfunction

function InitTrig_Initial_Umbrella takes nothing returns nothing
    set gg_trg_Initial_Umbrella = CreateTrigger()
    call TriggerAddAction(gg_trg_Initial_Umbrella, function Trig_Initial_Umbrella_Actions)
endfunction