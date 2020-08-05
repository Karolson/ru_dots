function Trig_Init_Lyrica_Actions takes nothing returns nothing
    local unit h = GetCharacterHandle('E020')
    call FirstAbilityInit('A0TR')
    call FirstAbilityInit('A0V4')
    call FirstAbilityInit('A0IL')
    call FirstAbilityInit('A0TS')
    call FirstAbilityInit('A0BD')
    call FirstAbilityInit('A0TT')
    call FirstAbilityInit('A0N0')
    call FirstAbilityInit('A0UU')
    call FirstAbilityInit('A0TZ')
    call FirstAbilityInit('A0UK')
    call FirstAbilityInit('A0UJ')
    if h == null then
        return
    endif
    call DebugMsg(GetHeroProperName(h) + " skill initialization completed")
    if not udg_Repick then
        call DestroyTrigger(GetTriggeringTrigger())
    endif
    call SetHeroLifeIncreaseValue(h, 31)
    call SetHeroManaIncreaseValue(h, 9)
    call SetHeroManaBaseRegenValue(h, 0.5)
    set udg_SK_Lyrica = h
    set udg_SK_LyricaEx_Count = 1
    set udg_SK_LyricaEx_Buff = 1.0
    set udg_SK_Lyrica02_Count = 0
    call DisableTrigger(gg_trg_LyricaAttack)
    call DestroyTrigger(gg_trg_LyricaAttack)
    set gg_trg_LyricaAttack = CreateTrigger()
    call RegisterAnyUnitDamage(gg_trg_LyricaAttack)
    call TriggerAddCondition(gg_trg_LyricaAttack, Condition(function Trig_LyricaAttack_Conditions))
    call TriggerAddAction(gg_trg_LyricaAttack, function Trig_LyricaAttack_Actions)
    call DisableTrigger(gg_trg_LyricaEx)
    call DestroyTrigger(gg_trg_LyricaEx)
    set gg_trg_LyricaEx = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_LyricaEx, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_LyricaEx, Condition(function Trig_LyricaEx_Conditions))
    call TriggerAddAction(gg_trg_LyricaEx, function Trig_LyricaEx_Actions)
    call DisableTrigger(gg_trg_Lyrica01)
    call DestroyTrigger(gg_trg_Lyrica01)
    set gg_trg_Lyrica01 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Lyrica01, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Lyrica01, Condition(function Trig_Lyrica01_Conditions))
    call TriggerAddAction(gg_trg_Lyrica01, function Trig_Lyrica01_Actions)
    call DisableTrigger(gg_trg_Lyrica02)
    call DestroyTrigger(gg_trg_Lyrica02)
    set gg_trg_Lyrica02 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Lyrica02, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Lyrica02, Condition(function Trig_Lyrica02_Conditions))
    call TriggerAddAction(gg_trg_Lyrica02, function Trig_Lyrica02_Actions)
    call DisableTrigger(gg_trg_Lyrica02Attack)
    call DestroyTrigger(gg_trg_Lyrica02Attack)
    set gg_trg_Lyrica02Attack = CreateTrigger()
    call RegisterAnyUnitDamage(gg_trg_Lyrica02Attack)
    call TriggerAddCondition(gg_trg_Lyrica02Attack, Condition(function Trig_Lyrica02Attack_Conditions))
    call TriggerAddAction(gg_trg_Lyrica02Attack, function Trig_Lyrica02Attack_Actions)
    call AddingLBuff(0, 'A0BD', 'B02D')
    call DisableTrigger(gg_trg_Lyrica03)
    call DestroyTrigger(gg_trg_Lyrica03)
    set gg_trg_Lyrica03 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Lyrica03, h, EVENT_UNIT_HERO_SKILL)
    call TriggerAddCondition(gg_trg_Lyrica03, Condition(function Trig_Lyrica03_Conditions))
    call TriggerAddAction(gg_trg_Lyrica03, function Trig_Lyrica03_Actions)
    call DisableTrigger(gg_trg_Lyrica04)
    call DestroyTrigger(gg_trg_Lyrica04)
    set gg_trg_Lyrica04 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Lyrica04, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Lyrica04, Condition(function Trig_Lyrica04_Conditions))
    call TriggerAddAction(gg_trg_Lyrica04, function Trig_Lyrica04_Actions)
    call SetPlayerTechResearched(GetOwningPlayer(h), 'R00B', 2)
    set h = null
endfunction

function InitTrig_Init_Lyrica takes nothing returns nothing
    set gg_trg_Init_Lyrica = CreateTrigger()
    call TriggerAddAction(gg_trg_Init_Lyrica, function Trig_Init_Lyrica_Actions)
endfunction