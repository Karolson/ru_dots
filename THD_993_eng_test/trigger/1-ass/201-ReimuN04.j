function Trig_ReimuN04_Danmaku_Main takes nothing returns nothing
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
    local real v = RMaxBJ(LoadReal(udg_ht, task, 4) - 0.2, 0.1)
    local real a = LoadReal(udg_ht, task, 5) + 0.012
    local real ax = v * CosBJ(angle)
    local real ay = v * SinBJ(angle)
    local group g
    local unit v2
    local boolexpr iif = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    local integer cnt = LoadInteger(udg_ht, task, 7) - 1
    call SaveInteger(udg_ht, task, 7, cnt)
    call SaveReal(udg_ht, task, 5, a)
    if a < 0 then
        set a = 0
    endif
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
        set dis = 99999
    endif
    set g = CreateGroup()
    call GroupEnumUnitsInRange(g, GetUnitX(u), GetUnitY(u), 250.0, iif)
    loop
        set v2 = FirstOfGroup(g)
    exitwhen v2 == null
        call GroupRemoveUnit(g, v2)
        if GetWidgetLife(v2) > 0.405 and IsUnitType(v2, UNIT_TYPE_STRUCTURE) == false then
            if IsUnitType(v2, UNIT_TYPE_HERO) then
                call UnitMagicDamageTarget(caster, v2, ABCIAllInt(caster, 30 + level * 60, 0.3), 1)
                call UnitStunTarget(caster, v2, 0.1, 0, 0)
                call UnitSlowTarget(caster, v2, 1.5, 'A1GC' + level, 'B0A2')
                set dis = 99999
            endif
        endif
    endloop
    call DestroyGroup(g)
    if GetWidgetLife(target) >= 0.405 == false or dis >= 3600 then
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Undead\\FreezingBreath\\FreezingBreathMissile.mdl", GetUnitX(u), GetUnitY(u)))
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Human\\Thunderclap\\ThunderClapCaster.mdl", GetUnitX(u), GetUnitY(u)))
        call DestroyEffect(AddSpecialEffect("Units\\NightElf\\Wisp\\WispExplode.mdl", GetUnitX(u), GetUnitY(u)))
        call ReleaseTimer(t)
        call KillUnit(u)
        call FlushChildHashtable(udg_ht, task)
    endif
    set u = null
    set t = null
    set g = null
    set v2 = null
    set iif = null
    set caster = null
    set target = null
endfunction

function Trig_ReimuN04_Danmaku takes unit caster, unit target, integer level returns nothing
    local timer t
    local integer task
    local unit u
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real tx = GetUnitX(target)
    local real ty = GetUnitY(target)
    local real a = Atan2(ty - oy, tx - ox)
    local integer j = 0
    loop
    exitwhen j >= 2
        set t = CreateTimer()
        set task = GetHandleId(t)
        set u = CreateUnit(GetOwningPlayer(caster), 'n00S' + GetRandomInt(1, 3), ox, oy, bj_RADTODEG * a + 150)
        call SetUnitPathing(u, false)
        call SaveUnitHandle(udg_ht, task, 0, caster)
        call SaveInteger(udg_ht, task, 1, level)
        call SaveUnitHandle(udg_ht, task, 2, u)
        call SaveUnitHandle(udg_ht, task, 3, target)
        call SaveReal(udg_ht, task, 4, 10)
        call SaveReal(udg_ht, task, 5, -0.1)
        call SaveReal(udg_ht, task, 6, bj_RADTODEG * a + 90 + 180 * j)
        call SaveInteger(udg_ht, task, 7, 200)
        call TimerStart(t, 0.02, true, function Trig_ReimuN04_Danmaku_Main)
        set j = j + 1
    endloop
endfunction

function Trig_ReimuN04_Reset_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 1)
    call UnitRemoveAbility(caster, 'A1GA')
    call UnitRemoveAbility(caster, 'A1G9')
    call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A1G8', true)
    call FlushChildHashtable(udg_ht, task)
    set caster = null
    set t = null
endfunction

function Trig_ReimuN04_Reset takes unit caster, real coldtime returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call SaveUnitHandle(udg_ht, task, 1, caster)
    call TimerStart(t, coldtime, false, function Trig_ReimuN04_Reset_Main)
    set t = null
endfunction

function Trig_ReimuN04_Conditions takes nothing returns boolean
    local unit caster
    local unit target
    local integer abid = GetSpellAbilityId()
    local integer level
    if abid != 'A1G8' and abid != 'A1G9' and abid != 'A1GA' then
        return false
    endif
    set caster = GetTriggerUnit()
    set target = GetSpellTargetUnit()
    set level = GetUnitAbilityLevel(caster, abid)
    if abid == 'A1G8' then
        call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A1G8', false)
        call UnitAddAbility(caster, 'A1G9')
        call SetUnitAbilityLevel(caster, 'A1G9', level)
        call SaveUnitHandle(udg_ht, GetHandleId(caster), -1 * 'A1G8', target)
    endif
    if abid == 'A1G9' then
        call UnitRemoveAbility(caster, 'A1G9')
        call UnitAddAbility(caster, 'A1GA')
        call SetUnitAbilityLevel(caster, 'A1GA', level)
    endif
    if abid == 'A1GA' then
        call UnitRemoveAbility(caster, 'A1GA')
        call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A1G8', true)
    endif
    set target = LoadUnitHandle(udg_ht, GetHandleId(caster), -1 * 'A1G8')
    if abid == 'A1G8' then
        call Trig_ReimuN04_Reset(caster, GetAbilityCoolDownTime(caster, abid, 160 - level * 30))
        call AbilityCoolDownResetion(caster, abid, 160 - level * 30)
    endif
    call Trig_ReimuN04_Danmaku(caster, target, level)
    set caster = null
    set target = null
    return false
    return true
endfunction

function Trig_ReimuN04_Actions takes nothing returns nothing
endfunction

function InitTrig_ReimuN04 takes nothing returns nothing
    set gg_trg_ReimuN04 = CreateTrigger()
    call DisableTrigger(gg_trg_ReimuN04)
    call TriggerAddCondition(gg_trg_ReimuN04, Condition(function Trig_ReimuN04_Conditions))
    call TriggerAddAction(gg_trg_ReimuN04, function Trig_ReimuN04_Actions)
endfunction