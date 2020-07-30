function Trig_Initial_Byakuren_Actions takes nothing returns nothing
    local unit h = GetCharacterHandle('H01K')
    local player w = GetOwningPlayer(h)
    local timer t
    local integer task
    if h == null then
        return
    endif
    call DebugMsg(GetHeroProperName(h) + " skill initialization completed")
    if not udg_Repick then
        call DestroyTrigger(GetTriggeringTrigger())
    endif
    call SetHeroLifeIncreaseValue(h, 27)
    call SetHeroManaIncreaseValue(h, 2)
    call DisableTrigger(gg_trg_ByakurenDS)
    call DestroyTrigger(gg_trg_ByakurenDS)
    set gg_trg_ByakurenDS = CreateTrigger()
    call TriggerRegisterPlayerEvent(gg_trg_ByakurenDS, GetOwningPlayer(h), EVENT_PLAYER_END_CINEMATIC)
    call TriggerAddCondition(gg_trg_ByakurenDS, Condition(function Trig_ByakurenDS_Conditions))
    call TriggerAddAction(gg_trg_ByakurenDS, function Trig_ByakurenDS_Actions)
    set t = CreateTimer()
    set task = GetHandleId(t)
    call SaveUnitHandle(udg_ht, task, 0, h)
    call SaveInteger(udg_ht, task, 1, 0)
    call TimerStart(t, 0.1, true, function Trig_ByakurenEx_Main)
    call DisableTrigger(gg_trg_ByakurenExAttack)
    call DestroyTrigger(gg_trg_ByakurenExAttack)
    set gg_trg_ByakurenExAttack = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_ByakurenExAttack, EVENT_PLAYER_UNIT_ATTACKED)
    call TriggerAddCondition(gg_trg_ByakurenExAttack, Condition(function Trig_ByakurenExAttack_Conditions))
    call TriggerAddAction(gg_trg_ByakurenExAttack, function Trig_ByakurenExAttack_Actions)
    call DisableTrigger(gg_trg_Byakuren01)
    call DestroyTrigger(gg_trg_Byakuren01)
    set gg_trg_Byakuren01 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Byakuren01, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Byakuren01, Condition(function Trig_Byakuren01_Conditions))
    call TriggerAddAction(gg_trg_Byakuren01, function Trig_Byakuren01_Actions)
    call DisableTrigger(gg_trg_Byakuren02)
    call DestroyTrigger(gg_trg_Byakuren02)
    set gg_trg_Byakuren02 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Byakuren02, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Byakuren02, Condition(function Trig_Byakuren02_Conditions))
    call TriggerAddAction(gg_trg_Byakuren02, function Trig_Byakuren02_Actions)
    call DisableTrigger(gg_trg_Byakuren02Learn)
    call DestroyTrigger(gg_trg_Byakuren02Learn)
    set gg_trg_Byakuren02Learn = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Byakuren02Learn, h, EVENT_UNIT_HERO_SKILL)
    call TriggerAddCondition(gg_trg_Byakuren02Learn, Condition(function Trig_Byakuren02Learn_Conditions))
    call TriggerAddAction(gg_trg_Byakuren02Learn, function Trig_Byakuren02Learn_Actions)
    call DisableTrigger(gg_trg_Byakuren03)
    call DestroyTrigger(gg_trg_Byakuren03)
    set gg_trg_Byakuren03 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Byakuren03, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Byakuren03, Condition(function Trig_Byakuren03_Conditions))
    call TriggerAddAction(gg_trg_Byakuren03, function Trig_Byakuren03_Actions)
    call DisableTrigger(gg_trg_Byakuren04)
    call DestroyTrigger(gg_trg_Byakuren04)
    set gg_trg_Byakuren04 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Byakuren04, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Byakuren04, Condition(function Trig_Byakuren04_Conditions))
    call TriggerAddAction(gg_trg_Byakuren04, function Trig_Byakuren04_Actions)
    set h = null
    set t = null
endfunction

function InitTrig_Initial_Byakuren takes nothing returns nothing
    set gg_trg_Initial_Byakuren = CreateTrigger()
    call TriggerAddAction(gg_trg_Initial_Byakuren, function Trig_Initial_Byakuren_Actions)
endfunction