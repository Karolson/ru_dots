function Trig_Init_Minoriko_Actions takes nothing returns nothing
    local unit h = GetCharacterHandle('H01I')
    local player w
    local integer task
    call FirstAbilityInit('A0JF')
    call FirstAbilityInit('A0JG')
    call FirstAbilityInit('A0UZ')
    call FirstAbilityInit('A0JI')
    call FirstAbilityInit('A0L6')
    call FirstAbilityInit('A0JJ')
    call FirstAbilityInit('A0JN')
    call FirstAbilityInit('A06A')
    call FirstAbilityInit('A06C')
    if h == null then
        set h = GetCharacterHandle('H01Y')
    endif
    if h == null then
        return
    endif
    set w = GetOwningPlayer(h)
    set task = GetHandleId(h)
    call DebugMsg(GetHeroProperName(h) + " skill initialization completed")
    if not udg_Repick then
        call DestroyTrigger(GetTriggeringTrigger())
    endif
    call SetHeroLifeIncreaseValue(h, 26)
    call SetHeroManaIncreaseValue(h, 3)
    call SetHeroManaBaseRegenValue(h, 0.5)
    set udg_SK_Minoriko = h
    call DisableTrigger(gg_trg_Minoriko_Harvest)
    call DestroyTrigger(gg_trg_Minoriko_Harvest)
    set gg_trg_Minoriko_Harvest = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Minoriko_Harvest, h, EVENT_UNIT_HERO_LEVEL)
    call TriggerAddAction(gg_trg_Minoriko_Harvest, function Trig_Minoriko_Harvest_Actions)
    call DisableTrigger(gg_trg_Minoriko01)
    call DestroyTrigger(gg_trg_Minoriko01)
    set gg_trg_Minoriko01 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Minoriko01, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Minoriko01, Condition(function Trig_Minoriko01_Conditions))
    call TriggerAddAction(gg_trg_Minoriko01, function Trig_Minoriko01_Actions)
    call DisableTrigger(gg_trg_Minoriko02)
    call DestroyTrigger(gg_trg_Minoriko02)
    set gg_trg_Minoriko02 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Minoriko02, h, EVENT_UNIT_SUMMON)
    call TriggerAddCondition(gg_trg_Minoriko02, Condition(function Trig_Minoriko02_Conditions))
    call TriggerAddAction(gg_trg_Minoriko02, function Trig_Minoriko02_Actions)
    call DisableTrigger(gg_trg_Minoriko03)
    call DestroyTrigger(gg_trg_Minoriko03)
    set gg_trg_Minoriko03 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Minoriko03, h, EVENT_UNIT_HERO_SKILL)
    call TriggerAddCondition(gg_trg_Minoriko03, Condition(function Trig_Minoriko03_Conditions))
    call TriggerAddAction(gg_trg_Minoriko03, function Trig_Minoriko03_Actions)
    call DisableTrigger(gg_trg_Minoriko04)
    call DestroyTrigger(gg_trg_Minoriko04)
    set gg_trg_Minoriko04 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Minoriko04, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Minoriko04, Condition(function Trig_Minoriko04_Conditions))
    call TriggerAddAction(gg_trg_Minoriko04, function Trig_Minoriko04_Actions)
    set h = null
endfunction

function InitTrig_Init_Minoriko takes nothing returns nothing
    set gg_trg_Init_Minoriko = CreateTrigger()
    call TriggerAddAction(gg_trg_Init_Minoriko, function Trig_Init_Minoriko_Actions)
endfunction