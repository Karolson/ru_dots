function Trig_Tensi01_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0T6'
endfunction

function Trig_Tensi01_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_Hashtable, task, 0)
    local real ox = LoadReal(udg_Hashtable, task, 1)
    local real oy = LoadReal(udg_Hashtable, task, 2)
    local real a = LoadReal(udg_Hashtable, task, 3)
    local real px
    local real py
    local destructable w
    local integer z = LoadInteger(udg_Hashtable, task, 4)
    local integer y = LoadInteger(udg_Hashtable, task, 5)
    local group m = LoadGroupHandle(udg_Hashtable, task, 21)
    local integer level = LoadInteger(udg_Hashtable, task, 6)
    local group g
    local unit v
    local unit u
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    if z > 0 then
        set px = ox + 128 * (y - z) * Cos(a)
        set py = oy + 128 * (y - z) * Sin(a)
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\Volcano\\VolcanoDeath.mdl", px, py))
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Orc\\WarStomp\\WarStompCaster.mdl", px, py))
        set g = CreateGroup()
        call GroupEnumUnitsInRange(g, px, py, 225.0, iff)
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if IsUnitType(v, UNIT_TYPE_DEAD) == false and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false and IsUnitInGroup(v, m) == false then
                call GroupAddUnit(m, v)
                if GetUnitAbilityLevel(caster, 'B004') != 0 then
                    call UnitPhysicalDamageTarget(caster, v, 75 + 25 * level + GetUnitAttack(caster) * 1)
                else
                    call UnitPhysicalDamageTarget(caster, v, 75 + 25 * level + GetUnitAttack(caster) * 1)
                endif
                if GetUnitAbilityLevel(caster, 'B005') != 0 then
                    call UnitStunTarget(caster, v, 0.75 + 0.25 * level, 0, 0)
                else
                    call UnitStunTarget(caster, v, 0.75 + 0.25 * level, 0, 0)
                endif
            endif
        endloop
        call DestroyGroup(g)
        set w = CreateDestructable('B01X', px, py, a * bj_RADTODEG, 0.7, 0)
        call SaveDestructableHandle(udg_Hashtable, task, z, w)
        set z = z - 1
        call SaveInteger(udg_Hashtable, task, 4, z)
    elseif z == 0 then
        set z = -1
        call SaveInteger(udg_Hashtable, task, 4, z)
        call TimerStart(t, 4 + level, false, function Trig_Tensi01_Main)
    else
        call ReleaseTimer(t)
        call DestroyGroup(m)
        set z = y - 1
        loop
        exitwhen z == 0
            set w = LoadDestructableHandle(udg_Hashtable, task, z)
            call RemoveDestructable(w)
            set z = z - 1
        endloop
        call FlushChildHashtable(udg_Hashtable, task)
    endif
    set t = null
    set caster = null
    set w = null
    set m = null
    set g = null
    set v = null
    set u = null
    set iff = null
endfunction

function Trig_Tensi01_Actions takes nothing returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local unit caster = GetTriggerUnit()
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real px = GetSpellTargetX()
    local real py = GetSpellTargetY()
    local real a = Atan2(py - oy, px - ox)
    local group m = CreateGroup()
    local integer level = GetUnitAbilityLevel(caster, 'A0T6')
    local integer z
    local integer y
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 17 - level)
    if GetUnitAbilityLevel(caster, 'B068') != 0 then
        set z = 14
        set y = 15
    else
        set z = 7
        set y = 8
    endif
    call SaveUnitHandle(udg_Hashtable, task, 0, caster)
    call SaveReal(udg_Hashtable, task, 1, ox)
    call SaveReal(udg_Hashtable, task, 2, oy)
    call SaveReal(udg_Hashtable, task, 3, a)
    call SaveInteger(udg_Hashtable, task, 4, z)
    call SaveInteger(udg_Hashtable, task, 5, y)
    call SaveGroupHandle(udg_Hashtable, task, 21, m)
    call SaveInteger(udg_Hashtable, task, 6, level)
    call TimerStart(t, 0.03, true, function Trig_Tensi01_Main)
    set t = null
    set caster = null
    set m = null
endfunction

function InitTrig_Tensi01 takes nothing returns nothing
endfunction