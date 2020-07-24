function Trig_Lunar03_Conditions takes nothing returns boolean
    if GetUnitAbilityLevel(GetEventDamageSource(), 'A06L') == 0 then
        return false
    elseif IsUnitAlly(GetTriggerUnit(), GetOwningPlayer(GetEventDamageSource())) then
        return false
    elseif IsUnitIllusion(GetEventDamageSource()) then
        return false
    elseif GetEventDamage() == 0 then
        return false
    elseif IsDamageNotUnitAttack(GetEventDamageSource()) then
        return false
    endif
    return true
endfunction

function Trig_Lunar03_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit q = LoadUnitHandle(udg_ht, task, 1)
    local unit u = LoadUnitHandle(udg_ht, task, 2)
    local real damage = LoadReal(udg_ht, task, 3)
    local integer i = LoadInteger(udg_ht, task, 4)
    local integer j = LoadInteger(udg_ht, task, 5)
    local integer o = GetUnitAbilityLevel(q, 'A0BE')
    local integer l = LoadInteger(udg_ht, task, 6)
    local integer c = 0
    local real ox = GetUnitX(u)
    local real oy = GetUnitY(u)
    local real tx = GetUnitX(q)
    local real ty = GetUnitY(q)
    local real px
    local real py
    local real a = Atan2(ty - oy, tx - ox)
    local real b
    if q == null then
        call KillUnit(u)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
        set t = null
        set caster = null
        set q = null
        set u = null
        return
    endif
    if i <= 45 then
        set i = i + 1
        call SaveInteger(udg_ht, task, 4, i)
        if j == 0 then
            set j = -1
        endif
        set b = (a * bj_RADTODEG - (180 + i * 4 * j)) * 0.017454
        set px = ox + 15.0 * Cos(b)
        set py = oy + 15.0 * Sin(b)
        call SetUnitXY(u, px, py)
        call SetUnitFacing(u, bj_RADTODEG * b)
    else
        set px = ox + 15.0 * Cos(a)
        set py = oy + 15.0 * Sin(a)
        call SetUnitXY(u, px, py)
        call SetUnitFacing(u, bj_RADTODEG * a)
    endif
    if IsUnitInRange(u, q, 25.0) and i > 45 then
        call UnitPhysicalDamageTarget(caster, q, damage)
        if l == 1 then
            set c = 'A0BE'
        elseif l == 2 then
            set c = 'A0BT'
        elseif l == 3 then
            set c = 'A0CU'
        else
            set c = 'A0CV'
        endif
        set o = GetUnitAbilityLevel(q, c)
        if o > 0 then
            call UnitSlowTarget(caster, q, 4.0, c, 0)
            call SetUnitAbilityLevel(q, c, IMinBJ(o + 1, 3))
        else
            call UnitSlowTarget(caster, q, 4.0, c, 0)
        endif
        call KillUnit(u)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set q = null
    set u = null
endfunction

function Trig_Lunar03_Actions takes nothing returns nothing
    local unit caster = GetEventDamageSource()
    local unit target = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A06L')
    local group g
    local boolexpr iff
    local unit u
    local unit v
    local unit q
    local real damage
    local real ox
    local real oy
    local real tx
    local real ty
    local real a
    local timer t
    local integer task
    set q = target
    set g = CreateGroup()
    set iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    call GroupEnumUnitsInRange(g, GetUnitX(target), GetUnitY(target), 600.0, iff)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if IsUnitType(v, UNIT_TYPE_DEAD) == false and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false then
            if q == null then
                set q = v
            elseif GetUnitState(v, UNIT_STATE_LIFE) / GetUnitState(v, UNIT_STATE_MAX_LIFE) < GetUnitState(q, UNIT_STATE_LIFE) / GetUnitState(q, UNIT_STATE_MAX_LIFE) then
                set q = v
            endif
        endif
    endloop
    call DestroyGroup(g)
    if q != null then
        set damage = ABCIExtraAgi(caster, level * 15 + 30, 0.0)
        set ox = GetUnitX(target)
        set oy = GetUnitY(target)
        set tx = GetUnitX(q)
        set ty = GetUnitY(q)
        set a = Atan2(ty - oy, tx - ox)
        set t = CreateTimer()
        set task = GetHandleId(t)
        set u = CreateUnit(GetOwningPlayer(caster), 'e02M', ox, oy, bj_RADTODEG * a)
        call SaveUnitHandle(udg_ht, task, 0, caster)
        call SaveUnitHandle(udg_ht, task, 1, q)
        call SaveUnitHandle(udg_ht, task, 2, u)
        call SaveReal(udg_ht, task, 3, damage)
        call SaveInteger(udg_ht, task, 4, 0)
        call SaveInteger(udg_ht, task, 5, GetRandomInt(0, 1))
        call SaveInteger(udg_ht, task, 6, level)
        call TimerStart(t, 0.02, true, function Trig_Lunar03_Main)
    endif
    set caster = null
    set target = null
    set g = null
    set iff = null
    set v = null
    set q = null
    set g = null
    set u = null
    set t = null
endfunction

function InitTrig_Lunar03 takes nothing returns nothing
endfunction