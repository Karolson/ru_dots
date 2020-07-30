function Trig_Init_Mystia_Actions takes nothing returns nothing
    local unit h = GetCharacterHandle('E00Z')
    local trigger t
    if h == null then
        set h = GetCharacterHandle('E02B')
    endif
    if h == null then
        return
    endif
    call DebugMsg(GetHeroProperName(h) + " skill initialization completed")
    if not udg_Repick then
        call DestroyTrigger(GetTriggeringTrigger())
    endif
    call SetHeroLifeIncreaseValue(h, 34)
    call SetHeroManaIncreaseValue(h, 19)
    call SetHeroManaBaseRegenValue(h, 0.7)
    set udg_SK_Mystia_Unit = h
    set t = CreateTrigger()
    call TriggerAddCondition(t, Condition(function MystiaEx))
    call RegisterAnyUnitDamage(t)
    call DisableTrigger(gg_trg_Mystia01)
    call DestroyTrigger(gg_trg_Mystia01)
    set gg_trg_Mystia01 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Mystia01, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Mystia01, Condition(function Trig_Mystia01_Conditions))
    call TriggerAddAction(gg_trg_Mystia01, function Trig_Mystia01_Actions)
    call DisableTrigger(gg_trg_Mystia02)
    call DestroyTrigger(gg_trg_Mystia02)
    set gg_trg_Mystia02 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Mystia02, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Mystia02, Condition(function Trig_Mystia02_Conditions))
    call TriggerAddAction(gg_trg_Mystia02, function Trig_Mystia02_Actions)
    call DisableTrigger(gg_trg_Mystia03)
    call DestroyTrigger(gg_trg_Mystia03)
    set gg_trg_Mystia03 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Mystia03, h, EVENT_UNIT_HERO_SKILL)
    call TriggerAddAction(gg_trg_Mystia03, function Trig_Mystia03_Learn)
    call DisableTrigger(gg_trg_Mystia04)
    call DestroyTrigger(gg_trg_Mystia04)
    set gg_trg_Mystia04 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Mystia04, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Mystia04, Condition(function Trig_Mystia04_Conditions))
    call TriggerAddAction(gg_trg_Mystia04, function Trig_Mystia04_Actions)
    call AddingLBuff(0, 'A11D', 'B04Z')
    call FirstAbilityInit('A0T7')
    call FirstAbilityInit('A0DC')
    call FirstAbilityInit('A0E3')
    call FirstAbilityInit('A0DD')
    call FirstAbilityInit('A0T8')
    call FirstAbilityInit('A0T9')
    call FirstAbilityInit('A0TA')
    call FirstAbilityInit('A0E2')
    call FirstAbilityInit('A0JO')
    set h = null
    set t = null
endfunction

function InitTrig_Init_Mystia takes nothing returns nothing
    set gg_trg_Init_Mystia = CreateTrigger()
    call TriggerAddAction(gg_trg_Init_Mystia, function Trig_Init_Mystia_Actions)
endfunction