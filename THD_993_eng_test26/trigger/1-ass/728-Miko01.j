function MikoEx__onExpire takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit u = LoadUnitHandle(udg_ht, task, 0)
    call RemoveSavedBoolean(udg_sht, StringHash("MikoEx"), GetHandleId(u))
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    set t = null
    set u = null
endfunction

function MikoEx_onDamage takes nothing returns boolean
    local unit v = GetEventDamageSource()
    local timer t
    if GetEventDamage() > 0.0 and IsUnitType(v, UNIT_TYPE_HERO) and not HaveSavedBoolean(udg_sht, StringHash("MikoEx"), GetHandleId(v)) then
        call UnitMagicDamageTarget(GetTriggerUnit(), v, 0.025 * GetUnitState(v, UNIT_STATE_MAX_MANA), 1)
        call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Human\\Feedback\\SpellBreakerAttack.mdl", v, "origin"))
        call SaveBoolean(udg_sht, StringHash("MikoEx"), GetHandleId(v), true)
        set t = CreateTimer()
        call SaveUnitHandle(udg_ht, GetHandleId(t), 0, v)
        call TimerStart(t, 0.35, false, function MikoEx__onExpire)
        set t = null
    endif
    set v = null
    return false
endfunction

function MikoEx_onPeriodic takes nothing returns nothing
    local unit u
    set udg_SK_MikoEx = 0
    call GroupEnumUnitsInRange(udg_SK_MikoEx_Group, GetUnitX(udg_SK_Miko), GetUnitY(udg_SK_Miko), 900.0, null)
    call GroupRemoveUnit(udg_SK_MikoEx_Group, udg_SK_Miko)
    loop
        set u = FirstOfGroup(udg_SK_MikoEx_Group)
    exitwhen u == null
        call GroupRemoveUnit(udg_SK_MikoEx_Group, u)
        if IsUnitType(u, UNIT_TYPE_HERO) then
            set udg_SK_MikoEx = udg_SK_MikoEx + 2
        endif
    endloop
endfunction

function MikoEx_MikoEx_Main takes nothing returns boolean
    local trigger trg = GetTriggeringTrigger()
    local unit hero = LoadUnitHandle(udg_Hashtable, GetHandleId(trg), 1)
    local integer last = LoadInteger(udg_ht, GetHandleId(trg), 2)
    if IsUnitType(hero, UNIT_TYPE_DEAD) then
        set trg = null
        set hero = null
        return false
    endif
    if (GetFloatGameState(GAME_STATE_TIME_OF_DAY) >= 6 and GetFloatGameState(GAME_STATE_TIME_OF_DAY) < 18) == false and GetUnitAbilityLevel(hero, 'A1HX') != 0 then
        call UnitRemoveAbility(hero, 'A1HX')
    elseif (GetFloatGameState(GAME_STATE_TIME_OF_DAY) >= 6 and GetFloatGameState(GAME_STATE_TIME_OF_DAY) < 18) and GetUnitAbilityLevel(hero, 'A1HX') != 1 then
        call UnitAddAbility(hero, 'A1HX')
        call UnitMakeAbilityPermanent(hero, true, 'A1HX')
        call UnitAddAbility(hero, 'A1HW')
        call UnitMakeAbilityPermanent(hero, true, 'A1HW')
        call SetUnitState(hero, UNIT_STATE_LIFE, GetUnitState(hero, UNIT_STATE_MAX_LIFE))
        call SetUnitState(hero, UNIT_STATE_MANA, GetUnitState(hero, UNIT_STATE_MAX_MANA))
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Human\\Resurrect\\ResurrectTarget.mdl", GetUnitX(hero), GetUnitY(hero)))
    endif
    set trg = null
    set hero = null
    return false
endfunction

function MikoEx_MikoEx_Effect_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local real x = LoadReal(udg_ht, task, 1)
    local real y = LoadReal(udg_ht, task, 2)
    local integer i = LoadInteger(udg_ht, task, 3) - 1
    call SaveInteger(udg_ht, task, 3, i)
    call UnitMagicDamageArea(caster, x, y, 250, 360 / 10, 5)
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Human\\ReviveHuman\\ReviveHuman.mdl", x, y))
    if i <= 0 then
        call PauseTimer(t)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
