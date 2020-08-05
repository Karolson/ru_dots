function Trig_Init_Nazrin_Actions takes nothing returns nothing
    local unit h = GetCharacterHandle('U00K')
    local unit u
    local timer t
    local integer task
    call FirstAbilityInit('Aloc')
    call FirstAbilityInit('A0OO')
    call FirstAbilityInit('A0P7')
    call FirstAbilityInit('A0V4')
    call FirstAbilityInit('A0D8')
    call FirstAbilityInit('A0IL')
    call FirstAbilityInit('A0I6')
    call FirstAbilityInit('A0I7')
    call FirstAbilityInit('A0L8')
    call FirstAbilityInit('A0D7')
    call FirstAbilityInit('A03Y')
    call FirstAbilityInit('A17T')
    if h == null then
        return
    endif
    call DebugMsg(GetHeroProperName(h) + " skill initialization completed")
    if not udg_Repick then
        call DestroyTrigger(GetTriggeringTrigger())
    endif
    call SetHeroLifeIncreaseValue(h, 31)
    call SetHeroManaIncreaseValue(h, 11)
    call SetHeroManaBaseRegenValue(h, 0.8)
    set t = CreateTimer()
    set task = GetHandleId(t)
    if IsUnitAlly(h, udg_PlayerA[0]) then
        set udg_SK_NazrinEX_team = 1
        set udg_GameSetting_Gold_A = udg_GameSetting_Gold_A + 5
    else
        set udg_SK_NazrinEX_team = 2
        set udg_GameSetting_Gold_B = udg_GameSetting_Gold_B + 5
    endif
    set u = CreateUnit(GetOwningPlayer(h), 'o00L', GetUnitX(h), GetUnitY(h), 0.0)
    call SaveUnitHandle(udg_ht, task, 0, h)
    call SaveUnitHandle(udg_ht, task, 1, u)
    call SaveInteger(udg_ht, task, 1, 0)
    call SaveBoolean(udg_ht, task, 0, false)
    call TimerStart(t, 0.5, false, function Trig_Nazrin_Pet_Main)
    call DisableTrigger(gg_trg_Nazrin_Pet)
    call DestroyTrigger(gg_trg_Nazrin_Pet)
    set gg_trg_Nazrin_Pet = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Nazrin_Pet, h, EVENT_UNIT_ISSUED_ORDER)
    call TriggerAddCondition(gg_trg_Nazrin_Pet, Condition(function Trig_Nazrin_Pet_Conditions))
    call DisableTrigger(gg_trg_Nazrin01)
    call DestroyTrigger(gg_trg_Nazrin01)
    set gg_trg_Nazrin01 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Nazrin01, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Nazrin01, Condition(function Trig_Nazrin01_Conditions))
    call TriggerAddAction(gg_trg_Nazrin01, function Trig_Nazrin01_Actions)
    call DisableTrigger(gg_trg_Nazrin02)
    call DestroyTrigger(gg_trg_Nazrin02)
    set gg_trg_Nazrin02 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Nazrin02, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Nazrin02, Condition(function Trig_Nazrin02_Conditions))
    call TriggerAddAction(gg_trg_Nazrin02, function Trig_Nazrin02_Actions)
    call DisableTrigger(gg_trg_Nazrin03)
    call DestroyTrigger(gg_trg_Nazrin03)
    set gg_trg_Nazrin03 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Nazrin03, h, EVENT_UNIT_HERO_SKILL)
    call TriggerAddCondition(gg_trg_Nazrin03, Condition(function Trig_Nazrin03_Learn_Conditions))
    call TriggerAddAction(gg_trg_Nazrin03, function Trig_Nazrin03_Learn_Actions)
    call DisableTrigger(gg_trg_Nazrin04New)
    call DestroyTrigger(gg_trg_Nazrin04New)
    set gg_trg_Nazrin04New = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Nazrin04New, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Nazrin04New, Condition(function Trig_Nazrin04New_Conditions))
    call TriggerAddAction(gg_trg_Nazrin04New, function Trig_Nazrin04New_Actions)
    call DisableTrigger(gg_trg_Nazrin04NewAttack)
    call DestroyTrigger(gg_trg_Nazrin04NewAttack)
    set gg_trg_Nazrin04NewAttack = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Nazrin04NewAttack, EVENT_PLAYER_UNIT_ATTACKED)
    call TriggerAddCondition(gg_trg_Nazrin04NewAttack, Condition(function Trig_Nazrin04NewAttack_Conditions))
    call TriggerAddAction(gg_trg_Nazrin04NewAttack, function Trig_Nazrin04NewAttack_Actions)
    call DisableTrigger(gg_trg_Nazrin04NewDeath)
    call DestroyTrigger(gg_trg_Nazrin04NewDeath)
    set gg_trg_Nazrin04NewDeath = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Nazrin04NewDeath, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_Nazrin04NewDeath, Condition(function Trig_Nazrin04NewDeath_Conditions))
    call TriggerAddAction(gg_trg_Nazrin04NewDeath, function Trig_Nazrin04NewDeath_Actions)
    set h = null
    set u = null
    set t = null
endfunction

function InitTrig_Init_Nazrin takes nothing returns nothing
    set gg_trg_Init_Nazrin = CreateTrigger()
    call TriggerAddAction(gg_trg_Init_Nazrin, function Trig_Init_Nazrin_Actions)
endfunction