function SeigaEX_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit h = LoadUnitHandle(udg_ht, task, 0)
    local real x = LoadReal(udg_ht, task, 0)
    local real y = LoadReal(udg_ht, task, 1)
    local real px = GetUnitX(h)
    local real py = GetUnitY(h)
    if IsTerrainPathable(px, py, PATHING_TYPE_FLYABILITY) then
        call SetUnitX(h, x)
        call SetUnitY(h, y)
        set t = null
        set h = null
        return
    endif
    if IsTerrainPathable(px, py, PATHING_TYPE_AMPHIBIOUSPATHING) == false and IsTerrainPathable(px, py, PATHING_TYPE_WALKABILITY) then
        call SetUnitX(h, x)
        call SetUnitY(h, y)
        set t = null
        set h = null
        return
    endif
    call SaveReal(udg_ht, task, 0, px)
    call SaveReal(udg_ht, task, 1, py)
    set t = null
    set h = null
endfunction

function Seiga_Fix_Pathing takes nothing returns nothing
    call SetUnitPathing(GetTriggerUnit(), false)
endfunction

function Trig_Initialing_Seiga_Actions takes nothing returns nothing
    local unit h = GetCharacterHandle('H02K')
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local real x = GetUnitX(h)
    local real y = GetUnitY(h)
    local trigger seiga_fix_pathing
    call FirstAbilityInit('A1FJ')
    call FirstAbilityInit('A1FI')
    call FirstAbilityInit('A1FK')
    call FirstAbilityInit('A1FL')
    call FirstAbilityInit('A1FH')
    call FirstAbilityInit('A1FM')
    if h == null then
        return
    endif
    call DebugMsg(GetHeroProperName(h) + " skill initialization completed")
    if not udg_Repick then
        call DestroyTrigger(GetTriggeringTrigger())
    endif
    call DisableTrigger(gg_trg_Seiga01)
    call DestroyTrigger(gg_trg_Seiga01)
    set gg_trg_Seiga01 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Seiga01, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Seiga01, Condition(function Trig_Seiga01_Conditions))
    call TriggerAddAction(gg_trg_Seiga01, function Trig_Seiga01_Actions)
    call DisableTrigger(gg_trg_Seiga02)
    call DestroyTrigger(gg_trg_Seiga02)
    set gg_trg_Seiga02 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Seiga02, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Seiga02, Condition(function Trig_Seiga02_Conditions))
    call TriggerAddAction(gg_trg_Seiga02, function Trig_Seiga02_Actions)
    call DisableTrigger(gg_trg_Seiga03)
    call DestroyTrigger(gg_trg_Seiga03)
    set gg_trg_Seiga03 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Seiga03, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Seiga03, Condition(function Trig_Seiga03_Conditions))
    call TriggerAddAction(gg_trg_Seiga03, function Trig_Seiga03_Actions)
    call DisableTrigger(gg_trg_Seiga04)
    call DestroyTrigger(gg_trg_Seiga04)
    set gg_trg_Seiga04 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Seiga04, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Seiga04, Condition(function Trig_Seiga04_Conditions))
    call TriggerAddAction(gg_trg_Seiga04, function Trig_Seiga04_Actions)
    call SetUnitPathing(h, false)
    set seiga_fix_pathing = CreateTrigger()
    call TriggerRegisterUnitEvent(seiga_fix_pathing, h, EVENT_UNIT_HERO_REVIVE_FINISH)
    call TriggerAddAction(seiga_fix_pathing, function Seiga_Fix_Pathing)
    call SetHeroLifeIncreaseValue(h, 25)
    call SaveReal(udg_ht, task, 0, x)
    call SaveReal(udg_ht, task, 1, y)
    call SaveUnitHandle(udg_ht, task, 0, h)
    call TimerStart(t, 0.1, true, function SeigaEX_Main)
    set h = null
    set t = null
endfunction

function InitTrig_Initialing_Seiga takes nothing returns nothing
    set gg_trg_Initialing_Seiga = CreateTrigger()
    call TriggerAddAction(gg_trg_Initialing_Seiga, function Trig_Initialing_Seiga_Actions)
endfunction