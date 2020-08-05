function Trig_Initial_Hina_Actions takes nothing returns nothing
    local unit h = GetCharacterHandle('H00X')
    local timer t
    local integer task
    call FirstAbilityInit('A070')
    call FirstAbilityInit('A0E4')
    call FirstAbilityInit('A0IB')
    call FirstAbilityInit('A0DZ')
    call FirstAbilityInit('Aloc')
    call FirstAbilityInit('A0E8')
    call FirstAbilityInit('A182')
    call FirstAbilityInit('A0JL')
    call FirstAbilityInit('A0E9')
    call FirstAbilityInit('A0IL')
    call FirstAbilityInit('A0EB')
    call FirstAbilityInit('A0EY')
    if h == null then
        return
    endif
    call DebugMsg(GetHeroProperName(h) + " skill initialization completed")
    if not udg_Repick then
        call DestroyTrigger(GetTriggeringTrigger())
    endif
    call SetHeroLifeIncreaseValue(h, 26)
    call SetHeroManaIncreaseValue(h, 1)
    call SetHeroManaBaseRegenValue(h, 0.2)
    set t = CreateTimer()
    set task = GetHandleId(t)
    call SaveTimerHandle(udg_ht, task, 0, t)
    call SaveUnitHandle(udg_ht, task, 1, h)
    call TimerStart(t, 1.0, true, function Trig_HinaEx_Actions)
    set udg_SK_HinaUnit01 = CreateUnit(GetOwningPlayer(h), 'n02V', GetUnitX(h), GetUnitY(h), 0)
    set udg_SK_HinaUnit02 = CreateUnit(GetOwningPlayer(h), 'n02V', GetUnitX(h), GetUnitY(h), 0)
    call DisableTrigger(gg_trg_Hina01)
    call DestroyTrigger(gg_trg_Hina01)
    set gg_trg_Hina01 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Hina01, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Hina01, Condition(function Trig_Hina01_Conditions))
    call DisableTrigger(gg_trg_Hina02)
    call DestroyTrigger(gg_trg_Hina02)
    set gg_trg_Hina02 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Hina02, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Hina02, Condition(function Trig_Hina02_Conditions))
    call DisableTrigger(gg_trg_Hina03)
    call DestroyTrigger(gg_trg_Hina03)
    set gg_trg_Hina03 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Hina03, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Hina03, Condition(function Trig_Hina03_Conditions))
    call DisableTrigger(gg_trg_Hina04)
    call DestroyTrigger(gg_trg_Hina04)
    set gg_trg_Hina04 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Hina04, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Hina04, Condition(function Trig_Hina04_Conditions))
    set t = null
    set h = null
endfunction

function InitTrig_Initial_Hina takes nothing returns nothing
    set gg_trg_Initial_Hina = CreateTrigger()
    call TriggerAddAction(gg_trg_Initial_Hina, function Trig_Initial_Hina_Actions)
endfunction