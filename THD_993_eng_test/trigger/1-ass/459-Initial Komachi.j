function Trig_Initial_Komachi_Actions takes nothing returns nothing
    local unit h = GetCharacterHandle('U00J')
    local timer t = CreateTimer()
    local integer i = 0
    call FirstAbilityInit('A1EC')
    call FirstAbilityInit('A0JK')
    call FirstAbilityInit('A0CL')
    call FirstAbilityInit('A0FH')
    call FirstAbilityInit('Aloc')
    call FirstAbilityInit('A1E3')
    call FirstAbilityInit('A0CK')
    call FirstAbilityInit('A1E2')
    call FirstAbilityInit('A19D')
    call FirstAbilityInit('A0V4')
    call FirstAbilityInit('Avul')
    call FirstAbilityInit('A0CN')
    call FirstAbilityInit('A0IL')
    call FirstAbilityInit('A1CU')
    call FirstAbilityInit('A0CM')
//   if h == null then
 //       set h=GetCharacterHandle('U013')
 //   endif
 //   if h == null then
//        set h=GetCharacterHandle('U013')
 //   endif
   if h == null then
     return
   endif
    call DebugMsg(GetHeroProperName(h) + " skill initialization completed")
    call SetHeroLifeIncreaseValue(h, 34)
    call SetHeroManaIncreaseValue(h, 6)
    call SetHeroManaBaseRegenValue(h, 0.4)
    if gg_trg_KomachiEx == null then
        set gg_trg_KomachiEx = CreateTrigger()
        loop
            call TriggerRegisterPlayerUnitEvent(gg_trg_KomachiEx, Player(i), EVENT_PLAYER_UNIT_ATTACKED, null)
            set i = i + 1
        exitwhen i == bj_MAX_PLAYER_SLOTS
        endloop
        call TriggerAddCondition(gg_trg_KomachiEx, Condition(function KomachiEx_Conditions))
    endif
    call SaveBoolean(udg_sht, StringHash("KomachiEx"), GetHandleId(h), true)
    set gg_trg_Komachi01 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Komachi01, h, EVENT_UNIT_HERO_SKILL)
    call TriggerRegisterUnitEvent(gg_trg_Komachi01, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Komachi01, Condition(function Trig_Komachi01_Conditions))
    call TriggerAddAction(gg_trg_Komachi01, function Trig_Komachi01_Actions)
    set gg_trg_Komachi02_Active = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Komachi02_Active, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Komachi02_Active, Condition(function Komachi02_Active_Conditions))
    if gg_trg_Komachi02_Damage == null then
        set gg_trg_Komachi02_Damage = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(gg_trg_Komachi02_Damage, EVENT_PLAYER_UNIT_ATTACKED)
        call RegisterAnyUnitDamage(gg_trg_Komachi02_Damage)
        call TriggerAddCondition(gg_trg_Komachi02_Damage, Condition(function Komachi02_Damage_Conditions))
    endif
    set gg_trg_Komachi03_New = CreateTrigger()
    call TriggerAddCondition(gg_trg_Komachi03_New, Condition(function Trig_Komachi03_New_Conditions))
    call TriggerRegisterUnitEvent(gg_trg_Komachi03_New, h, EVENT_UNIT_SPELL_EFFECT)
    set gg_trg_Komachi04 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Komachi04, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Komachi04, Condition(function Trig_Komachi04_Conditions))
    call TriggerAddAction(gg_trg_Komachi04, function Trig_Komachi04_Actions)
    set t = null
    set h = null
endfunction

function InitTrig_Initial_Komachi takes nothing returns nothing
    set gg_trg_Initial_Komachi = CreateTrigger()
    call TriggerAddAction(gg_trg_Initial_Komachi, function Trig_Initial_Komachi_Actions)
endfunction