endfunction

function MikoEx_MikoEx_Effect takes unit caster, unit target returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveReal(udg_ht, task, 1, GetUnitX(target))
    call SaveReal(udg_ht, task, 2, GetUnitY(target))
    call SaveInteger(udg_ht, task, 3, 10)
    call UnitRemoveAbility(caster, 'A1HW')
    call TimerStart(t, 0.3, true, function MikoEx_MikoEx_Effect_Main)
    set t = null
endfunction

function MikoEx_MikoEx_Main_Run takes nothing returns boolean
    if GetUnitAbilityLevel(GetEventDamageSource(), 'A1HW') == 0 then
        return false
    elseif GetEventDamage() == 0.0 then
        return false
    elseif IsUnitAlly(GetEventDamageSource(), GetOwningPlayer(GetTriggerUnit())) then
        return false
    elseif IsUnitType(GetTriggerUnit(), UNIT_TYPE_STRUCTURE) then
        return false
    elseif IsUnitIllusion(GetEventDamageSource()) then
        return false
    endif
    call MikoEx_MikoEx_Effect(GetEventDamageSource(), GetTriggerUnit())
    return false
endfunction

function MikoEx_Initial takes unit u returns nothing
    local trigger trg
    call UnitAddAbility(u, 'A1HW')
    call UnitMakeAbilityPermanent(u, true, 'A1HW')
    set trg = CreateTrigger()
    call SaveUnitHandle(udg_Hashtable, GetHandleId(trg), 1, u)
    call TriggerRegisterTimerEvent(trg, 2, true)
    call TriggerRegisterGameStateEventTimeOfDay(trg, GREATER_THAN_OR_EQUAL, 6.0)
    call TriggerRegisterGameStateEventTimeOfDay(trg, LESS_THAN, 6.0)
    call TriggerRegisterGameStateEventTimeOfDay(trg, GREATER_THAN_OR_EQUAL, 18.0)
    call TriggerRegisterGameStateEventTimeOfDay(trg, LESS_THAN, 18.0)
    call TriggerAddCondition(trg, Condition(function MikoEx_MikoEx_Main))
    set trg = null
    set trg = CreateTrigger()
    call RegisterAnyUnitDamage(trg)
    call TriggerAddCondition(trg, Condition(function MikoEx_MikoEx_Main_Run))
    set trg = null
endfunction

function Miko01 takes nothing returns integer
    return 'A183'
endfunction

function Miko01_Buff takes nothing returns integer
    return 'B08N'
endfunction

function Miko01_Unit takes nothing returns integer
    return 'e03B'
endfunction

function Miko01_Skill takes nothing returns integer
    return 'A0V1'
endfunction

function Miko01_Range takes nothing returns real
    return 500.0
endfunction

function Trig_Miko01_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A183'
endfunction

function Trig_Miko01_Hit_Conditions takes nothing returns boolean
    return GetUnitTypeId(GetEventDamageSource()) == 'e03B'
endfunction

function Trig_Miko01_Target takes nothing returns boolean
    if GetUnitState(GetFilterUnit(), UNIT_STATE_LIFE) <= 0 then
        return false
    endif
    if GetUnitAbilityLevel(GetFilterUnit(), 'Aloc') != 0 then
        return false
    endif
    if IsUnitAlly(GetFilterUnit(), GetOwningPlayer(LoadUnitHandle(udg_ht, GetHandleId(GetExpiredTimer()), 0))) then
        return false
    endif
    if IsUnitType(GetFilterUnit(), UNIT_TYPE_MECHANICAL) or GetUnitAbilityLevel(GetFilterUnit(), 'A0IL') > 0 then
        return false
    endif
    return true
endfunction

