function Trig_Init_Start_Actions takes nothing returns nothing
    local unit h = GetCharacterHandle('E03L')
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
    call DisableTrigger(gg_trg_Start01)
    call DestroyTrigger(gg_trg_Start01)
    set gg_trg_Start01 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Start01, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Start01, Condition(function Trig_Start01_Conditions))
    call TriggerAddAction(gg_trg_Start01, function Trig_Start01_Actions)
    call DisableTrigger(gg_trg_Start02)
    call DestroyTrigger(gg_trg_Start02)
    set gg_trg_Start02 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Start02, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Start02, Condition(function Trig_Start02_Conditions))
    call TriggerAddAction(gg_trg_Start02, function Trig_Start02_Actions)
    call DisableTrigger(gg_trg_Start03)
    call DestroyTrigger(gg_trg_Start03)
    set gg_trg_Start03 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Start03, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Start03, Condition(function Trig_Start03_Conditions))
    call TriggerAddAction(gg_trg_Start03, function Trig_Start03_Actions)
    call FirstAbilityInit('A10Q')
    set h = null
endfunction

function InitTrig_Init_Start takes nothing returns nothing
    set gg_trg_Init_Start = CreateTrigger()
    call TriggerAddAction(gg_trg_Init_Start, function Trig_Init_Start_Actions)
endfunction