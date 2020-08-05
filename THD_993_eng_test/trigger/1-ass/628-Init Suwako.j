function Trig_Init_Suwako_Actions takes nothing returns nothing
    local unit h = GetCharacterHandle('H012')
    call FirstAbilityInit('A032')
    call FirstAbilityInit('A0FK')
    call FirstAbilityInit('A0IL')
    call FirstAbilityInit('A0FI')
    call FirstAbilityInit('A17R')
    call FirstAbilityInit('A0X7')
    call FirstAbilityInit('A17Q')
    call FirstAbilityInit('A0FL')
    call FirstAbilityInit('A0LL')
    if h == null then
        set h = GetCharacterHandle('H01X')
    endif
    if h == null then
        set h = GetCharacterHandle('H02A')
    endif
    if h == null then
        return
    endif
    call DebugMsg(GetHeroProperName(h) + " skill initialization completed")
    if not udg_Repick then
        call DestroyTrigger(GetTriggeringTrigger())
    endif
    call SetHeroLifeIncreaseValue(h, 25)
    call SetHeroManaIncreaseValue(h, 2)
    call SetHeroManaBaseRegenValue(h, 0.5)
    call DisableTrigger(gg_trg_SuwakoEx)
    call DestroyTrigger(gg_trg_SuwakoEx)
    set gg_trg_SuwakoEx = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_SuwakoEx, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_SuwakoEx, Condition(function Trig_SuwakoEx_Conditions))
    call TriggerAddAction(gg_trg_SuwakoEx, function Trig_SuwakoEx_Actions)
    call DisableTrigger(gg_trg_Suwako01)
    call DestroyTrigger(gg_trg_Suwako01)
    set gg_trg_Suwako01 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Suwako01, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Suwako01, Condition(function Trig_Suwako01_Conditions))
    call TriggerAddAction(gg_trg_Suwako01, function Trig_Suwako01_Actions)
    call DisableTrigger(gg_trg_Suwako02)
    call DestroyTrigger(gg_trg_Suwako02)
    set gg_trg_Suwako02 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Suwako02, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Suwako02, Condition(function Trig_Suwako02_Conditions))
    call TriggerAddAction(gg_trg_Suwako02, function Trig_Suwako02_Actions)
    call DisableTrigger(gg_trg_Suwako04)
    call DestroyTrigger(gg_trg_Suwako04)
    set gg_trg_Suwako04 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Suwako04, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Suwako04, Condition(function Trig_Suwako04_Conditions))
    call TriggerAddAction(gg_trg_Suwako04, function Trig_Suwako04_Actions)
    set h = null
endfunction

function InitTrig_Init_Suwako takes nothing returns nothing
    set gg_trg_Init_Suwako = CreateTrigger()
    call TriggerAddAction(gg_trg_Init_Suwako, function Trig_Init_Suwako_Actions)
endfunction