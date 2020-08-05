function Trig_Init_Orange_Actions takes nothing returns nothing
    local unit h = GetCharacterHandle('E01I')
    call FirstAbilityInit('A0XB')
    call FirstAbilityInit('A08W')
    call FirstAbilityInit('A0UL')
    call FirstAbilityInit('A15K')
    call FirstAbilityInit('A08P')
    call FirstAbilityInit('A15M')
    call FirstAbilityInit('A15N')
    call FirstAbilityInit('A15O')
    call FirstAbilityInit('A15P')
    call FirstAbilityInit('A114')
    call FirstAbilityInit('A115')
    call FirstAbilityInit('A116')
    call FirstAbilityInit('A0TQ')
    call FirstAbilityInit('A0Z3')
    call FirstAbilityInit('A10W')
    call FirstAbilityInit('A10X')
    call FirstAbilityInit('A10Y')
    call FirstAbilityInit('A10Z')
    call FirstAbilityInit('A0LP')
    call FirstAbilityInit('A193')
    call FirstAbilityInit('A0V4')
    call FirstAbilityInit('A0EP')
    call FirstAbilityInit('A0TM')
    call FirstAbilityInit('A0QV')
    call FirstAbilityInit('A04D')
    call FirstAbilityInit('A04K')
    call FirstAbilityInit('A0TO')
    if h == null then
        return
    endif
    call DebugMsg(GetHeroProperName(h) + " skill initialization completed")
    call SetHeroLifeIncreaseValue(h, 31)
    call SetHeroManaIncreaseValue(h, 8)
    call SetHeroManaBaseRegenValue(h, 0.5)
    call RecHeroBasicArmorValue(h, 3.0)
    call RecHeroIncreArmorValue(h, 0.0)
    call RecHeroAttackBaseValue(h, 35)
    call RecHeroAttackUppeValue(h, 41)
    call RecHeroStaterTypeValue(h, 2)
    set udg_SK_Chen = h
    set gg_trg_OrangeEx = CreateTrigger()
    call TriggerRegisterTimerEventPeriodic(gg_trg_OrangeEx, 2.0)
    call TriggerAddAction(gg_trg_OrangeEx, function Trig_OrangeEx_Actions)
    set gg_trg_Orange01 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Orange01, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Orange01, Condition(function Trig_Orange01_Conditions))
    call TriggerAddAction(gg_trg_Orange01, function Trig_Orange01_Actions)
    set gg_trg_Orange02 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Orange02, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Orange02, Condition(function Trig_Orange02_Conditions))
    call TriggerAddAction(gg_trg_Orange02, function Trig_Orange02_Actions)
    set gg_trg_Orange02_Spell = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Orange02_Spell, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Orange02_Spell, Condition(function Trig_Orange02_Spell_Conditions))
    call TriggerAddAction(gg_trg_Orange02_Spell, function Trig_Orange02_Spell_Actions)
    set gg_trg_Orange03 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Orange03, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Orange03, Condition(function Trig_Orange03_Conditions))
    call TriggerAddAction(gg_trg_Orange03, function Trig_Orange03_Actions)
    call AddingLBuff(0, 'A10W', 'B03E')
    call AddingLBuff(0, 'A10X', 'B03E')
    call AddingLBuff(0, 'A10Y', 'B03E')
    call AddingLBuff(0, 'A10Z', 'B03E')
    call UnitAddAbility(h, 'A0TO')
    call SetUnitAbilityLevel(h, 'A0TO', 1)
    set gg_trg_Orange04 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Orange04, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Orange04, Condition(function Trig_Orange04_Conditions))
    call TriggerAddAction(gg_trg_Orange04, function Trig_Orange04_Actions)
    set gg_trg_Orange04_Attack = CreateTrigger()
    call RegisterAnyUnitDamage(gg_trg_Orange04_Attack)
    call TriggerAddCondition(gg_trg_Orange04_Attack, Condition(function Trig_Orange04_Attack_Conditions))
    call TriggerAddAction(gg_trg_Orange04_Attack, function Trig_Orange04_Attack_Actions)
    call DisableTrigger(gg_trg_Orange04_Attack)
    call UnitInitAddAttack(h)
    set h = null
endfunction

function InitTrig_Init_Orange takes nothing returns nothing
    set gg_trg_Init_Orange = CreateTrigger()
    call TriggerAddAction(gg_trg_Init_Orange, function Trig_Init_Orange_Actions)
endfunction