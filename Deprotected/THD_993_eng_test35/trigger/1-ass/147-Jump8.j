function Jump_End takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit v = LoadUnitHandle(udg_ht, task, 1)
    local effect e = LoadEffectHandle(udg_ht, task, 2)
    call SetUnitFlag(v, 5, false)
    call DestroyEffect(e)
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Orc\\WarStomp\\WarStompCaster.mdl", GetUnitX(v), GetUnitY(v)))
    call PauseTimer(t)
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    set t = null
    set e = null
    set v = null
endfunction

function Jump_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local timer t2
    local real ang = LoadReal(udg_ht, task, 1)
    local real dst = LoadReal(udg_ht, task, 2)
    local real x = LoadReal(udg_ht, task, 3)
    local real y = LoadReal(udg_ht, task, 4)
    local unit v
    local group g = CreateGroup()
    local effect e
    call GroupEnumUnitsInRange(g, x, y, 150, null)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if GetCustomState(v, 5) != 0 == false and IsMobileUnit(v) then
            call SetUnitFlag(v, 5, true)
            call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Orc\\WarStomp\\WarStompCaster.mdl", GetUnitX(v), GetUnitY(v)))
            set e = AddSpecialEffectTarget("belt.mdl", v, "chest")
            call JumpTimer(v, ang, dst, 1.2, 0.02, 300)
            set t2 = CreateTimer()
            call SaveUnitHandle(udg_ht, GetHandleId(t2), 1, v)
            call SaveEffectHandle(udg_ht, GetHandleId(t2), 2, e)
            call TimerStart(t2, 1.2, false, function Jump_End)
            set t2 = null
            set e = null
        endif
    endloop
    call DestroyGroup(g)
    set v = null
    set g = null
    set t = null
endfunction

function Jump_Init takes rect r1, rect r2 returns nothing
    local timer t = CreateTimer()
    local location a = GetRectCenter(r1)
    local location b = GetRectCenter(r2)
    local real ang = AngleBetweenPoints(a, b)
    local real dst = DistanceBetweenPoints(a, b)
    local integer task = GetHandleId(t)
    call SaveReal(udg_ht, task, 1, ang)
    call SaveReal(udg_ht, task, 2, dst)
    call SaveReal(udg_ht, task, 3, GetLocationX(a))
    call SaveReal(udg_ht, task, 4, GetLocationY(a))
    call TimerStart(t, 0.2, true, function Jump_Main)
    call RemoveLocation(a)
    call RemoveLocation(b)
    set t = null
    set a = null
    set b = null
endfunction

function Trig_Jump8_Conditions takes nothing returns boolean
    if not IsUnitType(GetTriggerUnit(), UNIT_TYPE_HERO) then
        return false
    endif
    if GetCustomState(GetTriggerUnit(), 5) != 0 then
        return false
    endif
    if GetUnitTypeId(GetTriggerUnit()) == 'E01T' then
        return false
    endif
    if GetUnitTypeId(GetTriggerUnit()) == 'E02C' then
        return false
    endif
    if GetUnitTypeId(GetTriggerUnit()) == 'E041' then
        return false
    endif
    return IsMobileUnit(GetTriggerUnit())
endfunction

function Trig_Jump8_Actions takes nothing returns nothing
    local unit u = GetTriggerUnit()
    local location a = GetRectCenter(gg_rct_Jump8top)
    local location b = GetRectCenter(gg_rct_Jump8bot)
    local real ang = AngleBetweenPoints(a, b)
    local real dst = DistanceBetweenPoints(a, b)
    local effect e
    call DisableTrigger(gg_trg_Jump8)
    set e = AddSpecialEffectLoc("Abilities\\Spells\\Orc\\WarStomp\\WarStompCaster.mdl", a)
    call DestroyEffect(e)
    set e = AddSpecialEffectTarget("belt.mdl", u, "chest")
    call SetUnitFlag(u, 5, true)
    call JumpTimer(u, ang, dst, 1.2, 0.02, 300)
    call TriggerSleepAction(0.2)
    call EnableTrigger(gg_trg_Jump8)
    call TriggerSleepAction(0.8)
    call SetUnitFlag(u, 5, false)
    call DestroyEffect(e)
    set e = AddSpecialEffectLoc("Abilities\\Spells\\Orc\\WarStomp\\WarStompCaster.mdl", b)
    call DestroyEffect(e)
    call SetUnitState(u, UNIT_STATE_LIFE, 0.9 * GetUnitState(u, UNIT_STATE_LIFE))
    call RemoveLocation(a)
    call RemoveLocation(b)
    set u = null
    set a = null
    set b = null
    set e = null
endfunction

function InitTrig_Jump8 takes nothing returns nothing
    set gg_trg_Jump8 = CreateTrigger()
    call YDWETriggerRegisterEnterRectSimpleNull(gg_trg_Jump8, gg_rct_Jump8top)
    call TriggerAddCondition(gg_trg_Jump8, Condition(function Trig_Jump8_Conditions))
    call TriggerAddAction(gg_trg_Jump8, function Trig_Jump8_Actions)
endfunction