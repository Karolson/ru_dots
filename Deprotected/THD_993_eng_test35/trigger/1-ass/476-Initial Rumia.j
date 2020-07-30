function Trig_Initial_Rumia_Actions takes nothing returns nothing
    local unit h = GetCharacterHandle('E00I')
    if h == null then
        return
    endif
    call DebugMsg(GetHeroProperName(h) + " skill initialization completed")
    if not udg_Repick then
        call DestroyTrigger(GetTriggeringTrigger())
    endif
    call SetHeroLifeIncreaseValue(h, 31)
    call SetHeroManaIncreaseValue(h, 10)
    call SetHeroManaBaseRegenValue(h, 0.5)
    call DisableTrigger(gg_trg_Rumia01)
    call DestroyTrigger(gg_trg_Rumia01)
    set gg_trg_Rumia01 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Rumia01, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Rumia01, Condition(function Trig_Rumia01_Conditions))
    call TriggerAddAction(gg_trg_Rumia01, function Trig_Rumia01_Actions)
    call DisableTrigger(gg_trg_Rumia02)
    call DestroyTrigger(gg_trg_Rumia02)
    set gg_trg_Rumia02 = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Rumia02, EVENT_PLAYER_UNIT_ATTACKED)
    call TriggerAddCondition(gg_trg_Rumia02, Condition(function Trig_Rumia02_Conditions))
    call TriggerAddAction(gg_trg_Rumia02, function Trig_Rumia02_Actions)
    call DisableTrigger(gg_trg_Rumia02Cast)
    call DestroyTrigger(gg_trg_Rumia02Cast)
    set gg_trg_Rumia02Cast = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Rumia02Cast, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Rumia02Cast, Condition(function Trig_Rumia02Cast_Conditions))
    call TriggerAddAction(gg_trg_Rumia02Cast, function Trig_Rumia02Cast_Actions)
    call DisableTrigger(gg_trg_Rumia03)
    call DestroyTrigger(gg_trg_Rumia03)
    set gg_trg_Rumia03 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Rumia03, h, EVENT_UNIT_HERO_SKILL)
    call TriggerAddCondition(gg_trg_Rumia03, Condition(function RumiaLearnSkillThreeConditions))
    call TriggerAddAction(gg_trg_Rumia03, function RumiaLearnSkillThreeActions)
    set udg_SK_Rumia04_Life = 0
    call DisableTrigger(gg_trg_Rumia04)
    call DestroyTrigger(gg_trg_Rumia04)
    set gg_trg_Rumia04 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Rumia04, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Rumia04, Condition(function Trig_Rumia04_Conditions))
    call TriggerAddAction(gg_trg_Rumia04, function Trig_Rumia04_Actions)
    call DisableTrigger(gg_trg_Rumia04_Lost)
    call DestroyTrigger(gg_trg_Rumia04_Lost)
    set gg_trg_Rumia04_Lost = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Rumia04_Lost, h, EVENT_UNIT_DEATH)
    call TriggerAddAction(gg_trg_Rumia04_Lost, function Trig_Rumia04_Lost_Actions)
    call FirstAbilityInit('A04G')
    call FirstAbilityInit('A07K')
    call FirstAbilityInit('A07H')
    call AddingLBuff(0, 'A11O', 'B06J')
    call AddingLBuff(0, 'A11P', 'B06J')
    call AddingLBuff(0, 'A11Q', 'B06J')
    call AddingLBuff(0, 'A11R', 'B06J')
    set h = null
endfunction

function InitTrig_Initial_Rumia takes nothing returns nothing
    set gg_trg_Initial_Rumia = CreateTrigger()
    call TriggerAddAction(gg_trg_Initial_Rumia, function Trig_Initial_Rumia_Actions)
endfunction