function Trig_Initialing_Lily_Actions takes nothing returns nothing
    local unit h = GetCharacterHandle('E023')
    if h == null then
        return
    endif
    call DebugMsg(GetHeroProperName(h) + " skill initialization completed")
    call SetHeroLifeIncreaseValue(h, 25)
    call SetHeroManaIncreaseValue(h, 10)
    call SetHeroManaBaseRegenValue(h, 0.5)
    call RecHeroBasicArmorValue(h, 0.0)
    call RecHeroIncreArmorValue(h, 0.0)
    call RecHeroAttackBaseValue(h, 26)
    call RecHeroAttackUppeValue(h, 35)
    call RecHeroStaterTypeValue(h, 3)
    set gg_trg_LilyEx = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_LilyEx, h, EVENT_UNIT_HERO_REVIVABLE)
    call TriggerRegisterUnitEvent(gg_trg_LilyEx, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_LilyEx, Condition(function Trig_LilyEx_Conditions))
    set gg_trg_Lily01 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Lily01, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Lily01, Condition(function Trig_Lily01_Conditions))
    call TriggerAddAction(gg_trg_Lily01, function Trig_Lily01_Actions)
    set gg_trg_Lily02 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Lily02, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Lily02, Condition(function Trig_Lily02_Conditions))
    call TriggerAddAction(gg_trg_Lily02, function Trig_Lily02_Actions)
    set gg_trg_Lily03 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Lily03, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Lily03, Condition(function Trig_Lily03_Conditions))
    call TriggerAddAction(gg_trg_Lily03, function Trig_Lily03_Actions)
    set gg_trg_Lily04 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Lily04, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Lily04, Condition(function Trig_Lily04_Conditions))
    call TriggerAddAction(gg_trg_Lily04, function Trig_Lily04_Actions)
    call FirstAbilityInit('A0WO')
    call FirstAbilityInit('A0WX')
    call FirstAbilityInit('A0WY')
    call FirstAbilityInit('A0WZ')
    call FirstAbilityInit('A0WP')
    call FirstAbilityInit('A0X0')
    call FirstAbilityInit('A0X1')
    call FirstAbilityInit('A0X2')
    set h = null
endfunction

function InitTrig_Initialing_Lily takes nothing returns nothing
    set gg_trg_Initialing_Lily = CreateTrigger()
    call TriggerAddAction(gg_trg_Initialing_Lily, function Trig_Initialing_Lily_Actions)
endfunction