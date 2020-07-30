function Trig_Initial_Medi_Actions takes nothing returns nothing
    local unit h = GetCharacterHandle('N00K')
    local timer t = CreateTimer()
    local group g = CreateGroup()
    local integer task = GetHandleId(t)
    if h == null then
        return
    endif
    call DebugMsg(GetHeroProperName(h) + " skill initialization completed")
    call SaveUnitHandle(udg_ht, task, 0, h)
    call SaveGroupHandle(udg_ht, task, 1, g)
    call TimerStart(t, 1.0, true, function Trig_MediEx_Actions)
    call SetHeroLifeIncreaseValue(h, 26)
    call SetHeroManaIncreaseValue(h, 10)
    call SetHeroManaBaseRegenValue(h, 0.3)
    if gg_trg_Medi01 == null then
        set gg_trg_Medi01 = CreateTrigger()
        call RegisterAnyUnitDamage(gg_trg_Medi01)
        call TriggerAddCondition(gg_trg_Medi01, Condition(function Trig_Medi01_Conditions))
        call TriggerAddAction(gg_trg_Medi01, function Trig_Medi01_Actions)
    endif
    set gg_trg_Medi02 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Medi02, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Medi02, Condition(function Medi02_Conditions))
    call TriggerAddAction(gg_trg_Medi02, function Medi02_Actions)
    set gg_trg_Medi03 = CreateTrigger()
    call RegisterAnyUnitDamage(gg_trg_Medi03)
    call TriggerRegisterUnitEvent(gg_trg_Medi03, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerRegisterUnitEvent(gg_trg_Medi03, h, EVENT_UNIT_HERO_SKILL)
    call TriggerAddCondition(gg_trg_Medi03, Condition(function Trig_Medi03_Conditions))
    call TriggerAddAction(gg_trg_Medi03, function Trig_Medi03_Actions)
    set gg_trg_Medi04 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Medi04, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Medi04, Condition(function Trig_Medi04_Conditions))
    call TriggerAddAction(gg_trg_Medi04, function Trig_Medi04_Actions)
    call AddingLBuff(0, 'A17Y', 'B076')
    call AddingLBuff(0, 'A17Z', 'B076')
    call AddingLBuff(0, 'A180', 'B076')
    call AddingLBuff(0, 'A181', 'B076')
    call AddingLBuff(0, 'A15U', 'B01N')
    call AddingLBuff(0, 'A15V', 'B01N')
    call AddingLBuff(0, 'A15W', 'B01N')
    call AddingLBuff(0, 'A15X', 'B01N')
    set g = null
    set h = null
endfunction

function InitTrig_Initial_Medi takes nothing returns nothing
    set gg_trg_Initial_Medi = CreateTrigger()
    call TriggerAddAction(gg_trg_Initial_Medi, function Trig_Initial_Medi_Actions)
endfunction