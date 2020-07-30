function Trig_Initial_Wriggle_Actions takes nothing returns nothing
    local unit h = GetCharacterHandle('E00A')
    if h == null then
        return
    endif
    call DebugMsg(GetHeroProperName(h) + " skill initialization completed")
    if not udg_Repick then
        call DestroyTrigger(GetTriggeringTrigger())
    endif
    call UnitInitAddAttack(h)
    call SetHeroLifeIncreaseValue(h, 33)
    call SetHeroManaIncreaseValue(h, 8)
    call SetHeroManaBaseRegenValue(h, 0.5)
    set gg_trg_WriggleEx = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_WriggleEx, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_WriggleEx, Condition(function Trig_WriggleEx_Conditions))
    call TriggerAddAction(gg_trg_WriggleEx, function Trig_WriggleEx_Actions)
    set gg_trg_Wriggle01 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Wriggle01, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Wriggle01, Condition(function Wriggle_01_Conditions))
    call TriggerAddAction(gg_trg_Wriggle01, function Wriggle_01_Actions)
    call SaveBoolean(udg_sht, StringHash("Wriggle01"), GetHandleId(h), false)
    set gg_trg_Wriggle01_Attack = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Wriggle01_Attack, EVENT_PLAYER_UNIT_ATTACKED)
    call RegisterAnyUnitDamage(gg_trg_Wriggle01_Attack)
    call TriggerAddCondition(gg_trg_Wriggle01_Attack, Condition(function Wriggle_01_Attack_Conditions))
    call TriggerAddAction(gg_trg_Wriggle01_Attack, function Wriggle_01_Attack_Actions)
    set gg_trg_Wriggle02 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Wriggle02, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Wriggle02, Condition(function Trig_Wriggle02_Conditions))
    call TriggerAddAction(gg_trg_Wriggle02, function Trig_Wriggle02_Actions)
    set gg_trg_Wriggle03 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Wriggle03, h, EVENT_UNIT_HERO_SKILL)
    call TriggerRegisterGameStateEvent(gg_trg_Wriggle03, GAME_STATE_TIME_OF_DAY, EQUAL, 6.01)
    call TriggerRegisterGameStateEvent(gg_trg_Wriggle03, GAME_STATE_TIME_OF_DAY, EQUAL, 18.01)
    call TriggerAddCondition(gg_trg_Wriggle03, Condition(function Wriggle03_Conditions))
    call TriggerAddAction(gg_trg_Wriggle03, function Wriggle03_Actions)
    set gg_trg_Wriggle04 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Wriggle04, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Wriggle04, Condition(function Wriggle04_Conditions))
    call TriggerAddAction(gg_trg_Wriggle04, function Wriggle04_Actions)
    call FirstAbilityInit('A0VU')
    call FirstAbilityInit('A0VV')
    call FirstAbilityInit('A08T')
    call FirstAbilityInit('A0D5')
    call FirstAbilityInit('A0JP')
    call FirstAbilityInit('A09L')
    call FirstAbilityInit('A09Q')
    call FirstAbilityInit('A09P')
    set h = null
endfunction

function InitTrig_Initial_Wriggle takes nothing returns nothing
    set gg_trg_Initial_Wriggle = CreateTrigger()
    call TriggerAddAction(gg_trg_Initial_Wriggle, function Trig_Initial_Wriggle_Actions)
endfunction