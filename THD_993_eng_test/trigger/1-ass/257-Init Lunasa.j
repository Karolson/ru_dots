function Trig_Init_Lunasa_Actions takes nothing returns nothing
    local unit h = GetCharacterHandle('E01N')
    local integer id = GetConvertedPlayerId(GetOwningPlayer(h))
    call FirstAbilityInit('A0V5')
    call FirstAbilityInit('A0OH')
    call FirstAbilityInit('A0LM')
    call FirstAbilityInit('A04D')
    call FirstAbilityInit('A0OK')
    call FirstAbilityInit('A0V2')
    call FirstAbilityInit('A0V4')
    call FirstAbilityInit('A0DS')
    call FirstAbilityInit('A0A1')
    call DebugMsg(GetHeroProperName(h) + " skill initialization completed")
    call SetHeroLifeIncreaseValue(h, 26)
    call SetHeroManaIncreaseValue(h, 2)
    call SetHeroManaBaseRegenValue(h, 0.2)
    set udg_SK_LunasaEx_Count[id] = 1
    set udg_SK_Lunasa02_Buff[id] = 0
    if gg_trg_LunasaAttack == null then
        set gg_trg_LunasaAttack = CreateTrigger()
        call RegisterAnyUnitDamage(gg_trg_LunasaAttack)
        call TriggerAddCondition(gg_trg_LunasaAttack, Condition(function Trig_LunasaAttack_Conditions))
        call TriggerAddAction(gg_trg_LunasaAttack, function Trig_LunasaAttack_Actions)
    endif
    if gg_trg_LunasaEx == null then
        set gg_trg_LunasaEx = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(gg_trg_LunasaEx, EVENT_PLAYER_UNIT_DEATH)
        call TriggerAddCondition(gg_trg_LunasaEx, Condition(function Trig_LunasaEx_Conditions))
        call TriggerAddAction(gg_trg_LunasaEx, function Trig_LunasaEx_Actions)
    endif
    set gg_trg_Lunasa01 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Lunasa01, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Lunasa01, Condition(function Trig_Lunasa01_Conditions))
    call TriggerAddAction(gg_trg_Lunasa01, function Trig_Lunasa01_Actions)
    set gg_trg_Lunasa04 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Lunasa04, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Lunasa04, Condition(function Trig_Lunasa04_Conditions))
    call TriggerAddAction(gg_trg_Lunasa04, function Trig_Lunasa04_Actions)
    set h = null
endfunction

function InitTrig_Init_Lunasa takes nothing returns nothing
    set gg_trg_Init_Lunasa = CreateTrigger()
    call TriggerAddAction(gg_trg_Init_Lunasa, function Trig_Init_Lunasa_Actions)
endfunction