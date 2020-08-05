function Trig_Initial_Parsee_Actions takes nothing returns nothing
    local unit h = GetCharacterHandle('E01U')
    call FirstAbilityInit('A0W5')
    call FirstAbilityInit('A0W6')
    call FirstAbilityInit('A03Q')
    call FirstAbilityInit('A0PM')
    call FirstAbilityInit('A15S')
    call FirstAbilityInit('A0RO')
    call FirstAbilityInit('A0PO')
    if h == null then
        return
    endif
    call DebugMsg(GetHeroProperName(h) + " skill initialization completed")
    if not udg_Repick then
        call DestroyTrigger(GetTriggeringTrigger())
    endif
    set udg_SK_Parsee = h
    call SetHeroLifeIncreaseValue(h, 24)
    call SetHeroManaIncreaseValue(h, 5)
    call SetHeroManaBaseRegenValue(h, 0.6)
    call DisableTrigger(gg_trg_ParseeEx)
    call DestroyTrigger(gg_trg_ParseeEx)
    set gg_trg_ParseeEx = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_ParseeEx, h, EVENT_UNIT_DAMAGED)
    call TriggerAddCondition(gg_trg_ParseeEx, Condition(function Trig_ParseeEx_Conditions))
    call TriggerAddAction(gg_trg_ParseeEx, function Trig_ParseeEx_Actions)
    call DisableTrigger(gg_trg_ParseeEx_Stage2)
    call DestroyTrigger(gg_trg_ParseeEx_Stage2)
    set gg_trg_ParseeEx_Stage2 = CreateTrigger()
    call TriggerRegisterPlayerUnitEvent(gg_trg_ParseeEx_Stage2, GetOwningPlayer(h), EVENT_PLAYER_UNIT_SUMMON, null)
    call TriggerAddCondition(gg_trg_ParseeEx_Stage2, Condition(function Trig_ParseeEx_Conditions_Stage2))
    call TriggerAddAction(gg_trg_ParseeEx_Stage2, function Trig_ParseeEx_Stage2_Actions)
    call DisableTrigger(gg_trg_ParseeEx_Stage3)
    call DestroyTrigger(gg_trg_ParseeEx_Stage3)
    set gg_trg_ParseeEx_Stage3 = CreateTrigger()
    call TriggerRegisterPlayerUnitEvent(gg_trg_ParseeEx_Stage3, GetOwningPlayer(h), EVENT_PLAYER_UNIT_DEATH, null)
    call TriggerAddCondition(gg_trg_ParseeEx_Stage3, Condition(function Trig_ParseeEx_Conditions_Stage3))
    call TriggerAddAction(gg_trg_ParseeEx_Stage3, function Trig_ParseeEx_Stage3_Actions)
    call SetPlayerAbilityAvailable(GetOwningPlayer(h), 'A03Q', true)
    call DisableTrigger(gg_trg_Parsee01_Active)
    call DestroyTrigger(gg_trg_Parsee01_Active)
    set gg_trg_Parsee01_Active = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Parsee01_Active, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Parsee01_Active, Condition(function Trig_Parsee01_Active_Conditions))
    call TriggerAddAction(gg_trg_Parsee01_Active, function Trig_Parsee01_Active_Actions)
    call DisableTrigger(gg_trg_Parsee01)
    call DestroyTrigger(gg_trg_Parsee01)
    set gg_trg_Parsee01 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Parsee01, h, EVENT_UNIT_HERO_SKILL)
    call TriggerAddCondition(gg_trg_Parsee01, Condition(function Trig_Parsee01_Conditions))
    call TriggerAddAction(gg_trg_Parsee01, function Trig_Parsee01_Actions)
    call DisableTrigger(gg_trg_Parsee02)
    call DestroyTrigger(gg_trg_Parsee02)
    set gg_trg_Parsee02 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Parsee02, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Parsee02, Condition(function Trig_Parsee02_Conditions))
    call TriggerAddAction(gg_trg_Parsee02, function Trig_Parsee02_Actions)
    call DisableTrigger(gg_trg_Parsee03)
    call DestroyTrigger(gg_trg_Parsee03)
    set gg_trg_Parsee03 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Parsee03, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Parsee03, Condition(function Trig_Parsee03_Conditions))
    call TriggerAddAction(gg_trg_Parsee03, function Trig_Parsee03_Actions)
    call DisableTrigger(gg_trg_Parsee03_Attack)
    call DestroyTrigger(gg_trg_Parsee03_Attack)
    set gg_trg_Parsee03_Attack = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Parsee03_Attack, EVENT_PLAYER_UNIT_ATTACKED)
    call TriggerAddCondition(gg_trg_Parsee03_Attack, Condition(function Trig_Parsee03_Attack_Conditions))
    call TriggerAddAction(gg_trg_Parsee03_Attack, function Trig_Parsee03_Attack_Actions)
    call DisableTrigger(gg_trg_Parsee04)
    call DestroyTrigger(gg_trg_Parsee04)
    set gg_trg_Parsee04 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Parsee04, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Parsee04, Condition(function Trig_Parsee04_Conditions))
    call TriggerAddAction(gg_trg_Parsee04, function Trig_Parsee04_Actions)
    call Preload("Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl")
    call Preload("Objects\\Spawnmodels\\Undead\\UDeathMedium\\UDeath.mdl")
    call Preload("Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl")
    call Preload("mizuhasi Parsee1.mdl")
    call PreloadStart()
    call PreloadEnd(3.0)
    set h = null
endfunction

function InitTrig_Initial_Parsee takes nothing returns nothing
    set gg_trg_Initial_Parsee = CreateTrigger()
    call TriggerAddAction(gg_trg_Initial_Parsee, function Trig_Initial_Parsee_Actions)
endfunction