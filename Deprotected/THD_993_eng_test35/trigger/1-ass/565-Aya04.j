function Trig_Aya04_Lv3_Use_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A05O'
endfunction

function Trig_Aya04_Lv3_Use_Actions_Loop takes nothing returns nothing
    local trigger trg = GetTriggeringTrigger()
    local integer task = GetHandleId(trg)
    local unit u = LoadUnitHandle(udg_sht, task, 0)
    local timer tmloop = LoadTimerHandle(udg_sht, task, 1)
    local timer tmstop = LoadTimerHandle(udg_sht, task, 2)
    local real ux = GetUnitX(u)
    local real uy = GetUnitY(u)
    local real lx
    local real ly
    local unit target
    local integer i = GetUnitCurrentOrder(u)
    local integer level = GetUnitAbilityLevel(u, 'A05O')
    if TimerGetRemaining(tmstop) < 60.5 - GetUnitAbilityLevel(u, 'A1CK') * 0.5 - 2 - level then
        call ReleaseTimer(tmloop)
        call ReleaseTimer(tmstop)
        call TriggerRemoveAction(trg, LoadTriggerActionHandle(udg_sht, task, 3))
        call UnitRemoveAbility(u, 'A1CK')
        call DebugMsg("Aya04End")
        call FlushChildHashtable(udg_sht, task)
        call DisableTrigger(trg)
        call DestroyTrigger(trg)
        set trg = null
        set tmloop = null
        set tmstop = null
        set u = null
        set target = null
        return
    endif
    if GetTriggerEventId() == EVENT_UNIT_ISSUED_TARGET_ORDER then
        if i == 851971 then
            set target = GetOrderTargetUnit()
            set lx = GetUnitX(target)
            set ly = GetUnitY(target)
            call SaveInteger(udg_sht, task, 4, 1)
            call SaveUnitHandle(udg_sht, task, 5, target)
        endif
    elseif GetTriggerEventId() == EVENT_UNIT_ISSUED_POINT_ORDER then
        if i == 851971 then
            set lx = GetOrderPointX()
            set ly = GetOrderPointY()
            call SaveInteger(udg_sht, task, 4, 2)
            call SaveReal(udg_sht, task, 5, lx)
            call SaveReal(udg_sht, task, 6, ly)
        endif
    endif
    if TimerGetRemaining(tmloop) > 0 then
        set tmloop = null
        set tmstop = null
        set u = null
        set target = null
        set trg = null
        return
    endif
    if GetTriggerEventId() == EVENT_GAME_TIMER_EXPIRED and i == 851971 then
        if LoadInteger(udg_sht, task, 4) == 1 then
            set target = LoadUnitHandle(udg_sht, task, 5)
            set lx = GetUnitX(target)
            set ly = GetUnitY(target)
        elseif LoadInteger(udg_sht, task, 4) == 2 then
            set lx = LoadReal(udg_sht, task, 5)
            set ly = LoadReal(udg_sht, task, 6)
        endif
    endif
    if i == 851971 then
        if IsUnitInRangeXY(u, lx, ly, 160.0) then
            call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\NightElf\\Blink\\BlinkCaster.mdl", u, "chest"))
            call SetUnitX(u, ux + SquareRoot((lx - ux) * (lx - ux) + (ly - uy) * (ly - uy)) * Cos(Atan2(ly - uy, lx - ux)))
            call SetUnitY(u, uy + SquareRoot((lx - ux) * (lx - ux) + (ly - uy) * (ly - uy)) * Sin(Atan2(ly - uy, lx - ux)))
            call TimerStart(tmloop, 0.3, false, null)
        else
            call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\NightElf\\Blink\\BlinkCaster.mdl", u, "chest"))
            call SetUnitX(u, ux + 160 * Cos(Atan2(ly - uy, lx - ux)))
            call SetUnitY(u, uy + 160 * Sin(Atan2(ly - uy, lx - ux)))
            call TimerStart(tmloop, 0.3, false, null)
        endif
    endif
    set tmloop = null
    set tmstop = null
    set target = null
    set u = null
    set trg = null
endfunction

function Trig_Aya04_Lv3_Use_Actions takes nothing returns nothing
    local trigger t
    local triggeraction ta
    local timer tmloop
    local timer tmstop
    local integer task
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A05O')
    call VE_Spellcast(caster)
    if udg_GameMode / 100 != 3 and udg_NewMid == false then
        call AbilityCoolDownResetion(caster, 'A05O', 110 - 10 * level)
    else
        call AbilityCoolDownResetion(caster, 'A05O', (110 - 10 * level) * 0.65)
    endif
    if GetUnitAbilityLevel(caster, 'A05K') != 0 then
        call AbilityCoolDownResetion(caster, 'A05K', 0.05)
    endif
    if GetUnitAbilityLevel(caster, 'A0V4') == 1 or GetUnitAbilityLevel(caster, 'A0A1') == 1 then
        set t = null
        set ta = null
        set caster = null
        set tmloop = null
        set tmstop = null
        return
    endif
    call UnitAddAbility(caster, 'A1CK')
    set t = CreateTrigger()
    set tmloop = CreateTimer()
    set tmstop = CreateTimer()
    set task = GetHandleId(t)
    call SaveUnitHandle(udg_sht, task, 0, caster)
    call SaveTimerHandle(udg_sht, task, 1, tmloop)
    call SaveTimerHandle(udg_sht, task, 2, tmstop)
    set ta = TriggerAddAction(t, function Trig_Aya04_Lv3_Use_Actions_Loop)
    call SaveTriggerActionHandle(udg_sht, task, 3, ta)
    call TriggerRegisterUnitEvent(t, caster, EVENT_UNIT_ISSUED_TARGET_ORDER)
    call TriggerRegisterUnitEvent(t, caster, EVENT_UNIT_ISSUED_POINT_ORDER)
    call TriggerRegisterTimerExpireEvent(t, tmloop)
    call TimerStart(tmstop, 60.0, false, null)
    set t = null
    set tmloop = null
    set tmstop = null
    set ta = null
    set caster = null
endfunction

function Trig_Aya04_Learn_Conditions takes nothing returns boolean
    return GetLearnedSkill() == 'A05O'
endfunction

function Trig_Aya04_Learn_Actions takes nothing returns nothing
    local trigger trg
    local unit u = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(u, 'A05O')
    if level >= 1 then
        call DisableTrigger(gg_trg_Aya04)
        call DestroyTrigger(gg_trg_Aya04)
        set gg_trg_Aya04 = CreateTrigger()
        call TriggerAddCondition(gg_trg_Aya04, Condition(function Trig_Aya04_Lv3_Use_Conditions))
        call TriggerAddAction(gg_trg_Aya04, function Trig_Aya04_Lv3_Use_Actions)
        call TriggerRegisterUnitEvent(gg_trg_Aya04, u, EVENT_UNIT_SPELL_EFFECT)
    endif
    set trg = null
    set u = null
endfunction

function InitTrig_Aya04 takes nothing returns nothing
endfunction