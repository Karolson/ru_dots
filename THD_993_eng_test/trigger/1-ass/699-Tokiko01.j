function Trig_Tokiko01_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0ZK'
endfunction

function Trig_Tokiko01_Moving takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit target = LoadUnitHandle(udg_ht, task, 9)
    local unit u = LoadUnitHandle(udg_ht, task, 1)
    local integer i = LoadInteger(udg_ht, task, 2)
    local integer j = LoadInteger(udg_ht, task, 7)
    local integer level = LoadInteger(udg_ht, task, 8)
    local real ox = LoadReal(udg_ht, task, 5)
    local real oy = LoadReal(udg_ht, task, 6)
    local real px
    local real py
    local real a = LoadReal(udg_ht, task, 3)
    local real d = LoadReal(udg_ht, task, 4)
    if i > 0 and IsUnitType(caster, UNIT_TYPE_DEAD) == false then
        set px = ox + (j - i) * d * Cos(a)
        set py = oy + (j - i) * d * Sin(a)
        call SetUnitXY(caster, px, py)
        call SaveInteger(udg_ht, task, 2, i - 1)
    else
        call PauseUnit(caster, false)
        if IsUnitType(caster, UNIT_TYPE_DEAD) == false then
            call IssueTargetOrderById(caster, 851983, target)
        endif
        call UnitHealingTarget(caster, caster, 30 + 30 * level + 1.1 * GetHeroInt(caster, true))
        call KillUnit(u)
        call RemoveUnit(u)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set target = null
    set u = null
endfunction

function Trig_Tokiko01_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit u = LoadUnitHandle(udg_ht, task, 1)
    local unit v
    local unit w
    local integer level = LoadInteger(udg_ht, task, 2)
    local integer i = LoadInteger(udg_ht, task, 3)
    local real ox = GetUnitX(u)
    local real oy = GetUnitY(u)
    local real px
    local real py
    local real a = LoadReal(udg_ht, task, 4)
    local real d = LoadReal(udg_ht, task, 5)
    local boolean instun = LoadBoolean(udg_ht, task, 6)
    local boolean k = false
    local group g
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    local timer t2
    local integer task2
    local real dis
    local real dis2
    local unit target
    if i > 0 then
        set px = ox + d * Cos(a)
        set py = oy + d * Sin(a)
        if IsTerrainPathable(px, py, PATHING_TYPE_FLYABILITY) == false then
            call SetUnitX(u, px)
            call SetUnitY(u, py)
            call SaveInteger(udg_ht, task, 3, i - 1)
        else
            call SaveInteger(udg_ht, task, 3, 0)
        endif
        set g = CreateGroup()
        call GroupEnumUnitsInRange(g, px, py, 100.0, iff)
        set v = FirstOfGroup(g)
        if v != null then
            if IsUnitType(v, UNIT_TYPE_HERO) and IsUnitType(v, UNIT_TYPE_DEAD) == false then
                call UnitStunTarget(caster, v, 1.3 + level * 0.3, 0, 0)
                call UnitMagicDamageTarget(caster, v, 30 + 30 * level + 1.1 * GetHeroInt(caster, true), 1)
                set target = v
                set k = true
            endif
        endif
        call DestroyGroup(g)
        if k then
            set t2 = CreateTimer()
            set task2 = GetHandleId(t2)
            set ox = GetUnitX(caster)
            set oy = GetUnitY(caster)
            set px = GetUnitX(u)
            set py = GetUnitY(u)
            set a = Atan2(py - oy, px - ox)
            set dis = SquareRoot((px - ox) * (px - ox) + (py - oy) * (py - oy))
            set dis2 = 30
            call PauseUnit(caster, true)
            call SetUnitFacing(caster, a)
            call SaveUnitHandle(udg_ht, task2, 0, caster)
            call SaveUnitHandle(udg_ht, task2, 1, u)
            call SaveInteger(udg_ht, task2, 2, R2I(RMaxBJ(dis / dis2, 1)))
            call SaveReal(udg_ht, task2, 3, a)
            call SaveReal(udg_ht, task2, 4, dis2)
            call SaveReal(udg_ht, task2, 5, ox)
            call SaveReal(udg_ht, task2, 6, oy)
            call SaveInteger(udg_ht, task2, 7, R2I(RMaxBJ(dis / dis2, 1)))
            call SaveInteger(udg_ht, task2, 8, level)
            call SaveUnitHandle(udg_ht, task2, 9, target)
            call TimerStart(t2, 0.02, true, function Trig_Tokiko01_Moving)
            call ReleaseTimer(t)
            call FlushChildHashtable(udg_ht, task)
        endif
    else
        call KillUnit(u)
        call RemoveUnit(u)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set u = null
    set v = null
    set w = null
    set g = null
    set iff = null
    set t2 = null
    set target = null
endfunction

function Trig_Tokiko01_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit u
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real tx = GetSpellTargetX()
    local real ty = GetSpellTargetY()
    local real a = Atan2(ty - oy, tx - ox)
    local integer level = GetUnitAbilityLevel(caster, 'A0ZK')
    local timer t
    local integer task
    call AbilityCoolDownResetion(caster, 'A0ZK', 13 - level)
    if GetUnitAbilityLevel(caster, 'A0V4') == 1 or GetUnitAbilityLevel(caster, 'A0A1') == 1 then
        set caster = null
        set t = null
        set u = null
        return
    endif
    set t = CreateTimer()
    set task = GetHandleId(t)
    set u = CreateUnit(GetOwningPlayer(caster), 'n04G', ox, oy, bj_RADTODEG * a)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, u)
    call SaveInteger(udg_ht, task, 2, level)
    call SaveInteger(udg_ht, task, 3, 30)
    call SaveReal(udg_ht, task, 4, a)
    call SaveReal(udg_ht, task, 5, 30)
    call TimerStart(t, 0.02, true, function Trig_Tokiko01_Main)
    set caster = null
    set u = null
    set t = null
endfunction

function InitTrig_Tokiko01 takes nothing returns nothing
endfunction