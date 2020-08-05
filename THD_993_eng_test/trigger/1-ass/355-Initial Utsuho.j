function Trig_Initial_Utsuho_Actions takes nothing returns nothing
    local unit h = GetCharacterHandle('O009')
    local timer t = CreateTimer()
    local group g = CreateGroup()
    local integer task = GetHandleId(t)
    call FirstAbilityInit('A0X8')
    call FirstAbilityInit('A05Z')
    call FirstAbilityInit('A060')
    call FirstAbilityInit('A076')
    call FirstAbilityInit('A0QN')
    call FirstAbilityInit('A074')
    call FirstAbilityInit('A077')
    call FirstAbilityInit('A078')
    call FirstAbilityInit('A079')
    call FirstAbilityInit('A07B')
    if h == null then
        return
    endif
    call DebugMsg(GetHeroProperName(h) + " skill initialization completed")
    call SetHeroLifeIncreaseValue(h, 28)
    call SetHeroManaIncreaseValue(h, 8)
    call SetHeroManaBaseRegenValue(h, 0.6)
    call SaveUnitHandle(udg_ht, task, 0, h)
    call SaveGroupHandle(udg_ht, task, 1, g)
    call TimerStart(t, 1.0, true, function Trig_UtsuhoEx_Actions)
    set gg_trg_Utsuho01 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Utsuho01, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Utsuho01, Condition(function Trig_Utsuho01_Conditions))
    call TriggerAddAction(gg_trg_Utsuho01, function Trig_Utsuho01_Actions)
    set gg_trg_Utsuho02 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Utsuho02, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Utsuho02, Condition(function Trig_Utsuho02_Conditions))
    call TriggerAddAction(gg_trg_Utsuho02, function Trig_Utsuho02_Actions)
    set gg_trg_Utsuho03 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Utsuho03, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Utsuho03, Condition(function Trig_Utsuho03_Conditions))
    call TriggerAddAction(gg_trg_Utsuho03, function Trig_Utsuho03_Actions)
    set gg_trg_Utsuho04 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Utsuho04, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Utsuho04, Condition(function Trig_Utsuho04_Conditions))
    call TriggerAddAction(gg_trg_Utsuho04, function Trig_Utsuho04_Actions)
    set h = null
    set t = null
    set g = null
endfunction

function InitTrig_Initial_Utsuho takes nothing returns nothing
    set gg_trg_Initial_Utsuho = CreateTrigger()
    call TriggerAddAction(gg_trg_Initial_Utsuho, function Trig_Initial_Utsuho_Actions)
endfunction