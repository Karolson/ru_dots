function ReimuAb01 takes nothing returns integer
    return 'A048'
endfunction

function Trig_Reimu01_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A048'
endfunction

function Trig_Reimu01_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit u = LoadUnitHandle(udg_ht, task, 1)
    local integer i = LoadInteger(udg_ht, task, 2)
    local integer z = LoadInteger(udg_ht, task, 3)
    local integer tcnt = LoadInteger(udg_ht, task, 4)
    local real v = LoadReal(udg_ht, task, 5)
    local real h = LoadReal(udg_ht, task, 6)
    local real g = -1.2
    local real damage
    local real stun
    local real dmgarea = LoadReal(udg_ht, task, 9)
    if i < z then
        set h = h + v
        call SetUnitFlyHeight(u, h, 2000)
        if h < 5.0 and v < 0 then
            set v = -0.75 * v
            set damage = LoadReal(udg_ht, task, 7) * (3 - tcnt) / 3
            call UnitMagicDamageArea(caster, GetUnitX(u), GetUnitY(u), 200, damage, 5)
            set stun = LoadReal(udg_ht, task, 8) * (3 - tcnt) / 3
            call UnitStunArea(u, stun, GetUnitX(u), GetUnitY(u), 200, 0, 0)
            call SaveInteger(udg_ht, task, 4, tcnt + 1)
            call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Orc\\WarStomp\\WarStompCaster.mdl", GetUnitX(u), GetUnitY(u)))
        endif
        set v = v + g
        set i = i + 1
        call SaveInteger(udg_ht, task, 2, i)
        call SaveReal(udg_ht, task, 5, v)
        call SaveReal(udg_ht, task, 6, h)
    else
        call RemoveUnit(u)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set u = null
endfunction

function Trig_Reimu01_Functioned takes unit caster, real tx, real ty, integer level, real damage, real stun, real dmgarea returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local unit u
    set u = CreateUnit(GetOwningPlayer(caster), 'n00S', tx, ty, 0.0)
    call SetUnitScale(u, 1.5 + 0.3 * level, 1.5 + 0.3 * level, 1.5 + 0.3 * level)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, u)
    call SaveInteger(udg_ht, task, 2, 0)
    call SaveInteger(udg_ht, task, 3, R2I((1.5 + level * 0.2) * 50))
    call SaveInteger(udg_ht, task, 4, 0)
    call SaveReal(udg_ht, task, 5, 0)
    call SaveReal(udg_ht, task, 6, 600)
    call SaveReal(udg_ht, task, 7, damage)
    call SaveReal(udg_ht, task, 8, stun)
    call SaveReal(udg_ht, task, 9, dmgarea)
    call TimerStart(t, 0.02, true, function Trig_Reimu01_Main)
    set t = null
    set u = null
endfunction

function Trig_Reimu01_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local real tx = GetSpellTargetX()
    local real ty = GetSpellTargetY()
    local integer abid = GetSpellAbilityId()
    local integer level = GetUnitAbilityLevel(caster, abid)
    local real damagebase = 55 + level * 40 - 2.5 * level * (level - 4) * (level - 1)
    local real damageinc = 1.7
    local real stun = 0.45
    local real dmgarea = 200.0
    local real damage = ABCIAllInt(caster, damagebase, damageinc)
    call AbilityCoolDownResetion(caster, abid, 7.0)
    call Trig_Reimu01_Functioned(caster, tx, ty, level, damage, stun, dmgarea)
    set caster = null
endfunction

function InitTrig_Reimu01 takes nothing returns nothing
endfunction