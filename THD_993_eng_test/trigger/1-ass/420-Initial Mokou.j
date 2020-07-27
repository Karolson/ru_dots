function Trig_Initial_Mokou_Actions takes nothing returns nothing
    local unit h = GetCharacterHandle('N00J')
    if h == null then
        set h = GetCharacterHandle('N04L')
    endif
    if h == null then
        return
    endif
    call DebugMsg(GetHeroProperName(h) + " skill initialization completed")
    if not udg_Repick then
        call DestroyTrigger(GetTriggeringTrigger())
    endif
    call SetHeroLifeIncreaseValue(h, 31)
    call SetHeroManaIncreaseValue(h, 0)
    call SetHeroManaBaseRegenValue(h, 0)
    call DisableTrigger(gg_trg_Mokou01)
    call DestroyTrigger(gg_trg_Mokou01)
    set gg_trg_Mokou01 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Mokou01, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Mokou01, Condition(function Trig_Mokou01_Conditions))
    call TriggerAddAction(gg_trg_Mokou01, function Trig_Mokou01_Actions)
    set udg_SK_Mokou02[0] = 'A04X'
    set udg_SK_Mokou02[1] = 'A04Y'
    set udg_SK_Mokou02[2] = 'A04Z'
    set udg_SK_Mokou02[3] = 'A050'
    set udg_SK_Mokou02[4] = 'A051'
    call DisableTrigger(gg_trg_MokouEx)
    call DestroyTrigger(gg_trg_MokouEx)
    set gg_trg_MokouEx = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_MokouEx, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerRegisterPlayerUnitEvent(gg_trg_MokouEx, GetOwningPlayer(h), EVENT_PLAYER_UNIT_DEATH, null)
    call TriggerAddCondition(gg_trg_MokouEx, Condition(function Trig_MokouEx_Conditions))
    call TriggerAddAction(gg_trg_MokouEx, function Trig_MokouEx_Actions)
    call DisableTrigger(gg_trg_Mokou02)
    call DestroyTrigger(gg_trg_Mokou02)
    set gg_trg_Mokou02 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Mokou02, h, EVENT_UNIT_HERO_SKILL)
    call TriggerAddCondition(gg_trg_Mokou02, Condition(function Trig_Mokou02_Learn_Conditions))
    call TriggerAddAction(gg_trg_Mokou02, function Trig_Mokou02_Learn_Actions)
    call DisableTrigger(gg_trg_Mokou02_Cast)
    call DestroyTrigger(gg_trg_Mokou02_Cast)
    set gg_trg_Mokou02_Cast = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Mokou02_Cast, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Mokou02_Cast, Condition(function Trig_Mokou02_Cast_Conditions))
    call TriggerAddAction(gg_trg_Mokou02_Cast, function Trig_Mokou02_Cast_Actions)
    call DisableTrigger(gg_trg_Mokou02_AOE)
    call DestroyTrigger(gg_trg_Mokou02_AOE)
    set gg_trg_Mokou02_AOE = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Mokou02_AOE, EVENT_PLAYER_UNIT_ATTACKED)
    call TriggerAddCondition(gg_trg_Mokou02_AOE, Condition(function Trig_Mokou02_AOE_Conditions))
    call TriggerAddAction(gg_trg_Mokou02_AOE, function Trig_Mokou02_AOE_Actions)
    call DisableTrigger(gg_trg_Mokou03)
    call DestroyTrigger(gg_trg_Mokou03)
    set gg_trg_Mokou03 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Mokou03, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Mokou03, Condition(function Trig_Mokou03_Conditions))
    call TriggerAddAction(gg_trg_Mokou03, function Trig_Mokou03_Actions)
    call DisableTrigger(gg_trg_Mokou04)
    call DestroyTrigger(gg_trg_Mokou04)
    set gg_trg_Mokou04 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Mokou04, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Mokou04, Condition(function Trig_Mokou04_Conditions))
    call TriggerAddAction(gg_trg_Mokou04, function Trig_Mokou04_Actions)
    call DisableTrigger(gg_trg_Mokou04_End)
    call DestroyTrigger(gg_trg_Mokou04_End)
    set gg_trg_Mokou04_End = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Mokou04_End, h, EVENT_UNIT_DEATH)
    call TriggerRegisterUnitEvent(gg_trg_Mokou04_End, h, EVENT_UNIT_HERO_REVIVE_FINISH)
    call TriggerAddCondition(gg_trg_Mokou04_End, Condition(function Trig_Mokou04_End_Conditions))
    call TriggerAddAction(gg_trg_Mokou04_End, function Trig_Mokou04_End_Actions)
    call FirstAbilityInit('A04X')
    call FirstAbilityInit('A04Y')
    call FirstAbilityInit('A04Z')
    call FirstAbilityInit('A050')
    call FirstAbilityInit('A051')
    call FirstAbilityInit('A053')
    call FirstAbilityInit('A054')
    call FirstAbilityInit('A055')
    call FirstAbilityInit('A04V')
    set h = null
endfunction

function InitTrig_Initial_Mokou takes nothing returns nothing
    set gg_trg_Initial_Mokou = CreateTrigger()
    call TriggerAddAction(gg_trg_Initial_Mokou, function Trig_Initial_Mokou_Actions)
endfunction