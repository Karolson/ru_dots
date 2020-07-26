function Trig_Sakuya01_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A04H'
endfunction

function Trig_Sakuya01_Damage takes nothing returns nothing
    local integer task
    local unit caster
    local real damage
    local integer level
    local boolean ccc
    local boolean first
    local unit w = GetTriggerUnit()
    if GetWidgetLife(w) < 0.405 then
        set w = null
        set caster = null
        return
    elseif IsUnitType(w, UNIT_TYPE_STRUCTURE) then
        set w = null
        set caster = null
        return
    elseif GetUnitAbilityLevel(w, 'A0IL') > 0 then
        set w = null
        set caster = null
        return
    endif
    set task = GetHandleId(GetTriggeringTrigger())
    set caster = LoadUnitHandle(udg_ht, task, 0)
    set damage = LoadReal(udg_ht, task, 0)
    set ccc = LoadBoolean(udg_ht, task, 1)
    set level = LoadInteger(udg_ht, task, 2)
    set first = LoadBoolean(udg_ht, task, 4)
    if first then
        call SaveBoolean(udg_ht, task, 4, false)
        call UnitDamageTarget(caster, GetEnteringUnit(), GetUnitAttack(caster) * 1.0, true, false, ATTACK_TYPE_HERO, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
    endif
    if ccc then
        call UnitStunTarget(caster, w, 1.0, 0, 0)
        call UnitMagicDamageTarget(caster, GetEnteringUnit(), GetHeroInt(caster, true) * 2.2 + 30, 5)
    endif
    call UnitMagicDamageTarget(caster, GetEnteringUnit(), damage, 5)
    call VE_Sword_Special(GetEnteringUnit(), 0)
    set caster = null
    set w = null
endfunction

function Trig_Sakuya01_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit u = LoadUnitHandle(udg_ht, task, 1)
    local boolean ccc = LoadBoolean(udg_ht, task, 4)
    local unit w
    local real ox = GetUnitX(u)
    local real oy = GetUnitY(u)
    local real px
    local real py
    local real a = LoadReal(udg_ht, task, 0)
    local integer level = LoadInteger(udg_ht, task, 0)
    local integer i = LoadInteger(udg_ht, task, 1)
    local trigger trg
    local triggeraction tga
    if ccc then
        set w = LoadUnitHandle(udg_ht, task, 5)
    endif
    if i < 36 and GetWidgetLife(caster) > 0.405 then
        set px = ox + 40.0 * Cos(a)
        set py = oy + 40.0 * Sin(a)
        if IsTerrainPathable(px, py, PATHING_TYPE_FLYABILITY) == false then
            call SetUnitXY(u, px, py)
            if ccc then
                call SetUnitXY(w, px, py)
            endif
            call SaveInteger(udg_ht, task, 1, i + 1)
        else
            call SaveInteger(udg_ht, task, 1, 40)
        endif
    else
        call KillUnit(u)
        call KillUnit(w)
        call ReleaseTimer(t)
        set trg = LoadTriggerHandle(udg_ht, task, 2)
        set tga = LoadTriggerActionHandle(udg_ht, task, 3)
        call TriggerRemoveAction(trg, tga)
        call DestroyTrigger(trg)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set u = null
    set w = null
    set trg = null
    set tga = null
endfunction

function Trig_Sakuya01_Timer takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 1)
    call UnitAddAbility(caster, 'A1I9')
    call SaveTimerHandle(udg_ht, GetHandleId(caster), 954, null)
    call PauseTimer(t)
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, GetHandleId(t))
    set t = null
    set caster = null
endfunction

function Trig_Sakuya01_Timer_Set takes unit u returns nothing
    local timer t = null
    set t = LoadTimerHandle(udg_ht, GetHandleId(u), 954)
    if t == null then
        set t = CreateTimer()
        call SaveTimerHandle(udg_ht, GetHandleId(u), 954, t)
        call DebugMsg("NewTimer")
    endif
    call TimerStart(t, 10, false, function Trig_Sakuya01_Timer)
    call SaveUnitHandle(udg_ht, GetHandleId(t), 1, u)
    set t = null
endfunction

function Trig_Sakuya01_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit u
    local unit w
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real tx = GetSpellTargetX()
    local real ty = GetSpellTargetY()
    local real dx = tx - ox
    local real dy = ty - oy
    local real a = Atan2(dy, dx)
    local integer level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local real damage
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    local trigger trg = CreateTrigger()
    local triggeraction tga = TriggerAddAction(trg, function Trig_Sakuya01_Damage)
    local boolean ccc = false
    local integer k = GetPlayerId(GetOwningPlayer(GetTriggerUnit())) + 1
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 4)
    set u = CreateUnit(GetOwningPlayer(caster), 'o00T', ox, oy, bj_RADTODEG * a)
    if GetUnitAbilityLevel(caster, 'A1I9') != 0 then
        set ccc = true
        call UnitRemoveAbility(caster, 'A1I9')
        call Trig_Sakuya01_Timer_Set(caster)
        set w = CreateUnit(GetOwningPlayer(caster), 'o00E', ox - Cos(a) * 120, oy - Sin(a) * 120, bj_RADTODEG * a)
    endif
    call SaveInteger(udg_ht, task, 0, level)
    call SaveInteger(udg_ht, task, 1, 0)
    call SaveReal(udg_ht, task, 0, a)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, u)
    call SaveBoolean(udg_ht, task, 4, ccc)
    if ccc then
        call SaveUnitHandle(udg_ht, task, 5, w)
    endif
    call SaveTriggerHandle(udg_ht, task, 2, trg)
    call SaveTriggerActionHandle(udg_ht, task, 3, tga)
    call TimerStart(t, 0.02, true, function Trig_Sakuya01_Main)
    set damage = 25 + 25 * level
    if udg_SK_Sakuya04_Mana01[k] != 0 then
        call SetUnitState(caster, UNIT_STATE_MANA, RMaxBJ(GetUnitState(caster, UNIT_STATE_MANA) - 60 * 0.75, 0))
    endif
    call TriggerRegisterUnitInRange(trg, u, 120.0, iff)
    call SaveUnitHandle(udg_ht, GetHandleId(trg), 0, caster)
    call SaveReal(udg_ht, GetHandleId(trg), 0, damage)
    call SaveBoolean(udg_ht, GetHandleId(trg), 1, ccc)
    call SaveInteger(udg_ht, GetHandleId(trg), 2, level)
    call SaveBoolean(udg_ht, GetHandleId(trg), 4, true)
    set caster = null
    set u = null
    set w = null
    set t = null
    set iff = null
    set trg = null
    set tga = null
endfunction

function InitTrig_Sakuya01 takes nothing returns nothing
endfunction