function Trig_Miko01_Active_Main takes nothing returns nothing
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
    local real damage
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
        call SetUnitX(u, tx - (dis - 16) * CosBJ(anglea))
        call SetUnitY(u, ty - (dis - 16) * SinBJ(anglea))
    endif
    if dis <= 50 or dis <= 100 or GetWidgetLife(target) >= 0.405 == false or dis >= 3600 then
        set damage = ABCIAllInt(caster, 15.0 + 15.0 * GetUnitAbilityLevel(caster, 'A183'), 1.0) + GetUnitState(target, UNIT_STATE_MAX_LIFE) * (0.0 + 0.01 * GetUnitAbilityLevel(caster, 'A187'))
        if false and GetUnitTypeId(target) == udg_SU_ID_A[0] or GetUnitTypeId(target) == udg_SU_ID_B[0] then
            call UnitMagicDamageTarget(caster, target, damage * (1 + 0.01 * udg_GameTime / 60), 1)
        else
            call UnitMagicDamageTarget(caster, target, damage * 1.0, 1)
        endif
        call ReleaseTimer(t)
        call KillUnit(u)
        call FlushChildHashtable(udg_ht, task)
    endif
    set u = null
    set t = null
    set caster = null
    set target = null
endfunction

function Miko01_Danmaku takes unit caster, unit target returns nothing
    local timer t
    local integer task
    local unit u
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real tx = GetUnitX(target)
    local real ty = GetUnitY(target)
    local real a = GetRandomInt(0, 360)
    set t = CreateTimer()
    set task = GetHandleId(t)
    set u = CreateUnit(GetOwningPlayer(caster), 'n03N', ox, oy, bj_RADTODEG * a + 150)
    call SetUnitAnimation(u, "stand")
    call SetUnitPathing(u, false)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveInteger(udg_ht, task, 1, GetRandomInt(1, 12))
    call SaveUnitHandle(udg_ht, task, 2, u)
    call SaveUnitHandle(udg_ht, task, 3, target)
    call SaveReal(udg_ht, task, 4, 15)
    call SaveReal(udg_ht, task, 5, 0.45)
    call SaveReal(udg_ht, task, 6, bj_RADTODEG * a + 160 + GetRandomInt(0, 40))
    call SaveInteger(udg_ht, task, 7, 15)
    call TimerStart(t, 0.02, true, function Trig_Miko01_Active_Main)
endfunction

function Trig_Miko01_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local integer level = LoadInteger(udg_ht, task, 0)
    local group g = CreateGroup()
    local boolexpr iff
    local real x = GetUnitX(caster)
    local real y = GetUnitY(caster)
    local unit v
    local unit target
    local real px
    local unit u
    local real py
    local real l = 999999
    call SetUnitState(caster, UNIT_STATE_MANA, GetUnitState(caster, UNIT_STATE_MANA) - 14)
    if LoadInteger(udg_ht, task, 1) == 1 then
        call SaveInteger(udg_ht, task, 1, 0)
        call TimerStart(t, 1, true, function Trig_Miko01_Main)
    endif
    if UnitHasBuffBJ(caster, 'B08N') then
        set iff = Filter(function Trig_Miko01_Target)
        call GroupEnumUnitsInRange(g, x, y, 500.0, iff)
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            set px = GetUnitX(v)
            set py = GetUnitY(v)
            if SquareRoot((px - x) * (px - x) + (py - y) * (py - y)) < l then
                set target = v
                set l = SquareRoot((px - x) * (px - x) + (py - y) * (py - y))
            endif
        endloop
        if target != null then
            call Miko01_Danmaku(caster, target)
        endif
    else
        call UnitRemoveAbility(caster, 'A0VL')
        call UnitRemoveAbility(caster, 'B08O')
        call UnitRemoveAbility(caster, 'B08P')
        call DestroyGroup(g)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set g = null
    set iff = null
    set v = null
    set target = null
    set u = null
endfunction

function Trig_Miko01_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A183')
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    if GetUnitAbilityLevel(caster, 'A0VL') == 0 then
        call UnitAddAbility(caster, 'A0VL')
        call SaveUnitHandle(udg_ht, task, 0, caster)
        call SaveInteger(udg_ht, task, 0, level)
        call SaveInteger(udg_ht, task, 1, 1)
        call TimerStart(t, 0, false, function Trig_Miko01_Main)
        set t = null
        set caster = null
    endif
endfunction

function InitTrig_Miko01 takes nothing returns nothing
endfunction