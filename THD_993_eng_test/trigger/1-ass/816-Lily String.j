function LiMa02_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit target = LoadUnitHandle(udg_ht, task, 1)
    local lightning l = LoadLightningHandle(udg_ht, task, 2)
    local real dis = LoadReal(udg_ht, task, 3)
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real oz
    local real tx = GetUnitX(target)
    local real ty = GetUnitY(target)
    local real tz
    local real a = Atan2(ty - oy, tx - ox)
    local integer i = LoadInteger(udg_ht, task, 1) - 1
    set oz = GetPositionZ(ox, oy) + GetUnitFlyHeight(caster) + 60
    set tz = GetPositionZ(tx, ty) + GetUnitFlyHeight(target) + 60
    if i > 0 then
        call MoveLightningEx(l, false, ox, oy, oz, tx, ty, tz)
        if not IsUnitInRange(caster, target, 1200.0) then
            set i = -1
        else
            if not IsUnitInRange(caster, target, dis) and IsMobileUnit(caster) then
                set ox = tx - dis * Cos(a)
                set oy = ty - dis * Sin(a)
                call SetUnitXYFly(caster, ox, oy)
            endif
        endif
        if IsUnitDead(caster) or IsUnitDead(target) then
            set i = -1
        endif
        call SaveInteger(udg_ht, task, 1, i)
    else
        call DestroyLightning(l)
        call SetUnitFlag(caster, 3, false)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set l = null
    set caster = null
    set target = null
endfunction

function LiMa02_Effect takes unit caster, unit target returns nothing
    local timer t
    local integer task
    local lightning l
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real oz
    local real tx = GetUnitX(target)
    local real ty = GetUnitY(target)
    local real tz
    local real dis = SquareRoot((ox - tx) * (ox - tx) + (oy - ty) * (oy - ty))
    set t = CreateTimer()
    set task = GetHandleId(t)
    set oz = GetPositionZ(ox, oy) + GetUnitFlyHeight(caster) + 60
    set tz = GetPositionZ(tx, ty) + GetUnitFlyHeight(target) + 60
    set l = AddLightningEx("LEAS", true, ox, oy, oz, tx, ty, tz)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, target)
    call SaveLightningHandle(udg_ht, task, 2, l)
    call SaveInteger(udg_ht, task, 1, 350)
    call SaveReal(udg_ht, task, 3, dis)
    call SetUnitFlag(caster, 3, true)
    call TimerStart(t, 0.02, true, function LiMa02_Main)
    set t = null
    set l = null
endfunction

function Lily_String_Loop takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit target = LoadUnitHandle(udg_ht, task, 0)
    local real time = LoadReal(udg_ht, task, 1) - 0.03125
    local real speed = LoadReal(udg_ht, task, 2)
    local real angle = LoadReal(udg_ht, task, 3)
    local real ox = GetUnitX(target)
    local real oy = GetUnitY(target)
    local real dx = ox + Cos(angle) * speed
    local real dy = oy + Sin(angle) * speed
    call SaveReal(udg_ht, task, 1, time)
    if time >= 0 then
        if IsTerrainPathable(dx, dy, PATHING_TYPE_WALKABILITY) == false then
            call SetUnitPosition(target, dx, dy)
        endif
    else
        call SetUnitPathing(target, true)
        call DestroyEffect(LoadEffectHandle(udg_ht, task, 4))
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set target = null
endfunction

function Lily_String_Main takes unit target, real distance, real speed, real angle, string e returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call SetUnitPathing(target, false)
    call SaveUnitHandle(udg_ht, task, 0, target)
    call SaveReal(udg_ht, task, 1, distance / speed)
    call SaveReal(udg_ht, task, 2, speed * 0.03125)
    call SaveReal(udg_ht, task, 3, angle)
    call SaveEffectHandle(udg_ht, task, 4, AddSpecialEffectTarget(e, target, "origin"))
    call TimerStart(t, 0.03125, true, function Lily_String_Loop)
    set target = null
endfunction

function Trig_Lily_String_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A01J'
endfunction

function Trig_Lily_String_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local real a
    set a = Atan2(GetUnitY(caster) - GetUnitY(target), GetUnitX(caster) - GetUnitX(target))
    if BlockingSpell(caster, target) == false then
        call Advanced_Strategy_Main(caster, target)
        call DummyCastTargetInstant_WW(caster, target, 'A1B1', 2, "faeriefire")
        call LiMa02_Effect(caster, target)
    endif
    set caster = null
    set target = null
endfunction

function InitTrig_Lily_String takes nothing returns nothing
    set gg_trg_Lily_String = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Lily_String, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Lily_String, Condition(function Trig_Lily_String_Conditions))
    call TriggerAddAction(gg_trg_Lily_String, function Trig_Lily_String_Actions)
endfunction