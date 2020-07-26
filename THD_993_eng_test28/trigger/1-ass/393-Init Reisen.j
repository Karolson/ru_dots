function Trig_Init_Reisen_Actions takes nothing returns nothing
    local unit h = GetCharacterHandle('O007')
    if h == null then
        return
    endif
    call DebugMsg(GetHeroProperName(h) + " skill initialization completed")
    if not udg_Repick then
        call DestroyTrigger(GetTriggeringTrigger())
    endif
    call SetHeroLifeIncreaseValue(h, 31)
    call SetHeroManaIncreaseValue(h, 1)
    call SetHeroManaBaseRegenValue(h, 0.4)
    set udg_SK_Reisen[0] = 0
    set udg_SK_Reisen[1] = 0
    call UnitInitAddAttack(h)
    call DisableTrigger(gg_trg_Reisen_Attack)
    call DestroyTrigger(gg_trg_Reisen_Attack)
    set gg_trg_Reisen_Attack = CreateTrigger()
    call RegisterAnyUnitDamage(gg_trg_Reisen_Attack)
    call TriggerRegisterPlayerUnitEvent(gg_trg_Reisen_Attack, GetOwningPlayer(h), EVENT_PLAYER_UNIT_SUMMON, null)
    call TriggerAddCondition(gg_trg_Reisen_Attack, Condition(function Trig_Reisen_Attack_Conditions))
    call TriggerAddAction(gg_trg_Reisen_Attack, function Trig_Reisen_Attack_Actions)
    call DisableTrigger(gg_trg_Reisen01)
    call DestroyTrigger(gg_trg_Reisen01)
    set gg_trg_Reisen01 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Reisen01, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Reisen01, Condition(function Trig_Reisen01_Conditions))
    call TriggerAddAction(gg_trg_Reisen01, function Trig_Reisen01_Actions)
    call DisableTrigger(gg_trg_Reisen02_New)
    call DestroyTrigger(gg_trg_Reisen02_New)
    set gg_trg_Reisen02_New = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Reisen02_New, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Reisen02_New, Condition(function Trig_Reisen02_New_Conditions))
    call TriggerAddAction(gg_trg_Reisen02_New, function Trig_Reisen02_New_Actions)
    call DisableTrigger(gg_trg_Reisen03)
    call DestroyTrigger(gg_trg_Reisen03)
    set gg_trg_Reisen03 = CreateTrigger()
    call RegisterAnyUnitDamage(gg_trg_Reisen03)
    call TriggerRegisterUnitEvent(gg_trg_Reisen03, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerRegisterUnitEvent(gg_trg_Reisen03, h, EVENT_UNIT_HERO_SKILL)
    call TriggerAddCondition(gg_trg_Reisen03, Condition(function Trig_Reisen03_Learn_Conditions))
    call TriggerAddAction(gg_trg_Reisen03, function Trig_Reisen03_Learn)
    call DisableTrigger(gg_trg_Reisen04)
    call DestroyTrigger(gg_trg_Reisen04)
    set gg_trg_Reisen04 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Reisen04, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Reisen04, Condition(function Trig_Reisen04_Conditions))
    call TriggerAddAction(gg_trg_Reisen04, function Trig_Reisen04_Actions)
    set udg_SK_Reisen04_On = 11
    set udg_SK_Reisen04_value = 0.75
    call AddingLBuff(0, 'A12H', 'B06N')
    call AddingLBuff(0, 'A12I', 'B06N')
    call AddingLBuff(0, 'A12J', 'B06N')
    call AddingLBuff(0, 'A12K', 'B06N')
    call FirstAbilityInit('A000')
    call FirstAbilityInit('A12E')
    call FirstAbilityInit('A12F')
    call FirstAbilityInit('A12G')
    call FirstAbilityInit('A067')
    call FirstAbilityInit('A06B')
    set h = null
endfunction

function InitTrig_Init_Reisen takes nothing returns nothing
    set gg_trg_Init_Reisen = CreateTrigger()
    call TriggerAddAction(gg_trg_Init_Reisen, function Trig_Init_Reisen_Actions)
endfunction