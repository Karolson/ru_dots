function Trig_Sunny04_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A1IH'
endfunction

function Trig_Sunny04_Go takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit u = LoadUnitHandle(udg_ht, task, 1)
    local unit v
    local group m = LoadGroupHandle(udg_ht, task, 2)
    local group g
    local real a = LoadReal(udg_ht, task, 3)
    local integer i = LoadInteger(udg_ht, task, 4)
    local real ox = GetUnitX(u)
    local real oy = GetUnitY(u)
    local real px
    local real py
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    if i > 0 then
        set px = ox + 18.75 * Cos(a)
        set py = oy + 18.75 * Sin(a)
        if IsTerrainPathable(px, py, PATHING_TYPE_FLYABILITY) == false then
            call SetUnitXY(u, px, py)
            call SaveInteger(udg_ht, task, 4, i - 1)
        else
            call SaveInteger(udg_ht, task, 4, 0)
        endif
        set g = CreateGroup()
        call GroupEnumUnitsInRange(g, px, py, 120.0, iff)
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if GetWidgetLife(v) > 0.405 and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false and IsUnitInGroup(v, m) == false then
                call GroupAddUnit(m, v)
                call UnitMagicDamageTarget(caster, v, 50.0 + GetHeroInt(caster, true) * 0.3, 5)
            endif
        endloop
        call DestroyGroup(g)
    else
        if IsUnitType(u, UNIT_TYPE_DEAD) == false then
            call RemoveUnit(u)
        endif
        call ReleaseTimer(t)
        call DestroyGroup(m)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set u = null
    set v = null
    set m = null
    set g = null
    set iff = null
endfunction

function Trig_Sunny04_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local integer i = LoadInteger(udg_ht, task, 1)
    local timer t2
    local integer task2
    local unit u
    local real a = GetUnitFacing(caster) * 0.017454
    local group m
    local real ox = GetUnitX(caster) + 18.75 * Cos(a)
    local real oy = GetUnitY(caster) + 18.75 * Sin(a)
    if i > 0 then
        set m = CreateGroup()
        set u = CreateUnit(GetOwningPlayer(caster), 'e01C', ox, oy, bj_RADTODEG * a)
        call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\AncestralGuardianMissile\\AncestralGuardianMissile.mdl", GetUnitX(caster), GetUnitY(caster)))
        set t2 = CreateTimer()
        set task2 = GetHandleId(t2)
        call SaveUnitHandle(udg_ht, task2, 0, caster)
        call SaveUnitHandle(udg_ht, task2, 1, u)
        call SaveGroupHandle(udg_ht, task2, 2, m)
        call SaveReal(udg_ht, task2, 3, a)
        call SaveInteger(udg_ht, task2, 4, 107)
        call TimerStart(t2, 0.02, true, function Trig_Sunny04_Go)
        call SaveInteger(udg_ht, task, 1, i - 1)
    else
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set t2 = null
    set u = null
    set m = null
endfunction

function Trig_Sunny04_Actions takes nothing returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A1IH')
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 105 - 15 * level)
    call VE_Spellcast(caster)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveInteger(udg_ht, task, 1, R2I(GetUnitState(caster, UNIT_STATE_MAX_LIFE) / 200) + level * 3)
    call TimerStart(t, 0.25, true, function Trig_Sunny04_Main)
    set t = null
    set caster = null
endfunction

function InitTrig_Sunny04 takes nothing returns nothing
endfunction