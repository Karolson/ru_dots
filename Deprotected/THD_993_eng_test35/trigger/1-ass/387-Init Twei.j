function Trig_Init_Twei_Actions takes nothing returns nothing
    local unit h = GetCharacterHandle('O00N')
    if h == null then
        return
    endif
    call DebugMsg(GetHeroProperName(h) + " skill initialization completed")
    if not udg_Repick then
        call DestroyTrigger(GetTriggeringTrigger())
    endif
    call SetHeroLifeIncreaseValue(h, 33)
    call SetHeroManaIncreaseValue(h, 0)
    call SetHeroManaBaseRegenValue(h, 0.3)
    set udg_SK_Twei03_Iff = 0
    set udg_SK_Twei03_Moving = false
    set udg_SK_Twei04_Twei = h
    set udg_SK_TweiEx = true
    call DisableTrigger(gg_trg_Twei01_Death)
    call DestroyTrigger(gg_trg_Twei01_Death)
    set gg_trg_Twei01_Death = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Twei01_Death, h, EVENT_UNIT_DEATH)
    call TriggerAddAction(gg_trg_Twei01_Death, function Trig_Twei01_Death_Actions)
    call DisableTrigger(gg_trg_Twei01)
    call DestroyTrigger(gg_trg_Twei01)
    set gg_trg_Twei01 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Twei01, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Twei01, Condition(function Trig_Twei01_Conditions))
    call TriggerAddAction(gg_trg_Twei01, function Trig_Twei01_Actions)
    call DisableTrigger(gg_trg_Twei02)
    call DestroyTrigger(gg_trg_Twei02)
    set gg_trg_Twei02 = CreateTrigger()
    call RegisterAnyUnitDamage(gg_trg_Twei02)
    call TriggerAddCondition(gg_trg_Twei02, Condition(function Trig_Twei02_Conditions))
    call TriggerAddAction(gg_trg_Twei02, function Trig_Twei02_Actions)
    call DisableTrigger(gg_trg_Twei03)
    call DestroyTrigger(gg_trg_Twei03)
    set gg_trg_Twei03 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Twei03, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Twei03, Condition(function Trig_Twei03_Conditions))
    call TriggerAddAction(gg_trg_Twei03, function Trig_Twei03_Actions)
    call DisableTrigger(gg_trg_Twei03_Damage)
    call DestroyTrigger(gg_trg_Twei03_Damage)
    set gg_trg_Twei03_Damage = CreateTrigger()
    call RegisterAnyUnitDamage(gg_trg_Twei03_Damage)
    call TriggerAddCondition(gg_trg_Twei03_Damage, Condition(function Trig_Twei03_Damage_Conditions))
    call TriggerAddAction(gg_trg_Twei03_Damage, function Trig_Twei03_Damage_Actions)
    call AddingLBuff(0, 'A08E', 0)
    call AddingLBuff(0, 'A12B', 0)
    call AddingLBuff(0, 'A12C', 0)
    call AddingLBuff(0, 'A12D', 0)
    set h = null
endfunction

function InitTrig_Init_Twei takes nothing returns nothing
    set gg_trg_Init_Twei = CreateTrigger()
    call TriggerAddAction(gg_trg_Init_Twei, function Trig_Init_Twei_Actions)
endfunction