function Trig_Initial_Cat_Actions takes nothing returns nothing
    local unit h = GetCharacterHandle('E00W')
    local trigger t
    local timer t2
    if h == null then
        return
    endif
    call DebugMsg(GetHeroProperName(h) + " skill initialization completed")
    call SetHeroLifeIncreaseValue(h, 25)
    call SetHeroManaIncreaseValue(h, 7)
    call SetHeroManaBaseRegenValue(h, 0.6)
    set t2 = CreateTimer()
    call SaveUnitHandle(udg_ht, GetHandleId(t2), 1, h)
    call TimerStart(t2, 0.5, true, function Rin04_Loop)
    set t2 = null
    call UnitAddAbility(h, 'A0X8')
    call UnitMakeAbilityPermanent(h, true, 'A0X8')
    set gg_trg_Cat01_Reg = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Cat01_Reg, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Cat01_Reg, Condition(function Trig_Cat01_Reg_Conditions))
    call TriggerAddAction(gg_trg_Cat01_Reg, function Trig_Cat01_Reg_Actions)
    if gg_trg_Cat01_BodyGet == null then
        set gg_trg_Cat01_BodyGet = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(gg_trg_Cat01_BodyGet, EVENT_PLAYER_UNIT_DEATH)
        call TriggerAddCondition(gg_trg_Cat01_BodyGet, Condition(function Trig_Cat01_BodyGet_Conditions))
    endif
    set gg_trg_Cat02 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Cat02, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Cat02, Condition(function Trig_zhenshan_Conditions))
    call TriggerAddAction(gg_trg_Cat02, function Trig_zhenshan_Actions)
    set gg_trg_Cat03 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Cat03, h, EVENT_UNIT_SUMMON)
    call TriggerAddCondition(gg_trg_Cat03, Condition(function Trig_Cat03_Conditions))
    call TriggerAddAction(gg_trg_Cat03, function Trig_Cat03_Actions)
    set gg_trg_Cat04 = CreateTrigger()
    call TriggerRegisterPlayerUnitEvent(gg_trg_Cat04, GetOwningPlayer(h), EVENT_PLAYER_UNIT_SPELL_EFFECT, null)
    call TriggerAddCondition(gg_trg_Cat04, Condition(function Trig_Rin04_Conditions))
    call TriggerAddAction(gg_trg_Cat04, function Trig_Rin04_Actions)
    set t = CreateTrigger()
    call TriggerRegisterPlayerUnitEvent(t, GetOwningPlayer(h), EVENT_PLAYER_UNIT_DEATH, null)
    call TriggerAddCondition(t, Condition(function Rin04_onDeath))
    set h = null
endfunction

function InitTrig_Initial_Cat takes nothing returns nothing
    set gg_trg_Initial_Cat = CreateTrigger()
    call TriggerAddAction(gg_trg_Initial_Cat, function Trig_Initial_Cat_Actions)
endfunction