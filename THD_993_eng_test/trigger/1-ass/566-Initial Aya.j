function Trig_Initial_Aya_Actions takes nothing returns nothing
    local unit h = GetCharacterHandle('E008')
    local integer task = GetHandleId(h)
    call FirstAbilityInit('A05Q')
    call FirstAbilityInit('A08Q')
    call FirstAbilityInit('A0LG')
    call FirstAbilityInit('A0LH')
    call FirstAbilityInit('A05K')
    call FirstAbilityInit('A0IL')
    call FirstAbilityInit('A1CK')
    call FirstAbilityInit('A1CS')
    call FirstAbilityInit('A0V4')
    call FirstAbilityInit('A05L')
    call FirstAbilityInit('A05S')
    call FirstAbilityInit('Aloc')
    call FirstAbilityInit('A05N')
    call FirstAbilityInit('A05O')
    if h == null then
        return
    endif
    call DebugMsg(GetHeroProperName(h) + " skill initialization completed")
    call SetHeroLifeIncreaseValue(h, 28)
    call SetHeroManaIncreaseValue(h, 2)
    call SetHeroManaBaseRegenValue(h, 0.1)
    set gg_trg_AyaEX = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_AyaEX, h, EVENT_UNIT_HERO_LEVEL)
    call TriggerRegisterPlayerUnitEvent(gg_trg_AyaEX, GetOwningPlayer(h), EVENT_PLAYER_UNIT_SUMMON, null)
    call TriggerAddCondition(gg_trg_AyaEX, Condition(function Trig_AyaEX_Conditions))
    call TriggerAddAction(gg_trg_AyaEX, function Trig_AyaEX_Actions)
    set gg_trg_Aya01 = CreateTrigger()
    call TriggerAddCondition(gg_trg_Aya01, Condition(function Trig_Aya01_Conditions))
    call TriggerAddAction(gg_trg_Aya01, function Trig_Aya01_Actions)
    call TriggerRegisterUnitEvent(gg_trg_Aya01, h, EVENT_UNIT_SPELL_EFFECT)
    if gg_trg_Aya02 == null then
        set gg_trg_Aya02 = CreateTrigger()
        call RegisterAnyUnitDamage(gg_trg_Aya02)
        call TriggerAddCondition(gg_trg_Aya02, Condition(function Trig_Aya02_Conditions))
        call TriggerAddAction(gg_trg_Aya02, function Trig_Aya02_Actions)
    endif
    set gg_trg_Aya02_Use = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Aya02_Use, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Aya02_Use, Condition(function Trig_Aya02_Use_Conditions))
    call TriggerAddAction(gg_trg_Aya02_Use, function Trig_Aya02_Use_Actions)
    set gg_trg_Aya04 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Aya04, h, EVENT_UNIT_HERO_SKILL)
    call TriggerAddCondition(gg_trg_Aya04, Condition(function Trig_Aya04_Learn_Conditions))
    call TriggerAddAction(gg_trg_Aya04, function Trig_Aya04_Learn_Actions)
    call AddingLBuff(0, 'A05N', 'B00Z')
    set h = null
endfunction

function InitTrig_Initial_Aya takes nothing returns nothing
    set gg_trg_Initial_Aya = CreateTrigger()
    call TriggerAddAction(gg_trg_Initial_Aya, function Trig_Initial_Aya_Actions)
endfunction