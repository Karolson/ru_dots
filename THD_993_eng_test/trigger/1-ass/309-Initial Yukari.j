function Trig_Initial_Yukari_Actions takes nothing returns nothing
    local unit h = GetCharacterHandle('E00F')
    call FirstAbilityInit('A117')
    call FirstAbilityInit('A0GL')
    call FirstAbilityInit('A0V4')
    call FirstAbilityInit('A03F')
    call FirstAbilityInit('A07W')
    call FirstAbilityInit('Aloc')
    call FirstAbilityInit('A04L')
    call FirstAbilityInit('A0QI')
    call FirstAbilityInit('A06P')
    call FirstAbilityInit('A0IQ')
    call FirstAbilityInit('A0IY')
    call FirstAbilityInit('A0JH')
    if h == null then
        return
    endif
    call DebugMsg(GetHeroProperName(h) + " skill initialization completed")
    call SetHeroLifeIncreaseValue(h, 25)
    call SetHeroManaIncreaseValue(h, 0)
    call SetHeroManaBaseRegenValue(h, 0)
    call UnitAddAbility(h, 'A0GL')
    set gg_trg_YukariEx = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_YukariEx, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_YukariEx, Condition(function Trig_YukariEx_Conditions))
    call TriggerAddAction(gg_trg_YukariEx, function Trig_YukariEx_Actions)
    set udg_SK_Yukari_Count = 0
    set gg_trg_Yukari01New = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Yukari01New, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Yukari01New, Condition(function Yukari01_Actions))
    set gg_trg_Yukari02 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Yukari02, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Yukari02, Condition(function Trig_Yukari02_Conditions))
    call TriggerAddAction(gg_trg_Yukari02, function Trig_Yukari02_Actions)
    set gg_trg_Yukari03 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Yukari03, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Yukari03, Condition(function Trig_Yukari03_Conditions))
    call TriggerAddAction(gg_trg_Yukari03, function Trig_Yukari03_Actions)
    set gg_trg_Yukari04 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Yukari04, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Yukari04, Condition(function Trig_Yukari04_Conditions))
    call TriggerAddAction(gg_trg_Yukari04, function Trig_Yukari04_Actions)
    set h = null
endfunction

function InitTrig_Initial_Yukari takes nothing returns nothing
    set gg_trg_Initial_Yukari = CreateTrigger()
    call TriggerAddAction(gg_trg_Initial_Yukari, function Trig_Initial_Yukari_Actions)
endfunction