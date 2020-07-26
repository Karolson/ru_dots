function Trig_Initial_Ran_Actions takes nothing returns nothing
    local unit h = GetCharacterHandle('E00G')
    if h == null then
        return
    endif
    call DebugMsg(GetHeroProperName(h) + " skill initialization completed")
    call SetHeroLifeIncreaseValue(h, 26)
    call SetHeroManaIncreaseValue(h, 4)
    call SetHeroManaBaseRegenValue(h, 0.1)
    set udg_SK_Ran = h
    set gg_trg_RanEx = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_RanEx, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_RanEx, Condition(function RanEx_Conditions))
    set gg_trg_Ran01 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Ran01, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Ran01, Condition(function Trig_Ran_01_Conditions))
    call TriggerAddAction(gg_trg_Ran01, function Trig_Ran_01_Actions)
    set gg_trg_Ran02 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Ran02, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Ran02, Condition(function Trig_Ran02_Conditions))
    call TriggerAddAction(gg_trg_Ran02, function Trig_Ran02_Actions)
    call AddingLBuff(0, 'A117', 'B03F')
    set gg_trg_Ran03New = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Ran03New, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Ran03New, Condition(function Ran03_Condition))
    set gg_trg_Ran04 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Ran04, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Ran04, Condition(function Trig_Ran_04_Conditions))
    call TriggerAddAction(gg_trg_Ran04, function Ran04_Actions)
    call FirstAbilityInit('A0ES')
    call FirstAbilityInit('A0ET')
    call FirstAbilityInit('A0EU')
    call FirstAbilityInit('A0EM')
    call FirstAbilityInit('A0EN')
    call FirstAbilityInit('A0EO')
    set h = null
endfunction

function InitTrig_Initial_Ran takes nothing returns nothing
    set gg_trg_Initial_Ran = CreateTrigger()
    call TriggerAddAction(gg_trg_Initial_Ran, function Trig_Initial_Ran_Actions)
endfunction