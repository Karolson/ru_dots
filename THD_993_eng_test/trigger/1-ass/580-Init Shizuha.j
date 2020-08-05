function Trig_Init_Shizuha_Actions takes nothing returns nothing
    local unit h = GetCharacterHandle('H01H')
    local player w = GetOwningPlayer(h)
    local integer task = GetHandleId(h)
    call FirstAbilityInit('A0E5')
    call FirstAbilityInit('A0J8')
    call FirstAbilityInit('A0JD')
    call FirstAbilityInit('A00C')
    call FirstAbilityInit('A0AN')
    call FirstAbilityInit('A018')
    call FirstAbilityInit('A0JC')
    call FirstAbilityInit('A0JM')
    call FirstAbilityInit('A0G8')
    call FirstAbilityInit('A0G9')
    call FirstAbilityInit('A0J6')
    call FirstAbilityInit('A0JA')
    if h == null then
        set h = GetCharacterHandle('H02F')
    endif
    if h == null then
        return
    endif
    call DebugMsg(GetHeroProperName(h) + " skill initialization completed")
    if not udg_Repick then
        call DestroyTrigger(GetTriggeringTrigger())
    endif
    call SetHeroLifeIncreaseValue(h, 21)
    call SetHeroManaIncreaseValue(h, 2)
    call SetHeroManaBaseRegenValue(h, 0.2)
    set udg_SK_Shizuha = h
    call DisableTrigger(gg_trg_ShizuhaEx)
    call DestroyTrigger(gg_trg_ShizuhaEx)
    set gg_trg_ShizuhaEx = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_ShizuhaEx, h, EVENT_UNIT_HERO_LEVEL)
    call TriggerAddAction(gg_trg_ShizuhaEx, function Trig_ShizuhaEx_Actions)
    call DisableTrigger(gg_trg_shizuha01)
    call DestroyTrigger(gg_trg_shizuha01)
    set gg_trg_shizuha01 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_shizuha01, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_shizuha01, Condition(function Trig_shizuha01_Conditions))
    call TriggerAddAction(gg_trg_shizuha01, function Trig_shizuha01_Actions)
    call DisableTrigger(gg_trg_Shizuha02)
    call DestroyTrigger(gg_trg_Shizuha02)
    set gg_trg_Shizuha02 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Shizuha02, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Shizuha02, Condition(function Trig_Shizuha02_Conditions))
    call TriggerAddAction(gg_trg_Shizuha02, function Trig_Shizuha02_Actions)
    call DisableTrigger(gg_trg_shizuha03)
    call DestroyTrigger(gg_trg_shizuha03)
    set gg_trg_shizuha03 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_shizuha03, h, EVENT_UNIT_HERO_SKILL)
    call RegisterAnyUnitDamage(gg_trg_shizuha03)
    call TriggerAddCondition(gg_trg_shizuha03, Condition(function Shizuha03_Conditions))
    call TriggerAddAction(gg_trg_shizuha03, function Shizuha03_Damage)
    call DisableTrigger(gg_trg_Shizuha04)
    call DestroyTrigger(gg_trg_Shizuha04)
    set gg_trg_Shizuha04 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Shizuha04, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Shizuha04, Condition(function Trig_Shizuha04_Conditions))
    call TriggerAddAction(gg_trg_Shizuha04, function Trig_Shizuha04_Actions)
    set h = null
endfunction

function InitTrig_Init_Shizuha takes nothing returns nothing
    set gg_trg_Init_Shizuha = CreateTrigger()
    call TriggerAddAction(gg_trg_Init_Shizuha, function Trig_Init_Shizuha_Actions)
endfunction