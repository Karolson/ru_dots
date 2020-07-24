function Trig_Youmu02_Conditions takes nothing returns boolean
    if GetUnitAbilityLevel(GetEventDamageSource(), 'A05Y') == 0 then
        return false
    elseif IsUnitAlly(GetTriggerUnit(), GetOwningPlayer(GetEventDamageSource())) then
        return false
    elseif GetEventDamage() == 0 then
        return false
    elseif IsDamageNotUnitAttack(GetEventDamageSource()) then
        return false
    endif
    return true
endfunction

function Trig_Youmu02_Fade takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit target = LoadUnitHandle(udg_ht, task, 0)
    local integer i = LoadInteger(udg_ht, task, 1)
    local integer difflevel = LoadInteger(udg_ht, task, 2)
    local integer armorlevel
    if IsUnitDead(target) then
        call UnitRemoveAbility(target, 'A0RV')
        call FlushChildHashtable(udg_ht, task)
        call ReleaseTimer(t)
    elseif i == 0 then
        set armorlevel = GetUnitAbilityLevel(target, 'A0RV') - difflevel
        if armorlevel <= 0 then
            call UnitRemoveAbility(target, 'A0RV')
        else
            call SetUnitAbilityLevel(target, 'A0RV', armorlevel)
        endif
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    else
        call SaveInteger(udg_ht, task, 1, i - 1)
    endif
    set t = null
    set target = null
endfunction

function Trig_Youmu02_Actions takes nothing returns nothing
    local unit caster = GetEventDamageSource()
    local unit target = GetTriggerUnit()
    local unit u
    local timer t
    local boolean b
    local integer level
    local integer changelevel
    local integer armorlevel
    local integer oldlevel
    local integer difflevel
    if IsUnitType(target, UNIT_TYPE_STRUCTURE) == false and not IsUnitIllusion(caster) then
        set b = false
        set level = GetUnitAbilityLevel(caster, 'A05Y')
        set changelevel = level
        set oldlevel = GetUnitAbilityLevel(target, 'A0RV')
        set armorlevel = oldlevel + changelevel
        if armorlevel > level * 16 then
            set armorlevel = level * 16
        endif
        if armorlevel > oldlevel then
            set difflevel = armorlevel - oldlevel
            if GetUnitAbilityLevel(target, 'A0RV') == 0 then
                call UnitAddAbility(target, 'A0RV')
            endif
            call SetUnitAbilityLevel(target, 'A0RV', armorlevel)
            set b = true
        endif
        if b then
            set t = CreateTimer()
            call SaveUnitHandle(udg_ht, GetHandleId(t), 0, target)
            call SaveInteger(udg_ht, GetHandleId(t), 1, 8)
            if IsUnitType(target, UNIT_TYPE_STRUCTURE) then
                call SaveInteger(udg_ht, GetHandleId(t), 1, 2)
            endif
            call SaveInteger(udg_ht, GetHandleId(t), 2, difflevel)
            call TimerStart(t, 1.0, true, function Trig_Youmu02_Fade)
        endif
    endif
    call UnitPhysicalDamageTarget(caster, target, level * 6 + 6)
    set caster = null
    set target = null
    set u = null
    set t = null
endfunction

function InitTrig_Youmu02 takes nothing returns nothing
endfunction