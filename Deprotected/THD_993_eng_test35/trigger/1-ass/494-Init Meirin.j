function Trig_Init_Meirin_Actions takes nothing returns nothing
    local integer i
    local unit h = GetCharacterHandle('E013')
    if h == null then
        set h = GetCharacterHandle('E03J')
    endif
    if h == null then
        return
    endif
    call DebugMsg(GetHeroProperName(h) + " skill initialization completed")
    if not udg_Repick then
        call DestroyTrigger(GetTriggeringTrigger())
    endif
    call SetHeroLifeIncreaseValue(h, 33)
    call SetHeroManaIncreaseValue(h, 5)
    call SetHeroManaBaseRegenValue(h, 0.5)
    call DisableTrigger(gg_trg_MeirinDS)
    call DestroyTrigger(gg_trg_MeirinDS)
    set gg_trg_MeirinDS = CreateTrigger()
    call TriggerRegisterPlayerEvent(gg_trg_MeirinDS, GetOwningPlayer(h), EVENT_PLAYER_END_CINEMATIC)
    call TriggerAddCondition(gg_trg_MeirinDS, Condition(function Trig_MeirinDS_Conditions))
    call TriggerAddAction(gg_trg_MeirinDS, function Trig_MeirinDS_Actions)
    set gg_trg_Meirin = null
    call DisableTrigger(gg_trg_Meirin01)
    call DestroyTrigger(gg_trg_Meirin01)
    set gg_trg_Meirin01 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Meirin01, h, EVENT_UNIT_HERO_SKILL)
    call TriggerAddCondition(gg_trg_Meirin01, Condition(function Trig_Meirin01_Learn_Conditions))
    call TriggerAddAction(gg_trg_Meirin01, function Trig_Meirin01_Learn_Actions)
    call DisableTrigger(gg_trg_Meirin02)
    call DestroyTrigger(gg_trg_Meirin02)
    set gg_trg_Meirin02 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Meirin02, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Meirin02, Condition(function Trig_Meirin02_Conditions))
    call TriggerAddAction(gg_trg_Meirin02, function Trig_Meirin02_Actions)
    call DisableTrigger(gg_trg_Meirin03)
    call DestroyTrigger(gg_trg_Meirin03)
    set gg_trg_Meirin03 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Meirin03, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Meirin03, Condition(function Trig_Meirin03_Conditions))
    call TriggerAddAction(gg_trg_Meirin03, function Trig_Meirin03_Actions)
    call DisableTrigger(gg_trg_Meirin04)
    call DestroyTrigger(gg_trg_Meirin04)
    set gg_trg_Meirin04 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Meirin04, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Meirin04, Condition(function Trig_Meirin04_Conditions))
    call TriggerAddAction(gg_trg_Meirin04, function Trig_Meirin04_Actions)
    set i = 0
    set udg_SK_Meirin_RGB[i + 0] = 255
    set udg_SK_Meirin_RGB[i + 1] = 0
    set udg_SK_Meirin_RGB[i + 2] = 0
    set i = i + 3
    set udg_SK_Meirin_RGB[i + 0] = 255
    set udg_SK_Meirin_RGB[i + 1] = 127
    set udg_SK_Meirin_RGB[i + 2] = 0
    set i = i + 3
    set udg_SK_Meirin_RGB[i + 0] = 255
    set udg_SK_Meirin_RGB[i + 1] = 255
    set udg_SK_Meirin_RGB[i + 2] = 0
    set i = i + 3
    set udg_SK_Meirin_RGB[i + 0] = 127
    set udg_SK_Meirin_RGB[i + 1] = 255
    set udg_SK_Meirin_RGB[i + 2] = 0
    set i = i + 3
    set udg_SK_Meirin_RGB[i + 0] = 0
    set udg_SK_Meirin_RGB[i + 1] = 255
    set udg_SK_Meirin_RGB[i + 2] = 0
    set i = i + 3
    set udg_SK_Meirin_RGB[i + 0] = 0
    set udg_SK_Meirin_RGB[i + 1] = 255
    set udg_SK_Meirin_RGB[i + 2] = 127
    set i = i + 3
    set udg_SK_Meirin_RGB[i + 0] = 0
    set udg_SK_Meirin_RGB[i + 1] = 255
    set udg_SK_Meirin_RGB[i + 2] = 255
    set i = i + 3
    set udg_SK_Meirin_RGB[i + 0] = 0
    set udg_SK_Meirin_RGB[i + 1] = 127
    set udg_SK_Meirin_RGB[i + 2] = 255
    set i = i + 3
    set udg_SK_Meirin_RGB[i + 0] = 0
    set udg_SK_Meirin_RGB[i + 1] = 0
    set udg_SK_Meirin_RGB[i + 2] = 255
    set i = i + 3
    set udg_SK_Meirin_RGB[i + 0] = 127
    set udg_SK_Meirin_RGB[i + 1] = 0
    set udg_SK_Meirin_RGB[i + 2] = 255
    set i = i + 3
    set udg_SK_Meirin_RGB[i + 0] = 255
    set udg_SK_Meirin_RGB[i + 1] = 0
    set udg_SK_Meirin_RGB[i + 2] = 255
    set i = i + 3
    set udg_SK_Meirin_RGB[i + 0] = 255
    set udg_SK_Meirin_RGB[i + 1] = 0
    set udg_SK_Meirin_RGB[i + 2] = 127
    set h = null
endfunction

function InitTrig_Init_Meirin takes nothing returns nothing
    set gg_trg_Init_Meirin = CreateTrigger()
    call TriggerAddAction(gg_trg_Init_Meirin, function Trig_Init_Meirin_Actions)
endfunction