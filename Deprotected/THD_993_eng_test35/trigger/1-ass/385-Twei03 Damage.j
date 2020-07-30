function Trig_Twei03_Damage_Conditions takes nothing returns boolean
    if GetUnitTypeId(GetEventDamageSource()) != 'O00N' then
        return false
    endif
    if udg_SK_Twei03_Iff == 0 then
        return false
    endif
    if udg_SK_Twei03_Moving then
        return false
    endif
    return GetEventDamage() > 0.0
endfunction

function Trig_Twei03_Damage_Move takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local real a = LoadReal(udg_ht, task, 1)
    local real d = LoadReal(udg_ht, task, 2)
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real rx = ox + 13 * CosBJ(a)
    local real ry = oy + 13 * SinBJ(a)
    if d > 0 and IsTerrainPathable(rx, ry, PATHING_TYPE_WALKABILITY) == false then
        call SetUnitXYGround(caster, rx, ry)
        call SaveReal(udg_ht, task, 2, d - 13)
    else
        set udg_SK_Twei03_Moving = false
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
endfunction

function Trig_Twei03_Damage_Actions takes nothing returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local unit caster = GetEventDamageSource()
    local unit target = GetTriggerUnit()
    local real a
    local real d
    local real x1 = GetUnitX(caster)
    local real x2 = GetUnitX(target)
    local real y1 = GetUnitY(caster)
    local real y2 = GetUnitY(target)
    local real dis = SquareRoot((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2))
    set d = (620 - dis) * 0.5
    set a = AngleBetween(caster, target) + 180.0
    if a > 360.0 then
        set a = a - 360.0
    endif
    call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\AncientProtectorMissile\\AncientProtectorMissile.mdl", x1, y1))
    set udg_SK_Twei03_Moving = true
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveReal(udg_ht, task, 1, a)
    call SaveReal(udg_ht, task, 2, d)
    call TimerStart(t, 0.02, true, function Trig_Twei03_Damage_Move)
    set t = null
    set caster = null
    set target = null
endfunction

function InitTrig_Twei03_Damage takes nothing returns nothing
endfunction