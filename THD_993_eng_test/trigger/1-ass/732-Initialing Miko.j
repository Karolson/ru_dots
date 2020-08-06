function Trig_Initialing_Miko_Actions takes nothing returns nothing
    local unit h = GetCharacterHandle('E02J')
    call FirstAbilityInit('A1HX')
    call FirstAbilityInit('A1HW')
    call FirstAbilityInit('A183')
    call FirstAbilityInit('A0V1')
    call FirstAbilityInit('A0IL')
    call FirstAbilityInit('A0VL')
    call FirstAbilityInit('A185')
    call FirstAbilityInit('A0UY')
    call FirstAbilityInit('A0UX')
    call FirstAbilityInit('A186')
    call FirstAbilityInit('A686')
    call FirstAbilityInit('A0UH')
    call FirstAbilityInit('A0UO')
    call FirstAbilityInit('A04D')
    call FirstAbilityInit('A187')
    call FirstAbilityInit('A1I2')
    if h == null then
        return
    endif
    call DebugMsg(GetHeroProperName(h) + " skill initialization completed")
    if not udg_Repick then
        call DestroyTrigger(GetTriggeringTrigger())
    endif
    call SetHeroLifeIncreaseValue(h, 31)
    set udg_SK_Miko = h
    set udg_Miko01_Stand[1] = "Stand 01"
    set udg_Miko01_Stand[2] = "Stand 02"
    set udg_Miko01_Stand[3] = "Stand 03"
    set udg_Miko01_Stand[4] = "Stand 04"
    set udg_Miko01_Stand[5] = "Stand 05"
    set udg_Miko01_Stand[6] = "Stand 06"
    set udg_Miko01_Stand[7] = "Stand 07"
    set udg_Miko01_Stand[8] = "Stand 08"
    set udg_Miko01_Stand[9] = "Stand 09"
    set udg_Miko01_Stand[10] = "Stand 10"
    set udg_Miko01_Stand[11] = "Stand 11"
    set udg_Miko01_Stand[12] = "Stand 12"
    call MikoEx_Initial(h)
    call AddingLBuff(0, 'A188', 0)
    call DisableTrigger(gg_trg_Miko01)
    call DestroyTrigger(gg_trg_Miko01)
    set gg_trg_Miko01 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Miko01, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Miko01, Condition(function Trig_Miko01_Conditions))
    call TriggerAddAction(gg_trg_Miko01, function Trig_Miko01_Actions)
    set gg_trg_Miko02 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Miko02, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Miko02, Condition(function Trig_Miko02_Conditions))
    call TriggerAddAction(gg_trg_Miko02, function Trig_Miko02_Actions)
    set gg_trg_Miko03 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Miko03, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Miko03, Condition(function Trig_Miko03_Conditions))
    call TriggerAddAction(gg_trg_Miko03, function Trig_Miko03_Actions)
    set gg_trg_Miko04 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Miko04, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Miko04, Condition(function Trig_Miko04_Conditions))
    call TriggerAddAction(gg_trg_Miko04, function Trig_Miko04_Actions)
    set h = null
endfunction

function InitTrig_Initialing_Miko takes nothing returns nothing
    set gg_trg_Initialing_Miko = CreateTrigger()
    call TriggerAddAction(gg_trg_Initialing_Miko, function Trig_Initialing_Miko_Actions)
endfunction