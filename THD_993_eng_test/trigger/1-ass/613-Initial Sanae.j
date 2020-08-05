function Trig_Initial_Sanae_Actions takes nothing returns nothing
    local unit h = GetCharacterHandle('H009')
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local trigger SanaeEx = CreateTrigger()
    call FirstAbilityInit('A0G6')
    call FirstAbilityInit('A00I')
    call FirstAbilityInit('A1GO')
    call FirstAbilityInit('A1AC')
    call FirstAbilityInit('A0RC')
    call FirstAbilityInit('A16T')
    call FirstAbilityInit('A06T')
    call FirstAbilityInit('A06V')
    call FirstAbilityInit('A0AC')
    call FirstAbilityInit('A09C')
    call FirstAbilityInit('A0A1')
    call FirstAbilityInit('A0V4')
    call FirstAbilityInit('A1AJ')
    call FirstAbilityInit('A06Y')
    if h == null then
        set h = GetCharacterHandle('H01W')
    endif
    if h == null then
        return
    endif
    set udg_Sanae = h
    call DebugMsg(GetHeroProperName(h) + " skill initialization completed")
    if not udg_Repick then
        call DestroyTrigger(GetTriggeringTrigger())
    endif
    call SetHeroLifeIncreaseValue(h, 21)
    call SetHeroManaIncreaseValue(h, 4)
    call SetHeroManaBaseRegenValue(h, 0.5)
    call SaveUnitHandle(udg_ht, task, 0, h)
    call TimerStart(t, 1.0, true, function Trig_SanaeEx_Actions)
    if udg_GameMode / 100 == 3 or udg_NewMid then
        call THD_AddSpirit(GetOwningPlayer(h), 2)
    endif
    call UnitAddAbility(h, 'A00I')
    call TriggerRegisterUnitEvent(SanaeEx, h, EVENT_UNIT_SPELL_CAST)
    call TriggerAddCondition(SanaeEx, Condition(function Trig_SanaeEx_Conditions))
    call TriggerAddAction(SanaeEx, function Trig_SanaeEx_Main)
    call DisableTrigger(gg_trg_Sanae01)
    call DestroyTrigger(gg_trg_Sanae01)
    set gg_trg_Sanae01 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Sanae01, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Sanae01, Condition(function Trig_Sanae01_Conditions))
    call TriggerAddAction(gg_trg_Sanae01, function Trig_Sanae01_Actions)
    call DisableTrigger(gg_trg_Sanae02)
    call DestroyTrigger(gg_trg_Sanae02)
    set gg_trg_Sanae02 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Sanae02, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Sanae02, Condition(function Trig_Sanae02_Conditions))
    call TriggerAddAction(gg_trg_Sanae02, function Trig_Sanae02_Actions)
    call DisableTrigger(gg_trg_Sanae03)
    call DestroyTrigger(gg_trg_Sanae03)
    set gg_trg_Sanae03 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Sanae03, h, EVENT_UNIT_HERO_SKILL)
    call TriggerAddCondition(gg_trg_Sanae03, Condition(function Trig_Sanae03_Conditions))
    call DisableTrigger(gg_trg_Sanae04)
    call DestroyTrigger(gg_trg_Sanae04)
    set gg_trg_Sanae04 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Sanae04, h, EVENT_UNIT_SPELL_CHANNEL)
    call TriggerAddCondition(gg_trg_Sanae04, Condition(function Trig_Sanae04_Conditions))
    call TriggerAddAction(gg_trg_Sanae04, function Trig_Sanae04_Actions)
    set h = null
    set t = null
endfunction

function InitTrig_Initial_Sanae takes nothing returns nothing
    set gg_trg_Initial_Sanae = CreateTrigger()
    call TriggerAddAction(gg_trg_Initial_Sanae, function Trig_Initial_Sanae_Actions)
endfunction