function Trig_Init_Kaguya_Actions takes nothing returns nothing
    local unit h = GetCharacterHandle('H00W')
    local trigger t
    local integer i
    call FirstAbilityInit('A1CO')
    call FirstAbilityInit('A1BN')
    call FirstAbilityInit('A1BO')
    call FirstAbilityInit('A1BP')
    call FirstAbilityInit('A1BQ')
    call FirstAbilityInit('A1BS')
    call FirstAbilityInit('A1BX')
    call FirstAbilityInit('A1BR')
    call FirstAbilityInit('A1BM')
    call FirstAbilityInit('A1CP')
    call FirstAbilityInit('A1CT')
    call FirstAbilityInit('Avul')
    call FirstAbilityInit('A0X5')
    call FirstAbilityInit('A0OK')
    call FirstAbilityInit('A09Z')
    call FirstAbilityInit('A1BZ')
    call FirstAbilityInit('A0MS')
    call FirstAbilityInit('A1CL')
    call FirstAbilityInit('A0IL')
    call FirstAbilityInit('A1CV')
    call FirstAbilityInit('A1BY')
    call FirstAbilityInit('A1CM')
    call FirstAbilityInit('A1CN')
    call FirstAbilityInit('A0D0')
    call FirstAbilityInit('A0D2')
    call FirstAbilityInit('A0V4')
    call FirstAbilityInit('A17W')
    call FirstAbilityInit('A0LN')
    call FirstAbilityInit('A0SQ')
    call FirstAbilityInit('A0I9')
    if h == null then
        set h = GetCharacterHandle('H02G')
    endif
    if h == null then
        return
    endif
    call DebugMsg(GetHeroProperName(h) + " skill initialization completed")
    if not udg_Repick then
        call DestroyTrigger(GetTriggeringTrigger())
    endif
    call SetHeroLifeIncreaseValue(h, 34)
    call SetHeroManaIncreaseValue(h, 0)
    call SetHeroManaBaseRegenValue(h, 0)
    set udg_SK_Neet = h
    call DisableTrigger(gg_trg_Kaguya01)
    call DestroyTrigger(gg_trg_Kaguya01)
    set gg_trg_Kaguya01 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Kaguya01, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Kaguya01, Condition(function Trig_Kaguya01_Conditions))
    call TriggerAddAction(gg_trg_Kaguya01, function Trig_Kaguya01_Actions)
    call DisableTrigger(gg_trg_Kaguya02)
    call DestroyTrigger(gg_trg_Kaguya02)
    set gg_trg_Kaguya02 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Kaguya02, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Kaguya02, Condition(function Trig_Kaguya02_Conditions))
    call TriggerAddAction(gg_trg_Kaguya02, function Trig_Kaguya02_Actions)
    set t = CreateTrigger()
    call TriggerRegisterUnitEvent(t, h, EVENT_UNIT_HERO_SKILL)
    call TriggerAddCondition(t, Condition(function Kaguya03_onLearn))
    call DisableTrigger(gg_trg_Kaguya04)
    call DestroyTrigger(gg_trg_Kaguya04)
    set gg_trg_Kaguya04 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Kaguya04, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Kaguya04, Condition(function Trig_Kaguya04_Conditions))
    call TriggerAddAction(gg_trg_Kaguya04, function Trig_Kaguya04_Actions)
    set i = 0
    set udg_SK_Kaguya01_RGB[i + 0] = 255
    set udg_SK_Kaguya01_RGB[i + 1] = 0
    set udg_SK_Kaguya01_RGB[i + 2] = 0
    set i = i + 3
    set udg_SK_Kaguya01_RGB[i + 0] = 255
    set udg_SK_Kaguya01_RGB[i + 1] = 63
    set udg_SK_Kaguya01_RGB[i + 2] = 0
    set i = i + 3
    set udg_SK_Kaguya01_RGB[i + 0] = 255
    set udg_SK_Kaguya01_RGB[i + 1] = 255
    set udg_SK_Kaguya01_RGB[i + 2] = 0
    set i = i + 3
    set udg_SK_Kaguya01_RGB[i + 0] = 0
    set udg_SK_Kaguya01_RGB[i + 1] = 255
    set udg_SK_Kaguya01_RGB[i + 2] = 51
    set i = i + 3
    set udg_SK_Kaguya01_RGB[i + 0] = 0
    set udg_SK_Kaguya01_RGB[i + 1] = 255
    set udg_SK_Kaguya01_RGB[i + 2] = 255
    set i = i + 3
    set udg_SK_Kaguya01_RGB[i + 0] = 0
    set udg_SK_Kaguya01_RGB[i + 1] = 51
    set udg_SK_Kaguya01_RGB[i + 2] = 255
    set i = i + 3
    set udg_SK_Kaguya01_RGB[i + 0] = 204
    set udg_SK_Kaguya01_RGB[i + 1] = 0
    set udg_SK_Kaguya01_RGB[i + 2] = 255
    set h = null
endfunction

function InitTrig_Init_Kaguya takes nothing returns nothing
    set gg_trg_Init_Kaguya = CreateTrigger()
    call TriggerAddAction(gg_trg_Init_Kaguya, function Trig_Init_Kaguya_Actions)
endfunction