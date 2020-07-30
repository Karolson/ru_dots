function Trig_Initialing_Hatate_Actions takes nothing returns nothing
    local unit h = GetCharacterHandle('O00V')
    if h == null then
        return
    endif
    call DebugMsg(GetHeroProperName(h) + " skill initialization completed")
    if not udg_Repick then
        call DestroyTrigger(GetTriggeringTrigger())
    endif
    call SetHeroLifeIncreaseValue(h, 26)
    call SetHeroManaIncreaseValue(h, 6)
    call SetHeroManaBaseRegenValue(h, 0.6)
    call DisableTrigger(gg_trg_Hatate01)
    call DestroyTrigger(gg_trg_Hatate01)
    set gg_trg_Hatate01 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Hatate01, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Hatate01, Condition(function Trig_Hatate01_Conditions))
    call TriggerAddAction(gg_trg_Hatate01, function Trig_Hatate01_Actions)
    call DisableTrigger(gg_trg_Hatate01_Learn)
    call DestroyTrigger(gg_trg_Hatate01_Learn)
    set gg_trg_Hatate01_Learn = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Hatate01_Learn, h, EVENT_UNIT_HERO_SKILL)
    call TriggerAddCondition(gg_trg_Hatate01_Learn, Condition(function Trig_Hatate01_Learn_Conditions))
    call TriggerAddAction(gg_trg_Hatate01_Learn, function Trig_Hatate01_Learn_Actions)
    call DisableTrigger(gg_trg_Hatate02)
    call DestroyTrigger(gg_trg_Hatate02)
    set gg_trg_Hatate02 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Hatate02, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Hatate02, Condition(function Trig_Hatate02_Conditions))
    call TriggerAddAction(gg_trg_Hatate02, function Trig_Hatate02_Actions)
    call DisableTrigger(gg_trg_Hatate02_Attack)
    call DestroyTrigger(gg_trg_Hatate02_Attack)
    set gg_trg_Hatate02_Attack = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Hatate02_Attack, EVENT_PLAYER_UNIT_ATTACKED)
    call TriggerAddCondition(gg_trg_Hatate02_Attack, Condition(function Trig_Hatate02_Attack_Conditions))
    call TriggerAddAction(gg_trg_Hatate02_Attack, function Trig_Hatate02_Attack_Actions)
    call DisableTrigger(gg_trg_Hatate03)
    call DestroyTrigger(gg_trg_Hatate03)
    set gg_trg_Hatate03 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Hatate03, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Hatate03, Condition(function Trig_Hatate03_Conditions))
    call TriggerAddAction(gg_trg_Hatate03, function Trig_Hatate03_Actions)
    call DisableTrigger(gg_trg_Hatate04)
    call DestroyTrigger(gg_trg_Hatate04)
    set gg_trg_Hatate04 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Hatate04, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Hatate04, Condition(function Trig_Hatate04_Conditions))
    call TriggerAddAction(gg_trg_Hatate04, function Trig_Hatate04_Actions)
    call DisableTrigger(gg_trg_Hatate04_Ex)
    call DestroyTrigger(gg_trg_Hatate04_Ex)
    set gg_trg_Hatate04_Ex = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Hatate04_Ex, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Hatate04_Ex, Condition(function Trig_Hatate04_Ex_Conditions))
    call TriggerAddAction(gg_trg_Hatate04_Ex, function Trig_Hatate04_Ex_Actions)
    call UnitAddAbility(h, 'A0E5')
    call UnitRemoveAbility(h, 'A0E5')
    set h = null
endfunction

function InitTrig_Initialing_Hatate takes nothing returns nothing
    set gg_trg_Initialing_Hatate = CreateTrigger()
    call TriggerAddAction(gg_trg_Initialing_Hatate, function Trig_Initialing_Hatate_Actions)
endfunction