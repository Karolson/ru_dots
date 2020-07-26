function Trig_Init_Momizi_Actions takes nothing returns nothing
    local unit h = GetCharacterHandle('O00A')
    local unit u
    if h == null then
        return
    endif
    call DebugMsg(GetHeroProperName(h) + " skill initialization completed")
    if not udg_Repick then
        call DestroyTrigger(GetTriggeringTrigger())
    endif
    call SetHeroLifeIncreaseValue(h, 26)
    call SetHeroManaIncreaseValue(h, 6)
    call SetHeroManaBaseRegenValue(h, 0.5)
    call SetPlayerAbilityAvailable(GetOwningPlayer(h), 'A0PH', false)
    call DisableTrigger(gg_trg_Momizi01)
    call DestroyTrigger(gg_trg_Momizi01)
    set gg_trg_Momizi01 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Momizi01, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Momizi01, Condition(function Trig_Momizi01_Conditions))
    call TriggerAddAction(gg_trg_Momizi01, function Trig_Momizi01_Actions)
    call DisableTrigger(gg_trg_Momiji01_Death)
    call DestroyTrigger(gg_trg_Momiji01_Death)
    set gg_trg_Momiji01_Death = CreateTrigger()
    call TriggerAddCondition(gg_trg_Momiji01_Death, Condition(function Trig_Momiji01_Death_Conditions))
    call TriggerRegisterUnitEvent(gg_trg_Momiji01_Death, h, EVENT_UNIT_DEATH)
    call DisableTrigger(gg_trg_Momizi02)
    call DestroyTrigger(gg_trg_Momizi02)
    set gg_trg_Momizi02 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Momizi02, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Momizi02, Condition(function Trig_Momizi02_Conditions))
    call TriggerAddAction(gg_trg_Momizi02, function Trig_Momizi02_Actions)
    call DisableTrigger(gg_trg_Momizi02_Learn)
    call DestroyTrigger(gg_trg_Momizi02_Learn)
    set gg_trg_Momizi02_Learn = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Momizi02_Learn, h, EVENT_UNIT_HERO_SKILL)
    call TriggerAddCondition(gg_trg_Momizi02_Learn, Condition(function Trig_Momizi02_Learn_Conditions))
    call TriggerAddAction(gg_trg_Momizi02_Learn, function Trig_Momizi02_Learn_Actions)
    call UnitInitAddAttack(h)
    call DisableTrigger(gg_trg_Momizi03)
    call DestroyTrigger(gg_trg_Momizi03)
    set gg_trg_Momizi03 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Momizi03, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Momizi03, Condition(function Trig_Momizi03_Conditions))
    call TriggerAddAction(gg_trg_Momizi03, function Trig_Momizi03_Actions)
    call Preload("units\\creeps\\WhiteWolf\\WhiteWolf.mdx")
    call Preload("units\\creeps\\WhiteWolf\\WhiteWolf.blp")
    call Preload("Textures\\RibbonBlur1.blp")
    call Preload("Textures\\gutz.blp")
    call PreloadEnd(2.5)
    set u = null
    set h = null
endfunction

function InitTrig_Init_Momizi takes nothing returns nothing
    set gg_trg_Init_Momizi = CreateTrigger()
    call TriggerAddAction(gg_trg_Init_Momizi, function Trig_Init_Momizi_Actions)
endfunction