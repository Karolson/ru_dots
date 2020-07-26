function Trig_Init_Sunny_Actions takes nothing returns nothing
    local unit h = GetCharacterHandle('E01D')
    if h == null then
        return
    endif
    call DebugMsg(GetHeroProperName(h) + " skill initialization completed")
    if not udg_Repick then
        call DestroyTrigger(GetTriggeringTrigger())
    endif
    call SetHeroLifeIncreaseValue(h, 26)
    call SetHeroManaIncreaseValue(h, 0)
    call SetHeroManaBaseRegenValue(h, 0)
    call DisableTrigger(gg_trg_Sunny01)
    call DestroyTrigger(gg_trg_Sunny01)
    set gg_trg_Sunny01 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Sunny01, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Sunny01, Condition(function Trig_Sunny01_Conditions))
    call TriggerAddAction(gg_trg_Sunny01, function Trig_Sunny01_Actions)
    call DisableTrigger(gg_trg_Sunny02)
    call DestroyTrigger(gg_trg_Sunny02)
    set gg_trg_Sunny02 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Sunny02, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Sunny02, Condition(function Trig_Sunny02_Conditions))
    call TriggerAddAction(gg_trg_Sunny02, function Trig_Sunny02_Actions)
    call DisableTrigger(gg_trg_Sunny03)
    call DestroyTrigger(gg_trg_Sunny03)
    set gg_trg_Sunny03 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Sunny03, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Sunny03, Condition(function Trig_Sunny03_Conditions))
    call TriggerAddAction(gg_trg_Sunny03, function Trig_Sunny03_Actions)
    call DisableTrigger(gg_trg_Sunny04)
    call DestroyTrigger(gg_trg_Sunny04)
    set gg_trg_Sunny04 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Sunny04, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Sunny04, Condition(function Trig_Sunny04_Conditions))
    call TriggerAddAction(gg_trg_Sunny04, function Trig_Sunny04_Actions)
    set h = null
endfunction

function InitTrig_Init_Sunny takes nothing returns nothing
    set gg_trg_Init_Sunny = CreateTrigger()
    call TriggerAddAction(gg_trg_Init_Sunny, function Trig_Init_Sunny_Actions)
endfunction