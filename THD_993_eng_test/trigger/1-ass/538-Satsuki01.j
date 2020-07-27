function Trig_Satsuki01_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A1H5'
endfunction

function Trig_Satsuki01_CallBack takes nothing returns nothing
    local unit caster = udg_PS_Source
    local player p = GetOwningPlayer(caster)
    local group g = udg_PS_OnHit_Group
    local integer level = GetUnitAbilityLevel(caster, 'A1H5')
    local unit v
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if IsUnitAlly(v, p) == false then
            call UnitSlowTarget(caster, v, 6, 'A1H6', 0)
            call UnitMagicDamageTarget(caster, v, ABCIAllAtk(caster, 20 + 40 * level, 1.3), 1)
        endif
    endloop
    set caster = null
    set p = null
    set g = null
    set v = null
endfunction

function Trig_Satsuki01_Jump takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_Hashtable, task, 1)
    local integer i = LoadInteger(udg_Hashtable, task, 2)
    local real a = LoadReal(udg_Hashtable, task, 3)
    local effect e
    local real x
    local real y
    if i > 0 then
        set i = i - 1
        call SaveInteger(udg_Hashtable, task, 2, i)
        set x = GetUnitX(caster) + 16 * Cos(a)
        set y = GetUnitY(caster) + 16 * Sin(a)
        call SetUnitXYGround(caster, x, y)
        set e = AddSpecialEffect("Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile_mini.mdl", GetUnitX(caster), GetUnitY(caster))
        call DestroyEffect(e)
    else
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_Hashtable, task)
    endif
    set t = null
    set caster = null
    set e = null
endfunction

function Trig_Satsuki01_Actions takes nothing returns nothing
    local timer t
    local integer task
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real tx = GetSpellTargetX()
    local real ty = GetSpellTargetY()
    local real a = Atan2(ty - oy, tx - ox)
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 22 - 3 * level)
    call DebugMsg("Satsuki01Main")
    if GetUnitAbilityLevel(caster, 'A0A1') == 1 then
        set t = null
        set caster = null
        return
    endif
    call DebugMsg("Satsuki01Main")
    call LaunchProjectileFromUnitToPoint("Abilities\\Spells\\Undead\\DeathPact\\DeathPactTarget.mdl", 1.5, caster, ox + Cos(a) * (650 + 100), oy + Sin(a) * (650 + 100), 1400, 100, "", "Trig_Satsuki01_CallBack", false, true, true)
    call UnitBuffTarget(caster, caster, 1.5, 'A1HG' + level, 'B0A4')
    set t = CreateTimer()
    set task = GetHandleId(t)
    call SaveTimerHandle(udg_Hashtable, task, 0, t)
    call SaveUnitHandle(udg_Hashtable, task, 1, caster)
    call SaveReal(udg_Hashtable, task, 3, a + 180 * bj_DEGTORAD)
    call SaveInteger(udg_Hashtable, task, 2, 25)
    call TimerStart(t, 0.02, true, function Trig_Satsuki01_Jump)
    set t = null
    set caster = null
endfunction

function InitTrig_Satsuki01 takes nothing returns nothing
endfunction