function Trig_Init_Koishi_Actions takes nothing returns nothing
    local unit h = GetCharacterHandle('E010')
    call FirstAbilityInit('A0GT')
    call FirstAbilityInit('A0GJ')
    call FirstAbilityInit('A0ZB')
    call FirstAbilityInit('A0I0')
    call FirstAbilityInit('A0DQ')
    call FirstAbilityInit('A0IP')
    call FirstAbilityInit('A0DY')
    if h == null then
        return
    endif
    call DebugMsg(GetHeroProperName(h) + " skill initialization completed")
    if not udg_Repick then
        call DestroyTrigger(GetTriggeringTrigger())
    endif
    call UnitInitAddAttack(h)
    call SetHeroLifeIncreaseValue(h, 26)
    call SetHeroManaIncreaseValue(h, 4)
    call SetHeroManaBaseRegenValue(h, 0.4)
    set udg_SK_Koishi04_value = false
    set gg_trg_Koishi01 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Koishi01, h, EVENT_UNIT_HERO_SKILL)
    call TriggerRegisterUnitEvent(gg_trg_Koishi01, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Koishi01, Condition(function Koishi01_Conditions))
    call TriggerAddAction(gg_trg_Koishi01, function Koishi01_Actions)
    call KoishiSkillEffect(h)
    set gg_trg_Koishi02 = CreateTrigger()
    call RegisterAnyUnitDamage(gg_trg_Koishi02)
    call TriggerAddCondition(gg_trg_Koishi02, Condition(function Koishi02_Conditions))
    set gg_trg_Koishi04 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Koishi04, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Koishi04, Condition(function Trig_Koishi04_Conditions))
    call TriggerAddAction(gg_trg_Koishi04, function Trig_Koishi04_Actions)
    set gg_trg_Koishi04_DS = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Koishi04_DS, h, EVENT_UNIT_SELECTED)
    call TriggerAddCondition(gg_trg_Koishi04_DS, Condition(function Trig_Koishi04_DS_Conditions))
    call TriggerAddAction(gg_trg_Koishi04_DS, function Trig_Koishi04_DS_Actions)
    call DisableTrigger(gg_trg_Koishi04_DS)
    set h = null
endfunction

function InitTrig_Init_Koishi takes nothing returns nothing
    set gg_trg_Init_Koishi = CreateTrigger()
    call TriggerAddAction(gg_trg_Init_Koishi, function Trig_Init_Koishi_Actions)
endfunction