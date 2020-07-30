function Trig_Initial_Iku_Actions takes nothing returns nothing
    local unit h = GetCharacterHandle('U003')
    if h == null then
        return
    endif
    call DebugMsg(GetHeroProperName(h) + " skill initialization completed")
    call UnitAddMaxLife(h, 15)
    call SetHeroLifeIncreaseValue(h, 31)
    call SetHeroManaIncreaseValue(h, 8)
    call SetHeroManaBaseRegenValue(h, 0.4)
    set gg_trg_IkuTime = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_IkuTime, h, EVENT_UNIT_HERO_LEVEL)
    call TriggerAddAction(gg_trg_IkuTime, function Trig_IkuTime_Actions)
    set gg_trg_Iku01 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Iku01, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Iku01, Condition(function Trig_Iku01_Conditions))
    call TriggerAddAction(gg_trg_Iku01, function Trig_Iku01_Actions)
    set gg_trg_Iku02 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Iku02, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Iku02, Condition(function Trig_Iku02_Conditions))
    call TriggerAddAction(gg_trg_Iku02, function Trig_Iku02_Actions)
    if gg_trg_Iku03_Active == null then
        set gg_trg_Iku03_Active = CreateTrigger()
        call RegisterAnyUnitDamage(gg_trg_Iku03_Active)
        call TriggerAddCondition(gg_trg_Iku03_Active, Condition(function Trig_Iku03_Active_Conditions))
        call TriggerAddAction(gg_trg_Iku03_Active, function Trig_Iku03_Active_Actions)
    endif
    set gg_trg_Iku03 = CreateTrigger()
    call RegisterAnyUnitDamage(gg_trg_Iku03)
    call TriggerAddCondition(gg_trg_Iku03, Condition(function Trig_Iku03_Conditions))
    call TriggerAddAction(gg_trg_Iku03, function Trig_Iku03_Actions)
    set gg_trg_Iku04 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Iku04, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Iku04, Condition(function Trig_Iku04_Conditions))
    call TriggerAddAction(gg_trg_Iku04, function Trig_Iku04_Actions)
    call FirstAbilityInit('A04P')
    call FirstAbilityInit('A04T')
    call FirstAbilityInit('A0A3')
    call FirstAbilityInit('A04R')
    call FirstAbilityInit('A0B6')
    call FirstAbilityInit('A0OY')
    call SetPlayerAbilityAvailable(GetOwningPlayer(h), 'A1ET', false)
    set h = null
endfunction

function InitTrig_Initial_Iku takes nothing returns nothing
    set gg_trg_Initial_Iku = CreateTrigger()
    call TriggerAddAction(gg_trg_Initial_Iku, function Trig_Initial_Iku_Actions)
endfunction