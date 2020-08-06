function Trig_Initial_Eirin_Actions takes nothing returns nothing
    local unit h = GetCharacterHandle('O006')
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call FirstAbilityInit('A0OU')
    call FirstAbilityInit('A1BA')
    call FirstAbilityInit('A0IL')
    call FirstAbilityInit('A1BB')
    call FirstAbilityInit('A083')
    call FirstAbilityInit('A085')
    call FirstAbilityInit('A086')
    call FirstAbilityInit('A0YZ')
    call FirstAbilityInit('A0Z0')
    call FirstAbilityInit('A087')
    call FirstAbilityInit('A12L')
    call FirstAbilityInit('A0WI')
    call FirstAbilityInit('A0VK')
    call FirstAbilityInit('A0UF')
    call FirstAbilityInit('A088')
    if h == null then
        return
    endif
    call DebugMsg(GetHeroProperName(h) + " skill initialization completed")
    if not udg_Repick then
        call DestroyTrigger(GetTriggeringTrigger())
    endif
    call SetHeroLifeIncreaseValue(h, 28)
    call SetHeroManaIncreaseValue(h, 0)
    call SetHeroManaBaseRegenValue(h, 0)
    if gg_trg_EirinAttack == null then
        set gg_trg_EirinAttack = CreateTrigger()
        call RegisterAnyUnitDamage(gg_trg_EirinAttack)
        call TriggerAddCondition(gg_trg_EirinAttack, Condition(function Trig_EirinAttack_Conditions))
        call TriggerAddAction(gg_trg_EirinAttack, function Trig_EirinAttack_Actions)
    endif
    set udg_SK_Eirin = h
    call SaveUnitHandle(udg_ht, task, 0, h)
    call TimerStart(t, 81.0, true, function Trig_EirinSage_Actions)
    if udg_GameMode / 100 == 3 or udg_NewMid then
        call SetHeroInt(h, GetHeroInt(h, false) + 5, true)
    endif
    call DisableTrigger(gg_trg_Eirin01_New)
    call DestroyTrigger(gg_trg_Eirin01_New)
    set gg_trg_Eirin01_New = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Eirin01_New, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Eirin01_New, Condition(function Trig_Eirin01_New_Conditions))
    call TriggerAddAction(gg_trg_Eirin01_New, function Trig_Eirin01_New_Actions)
    call DisableTrigger(gg_trg_Eirin02)
    call DestroyTrigger(gg_trg_Eirin02)
    set gg_trg_Eirin02 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Eirin02, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Eirin02, Condition(function Trig_Eirin02_Conditions))
    call TriggerAddAction(gg_trg_Eirin02, function Trig_Eirin02_Actions)
    call DisableTrigger(gg_trg_Eirin03)
    call DestroyTrigger(gg_trg_Eirin03)
    set gg_trg_Eirin03 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Eirin03, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Eirin03, Condition(function Trig_Eirin03_Conditions))
    call TriggerAddAction(gg_trg_Eirin03, function Trig_Eirin03_Actions)
    call DisableTrigger(gg_trg_Eirin04)
    call DestroyTrigger(gg_trg_Eirin04)
    set gg_trg_Eirin04 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Eirin04, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerRegisterUnitEvent(gg_trg_Eirin04, h, EVENT_UNIT_HERO_SKILL)
    call TriggerAddCondition(gg_trg_Eirin04, Condition(function Eirin04_bufftarget))
    set h = null
    set t = null
endfunction

function InitTrig_Initial_Eirin takes nothing returns nothing
    set gg_trg_Initial_Eirin = CreateTrigger()
    call TriggerAddAction(gg_trg_Initial_Eirin, function Trig_Initial_Eirin_Actions)
endfunction