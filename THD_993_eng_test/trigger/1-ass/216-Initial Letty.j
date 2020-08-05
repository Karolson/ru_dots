function Trig_Initial_Letty_Actions takes nothing returns nothing
    local unit h = GetCharacterHandle('H00N')
    local integer i = 0
    local timer t
    local integer task
    call FirstAbilityInit('A02L')
    call FirstAbilityInit('A02Q')
    call FirstAbilityInit('A107')
    call FirstAbilityInit('A040')
    call FirstAbilityInit('A041')
    call FirstAbilityInit('A03Z')
    call FirstAbilityInit('A042')
    call FirstAbilityInit('A0XC')
    call FirstAbilityInit('A0XB')
    call FirstAbilityInit('A08W')
    call FirstAbilityInit('A0UL')
    call FirstAbilityInit('A15K')
    call FirstAbilityInit('A08P')
    call FirstAbilityInit('A114')
    call FirstAbilityInit('A115')
    call FirstAbilityInit('A116')
    if h == null then
        return
    endif
    call DebugMsg(GetHeroProperName(h) + " skill initialization completed")
    call SetHeroLifeIncreaseValue(h, 31)
    call SetHeroManaIncreaseValue(h, 6)
    call SetHeroManaBaseRegenValue(h, 0.5)
    call RecHeroBasicArmorValue(h, 3.0)
    call RecHeroIncreArmorValue(h, 0.0)
    call RecHeroAttackBaseValue(h, 27)
    call RecHeroAttackUppeValue(h, 33)
    call RecHeroStaterTypeValue(h, 3)
    set i = 0
    call SaveInteger(udg_Hashtable_CastSq_Id, GetHandleId(h), i * 10 + 0, 'A0XB')
    call SaveInteger(udg_Hashtable_CastSq_Id, GetHandleId(h), i * 10 + 1, 0)
    set i = 1
    call SaveInteger(udg_Hashtable_CastSq_Id, GetHandleId(h), i * 10 + 0, 'A08W')
    call SaveInteger(udg_Hashtable_CastSq_Id, GetHandleId(h), i * 10 + 1, 1)
    call SaveReal(udg_Hashtable_CastSq_Id, GetHandleId(h), i * 10 + 2, 700.0 * 1.0)
    call SaveReal(udg_Hashtable_CastSq_Id, GetHandleId(h), i * 10 + 3, 0.0 * 1.0)
    call SaveInteger(udg_Hashtable_CastSq_Id, GetHandleId(h), i * 10 + 4, 0)
    call SaveInteger(udg_Hashtable_CastSq_Id, GetHandleId(h), i * 10 + 5, 65)
    call SaveInteger(udg_Hashtable_CastSq_Id, GetHandleId(h), i * 10 + 6, 65)
    call SaveInteger(udg_Hashtable_CastSq_Id, GetHandleId(h), i * 10 + 7, 215)
    call SqSaveUnitCircl(h, i, 0)
    set i = 2
    call SaveInteger(udg_Hashtable_CastSq_Id, GetHandleId(h), i * 10 + 0, 'A0UL')
    call SaveInteger(udg_Hashtable_CastSq_Id, GetHandleId(h), i * 10 + 1, 0)
    set i = 3
    call SaveInteger(udg_Hashtable_CastSq_Id, GetHandleId(h), i * 10 + 0, 'A15K')
    call SaveInteger(udg_Hashtable_CastSq_Id, GetHandleId(h), i * 10 + 1, 0)
    set i = 4
    call SaveInteger(udg_Hashtable_CastSq_Id, GetHandleId(h), i * 10 + 0, 'A08P')
    call SaveInteger(udg_Hashtable_CastSq_Id, GetHandleId(h), i * 10 + 1, 2)
    call SaveReal(udg_Hashtable_CastSq_Id, GetHandleId(h), i * 10 + 2, 350.0 * 1.0)
    call SaveReal(udg_Hashtable_CastSq_Id, GetHandleId(h), i * 10 + 3, 0.0 * 1.0)
    call SaveInteger(udg_Hashtable_CastSq_Id, GetHandleId(h), i * 10 + 4, 0)
    call SaveInteger(udg_Hashtable_CastSq_Id, GetHandleId(h), i * 10 + 5, 115)
    call SaveInteger(udg_Hashtable_CastSq_Id, GetHandleId(h), i * 10 + 6, 115)
    call SaveInteger(udg_Hashtable_CastSq_Id, GetHandleId(h), i * 10 + 7, 115)
    call SqSaveUnitCircl(h, i, 0)
    set t = CreateTimer()
    set task = GetHandleId(t)
    call SaveUnitHandle(udg_ht, task, 0, h)
    call SaveReal(udg_ht, task, 1, 0)
    call SaveReal(udg_ht, task, 2, 0)
    call SaveInteger(udg_ht, task, 3, 0)
    call TimerStart(t, 0.1, true, function Trig_LettyEx_Actions)
    if gg_trg_Letty01 == null then
        set gg_trg_Letty01 = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(gg_trg_Letty01, EVENT_PLAYER_UNIT_SPELL_EFFECT)
        call TriggerAddCondition(gg_trg_Letty01, Condition(function Trig_Letty01_Conditions))
        call TriggerAddAction(gg_trg_Letty01, function Trig_Letty01_Actions)
    endif
    if gg_trg_Letty02 == null then
        set gg_trg_Letty02 = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(gg_trg_Letty02, EVENT_PLAYER_UNIT_SPELL_EFFECT)
        call TriggerAddCondition(gg_trg_Letty02, Condition(function Trig_Letty02_Conditions))
        call TriggerAddAction(gg_trg_Letty02, function Trig_Letty02_Actions)
    endif
    if gg_trg_Letty03 == null then
        set gg_trg_Letty03 = CreateTrigger()
        call TriggerRegisterUnitEvent(gg_trg_Letty03, h, EVENT_UNIT_HERO_SKILL)
        call TriggerAddCondition(gg_trg_Letty03, Condition(function Trig_Letty03_Conditions))
        call TriggerAddAction(gg_trg_Letty03, function Trig_Letty03_Actions)
    endif
    if gg_trg_Letty04 == null then
        set gg_trg_Letty04 = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(gg_trg_Letty04, EVENT_PLAYER_UNIT_SPELL_EFFECT)
        call TriggerAddCondition(gg_trg_Letty04, Condition(function Trig_Letty04_Conditions))
        call TriggerAddAction(gg_trg_Letty04, function Trig_Letty04_Actions)
    endif
    call AddingLBuff(0, 'A15M', 'B06W')
    call AddingLBuff(0, 'A15N', 'B06W')
    call AddingLBuff(0, 'A15O', 'B06W')
    call AddingLBuff(0, 'A15P', 'B06W')
    call AddingLBuff(0, 'A114', 'B01U')
    call AddingLBuff(0, 'A115', 'B01U')
    call AddingLBuff(0, 'A116', 'B01U')
    set h = null
    set t = null
endfunction

function InitTrig_Initial_Letty takes nothing returns nothing
    set gg_trg_Initial_Letty = CreateTrigger()
    call TriggerAddAction(gg_trg_Initial_Letty, function Trig_Initial_Letty_Actions)
endfunction