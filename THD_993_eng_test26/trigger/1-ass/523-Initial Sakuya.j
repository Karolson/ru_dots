function Trig_Initial_Sakuya_Actions takes nothing returns nothing
    local unit h = GetCharacterHandle('E000')
    local integer task = GetHandleId(h)
    if h == null then
        set h = GetCharacterHandle('E02D')
        set task = GetHandleId(h)
    endif
    if h == null then
        return
    endif
    call DebugMsg(GetHeroProperName(h) + " skill initialization completed")
    if not udg_Repick then
        call DestroyTrigger(GetTriggeringTrigger())
    endif
    call SetHeroLifeIncreaseValue(h, 24)
    call SetHeroManaIncreaseValue(h, 10)
    call SetHeroManaBaseRegenValue(h, 0.4)
    call Trig_Sakuya01_Timer_Set(h)
    call UnitAddAbility(h, 'A1IB')
    if gg_trg_SakuyaAttack == null then
        set gg_trg_SakuyaAttack = CreateTrigger()
        call RegisterAnyUnitDamage(gg_trg_SakuyaAttack)
        call TriggerAddCondition(gg_trg_SakuyaAttack, Condition(function Trig_SakuyaAttack_Conditions))
        call TriggerAddAction(gg_trg_SakuyaAttack, function Trig_SakuyaAttack_Actions)
    endif
    call DisableTrigger(gg_trg_SakuyaClock)
    call DestroyTrigger(gg_trg_SakuyaClock)
    set gg_trg_SakuyaClock = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_SakuyaClock, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_SakuyaClock, Condition(function Trig_SakuyaClock_Conditions))
    call TriggerAddAction(gg_trg_SakuyaClock, function Trig_SakuyaClock_Actions)
    call DisableTrigger(gg_trg_Sakuya01)
    call DestroyTrigger(gg_trg_Sakuya01)
    set gg_trg_Sakuya01 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Sakuya01, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Sakuya01, Condition(function Trig_Sakuya01_Conditions))
    call TriggerAddAction(gg_trg_Sakuya01, function Trig_Sakuya01_Actions)
    call DisableTrigger(gg_trg_Sakuya02)
    call DestroyTrigger(gg_trg_Sakuya02)
    set gg_trg_Sakuya02 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Sakuya02, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Sakuya02, Condition(function Trig_Sakuya02_Conditions))
    call TriggerAddAction(gg_trg_Sakuya02, function Trig_Sakuya02_New_Actions)
    call DisableTrigger(gg_trg_Sakuya03)
    call DestroyTrigger(gg_trg_Sakuya03)
    set gg_trg_Sakuya03 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Sakuya03, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Sakuya03, Condition(function Trig_Sakuya03_Conditions))
    call TriggerAddAction(gg_trg_Sakuya03, function Trig_Sakuya03_Actions)
    call DisableTrigger(gg_trg_Sakuya04)
    call DestroyTrigger(gg_trg_Sakuya04)
    set gg_trg_Sakuya04 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Sakuya04, h, EVENT_UNIT_SPELL_CAST)
    call TriggerAddCondition(gg_trg_Sakuya04, Condition(function Trig_Sakuya04_Conditions))
    call TriggerAddAction(gg_trg_Sakuya04, function Trig_Sakuya04_Actions)
    call DisableTrigger(gg_trg_Sakuya04_Reset)
    call DestroyTrigger(gg_trg_Sakuya04_Reset)
    set gg_trg_Sakuya04_Reset = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Sakuya04_Reset, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Sakuya04_Reset, Condition(function Trig_Sakuya04_Reset_Conditions))
    call TriggerAddAction(gg_trg_Sakuya04_Reset, function Trig_Sakuya04_Reset_Actions)
    call DisableTrigger(gg_trg_Sakuya04_Reset)
    call DisableTrigger(gg_trg_Sakuya04_Enter)
    call DestroyTrigger(gg_trg_Sakuya04_Enter)
    set gg_trg_Sakuya04_Enter = CreateTrigger()
    call TriggerAddAction(gg_trg_Sakuya04_Enter, function Trig_Sakuya04_Enter_Actions)
    call DisableTrigger(gg_trg_Sakuya04_Enter)
    set h = null
endfunction

function InitTrig_Initial_Sakuya takes nothing returns nothing
    set gg_trg_Initial_Sakuya = CreateTrigger()
    call TriggerAddAction(gg_trg_Initial_Sakuya, function Trig_Initial_Sakuya_Actions)
endfunction