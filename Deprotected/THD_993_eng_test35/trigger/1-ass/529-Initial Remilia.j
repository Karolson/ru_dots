function Trig_Initial_Remilia_Actions takes nothing returns nothing
    local unit h = GetCharacterHandle('O00J')
    if h == null then
        return
    endif
    call DebugMsg(GetHeroProperName(h) + " skill initialization completed")
    if not udg_Repick then
        call DestroyTrigger(GetTriggeringTrigger())
    endif
    set udg_SK_Remilia = h
    set udg_SK_Remilia_Player = GetOwningPlayer(h)
    call SetHeroLifeIncreaseValue(h, 23)
    call SetHeroManaIncreaseValue(h, 10)
    call SetHeroManaBaseRegenValue(h, 0.4)
    call DisableTrigger(gg_trg_Remilia01)
    call DestroyTrigger(gg_trg_Remilia01)
    set gg_trg_Remilia01 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Remilia01, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Remilia01, Condition(function Trig_Remilia01_Conditions))
    call TriggerAddAction(gg_trg_Remilia01, function Trig_Remilia01_Actions)
    call DisableTrigger(gg_trg_Remilia02)
    call DestroyTrigger(gg_trg_Remilia02)
    set gg_trg_Remilia02 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Remilia02, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerRegisterPlayerUnitEvent(gg_trg_Remilia02, GetOwningPlayer(h), EVENT_PLAYER_UNIT_DEATH, null)
    call TriggerAddCondition(gg_trg_Remilia02, Condition(function Trig_Remilia02_Conditions))
    call TriggerAddAction(gg_trg_Remilia02, function Trig_Remilia02_Actions)
    call DisableTrigger(gg_trg_Remilia02Back)
    call DestroyTrigger(gg_trg_Remilia02Back)
    set gg_trg_Remilia02Back = CreateTrigger()
    call TriggerRegisterPlayerUnitEvent(gg_trg_Remilia02Back, GetOwningPlayer(h), EVENT_PLAYER_UNIT_SPELL_EFFECT, null)
    call TriggerAddCondition(gg_trg_Remilia02Back, Condition(function Trig_Remilia02Back_Conditions))
    call TriggerAddAction(gg_trg_Remilia02Back, function Trig_Remilia02Back_Actions)
    call DisableTrigger(gg_trg_Remilia03)
    call DestroyTrigger(gg_trg_Remilia03)
    set gg_trg_Remilia03 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Remilia03, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Remilia03, Condition(function Remilia03_Conditions))
    call TriggerAddAction(gg_trg_Remilia03, function Remilia03_Actions)
    call DisableTrigger(gg_trg_Remilia04)
    call DestroyTrigger(gg_trg_Remilia04)
    set gg_trg_Remilia04 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Remilia04, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Remilia04, Condition(function Trig_Remilia04_Conditions))
    call TriggerAddAction(gg_trg_Remilia04, function Trig_Remilia04_Actions)
    set h = null
endfunction

function InitTrig_Initial_Remilia takes nothing returns nothing
    set gg_trg_Initial_Remilia = CreateTrigger()
    call TriggerAddAction(gg_trg_Initial_Remilia, function Trig_Initial_Remilia_Actions)
endfunction