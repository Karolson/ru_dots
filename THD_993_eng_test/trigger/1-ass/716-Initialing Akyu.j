function Trig_Initialing_Akyu_Actions takes nothing returns nothing
    set udg_SK_Akyu = GetCharacterHandle('E02Y')
    call FirstAbilityInit('A14F')
    call FirstAbilityInit('A14G')
    call FirstAbilityInit('A14H')
    call FirstAbilityInit('A1AU')
    call FirstAbilityInit('A0QH')
    call FirstAbilityInit('A0P1')
    call FirstAbilityInit('A0P5')
    call FirstAbilityInit('A0PE')
    call FirstAbilityInit('A0IV')
    call FirstAbilityInit('A0P0')
    call FirstAbilityInit('A0PF')
    call FirstAbilityInit('A0P6')
    call FirstAbilityInit('A0PA')
    call FirstAbilityInit('A0PY')
    call FirstAbilityInit('Avul')
    call FirstAbilityInit('A0QI')
    if udg_SK_Akyu == null then
        return
    endif
    if not udg_Repick then
        call DestroyTrigger(GetTriggeringTrigger())
    endif
    call SetHeroLifeIncreaseValue(udg_SK_Akyu, 35)
    call SetHeroManaIncreaseValue(udg_SK_Akyu, 10)
    call SetHeroManaBaseRegenValue(udg_SK_Akyu, 0.4)
    call DebugMsg(GetHeroProperName(udg_SK_Akyu) + "技能初始化完成")
    set gg_trg_AkyuEx = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_AkyuEx, udg_SK_Akyu, EVENT_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_AkyuEx, Condition(function AkyuEx_Conditions))
    if IsPlayerInForce(GetOwningPlayer(udg_SK_Akyu), udg_TeamA) then
        set udg_SK_Akyu_Ghost = CreateUnitAtLoc(GetOwningPlayer(udg_SK_Akyu), 'e02Z', udg_RevivePoint[0], 0.0)
    else
        set udg_SK_Akyu_Ghost = CreateUnitAtLoc(GetOwningPlayer(udg_SK_Akyu), 'e02Z', udg_RevivePoint[1], 0.0)
    endif
    call SetUnitVertexColor(udg_SK_Akyu_Ghost, 155, 155, 155, 155)
    call ShowUnit(udg_SK_Akyu_Ghost, false)
    set gg_trg_AkyuEx_Revive = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_AkyuEx_Revive, udg_SK_Akyu_Ghost, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_AkyuEx_Revive, Condition(function AkyuEx_Revive_Conditions))
    set gg_trg_Akyu01 = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Akyu01, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Akyu01, Condition(function Akyu01_Conditions))
    set gg_trg_Akyu02 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Akyu02, udg_SK_Akyu, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Akyu02, Condition(function Akyu02_Conditions))
    set gg_trg_Akyu03 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Akyu03, udg_SK_Akyu, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Akyu03, Condition(function Akyu03_Conditions))
    set gg_trg_Akyu04 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Akyu04, udg_SK_Akyu, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Akyu04, Condition(function Akyu04_Conditions))
    call AddingLBuff(0, 'A0PE', 'B07V')
    call AddingLBuff(0, 'A0PY', 'B07R')
    call AddingLBuff(0, 'A0PA', 'B081')
endfunction

function InitTrig_Initialing_Akyu takes nothing returns nothing
    set gg_trg_Initialing_Akyu = CreateTrigger()
    call TriggerAddAction(gg_trg_Initialing_Akyu, function Trig_Initialing_Akyu_Actions)
endfunction