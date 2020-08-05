function SuikaEx_ReCharge takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 1)
    if GetUnitAbilityLevel(caster, 'A10B') != 1 then
        if RectContainsUnit(gg_rct_BArea1, caster) or RectContainsUnit(gg_rct_BArea2, caster) then
            call SetUnitAbilityLevel(caster, 'A10B', 1)
            call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Undead\\ReplenishMana\\ReplenishManaCasterOverhead.mdl", GetUnitX(caster), GetUnitY(caster)))
        endif
    endif
endfunction

function Trig_Initial_Suika_Actions takes nothing returns nothing
    local unit h = GetCharacterHandle('H00L')
    local timer t
    local integer task
    call FirstAbilityInit('A04X')
    call FirstAbilityInit('A04Y')
    call FirstAbilityInit('A04Z')
    call FirstAbilityInit('A050')
    call FirstAbilityInit('A051')
    call FirstAbilityInit('A10B')
    call FirstAbilityInit('A05R')
    call FirstAbilityInit('Aloc')
    call FirstAbilityInit('Avul')
    call FirstAbilityInit('A0IL')
    call FirstAbilityInit('A0BC')
    call FirstAbilityInit('A05W')
    call FirstAbilityInit('A02I')
    call FirstAbilityInit('A15T')
    call FirstAbilityInit('A1F7')
    call FirstAbilityInit('A05V')
    call FirstAbilityInit('A0HZ')
    if h == null then
        return
    endif
    call DebugMsg(GetHeroProperName(h) + " skill initialization completed")
    set t = CreateTimer()
    set task = GetHandleId(t)
    call SaveUnitHandle(udg_ht, task, 1, h)
    call TimerStart(t, 1, true, function SuikaEx_ReCharge)
    set t = null
    call UnitAddAbility(h, 'A10B')
    call UnitMakeAbilityPermanent(h, true, 'A10B')
    call SetHeroLifeIncreaseValue(h, 33)
    call SetHeroManaIncreaseValue(h, 5)
    call SetHeroManaBaseRegenValue(h, 0.5)
    set gg_trg_Suika01 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Suika01, h, EVENT_UNIT_SPELL_CAST)
    call TriggerRegisterUnitEvent(gg_trg_Suika01, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Suika01, Condition(function Trig_Suika01_Use_Conditions))
    call TriggerAddAction(gg_trg_Suika01, function Trig_Suika01_Use_Actions)
    if gg_trg_Suika02 == null then
        set gg_trg_Suika02 = CreateTrigger()
        call RegisterAnyUnitDamage(gg_trg_Suika02)
        call TriggerAddCondition(gg_trg_Suika02, Condition(function Trig_Suika02_Conditions))
        call TriggerAddAction(gg_trg_Suika02, function Trig_Suika02_Actions)
    endif
    set gg_trg_Suika03 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Suika03, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Suika03, Condition(function Trig_Suika03_Conditions))
    call TriggerAddAction(gg_trg_Suika03, function Trig_Suika03_Actions)
    set gg_trg_Suika04 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Suika04, h, EVENT_UNIT_SPELL_FINISH)
    call TriggerAddCondition(gg_trg_Suika04, Condition(function Trig_Suika04_Conditions))
    call TriggerAddAction(gg_trg_Suika04, function Trig_Suika04_Actions)
    call AddingLBuff(0, 'A15T', 'BHtv')
    set h = null
endfunction

function InitTrig_Initial_Suika takes nothing returns nothing
    set gg_trg_Initial_Suika = CreateTrigger()
    call TriggerAddAction(gg_trg_Initial_Suika, function Trig_Initial_Suika_Actions)
endfunction