function Trig_Initial_ReimuN_Actions takes nothing returns nothing
    local unit h = GetCharacterHandle('H02D')
    call FirstAbilityInit('A0T4')
    call FirstAbilityInit('A048')
    call FirstAbilityInit('A049')
    call FirstAbilityInit('A04A')
    call FirstAbilityInit('A04B')
    call FirstAbilityInit('A1G5')
    call FirstAbilityInit('Aloc')
    call FirstAbilityInit('A1G6')
    call FirstAbilityInit('A0CC')
    call FirstAbilityInit('A1G7')
    call FirstAbilityInit('A1GC')
    call FirstAbilityInit('A1GA')
    call FirstAbilityInit('A1G9')
    call FirstAbilityInit('A1G8')
    if h == null then
        return
    endif
    call SetHeroLifeIncreaseValue(h, 21)
    call SetHeroManaIncreaseValue(h, 6)
    call SetHeroManaBaseRegenValue(h, 0.4)
    call RecHeroBasicArmorValue(h, 0.0)
    call RecHeroIncreArmorValue(h, 0.0)
    call RecHeroAttackBaseValue(h, 26)
    call RecHeroAttackUppeValue(h, 36)
    call RecHeroStaterTypeValue(h, 3)
    call UnitAddAbility(h, 'A1GB')
    set gg_trg_ReimuN01 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_ReimuN01, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_ReimuN01, Condition(function Trig_ReimuN01_Conditions))
    set gg_trg_ReimuN02 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_ReimuN02, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_ReimuN02, Condition(function Trig_ReimuN02_Conditions))
    set gg_trg_ReimuN03 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_ReimuN03, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_ReimuN03, Condition(function Trig_ReimuN03_Conditions))
    set gg_trg_ReimuN04 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_ReimuN04, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_ReimuN04, Condition(function Trig_ReimuN04_Conditions))
    set h = null
endfunction

function InitTrig_Initial_ReimuN takes nothing returns nothing
    set gg_trg_Initial_ReimuN = CreateTrigger()
    call TriggerAddAction(gg_trg_Initial_ReimuN, function Trig_Initial_ReimuN_Actions)
endfunction