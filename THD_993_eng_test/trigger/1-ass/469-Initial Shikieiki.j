function Trig_Initial_Shikieiki_Actions takes nothing returns nothing
    local unit h = GetCharacterHandle('E00V')
    call FirstAbilityInit('A1ED')
    call FirstAbilityInit('A0B7')
    call FirstAbilityInit('A0B0')
    call FirstAbilityInit('A0B8')
    call FirstAbilityInit('A0I1')
    call FirstAbilityInit('A0I4')
    call FirstAbilityInit('A0SY')
    call FirstAbilityInit('A0SZ')
    call FirstAbilityInit('A194')
    call FirstAbilityInit('A00K')
    call FirstAbilityInit('A00W')
    call FirstAbilityInit('A08V')
    call FirstAbilityInit('A0BG')
    if h == null then
        return
    endif
    call DebugMsg(GetHeroProperName(h) + " skill initialization completed")
    if not udg_Repick then
        call DestroyTrigger(GetTriggeringTrigger())
    endif
    call SetHeroLifeIncreaseValue(h, 28)
    call SetHeroManaIncreaseValue(h, 0)
    call SetHeroManaBaseRegenValue(h, 0)
    set udg_SK_Shikieiki = h
    set udg_SK_Shikieiki_Count = InitHashtable()
    call DisableTrigger(gg_trg_Shikieiki01)
    call DestroyTrigger(gg_trg_Shikieiki01)
    set gg_trg_Shikieiki01 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Shikieiki01, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Shikieiki01, Condition(function Trig_Shikieiki01_Conditions))
    call TriggerAddAction(gg_trg_Shikieiki01, function Trig_Shikieiki01_Actions)
    call DisableTrigger(gg_trg_Shikieiki01_Active)
    call DestroyTrigger(gg_trg_Shikieiki01_Active)
    set gg_trg_Shikieiki01_Active = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Shikieiki01_Active, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_Shikieiki01_Active, Condition(function Trig_Shikieiki01_Active_Conditions))
    call TriggerAddAction(gg_trg_Shikieiki01_Active, function Trig_Shikieiki01_Active_Actions)
    call SaveUnitHandle(udg_sht, GetHandleId(gg_trg_Shikieiki01_Active), 0, h)
    call DisableTrigger(gg_trg_Shikieiki01_Display)
    call DestroyTrigger(gg_trg_Shikieiki01_Display)
    set gg_trg_Shikieiki01_Display = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Shikieiki01_Display, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Shikieiki01_Display, Condition(function Trig_Shikieiki01_Display_Conditions))
    call TriggerAddAction(gg_trg_Shikieiki01_Display, function Trig_Shikieiki01_Display_Actions)
    call DisableTrigger(gg_trg_Shikieiki01_Death)
    call DestroyTrigger(gg_trg_Shikieiki01_Death)
    set gg_trg_Shikieiki01_Death = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Shikieiki01_Death, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_Shikieiki01_Death, Condition(function Trig_Shikieiki01_Death_Conditions))
    call TriggerAddAction(gg_trg_Shikieiki01_Death, function Trig_Shikieiki01_Death_Actions)
    call DisableTrigger(gg_trg_Shikieiki02)
    call DestroyTrigger(gg_trg_Shikieiki02)
    set gg_trg_Shikieiki02 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Shikieiki02, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Shikieiki02, Condition(function Trig_Shikieiki02_Conditions))
    call TriggerAddAction(gg_trg_Shikieiki02, function Trig_Shikieiki02_Actions)
    call DisableTrigger(gg_trg_Shikieiki03)
    call DestroyTrigger(gg_trg_Shikieiki03)
    set gg_trg_Shikieiki03 = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Shikieiki03, EVENT_PLAYER_UNIT_ATTACKED)
    call TriggerAddCondition(gg_trg_Shikieiki03, Condition(function Trig_Shikieiki03_Conditions))
    call TriggerAddAction(gg_trg_Shikieiki03, function Trig_Shikieiki03_Actions)
    call DisableTrigger(gg_trg_Shikieiki04)
    call DestroyTrigger(gg_trg_Shikieiki04)
    set gg_trg_Shikieiki04 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Shikieiki04, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Shikieiki04, Condition(function Trig_Shikieiki04_Conditions))
    call TriggerAddAction(gg_trg_Shikieiki04, function Trig_Shikieiki04_Actions)
    set udg_SK_Shikieiki_Degree[0] = "0"
    set udg_SK_Shikieiki_Degree[1] = "1"
    set udg_SK_Shikieiki_Degree[2] = "2"
    set udg_SK_Shikieiki_Degree[3] = "3"
    set udg_SK_Shikieiki_Degree[4] = "4"
    set udg_SK_Shikieiki_Degree[5] = "5"
    set udg_SK_Shikieiki_Degree[6] = "6"
    set udg_SK_Shikieiki_Degree[7] = "7"
    set udg_SK_Shikieiki_Degree[8] = "8"
    set udg_SK_Shikieiki_Degree[9] = "9"
    set udg_SK_Shikieiki_Degree[10] = "10"
    set udg_SK_Shikieiki_Degree[11] = "11"
    set udg_SK_Shikieiki_Degree[12] = "12"
    set h = null
endfunction

function InitTrig_Initial_Shikieiki takes nothing returns nothing
    set gg_trg_Initial_Shikieiki = CreateTrigger()
    call TriggerAddAction(gg_trg_Initial_Shikieiki, function Trig_Initial_Shikieiki_Actions)
endfunction