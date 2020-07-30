function Trig_Initial_Keine_Actions takes nothing returns nothing
    local unit h = GetCharacterHandle('E01A')
    local player w = GetOwningPlayer(h)
    local integer task = GetHandleId(h)
    if h == null then
        return
    endif
    call DebugMsg(GetHeroProperName(h) + " skill initialization completed")
    if not udg_Repick then
        call DestroyTrigger(GetTriggeringTrigger())
    endif
    call SetHeroLifeIncreaseValue(h, 34)
    call SetHeroManaIncreaseValue(h, 0)
    call SetHeroManaBaseRegenValue(h, 0.4)
    set udg_SK_Keine = h
    set udg_SK_Keine_Str = 0
    set udg_SK_Keine_Wolf = 0
    call DisableTrigger(gg_trg_KeineAttack)
    call DestroyTrigger(gg_trg_KeineAttack)
    set gg_trg_KeineAttack = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_KeineAttack, EVENT_PLAYER_UNIT_ATTACKED)
    call TriggerAddCondition(gg_trg_KeineAttack, Condition(function Trig_KeineAttack_Conditions))
    call TriggerAddAction(gg_trg_KeineAttack, function Trig_KeineAttack_Actions)
    call DisableTrigger(gg_trg_Keine_Ability_Change)
    call DestroyTrigger(gg_trg_Keine_Ability_Change)
    set gg_trg_Keine_Ability_Change = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Keine_Ability_Change, h, EVENT_UNIT_HERO_SKILL)
    call TriggerRegisterTimerEventPeriodic(gg_trg_Keine_Ability_Change, 5.0)
    call TriggerAddAction(gg_trg_Keine_Ability_Change, function Trig_Keine_Ability_Change_Actions)
    call DisableTrigger(gg_trg_Keine01)
    call DestroyTrigger(gg_trg_Keine01)
    set gg_trg_Keine01 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Keine01, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Keine01, Condition(function Trig_Keine_01_Conditions))
    call TriggerAddAction(gg_trg_Keine01, function Trig_Keine_01_Actions)
    call DisableTrigger(gg_trg_Keine02)
    call DestroyTrigger(gg_trg_Keine02)
    set gg_trg_Keine02 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Keine02, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Keine02, Condition(function Trig_Keine_02_Conditions))
    call TriggerAddAction(gg_trg_Keine02, function Trig_Keine_02_Actions)
    call DisableTrigger(gg_trg_Keine03)
    call DestroyTrigger(gg_trg_Keine03)
    set gg_trg_Keine03 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Keine03, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Keine03, Condition(function Trig_Keine_03_Conditions))
    call TriggerAddAction(gg_trg_Keine03, function Trig_Keine_03_Actions)
    call DisableTrigger(gg_trg_Keine04)
    call DestroyTrigger(gg_trg_Keine04)
    set gg_trg_Keine04 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Keine04, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Keine04, Condition(function Trig_Keine_04_Conditions))
    call TriggerAddAction(gg_trg_Keine04, function Trig_Keine_04_Actions)
    call FirstAbilityInit('A0MC')
    call FirstAbilityInit('A0MH')
    call FirstAbilityInit('A0MG')
    call FirstAbilityInit('A0MF')
    set h = null
endfunction

function InitTrig_Initial_Keine takes nothing returns nothing
    set gg_trg_Initial_Keine = CreateTrigger()
    call TriggerAddAction(gg_trg_Initial_Keine, function Trig_Initial_Keine_Actions)
endfunction