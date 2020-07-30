function Trig_Mokou02_Conditions takes nothing returns boolean
    if GetTriggerEventId() == EVENT_UNIT_DEATH then
        call SaveInteger(udg_sht, GetHandleId(GetTriggerUnit()), 0, 0)
        call UnitRemoveAbility(GetTriggerUnit(), udg_SK_Mokou02[0])
        call UnitRemoveAbility(GetTriggerUnit(), udg_SK_Mokou02[1])
        call UnitRemoveAbility(GetTriggerUnit(), udg_SK_Mokou02[2])
        call UnitRemoveAbility(GetTriggerUnit(), udg_SK_Mokou02[3])
        call UnitRemoveAbility(GetTriggerUnit(), udg_SK_Mokou02[4])
        return false
    endif
    if IsUnitIllusion(GetAttacker()) then
        return false
    elseif GetUnitAbilityLevel(GetAttacker(), 'A00N') == 0 then
        return false
    elseif IsUnitType(GetTriggerUnit(), UNIT_TYPE_STRUCTURE) then
        return false
    endif
    return true
endfunction

function Mokou02_Resolve takes unit u, integer x returns nothing
    local integer i = 5
    loop
    exitwhen i == 0
        set i = i - 1
        call UnitRemoveAbility(u, udg_SK_Mokou02[i])
        if GetBitBoolean(x, i) then
            call UnitAddAbility(u, udg_SK_Mokou02[i])
        endif
    endloop
endfunction

function Trig_Mokou02_Fade takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local integer x
    set task = GetHandleId(caster)
    set x = LoadInteger(udg_sht, task, 0)
    if x > 0 then
        set x = IMaxBJ(0, x - 3)
        call SaveInteger(udg_sht, task, 0, x)
        call Mokou02_Resolve(caster, x)
        call DisplayTextToPlayer(GetOwningPlayer(caster), 0, 0, I2S(R2I((GetUnitAttackSpeed(caster) - 1.0) * 100)) + "%")
    else
        call PauseTimer(t)
    endif
    set t = null
    set caster = null
endfunction

function Trig_Mokou02_Actions takes nothing returns nothing
    local unit caster = GetAttacker()
    local unit target = GetTriggerUnit()
    local integer task = GetHandleId(caster)
    local integer x = LoadInteger(udg_sht, task, 0)
    local integer precharge = LoadInteger(udg_sht, task, 1)
    local timer t = LoadTimerHandle(udg_sht, task, 0)
    local unit u = LoadUnitHandle(udg_sht, task, 1)
    call DisableTrigger(GetTriggeringTrigger())
    if precharge > 0 then
        set x = x + 3 * precharge
        call SaveInteger(udg_sht, task, 1, 0)
    endif
    if target != u then
        set x = x / 2
        call Mokou02_Resolve(caster, x)
        call SaveInteger(udg_sht, task, 0, x)
        call SaveUnitHandle(udg_sht, task, 1, target)
    else
        set x = IMinBJ(x + 3, 20)
        call Mokou02_Resolve(caster, x)
        call SaveInteger(udg_sht, task, 0, x)
    endif
    call DisplayTextToPlayer(GetOwningPlayer(caster), 0, 0, I2S(R2I((GetUnitAttackSpeed(caster) - 1.0) * 100)) + "%")
    call TimerStart(t, 3.0, true, function Trig_Mokou02_Fade)
    set caster = null
    set target = null
    set u = null
    set t = null
    call TriggerSleepAction(0.3)
    call EnableTrigger(GetTriggeringTrigger())
endfunction

function Trig_Mokou02_Learn_Conditions takes nothing returns boolean
    return GetLearnedSkill() == 'A00G'
endfunction

function Trig_Mokou02_Learn_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local timer t
    call DestroyTrigger(gg_trg_Mokou02)
    set gg_trg_Mokou02 = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Mokou02, EVENT_PLAYER_UNIT_ATTACKED)
    call TriggerRegisterUnitEvent(gg_trg_Mokou02, caster, EVENT_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_Mokou02, Condition(function Trig_Mokou02_Conditions))
    call TriggerAddAction(gg_trg_Mokou02, function Trig_Mokou02_Actions)
    set t = CreateTimer()
    call SaveUnitHandle(udg_ht, GetHandleId(t), 0, caster)
    call SaveTimerHandle(udg_sht, GetHandleId(caster), 0, t)
    call TimerStart(t, 3.0, true, function Trig_Mokou02_Fade)
    set caster = null
    set t = null
endfunction

function InitTrig_Mokou02 takes nothing returns nothing
endfunction