function Trig_Shizuha04_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0J6'
endfunction

function Trig_Shizuha04_Go takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit u = LoadUnitHandle(udg_ht, task, 1)
    local unit v
    local group m = LoadGroupHandle(udg_ht, task, 2)
    local group g
    local real a = LoadReal(udg_ht, task, 3)
    local integer i = LoadInteger(udg_ht, task, 4)
    local real ox = GetUnitX(u)
    local real oy = GetUnitY(u)
    local real px
    local real py
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    local real damage = LoadReal(udg_ht, task, 5)
    local boolean k = false
    if i > 0 then
        set px = ox + 25 * Cos(a)
        set py = oy + 25 * Sin(a)
        if IsTerrainPathable(px, py, PATHING_TYPE_FLYABILITY) == false then
            call SetUnitXY(u, px, py)
            call SaveInteger(udg_ht, task, 4, i - 1)
        else
            call SaveInteger(udg_ht, task, 4, 0)
        endif
        set g = CreateGroup()
        call GroupEnumUnitsInRange(g, px, py, 60.0, iff)
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if GetWidgetLife(v) > 0.405 and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false and IsUnitInGroup(v, m) == false then
                call GroupAddUnit(m, v)
                if GetUnitAbilityLevel(v, 'A0JA') == 0 then
                    call UnitBuffTarget(caster, v, 0.5, 'A0JA', 0)
                    call UnitDamageTarget(caster, v, damage, true, false, ATTACK_TYPE_HERO, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
                else
                    call UnitPhysicalDamageTarget(caster, v, damage)
                endif
                set k = true
            endif
        endloop
        call DestroyGroup(g)
        if k then
            call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\HydraliskImpact\\HydraliskImpact.mdl", GetUnitX(u), GetUnitY(u)))
            call SaveInteger(udg_ht, task, 4, 0)
        endif
    else
        if IsUnitType(u, UNIT_TYPE_DEAD) == false then
            call RemoveUnit(u)
        endif
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

function Trig_Shizuha04_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local integer i = LoadInteger(udg_ht, task, 1)
    local real ox = LoadReal(udg_ht, task, 2)
    local real oy = LoadReal(udg_ht, task, 3)
    local real a = LoadReal(udg_ht, task, 4)
    local real damage = LoadReal(udg_ht, task, 5)
    local timer t2
    local integer task2
    local unit u
    local group m
    local real px
    local real py
    local real poyi
    if i > 0 then
        set m = CreateGroup()
        set poyi = GetRandomReal(-600, 600)
        set px = ox - 600 * Cos(a) + poyi * CosBJ(bj_RADTODEG * a - 90)
        set py = oy - 600 * Sin(a) + poyi * SinBJ(bj_RADTODEG * a - 90)
        set u = CreateUnit(GetOwningPlayer(caster), 'e02G', px, py, bj_RADTODEG * a)
        set t2 = CreateTimer()
        set task2 = GetHandleId(t2)
        call SaveUnitHandle(udg_ht, task2, 0, caster)
        call SaveUnitHandle(udg_ht, task2, 1, u)
        call SaveGroupHandle(udg_ht, task2, 2, m)
        call SaveReal(udg_ht, task2, 3, a)
        call SaveInteger(udg_ht, task2, 4, 48)
        call SaveReal(udg_ht, task2, 5, damage)
        call TimerStart(t2, 0.02, true, function Trig_Shizuha04_Go)
        call SaveInteger(udg_ht, task, 1, i - 1)
    else
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set t2 = null
    set u = null
    set m = null
endfunction

function Trig_Shizuha04_Actions takes nothing returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local unit caster = GetTriggerUnit()
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real tx = GetSpellTargetX()
    local real ty = GetSpellTargetY()
    local real dx = tx - ox
    local real dy = ty - oy
    local real a = Atan2(dy, dx)
    local integer level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    call VE_Spellcast(caster)
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 90)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveReal(udg_ht, task, 2, ox)
    call SaveReal(udg_ht, task, 3, oy)
    call SaveReal(udg_ht, task, 4, a)
    if level == 1 then
        call SaveInteger(udg_ht, task, 1, 54)
        call SaveReal(udg_ht, task, 5, 30 + GetUnitAttack(caster) * 0.15)
        call TimerStart(t, 0.08, true, function Trig_Shizuha04_Main)
    elseif level == 2 then
        call SaveInteger(udg_ht, task, 1, 120)
        call SaveReal(udg_ht, task, 5, 40 + GetUnitAttack(caster) * 0.15)
        call TimerStart(t, 0.06, true, function Trig_Shizuha04_Main)
    else
        call SaveInteger(udg_ht, task, 1, 198)
        call SaveReal(udg_ht, task, 5, 50 + GetUnitAttack(caster) * 0.15)
        call TimerStart(t, 0.05, true, function Trig_Shizuha04_Main)
    endif
    set t = null
    set caster = null
endfunction

function InitTrig_Shizuha04 takes nothing returns nothing
endfunction