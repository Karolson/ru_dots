function Shinki04 takes nothing returns integer
    return 'A1DZ'
endfunction

function Shinki04_Duration takes nothing returns real
    return 5.0
endfunction

function Shinki04_Range takes nothing returns real
    return 812.0
endfunction

function Shinki04_Unit takes nothing returns integer
    return 'e03Y'
endfunction

function Shinki04_dog takes nothing returns integer
    return 'u00Y'
endfunction

function Trig_Shinki04_Conditions takes nothing returns boolean
    return GetUnitTypeId(GetSummonedUnit()) == 'e03Y'
endfunction

function Shinki04_If takes nothing returns boolean
    if GetUnitState(GetFilterUnit(), UNIT_STATE_LIFE) <= 0 then
        return false
    endif
    if GetUnitAbilityLevel(GetFilterUnit(), 'Aloc') != 0 then
        return false
    endif
    if IsUnitType(GetFilterUnit(), UNIT_TYPE_MECHANICAL) or GetUnitAbilityLevel(GetFilterUnit(), 'A0IL') > 0 then
        return false
    endif
    return true
endfunction

function js takes real x, real y, real x1, real y1, real x2, real y2 returns real
    return (x - x1) * (y - y2) - (y - y1) * (x - x2)
endfunction

function Shinki04_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local real s = LoadReal(udg_ht, task, 0)
    local unit caster = LoadUnitHandle(udg_ht, task, 78)
    local group gr = LoadGroupHandle(udg_ht, task, 1)
    local unit u = LoadUnitHandle(udg_ht, task, 2)
    local integer level = LoadInteger(udg_ht, task, 0)
    local integer i = LoadInteger(udg_ht, task, 1) + 1
    local real x = GetUnitX(u)
    local real y = GetUnitY(u)
    local group g = CreateGroup()
    local boolexpr iff
    local unit v
    local real px
    local real py
    local real x1 = x + 150.0 * Cos(s + 90.0 * 0.017454)
    local real y1 = y + 150.0 * Sin(s + 90.0 * 0.017454)
    local real x2 = x + 150.0 * Cos(s - 90.0 * 0.017454)
    local real y2 = y + 150.0 * Sin(s - 90.0 * 0.017454)
    local real x3 = x2 + 1000.0 * Cos(s)
    local real y3 = y2 + 1000.0 * Sin(s)
    local real x4 = x1 + 1000.0 * Cos(s)
    local real y4 = y1 + 1000.0 * Sin(s)
    local integer bl
    call SaveInteger(udg_ht, task, 1, i)
    if i * 1.0 > 5.0 * 50 then
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
        call DestroyGroup(gr)
        call DestroyGroup(g)
        set t = null
        set caster = null
        set u = null
        set v = null
        set g = null
        set gr = null
        set iff = null
        return
    endif
    set iff = Filter(function Shinki04_If)
    call GroupEnumUnitsInRange(g, x, y, 812.0, iff)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        set bl = 0
        set px = GetUnitX(v)
        set py = GetUnitY(v)
        if js(px, py, x1, y1, x2, y2) > 0 and js(px, py, x2, y2, x3, y3) > 0 and js(px, py, x3, y3, x4, y4) > 0 and js(px, py, x4, y4, x1, y1) > 0 then
            set bl = 1
        endif
        if IsUnitAlly(v, GetOwningPlayer(caster)) == false and bl == 1 then
            call SetUnitX(v, px - (3.6 + 0.8 * 3) * Cos(s))
            call SetUnitY(v, py - (3.6 + 0.8 * 3) * Sin(s))
        endif
    endloop
    call GroupClear(g)
    call GroupEnumUnitsInRange(g, x, y, 300.0, iff)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if IsUnitAlly(v, GetOwningPlayer(caster)) == false and not IsUnitInGroup(v, gr) then
            call GroupAddUnitSimple(v, gr)
            call UnitStunTarget(caster, v, 1.0, 0, 0)
            call UnitMagicDamageTarget(caster, v, 1.7 * GetHeroInt(caster, true) + 90.0 + 90.0 * GetUnitAbilityLevel(caster, 'A1DZ'), 1)
        endif
    endloop
    call SaveGroupHandle(udg_ht, task, 0, gr)
    call DestroyGroup(g)
    set t = null
    set caster = null
    set u = null
    set v = null
    set g = null
    set gr = null
    set iff = null
endfunction

function Trig_Shinki04_Actions takes nothing returns nothing
    local unit caster = GetSummoningUnit()
    local unit u = GetSummonedUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A1DZ')
    local group gr = CreateGroup()
    local integer i = 0
    local integer j = 1
    local real s = Atan2(GetUnitY(u) - GetUnitY(caster), GetUnitX(u) - GetUnitX(caster))
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local integer dis = 1000
    local unit v
    call AbilityCoolDownResetion(caster, 'A1DZ', 190 - 20 * level)
    call SetUnitAnimation(u, "stand")
    call SetUnitFacing(u, s / 3.14 * 180)
    call SaveUnitHandle(udg_ht, task, 78, caster)
    call SaveGroupHandle(udg_ht, task, 1, gr)
    call SaveUnitHandle(udg_ht, task, 2, u)
    call SaveInteger(udg_ht, task, 0, level)
    call SaveInteger(udg_ht, task, 1, i)
    call SaveReal(udg_ht, task, 0, s)
    call VE_Spellcast(caster)
    if GetUnitAbilityLevel(caster, 'A1DV') > 0 then
        loop
        exitwhen dis < 30
            call AddTimedEffectToPoint(GetUnitX(u) + Cos(s + 1.57) * 150 + Cos(s) * dis, GetUnitY(u) + Sin(s + 1.57) * 150 + Sin(s) * dis, 5, "Abilities\\Spells\\Human\\FlameStrike\\FlameStrikeDamageTarget.mdl")
            call AddTimedEffectToPoint(GetUnitX(u) + Cos(s - 1.57) * 150 + Cos(s) * dis, GetUnitY(u) + Sin(s - 1.57) * 150 + Sin(s) * dis, 5, "Abilities\\Spells\\Human\\FlameStrike\\FlameStrikeDamageTarget.mdl")
            set dis = dis - 60
        endloop
        loop
        exitwhen j > GetUnitAbilityLevel(caster, 'A1DV') + 1
            set v = CreateUnit(GetOwningPlayer(caster), 'u00Y', GetUnitX(u), GetUnitY(u), GetUnitFacing(caster))
            call IssuePointOrder(v, "attack", GetUnitX(caster) + 1000.0 * Cos(s) + GetRandomReal(-200.0, 200.0), GetUnitY(caster) + 1000.0 * Sin(s) + GetRandomReal(-200.0, 200.0))
            set j = j + 1
        endloop
    endif
    call TimerStart(t, 0.02, true, function Shinki04_Main)
    set gr = null
    set t = null
    set caster = null
    set u = null
    set v = null
endfunction

function InitTrig_Shinki04 takes nothing returns nothing
    set gg_trg_Shinki04 = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Shinki04, EVENT_PLAYER_UNIT_SUMMON)
    call TriggerAddCondition(gg_trg_Shinki04, Condition(function Trig_Shinki04_Conditions))
    call TriggerAddAction(gg_trg_Shinki04, function Trig_Shinki04_Actions)
endfunction