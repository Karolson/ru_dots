function Trig_Initial_Spider_Actions takes nothing returns nothing
    local unit h = GetCharacterHandle('O008')
    local boolean firstinit = false
    call FirstAbilityInit('A0RD')
    call FirstAbilityInit('A08A')
    call FirstAbilityInit('A08F')
    call FirstAbilityInit('A08G')
    call FirstAbilityInit('Aloc')
    call FirstAbilityInit('A017')
    call FirstAbilityInit('A0JW')
    call FirstAbilityInit('A0JX')
    call FirstAbilityInit('A0ER')
    call FirstAbilityInit('A0FF')
    call FirstAbilityInit('A0RJ')
    call FirstAbilityInit('A0YX')
    call FirstAbilityInit('A0V4')
    if h == null then
        return
    endif
    call DebugMsg(GetHeroProperName(h) + " skill initialization completed")
    call SetHeroLifeIncreaseValue(h, 31)
    call SetHeroManaIncreaseValue(h, 8)
    call SetHeroManaBaseRegenValue(h, 0.7)
    if gg_trg_Yamame_Dis == null then
        set firstinit = true
        set gg_trg_Yamame_Dis = CreateTrigger()
        call RegisterAnyUnitDamage(gg_trg_Yamame_Dis)
        call TriggerAddCondition(gg_trg_Yamame_Dis, Condition(function Trig_Yamame_Dis_Conditions))
        call TriggerAddAction(gg_trg_Yamame_Dis, function Trig_Yamame_Dis_Actions)
    endif
    set gg_trg_Yamame01 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Yamame01, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Yamame01, Condition(function Yamame01_Conditions))
    set gg_trg_Yamame02 = CreateTrigger()
    call RegisterAnyUnitDamage(gg_trg_Yamame02)
    call TriggerRegisterUnitEvent(gg_trg_Yamame02, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Yamame02, Condition(function Yamame02_Conditions))
    set gg_trg_Yamame03 = CreateTrigger()
    if firstinit then
        call TriggerRegisterAnyUnitEventBJ(gg_trg_Yamame03, EVENT_PLAYER_UNIT_DEATH)
    endif
    call TriggerRegisterUnitEvent(gg_trg_Yamame03, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Yamame03, Condition(function Yamame03_Conditions))
    set gg_trg_Yamame04 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Yamame04, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Yamame04, Condition(function Trig_Yamame04_Conditions))
    call TriggerAddAction(gg_trg_Yamame04, function Trig_Yamame04_Actions)
    set h = null
endfunction

function InitTrig_Initial_Spider takes nothing returns nothing
    set gg_trg_Initial_Spider = CreateTrigger()
    call TriggerAddAction(gg_trg_Initial_Spider, function Trig_Initial_Spider_Actions)
endfunction