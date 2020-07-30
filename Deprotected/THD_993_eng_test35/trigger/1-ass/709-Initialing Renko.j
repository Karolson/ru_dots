function Trig_Initialing_Renko_Actions takes nothing returns nothing
    local unit h = GetCharacterHandle('H01Z')
    if h == null then
        return
    endif
    call DebugMsg(GetHeroProperName(h) + " skill initialization completed")
    if not udg_Repick then
        call DestroyTrigger(GetTriggeringTrigger())
    endif
    call UnitInitAddAttack(h)
    call SetHeroLifeIncreaseValue(h, 31)
    call SetHeroManaIncreaseValue(h, 2)
    call SetHeroManaBaseRegenValue(h, 0.4)
    set udg_SK_Renko_LastSpell = 1
    call AddingLBuff(0, 'A14F', 0)
    call AddingLBuff(0, 'A14G', 0)
    call AddingLBuff(0, 'A14H', 'B06S')
    call AddingLBuff(0, 'A1AU', 'B08B')
    call DisableTrigger(gg_trg_Renko01)
    call DestroyTrigger(gg_trg_Renko01)
    set gg_trg_Renko01 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Renko01, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Renko01, Condition(function Trig_Renko01_Conditions))
    call TriggerAddAction(gg_trg_Renko01, function Trig_Renko01_Actions)
    call DisableTrigger(gg_trg_Renko02)
    call DestroyTrigger(gg_trg_Renko02)
    set gg_trg_Renko02 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Renko02, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Renko02, Condition(function Trig_Renko02_Conditions))
    call TriggerAddAction(gg_trg_Renko02, function Trig_Renko02_Actions)
    call DisableTrigger(gg_trg_Renko03)
    call DestroyTrigger(gg_trg_Renko03)
    set gg_trg_Renko03 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Renko03, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Renko03, Condition(function Trig_Renko03_Conditions))
    call TriggerAddAction(gg_trg_Renko03, function Trig_Renko03_Actions)
    call DisableTrigger(gg_trg_Renko04)
    call DestroyTrigger(gg_trg_Renko04)
    set gg_trg_Renko04 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Renko04, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Renko04, Condition(function Trig_Renko04_Conditions))
    call TriggerAddAction(gg_trg_Renko04, function Trig_Renko04_Actions)
    set h = null
endfunction

function InitTrig_Initialing_Renko takes nothing returns nothing
    set gg_trg_Initialing_Renko = CreateTrigger()
    call TriggerAddAction(gg_trg_Initialing_Renko, function Trig_Initialing_Renko_Actions)
endfunction