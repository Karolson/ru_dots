function Trig_Initial_YoumuN_Conditions takes nothing returns boolean
    return true
endfunction

function Trig_Initial_YoumuN_Actions takes nothing returns nothing
    local unit h = GetCharacterHandle('O019')
    call FirstAbilityInit('A1IF')
    call FirstAbilityInit('A1GM')
    call FirstAbilityInit('A0DJ')
    call FirstAbilityInit('A0IL')
    call FirstAbilityInit('A1GG')
    call FirstAbilityInit('A1GJ')
    call FirstAbilityInit('A0V4')
    call FirstAbilityInit('A1GH')
    call FirstAbilityInit('A0RV')
    call FirstAbilityInit('A1GI')
    call FirstAbilityInit('A0E0')
    call FirstAbilityInit('A1GK')
    call FirstAbilityInit('A1GL')
    if h == null then
        return
    endif
    call DebugMsg(GetHeroProperName(h) + " skill initialization completed")
    call SetHeroLifeIncreaseValue(h, 28)
    call SetHeroManaIncreaseValue(h, 8)
    call SetHeroManaBaseRegenValue(h, 0.7)
    set gg_trg_YoumuN01_Life = CreateTrigger()
    call RegisterAnyUnitDamage(gg_trg_YoumuN01_Life)
    call TriggerAddCondition(gg_trg_YoumuN01_Life, Condition(function Trig_YoumuN01_Life_Conditions))
    call TriggerAddAction(gg_trg_YoumuN01_Life, function Trig_YoumuN01_Life_Actions)
    set gg_trg_YoumuN01 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_YoumuN01, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_YoumuN01, Condition(function Trig_YoumuN01_Conditions))
    call TriggerAddAction(gg_trg_YoumuN01, function Trig_YoumuN01_Actions)
    if gg_trg_YoumuN02 == null then
        set gg_trg_YoumuN02 = CreateTrigger()
        call RegisterAnyUnitDamage(gg_trg_YoumuN02)
        call TriggerAddCondition(gg_trg_YoumuN02, Condition(function Trig_YoumuN02_Conditions))
        call TriggerAddAction(gg_trg_YoumuN02, function Trig_YoumuN02_Actions)
    endif
    set gg_trg_YoumuN03 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_YoumuN03, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerRegisterPlayerUnitEvent(gg_trg_YoumuN03, GetOwningPlayer(h), EVENT_PLAYER_UNIT_SUMMON, null)
    call TriggerRegisterPlayerUnitEvent(gg_trg_YoumuN03, GetOwningPlayer(h), EVENT_PLAYER_UNIT_DEATH, null)
    call TriggerAddCondition(gg_trg_YoumuN03, Condition(function Trig_YoumuN03_Conditions))
    call TriggerAddAction(gg_trg_YoumuN03, function Trig_YoumuN03_Actions)
    call Trig_YoumuN03_Init(h, false)
    set gg_trg_YoumuN03 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_YoumuN03, h, EVENT_UNIT_ISSUED_ORDER)
    call TriggerRegisterUnitEvent(gg_trg_YoumuN03, h, EVENT_UNIT_ISSUED_POINT_ORDER)
    call TriggerRegisterUnitEvent(gg_trg_YoumuN03, h, EVENT_UNIT_ISSUED_TARGET_ORDER)
    call TriggerAddAction(gg_trg_YoumuN03, function Trig_YoumuN03_Duplicate_Order)
    call DisableTrigger(gg_trg_YoumuN03)
    set gg_trg_YoumuN04 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_YoumuN04, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_YoumuN04, Condition(function Trig_YoumuN04_Conditions))
    call TriggerAddAction(gg_trg_YoumuN04, function Trig_YoumuN04_Actions)
    call UnitAddAbility(h, 'A1GM')
    set h = null
endfunction

function InitTrig_Initial_YoumuN takes nothing returns nothing
    set gg_trg_Initial_YoumuN = CreateTrigger()
    call TriggerAddCondition(gg_trg_Initial_YoumuN, Condition(function Trig_Initial_YoumuN_Conditions))
    call TriggerAddAction(gg_trg_Initial_YoumuN, function Trig_Initial_YoumuN_Actions)
endfunction