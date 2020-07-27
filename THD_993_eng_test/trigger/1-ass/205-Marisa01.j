function Trig_BlinkDestructCount_Condition takes nothing returns nothing
    set udg_SK_BlinkDestructCount = udg_SK_BlinkDestructCount + 1
endfunction

function Trig_BlinkPlaceRealer takes real px, real py, real d, real a returns nothing
    local boolean k = false
    local real f = 0
    local location p
    loop
        if IsTerrainPathable(px, py, PATHING_TYPE_WALKABILITY) == false then
            set udg_SK_BlinkDestructCount = 0
            set k = true
            set p = Location(px, py)
            call YDWEEnumDestructablesInCircleBJNull(75, p, function Trig_BlinkDestructCount_Condition)
            call RemoveLocation(p)
            if udg_SK_BlinkDestructCount == 0 then
                set k = true
            endif
        endif
    exitwhen f >= d
    exitwhen k
        set f = f + 25
        set px = px - 25 * Cos(a)
        set py = py - 25 * Sin(a)
    endloop
    set udg_SK_BlinkPlace_x = px
    set udg_SK_BlinkPlace_y = py
    set udg_SK_BlinkPlace_d = d - f
    set p = null
endfunction

function MarisaAb01 takes nothing returns integer
    return 'A040'
endfunction

function Trig_Marisa01_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A040'
endfunction

function Trig_Marisa01_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 1)
    local unit u = LoadUnitHandle(udg_ht, task, 2)
    local unit v
    local group m = LoadGroupHandle(udg_ht, task, 3)
    local group g
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real px
    local real py
    local real a = LoadReal(udg_ht, task, 5)
    local real d = LoadReal(udg_ht, task, 6)
    local real damage = LoadReal(udg_ht, task, 7)
    local integer i = LoadInteger(udg_ht, task, 4)
    if i > 0 then
        set px = ox + d * Cos(a)
        set py = oy + d * Sin(a)
        call SetUnitXY(caster, px, py)
        call SetUnitXY(u, px, py)
        if i / 4 * 4 == 4 then
            call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\BloodElfMissile\\BloodElfMissile.mdl", px + 45 * CosBJ(a + 90), py + 45 * CosBJ(a + 90)))
            call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\BloodElfMissile\\BloodElfMissile.mdl", px + 45 * CosBJ(a - 90), py + 45 * CosBJ(a - 90)))
        endif
        call SaveInteger(udg_ht, task, 4, i - 1)
        set g = CreateGroup()
        call GroupEnumUnitsInRange(g, px, py, 125, iff)
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if GetWidgetLife(v) > 0.405 and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false and IsUnitInGroup(v, m) == false then
                call GroupAddUnit(m, v)
                call UnitMagicDamageTarget(caster, v, damage, 1)
            endif
        endloop
        call DestroyGroup(g)
    else
        call RemoveUnit(u)
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

function Trig_Marisa01_Functioned takes unit caster, real tx, real ty, real damage, real maxdistance returns nothing
    local timer t
    local integer task
    local unit u
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real a = Atan2(ty - oy, tx - ox)
    local real d = SquareRoot((ty - oy) * (ty - oy) + (tx - ox) * (tx - ox))
    local group m = CreateGroup()
    set d = RMinBJ(d, maxdistance)
    call Trig_BlinkPlaceRealer(ox + d * Cos(a), oy + d * Sin(a), d, a)
    set d = udg_SK_BlinkPlace_d
    set t = CreateTimer()
    set task = GetHandleId(t)
    set u = CreateUnit(GetOwningPlayer(caster), 'n00M', ox, oy, bj_RADTODEG * a)
    call SaveTimerHandle(udg_ht, task, 0, t)
    call SaveUnitHandle(udg_ht, task, 1, caster)
    call SaveUnitHandle(udg_ht, task, 2, u)
    call SaveGroupHandle(udg_ht, task, 3, m)
    call SaveInteger(udg_ht, task, 4, R2I(d / 25))
    call SaveReal(udg_ht, task, 5, a)
    call SaveReal(udg_ht, task, 6, 25.0)
    call SaveReal(udg_ht, task, 7, damage)
    call TimerStart(t, 0.02, true, function Trig_Marisa01_Main)
    set caster = null
    set u = null
    set m = null
    set t = null
endfunction

function Trig_Marisa01_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer abid = GetSpellAbilityId()
    local integer level = GetUnitAbilityLevel(caster, abid)
    local real tx = GetSpellTargetX()
    local real ty = GetSpellTargetY()
    local real basedamage = level * 50
    local real incdamage = 0.5
    local real maxdistance = 400 + level * 100
    local real damage = ABCIAllInt(caster, basedamage, incdamage)
    call AbilityCoolDownResetion(caster, abid, 15.0 - level * 2.0)
    call MarisaEx_ColdTimer(caster)
    if GetUnitAbilityLevel(caster, 'A0V4') == 1 or GetUnitAbilityLevel(caster, 'A0A1') == 1 then
        set caster = null
        return
    endif
    call Trig_Marisa01_Functioned(caster, tx, ty, damage, maxdistance)
    set caster = null
endfunction

function InitTrig_Marisa01 takes nothing returns nothing
endfunction