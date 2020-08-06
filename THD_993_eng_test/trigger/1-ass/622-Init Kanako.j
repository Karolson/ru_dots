function Trig_Init_Kanako_Actions takes nothing returns nothing
    local unit h = GetCharacterHandle('U00L')
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call FirstAbilityInit('A00I')
    call FirstAbilityInit('A0F7')
    call FirstAbilityInit('A0F1')
    call FirstAbilityInit('A0F4')
    call FirstAbilityInit('A0IL')
    call FirstAbilityInit('A0F6')
    call FirstAbilityInit('A0FB')
    call FirstAbilityInit('A0FE')
    call FirstAbilityInit('A0F8')
    call FirstAbilityInit('A0FC')
    call FirstAbilityInit('A0F0')
    call FirstAbilityInit('A0F9')
    call FirstAbilityInit('A172')
    if h == null then
        return
    endif
    call DebugMsg(GetHeroProperName(h) + " skill initialization completed")
    if not udg_Repick then
        call DestroyTrigger(GetTriggeringTrigger())
    endif
    call SetHeroLifeIncreaseValue(h, 23)
    call SetHeroManaIncreaseValue(h, 2)
    call SetHeroManaBaseRegenValue(h, 0.4)
    call SaveUnitHandle(udg_ht, task, 0, h)
    call TimerStart(t, 0.75, true, function Trig_KanakoThunder_Actions)
    call DisableTrigger(gg_trg_Kanako01)
    call DestroyTrigger(gg_trg_Kanako01)
    set gg_trg_Kanako01 = CreateTrigger()
    call TriggerRegisterPlayerUnitEvent(gg_trg_Kanako01, GetOwningPlayer(h), EVENT_PLAYER_UNIT_SPELL_EFFECT, null)
    call TriggerAddCondition(gg_trg_Kanako01, Condition(function Trig_Kanako01_Conditions))
    call TriggerAddAction(gg_trg_Kanako01, function Trig_Kanako01_Actions)
    call DisableTrigger(gg_trg_Kanako02)
    call DestroyTrigger(gg_trg_Kanako02)
    set gg_trg_Kanako02 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Kanako02, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Kanako02, Condition(function Trig_Kanako02_Conditions))
    call TriggerAddAction(gg_trg_Kanako02, function Trig_Kanako02_Actions)
    call DisableTrigger(gg_trg_Kanako03)
    call DestroyTrigger(gg_trg_Kanako03)
    set gg_trg_Kanako03 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Kanako03, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Kanako03, Condition(function Trig_Kanako03_Conditions))
    call TriggerAddAction(gg_trg_Kanako03, function Trig_Kanako03_Actions)
    call DisableTrigger(gg_trg_Kanako04)
    call DestroyTrigger(gg_trg_Kanako04)
    set gg_trg_Kanako04 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Kanako04, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerRegisterUnitEvent(gg_trg_Kanako04, h, EVENT_UNIT_SPELL_FINISH)
    call TriggerAddCondition(gg_trg_Kanako04, Condition(function Trig_Kanako04_Conditions))
    call TriggerAddAction(gg_trg_Kanako04, function Trig_Kanako04_Actions)
    call DisableTrigger(gg_trg_KanakoEX01)
    call DestroyTrigger(gg_trg_KanakoEX01)
    set gg_trg_KanakoEX01 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_KanakoEX01, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_KanakoEX01, Condition(function Trig_KanakoEX01_Conditions))
    call TriggerAddAction(gg_trg_KanakoEX01, function Trig_KanakoEX01_Actions)
    call DisableTrigger(gg_trg_KanakoEX02)
    call DestroyTrigger(gg_trg_KanakoEX02)
    set gg_trg_KanakoEX02 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_KanakoEX02, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerRegisterUnitEvent(gg_trg_KanakoEX02, h, EVENT_UNIT_SPELL_ENDCAST)
    call TriggerAddCondition(gg_trg_KanakoEX02, Condition(function Trig_KanakoEX02_Conditions))
    call TriggerAddAction(gg_trg_KanakoEX02, function Trig_KanakoEX02_Actions)
    call DisableTrigger(gg_trg_KanakoEX03)
    call DestroyTrigger(gg_trg_KanakoEX03)
    set gg_trg_KanakoEX03 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_KanakoEX03, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_KanakoEX03, Condition(function Trig_KanakoEX03_Conditions))
    call TriggerAddAction(gg_trg_KanakoEX03, function Trig_KanakoEX03_Actions)
    call SetPlayerTechResearched(GetOwningPlayer(h), 'R004', 1)
    set h = null
endfunction

function InitTrig_Init_Kanako takes nothing returns nothing
    set gg_trg_Init_Kanako = CreateTrigger()
    call TriggerAddAction(gg_trg_Init_Kanako, function Trig_Init_Kanako_Actions)
endfunction