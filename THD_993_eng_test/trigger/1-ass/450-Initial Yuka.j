function Trig_Initial_Yuka_Actions takes nothing returns nothing
    local unit h = GetCharacterHandle('N00L')
    if h == null then
        return
    endif
    call DebugMsg(GetHeroProperName(h) + " skill initialization completed")
    call UnitInitAddAttack(h)
    call SetHeroLifeIncreaseValue(h, 30)
    call SetHeroManaIncreaseValue(h, 10)
    call SetHeroManaBaseRegenValue(h, 0.6)
    set udg_SK_Yuka = h
    set gg_trg_YukaFlower = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_YukaFlower, h, EVENT_UNIT_SUMMON)
    call TriggerAddCondition(gg_trg_YukaFlower, Condition(function YukaFlower_ID))
    call TriggerAddAction(gg_trg_YukaFlower, function YukaFlower_Actions)
    set gg_trg_Yuka01 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Yuka01, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Yuka01, Condition(function Trig_Yuka01_Conditions))
    call TriggerAddAction(gg_trg_Yuka01, function Trig_Yuka01_Actions)
    set gg_trg_Yuka02 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Yuka02, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Yuka02, Condition(function Trig_Yuka02_Conditions))
    call TriggerAddAction(gg_trg_Yuka02, function Trig_Yuka02_Actions)
    set gg_trg_Yuka04 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Yuka04, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerRegisterPlayerUnitEvent(gg_trg_Yuka04, GetOwningPlayer(h), EVENT_PLAYER_UNIT_SUMMON, null)
    call TriggerRegisterPlayerUnitEvent(gg_trg_Yuka04, GetOwningPlayer(h), EVENT_PLAYER_UNIT_DEATH, null)
    call TriggerAddCondition(gg_trg_Yuka04, Condition(function Trig_Yuka04_Conditions))
    call TriggerAddAction(gg_trg_Yuka04, function Trig_Yuka04_Actions)
    set h = null
endfunction

function InitTrig_Initial_Yuka takes nothing returns nothing
    set gg_trg_Initial_Yuka = CreateTrigger()
    call TriggerAddAction(gg_trg_Initial_Yuka, function Trig_Initial_Yuka_Actions)
endfunction