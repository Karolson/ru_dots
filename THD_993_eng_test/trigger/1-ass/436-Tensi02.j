function Trig_Tensi02_Conditions takes nothing returns boolean
    return GetLearnedSkill() == 'A071'
endfunction

function Trig_Tensi02_Active_Conditions takes nothing returns boolean
    return GetUnitTypeId(GetAttacker()) == 'H002' and IsUnitIllusion(GetAttacker()) == false
endfunction

function Trig_Tensi02_Active_Actions takes nothing returns nothing
    local unit caster = GetAttacker()
    local unit target = GetTriggerUnit()
    local real px = GetUnitX(target)
    local real py = GetUnitY(target)
    local unit u
    local integer level = GetUnitAbilityLevel(caster, 'A071')
    call DisableTrigger(gg_trg_Tensi02)
    call SetUnitAnimation(caster, "attack slam")
    call TriggerSleepAction(0.1)
    set u = NewDummy(GetOwningPlayer(caster), GetUnitX(target), GetUnitY(target), 0.0)
    call UnitAddAbility(u, 'A072')
    call SetUnitAbilityLevel(u, 'A072', GetUnitAbilityLevel(caster, 'A071'))
    call IssueImmediateOrder(u, "stomp")
    call UnitRemoveAbility(u, 'A072')
    call ReleaseDummy(u)
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Orc\\WarStomp\\WarStompCaster.mdl", px, py))
    if GetUnitAbilityLevel(caster, 'B003') != 0 then
        call UnitStunArea(caster, 0.6 + 0.45 + 0.15 * level, px, py, 260 + 40 * level, 0, 0)
    else
        call UnitStunArea(caster, 0.4 + 0.1 * level, px, py, 260 + 40 * level, 0, 0)
    endif
    if GetUnitAbilityLevel(caster, 'B069') != 0 then
        call UnitPhysicalDamageArea(caster, px, py, 260 + 40 * level, ABCIExtraAtk(caster, 130 + 20 * level, 0.8))
    else
        call UnitPhysicalDamageArea(caster, px, py, 260 + 40 * level, ABCIExtraAtk(caster, 40 + 20 * level, 0.8))
    endif
    call SaveInteger(udg_sht, GetHandleId(caster), 0, 0)
    set caster = null
    set target = null
    set u = null
endfunction

function Trig_Tensi02_Orbitting_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit u = LoadUnitHandle(udg_ht, task, 1)
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real px
    local real py
    local integer i = LoadInteger(udg_ht, task, 1)
    local integer k = LoadInteger(udg_sht, GetHandleId(caster), 0)
    if GetWidgetLife(caster) > 0.405 and k >= 1 then
        set px = ox + 80.0 * Cos(i * 2.0 * 0.017454)
        set py = oy + 80.0 * Sin(i * 2.0 * 0.017454)
        call SetUnitX(u, px)
        call SetUnitY(u, py)
        if IsUnitVisible(caster, GetLocalPlayer()) == false then
            call SetUnitVertexColor(u, 255, 255, 255, 0)
        else
            call SetUnitVertexColor(u, 255, 255, 255, 255)
        endif
        if GetUnitAbilityLevel(caster, 'B005') + GetUnitAbilityLevel(caster, 'B00M') + GetUnitAbilityLevel(caster, 'B01P') + GetUnitAbilityLevel(caster, 'Binv') > 0 then
            if GetUnitAbilityLevel(caster, 'A0LI') < 0 then
                call UnitAddAbility(u, 'A0LI')
            endif
        else
            if GetUnitAbilityLevel(caster, 'A0LI') > 0 then
                call UnitRemoveAbility(u, 'A0LI')
            endif
        endif
        call SaveInteger(udg_ht, task, 1, i + 1)
    else
        call KillUnit(u)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set u = null
endfunction

function Trig_Tensi02_Orbitting takes unit h returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local unit u
    set u = CreateUnit(GetOwningPlayer(h), 'n02R', GetUnitX(h), GetUnitY(h), 270.0)
    call SaveUnitHandle(udg_ht, task, 0, h)
    call SaveUnitHandle(udg_ht, task, 1, u)
    call SaveInteger(udg_ht, task, 1, 0)
    call TimerStart(t, 0.02, true, function Trig_Tensi02_Orbitting_Main)
    set t = null
    set h = null
    set u = null
endfunction

function Trig_Tensi02_Charge_Actions takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_sht, task, 0)
    local integer k = LoadInteger(udg_sht, task, 0)
    local real period
    if not IsTriggerEnabled(gg_trg_Tensi02) and GetWidgetLife(caster) > 0.405 then
        if k == 0 then
            call EnableTrigger(gg_trg_Tensi02)
            call SaveInteger(udg_sht, task, 0, 1)
            call SaveInteger(udg_sht, GetHandleId(caster), 0, 1)
            call TimerStart(t, 1.0, false, function Trig_Tensi02_Charge_Actions)
            call SaveInteger(udg_sht, GetHandleId(caster), 0, 1)
            call Trig_Tensi02_Orbitting(caster)
        else
            call SaveInteger(udg_sht, task, 0, 0)
            set period = 3 + 8000.0 / GetUnitState(caster, UNIT_STATE_MAX_LIFE)
            call TimerStart(t, period, false, function Trig_Tensi02_Charge_Actions)
        endif
    else
        if GetWidgetLife(caster) > 0.405 then
            call TimerStart(t, 1.0, false, function Trig_Tensi02_Charge_Actions)
        else
            call DisableTrigger(gg_trg_Tensi02)
            call SaveInteger(udg_sht, task, 0, 0)
            call TimerStart(t, 1.0, false, function Trig_Tensi02_Charge_Actions)
        endif
    endif
    set t = null
    set caster = null
endfunction

function Trig_Tensi02_Learn takes nothing returns nothing
    local unit caster = GetLearningUnit()
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local real period
    call SaveUnitHandle(udg_sht, task, 0, caster)
    call SaveInteger(udg_sht, task, 0, 0)
    set period = 2 + 7200.0 / GetUnitState(caster, UNIT_STATE_MAX_LIFE)
    call TimerStart(t, period, false, function Trig_Tensi02_Charge_Actions)
    call DisableTrigger(gg_trg_Tensi02)
    call DestroyTrigger(gg_trg_Tensi02)
    set gg_trg_Tensi02 = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Tensi02, EVENT_PLAYER_UNIT_ATTACKED)
    call TriggerAddCondition(gg_trg_Tensi02, Condition(function Trig_Tensi02_Active_Conditions))
    call TriggerAddAction(gg_trg_Tensi02, function Trig_Tensi02_Active_Actions)
    call DisableTrigger(gg_trg_Tensi02)
    set task = GetHandleId(gg_trg_Tensi02)
    call SaveUnitHandle(udg_sht, task, 0, caster)
    set caster = null
    set t = null
endfunction

function InitTrig_Tensi02 takes nothing returns nothing
endfunction