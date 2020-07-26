function Trig_Jump7_Conditions takes nothing returns boolean
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

function Trig_Jump7_Actions takes nothing returns nothing
    local unit u = GetTriggerUnit()
    local location a = GetRectCenter(gg_rct_Jump7top)
    local location b = GetRectCenter(gg_rct_Jump7bot)
    local real ang = AngleBetweenPoints(a, b)
    local real dst = DistanceBetweenPoints(a, b)
    local effect e
    call DisableTrigger(gg_trg_Jump7)
    set e = AddSpecialEffectLoc("Abilities\\Spells\\Orc\\WarStomp\\WarStompCaster.mdl", a)
    call DestroyEffect(e)
    set e = AddSpecialEffectTarget("belt.mdl", u, "chest")
    call SetUnitFlag(u, 5, true)
    call JumpTimer(u, ang, dst, 1.2, 0.02, 300)
    call TriggerSleepAction(0.2)
    call EnableTrigger(gg_trg_Jump7)
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

function InitTrig_Jump7 takes nothing returns nothing
    set gg_trg_Jump7 = CreateTrigger()
    call YDWETriggerRegisterEnterRectSimpleNull(gg_trg_Jump7, gg_rct_Jump7top)
    call TriggerAddCondition(gg_trg_Jump7, Condition(function Trig_Jump7_Conditions))
    call TriggerAddAction(gg_trg_Jump7, function Trig_Jump7_Actions)
endfunction