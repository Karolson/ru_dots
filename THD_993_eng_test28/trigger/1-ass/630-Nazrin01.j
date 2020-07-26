function Trig_Nazrin01_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0OO'
endfunction

function Trig_Nazrin01_Jump takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_Hashtable, task, 1)
    local integer i = LoadInteger(udg_Hashtable, task, 2)
    local effect e
    local real x
    local real y
    if i > 0 then
        set i = i - 1
        call SaveInteger(udg_Hashtable, task, 2, i)
        set x = GetUnitX(caster) + 16 * Cos(GetUnitFacing(caster) * bj_DEGTORAD)
        set y = GetUnitY(caster) + 16 * Sin(GetUnitFacing(caster) * bj_DEGTORAD)
        call SetUnitXYGround(caster, x, y)
        set e = AddSpecialEffect("Abilities\\Weapons\\WingedSerpentMissile\\WingedSerpentMissile.mdl", GetUnitX(caster), GetUnitY(caster))
        call DestroyEffect(e)
    else
        call UnitBuffTarget(caster, caster, 3.0, 'A0P7', 0)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_Hashtable, task)
    endif
    set t = null
    set caster = null
    set e = null
endfunction

function Trig_Nazrin01_Actions takes nothing returns nothing
    local timer t
    local integer task
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A0OO')
    call AbilityCoolDownResetion(caster, 'A0OO', 12 - 2 * level)
    if GetUnitAbilityLevel(caster, 'A0V4') == 1 or GetUnitAbilityLevel(caster, 'A0A1') == 1 then
        set t = null
        set caster = null
        return
    endif
    call UnitBuffTarget(caster, caster, 3.0, 'A0P7', 0)
    call SetUnitAbilityLevel(caster, 'A0P7', level)
    set t = CreateTimer()
    set task = GetHandleId(t)
    call SaveTimerHandle(udg_Hashtable, task, 0, t)
    call SaveUnitHandle(udg_Hashtable, task, 1, caster)
    call SaveInteger(udg_Hashtable, task, 2, 25)
    call TimerStart(t, 0.02, true, function Trig_Nazrin01_Jump)
    set t = null
    set caster = null
endfunction

function InitTrig_Nazrin01 takes nothing returns nothing
endfunction