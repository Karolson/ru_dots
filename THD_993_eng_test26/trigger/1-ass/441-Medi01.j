function Trig_Medi01_Conditions takes nothing returns boolean
    if GetUnitAbilityLevel(GetEventDamageSource(), 'B07I') == 0 or GetUnitState(GetEventDamageSource(), UNIT_STATE_MANA) < 6 then
        return false
    elseif IsUnitIllusion(GetEventDamageSource()) then
        return false
    elseif IsUnitType(GetTriggerUnit(), UNIT_TYPE_STRUCTURE) then
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

function Trig_Medi01_Damage takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit target = LoadUnitHandle(udg_ht, task, 1)
    local real damage = LoadReal(udg_ht, task, 2)
    call UnitMagicDamageTarget(caster, target, damage, 2)
    if GetUnitAbilityLevel(target, 'B076') == 0 then
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set target = null
endfunction

function Trig_Medi01_Actions takes nothing returns nothing
    local unit caster = GetEventDamageSource()
    local unit target = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A0EE')
    local real damage = ABCIExtraInt(caster, 5 + 5 * level, 0.4)
    local timer t
    local integer task
    call SetUnitState(caster, UNIT_STATE_MANA, GetUnitState(caster, UNIT_STATE_MANA) - (5 + 3 * level))
    call UnitMagicDamageTarget(caster, target, damage, 2)
    if GetUnitAbilityLevel(target, 'B076') == 0 then
        call UnitMagicDamageTarget(caster, target, damage, 2)
        set t = CreateTimer()
        set task = GetHandleId(t)
        call SaveUnitHandle(udg_ht, task, 0, caster)
        call SaveUnitHandle(udg_ht, task, 1, target)
        call SaveReal(udg_ht, task, 2, damage)
        call TimerStart(t, 1.0, true, function Trig_Medi01_Damage)
    endif
    if udg_NewDebuffSys then
        call UnitSlowTargetMspd(caster, target, 10 + level * 5, 4.0, 3, 'A0A0')
    else
        if level == 1 then
            call UnitSlowTarget(caster, target, 2.5, 'A17Y', 'B076')
        elseif level == 2 then
            call UnitSlowTarget(caster, target, 2.5, 'A17Z', 'B076')
        elseif level == 3 then
            call UnitSlowTarget(caster, target, 2.5, 'A180', 'B076')
        elseif level == 4 then
            call UnitSlowTarget(caster, target, 2.5, 'A181', 'B076')
        endif
    endif
    set caster = null
    set target = null
    set t = null
endfunction

function InitTrig_Medi01 takes nothing returns nothing
endfunction