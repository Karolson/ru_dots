function Trig_Orange04_Attack_Conditions takes nothing returns boolean
    local unit caster = GetEventDamageSource()
    local unit target = GetTriggerUnit()
    if IsUnitAlly(GetTriggerUnit(), GetOwningPlayer(GetEventDamageSource())) then
        return false
    endif
    if GetEventDamage() == 0 then
        return false
    endif
    if IsDamageNotUnitAttack(GetEventDamageSource()) then
        return false
    endif
    if IsUnitType(target, UNIT_TYPE_HERO) and GetUnitTypeId(caster) == 'E01I' then
        set caster = null
        set target = null
        call DebugMsg("Chen04 Hit")
        return true
    endif
    set caster = null
    set target = null
    return false
endfunction

function Trig_Orange04_Attack_Actions_Stage2 takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_sht, task, 0)
    local integer ctask = LoadInteger(udg_sht, task, 1)
    local unit target = LoadUnitHandle(udg_sht, task, 2)
    local integer increase = LoadInteger(udg_sht, task, 3)
    local timer t2
    local integer task2
    local integer total
    if HaveSavedHandle(udg_sht, ctask, 0) then
        set t2 = LoadTimerHandle(udg_sht, ctask, 0)
        set total = LoadInteger(udg_sht, ctask, 1)
        call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\HydraliskImpact\\HydraliskImpact.mdl", GetUnitX(target), GetUnitY(target)))
        call UnitAddAttackDamage(caster, increase)
        set total = total + increase
        call SetUnitScale(udg_SK_Chen04, 1 + total / 150, 1 + total / 150, 1 + total / 150)
        call SaveInteger(udg_sht, ctask, 1, total)
        call TimerStart(t2, 6.0, false, function Trig_Orange04_Clear)
        call DebugMsg("Timer Restarted")
        call DebugMsg("Attack Bonus: " + I2S(total))
    else
        set t2 = CreateTimer()
        set task2 = GetHandleId(t2)
        call SaveTimerHandle(udg_sht, ctask, 0, t2)
        call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\HydraliskImpact\\HydraliskImpact.mdl", GetUnitX(target), GetUnitY(target)))
        call UnitAddAttackDamage(caster, increase)
        call SaveInteger(udg_sht, ctask, 1, increase)
        call SaveUnitHandle(udg_sht, task2, 0, caster)
        call SaveInteger(udg_sht, task2, 0, ctask)
        call TimerStart(t2, 6.0, false, function Trig_Orange04_Clear)
        call DebugMsg("Timer Started")
        call DebugMsg("Attack Bonus: " + I2S(LoadInteger(udg_sht, ctask, 1)))
    endif
    call FlushChildHashtable(udg_sht, task)
    call ReleaseTimer(t)
    set t = null
    set t2 = null
    set caster = null
    set target = null
endfunction

function Trig_Orange04_Attack_Actions takes nothing returns nothing
    local unit caster = GetEventDamageSource()
    local integer ctask = GetHandleId(caster)
    local unit target = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A0TO')
    local integer increase = level * 15
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    if udg_SK_Chen04 == null then
        set udg_SK_Chen04 = CreateUnit(GetOwningPlayer(caster), 'o010', GetUnitX(caster), GetUnitY(caster), 0)
        call IssueTargetOrder(udg_SK_Chen04, "move", caster)
    endif
    call SaveUnitHandle(udg_sht, task, 0, caster)
    call SaveInteger(udg_sht, task, 1, ctask)
    call SaveUnitHandle(udg_sht, task, 2, target)
    call SaveInteger(udg_sht, task, 3, increase)
    call TimerStart(t, 0.0, false, function Trig_Orange04_Attack_Actions_Stage2)
    set caster = null
    set target = null
    set t = null
endfunction

function InitTrig_Orange04_Attack takes nothing returns nothing
endfunction