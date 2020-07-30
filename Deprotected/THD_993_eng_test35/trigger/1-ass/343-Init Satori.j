function Trig_Init_Satori_Actions takes nothing returns nothing
    local unit h = GetCharacterHandle('E015')
    local player w = GetOwningPlayer(h)
    local integer task = GetHandleId(h)
    local integer i
    if h == null then
        return
    endif
    call UnitAddAbility(h, 'A03B')
    call DebugMsg(GetHeroProperName(h) + " skill initialization completed")
    call SaveInteger(udg_sht, task, 0, 0)
    set i = 1
    loop
        call SaveUnitHandle(udg_sht, task, i, h)
        call SaveInteger(udg_sht, task, i, 0)
        set i = i + 1
    exitwhen i > 9
    endloop
    call SetHeroLifeIncreaseValue(h, 26)
    call SetHeroManaIncreaseValue(h, 4)
    call SetHeroManaBaseRegenValue(h, 0.2)
    set gg_trg_Satori01 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Satori01, h, EVENT_UNIT_SPELL_CAST)
    call TriggerRegisterUnitEvent(gg_trg_Satori01, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Satori01, Condition(function Trig_Satori01_Conditions))
    call TriggerAddAction(gg_trg_Satori01, function Trig_Satori01_Actions)
    set gg_trg_Satori01_Collect = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Satori01_Collect, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Satori01_Collect, Condition(function Trig_Satori01_Collect_Conditions))
    call TriggerAddAction(gg_trg_Satori01_Collect, function Trig_Satori01_Collect_Actions)
    call FlushChildHashtable(udg_sht, GetHandleId(gg_trg_Satori01_Collect))
    call SaveUnitHandle(udg_sht, GetHandleId(gg_trg_Satori01_Collect), 0, h)
    set gg_trg_Satori02 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Satori02, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Satori02, Condition(function Trig_Satori02_Conditions))
    call TriggerAddAction(gg_trg_Satori02, function Trig_Satori02_Actions)
    set gg_trg_Satori03 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Satori03, h, EVENT_UNIT_HERO_SKILL)
    call TriggerAddCondition(gg_trg_Satori03, Condition(function Trig_Satori03_Learn))
    set gg_trg_Satori04 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Satori04, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Satori04, Condition(function Trig_Satori04_Conditions))
    call TriggerAddAction(gg_trg_Satori04, function Trig_Satori04_Actions)
    call FirstAbilityInit('A0J0')
    call FirstAbilityInit('A0J5')
    call FirstAbilityInit('A0J1')
    call FirstAbilityInit('A0J2')
    call FirstAbilityInit('A0J3')
    call FirstAbilityInit('A0J4')
    set h = null
    set w = null
endfunction

function InitTrig_Init_Satori takes nothing returns nothing
    set gg_trg_Init_Satori = CreateTrigger()
    call TriggerAddAction(gg_trg_Init_Satori, function Trig_Init_Satori_Actions)
endfunction