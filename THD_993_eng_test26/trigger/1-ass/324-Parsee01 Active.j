function Trig_Parsee01_Active_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A03Q'
endfunction

function Trig_Parsee01_Active_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit u = LoadUnitHandle(udg_ht, task, 2)
    local unit target = LoadUnitHandle(udg_ht, task, 3)
    local integer level = LoadInteger(udg_ht, task, 1)
    local real ox = GetUnitX(u)
    local real oy = GetUnitY(u)
    local real tx = GetUnitX(target)
    local real ty = GetUnitY(target)
    local real dis = SquareRoot((ty - oy) * (ty - oy) + (tx - ox) * (tx - ox))
    local real anglea = bj_RADTODEG * Atan2(ty - oy, tx - ox)
    local real angle = LoadReal(udg_ht, task, 6)
    local real v = LoadReal(udg_ht, task, 4)
    local real a = LoadReal(udg_ht, task, 5) + 0.002
    local real ax = v * CosBJ(angle)
    local real ay = v * SinBJ(angle)
    local integer cnt = LoadInteger(udg_ht, task, 7) - 1
    call SaveInteger(udg_ht, task, 7, cnt)
    call SaveReal(udg_ht, task, 5, a)
    if cnt < 0 then
        set a = a * 2
    endif
    if cnt > 0 then
        if anglea < 0 then
            set anglea = anglea + 360
        endif
        set ax = ax + a * CosBJ(anglea)
        set ay = ay + a * SinBJ(anglea)
        set angle = bj_RADTODEG * Atan2(ay, ax)
        if angle < 0 then
            set angle = angle + 360
        endif
        set v = SquareRoot(ax * ax + ay * ay)
        call SaveReal(udg_ht, task, 4, v)
        call SaveReal(udg_ht, task, 6, angle)
        if IsTerrainPathable(ox + v * CosBJ(angle), oy + v * SinBJ(angle), PATHING_TYPE_FLYABILITY) == false then
            call SetUnitX(u, ox + v * CosBJ(angle))
            call SetUnitY(u, oy + v * SinBJ(angle))
        endif
    else
        if IsTerrainPathable(tx - (dis - 16) * CosBJ(anglea), ty - (dis - 16) * SinBJ(anglea), PATHING_TYPE_FLYABILITY) == false then
            call SetUnitX(u, tx - (dis - 16) * CosBJ(anglea))
            call SetUnitY(u, ty - (dis - 16) * SinBJ(anglea))
        endif
    endif
    if dis <= 50 or dis <= 100 or GetWidgetLife(target) >= 0.405 == false or dis >= 3600 then
        call DebugMsg("End")
        call DestroyEffect(AddSpecialEffect("units\\nightelf\\Wisp\\Wisp.mdl", GetUnitX(target), GetUnitY(target)))
        call UnitMagicDamageTarget(caster, target, ABCIAllInt(caster, 35 + level * 35, 1.35) * (1 + udg_SK_Parsee01 * (0.04 + level * 0.04)) / 2, 1)
        call ReleaseTimer(t)
        call KillUnit(u)
        call FlushChildHashtable(udg_ht, task)
    endif
    set u = null
    set t = null
    set caster = null
    set target = null
endfunction

function Trig_Parsee01_Active_Actions takes nothing returns nothing
    local timer t
    local integer task
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    local unit u
    local unit target = GetSpellTargetUnit()
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real tx = GetUnitX(target)
    local real ty = GetUnitY(target)
    local real a = Atan2(ty - oy, tx - ox)
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 7)
    set t = CreateTimer()
    set task = GetHandleId(t)
    set u = CreateUnit(GetOwningPlayer(caster), 'n00T', ox, oy, bj_RADTODEG * a + 150)
    call SetUnitPathing(u, false)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveInteger(udg_ht, task, 1, level)
    call SaveUnitHandle(udg_ht, task, 2, u)
    call SaveUnitHandle(udg_ht, task, 3, target)
    call SaveReal(udg_ht, task, 4, 11)
    call SaveReal(udg_ht, task, 5, 0.23)
    call SaveReal(udg_ht, task, 6, bj_RADTODEG * a + 120)
    call SaveInteger(udg_ht, task, 7, 100)
    call TimerStart(t, 0.02, true, function Trig_Parsee01_Active_Main)
    set t = CreateTimer()
    set task = GetHandleId(t)
    set u = CreateUnit(GetOwningPlayer(caster), 'n00V', ox, oy, bj_RADTODEG * a + 210)
    call SetUnitPathing(u, false)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveInteger(udg_ht, task, 1, level)
    call SaveUnitHandle(udg_ht, task, 2, u)
    call SaveUnitHandle(udg_ht, task, 3, target)
    call SaveReal(udg_ht, task, 4, 11)
    call SaveReal(udg_ht, task, 5, 0.23)
    call SaveReal(udg_ht, task, 6, bj_RADTODEG * a + 240)
    call SaveInteger(udg_ht, task, 7, 100)
    call TimerStart(t, 0.02, true, function Trig_Parsee01_Active_Main)
    set caster = null
    set t = null
    set u = null
    set target = null
endfunction

function InitTrig_Parsee01_Active takes nothing returns nothing
endfunction