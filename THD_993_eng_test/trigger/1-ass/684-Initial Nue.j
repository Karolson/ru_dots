function Trig_Initial_Nue_Actions takes nothing returns nothing
    local unit h = GetCharacterHandle('H01J')
    local player w = GetOwningPlayer(h)
    local integer task = GetHandleId(h)
    call FirstAbilityInit('A0LZ')
    call FirstAbilityInit('A0M1')
    call FirstAbilityInit('A0DW')
    call FirstAbilityInit('A0M2')
    call FirstAbilityInit('A0MM')
    call FirstAbilityInit('A0M4')
    call FirstAbilityInit('A0V4')
    if h == null then
        return
    endif
    call DebugMsg(GetHeroProperName(h) + " skill initialization completed")
    if not udg_Repick then
        call DestroyTrigger(GetTriggeringTrigger())
    endif
    call SetHeroLifeIncreaseValue(h, 31)
    call SetHeroManaIncreaseValue(h, 11)
    call SetHeroManaBaseRegenValue(h, 0.4)
    set udg_SK_nue_nightmare_insc = 0
    set udg_SK_nue_nightmare_buff = 0
    set udg_SK_nue_rscd_player = GetOwningPlayer(h)
    call DisableTrigger(gg_trg_NueAttack)
    call DestroyTrigger(gg_trg_NueAttack)
    set gg_trg_NueAttack = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_NueAttack, EVENT_PLAYER_UNIT_ATTACKED)
    call TriggerAddCondition(gg_trg_NueAttack, Condition(function Trig_NueAttack_Conditions))
    call TriggerAddAction(gg_trg_NueAttack, function Trig_NueAttack_Actions)
    call DisableTrigger(gg_trg_NueIllusionKill)
    call DestroyTrigger(gg_trg_NueIllusionKill)
    set gg_trg_NueIllusionKill = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_NueIllusionKill, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_NueIllusionKill, Condition(function Trig_NueIllusionKill_Conditions))
    call TriggerAddAction(gg_trg_NueIllusionKill, function Trig_NueIllusionKill_Actions)
    call DisableTrigger(gg_trg_Nue01)
    call DestroyTrigger(gg_trg_Nue01)
    set gg_trg_Nue01 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Nue01, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Nue01, Condition(function Trig_Nue01_Conditions))
    call TriggerAddAction(gg_trg_Nue01, function Trig_Nue01_Actions)
    call DisableTrigger(gg_trg_Nue02)
    call DestroyTrigger(gg_trg_Nue02)
    set gg_trg_Nue02 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Nue02, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Nue02, Condition(function Trig_Nue02_Conditions))
    call TriggerAddAction(gg_trg_Nue02, function Trig_Nue02_Actions)
    call DisableTrigger(gg_trg_Nue03)
    call DestroyTrigger(gg_trg_Nue03)
    set gg_trg_Nue03 = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Nue03, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_Nue03, Condition(function Trig_Nue03_Conditions))
    call TriggerAddAction(gg_trg_Nue03, function Trig_Nue03_Actions)
    call DisableTrigger(gg_trg_Nue04)
    call DestroyTrigger(gg_trg_Nue04)
    set gg_trg_Nue04 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Nue04, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Nue04, Condition(function Trig_Nue04_Conditions))
    call TriggerAddAction(gg_trg_Nue04, function Trig_Nue04_Actions)
    set h = null
endfunction

function InitTrig_Initial_Nue takes nothing returns nothing
    set gg_trg_Initial_Nue = CreateTrigger()
    call TriggerAddAction(gg_trg_Initial_Nue, function Trig_Initial_Nue_Actions)
endfunction