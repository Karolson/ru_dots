function Trig_Int05_MoonArrowEffect_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0VJ'
endfunction

function Trig_Int05_MoonArrowEffect_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit u = LoadUnitHandle(udg_ht, task, 1)
    local unit u2 = LoadUnitHandle(udg_ht, task, 3)
    local unit v
    local group m = LoadGroupHandle(udg_ht, task, 2)
    local group g
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    local real ox = GetUnitX(u)
    local real oy = GetUnitY(u)
    local real px
    local real py
    local real a = LoadReal(udg_ht, task, 0)
    local real d = LoadReal(udg_ht, task, 1)
    local integer int = LoadInteger(udg_ht, task, 0)
    local integer i = LoadInteger(udg_ht, task, 1)
    if i > 0 then
        set px = ox + d * Cos(a)
        set py = oy + d * Sin(a)
        if IsTerrainPathable(px, py, PATHING_TYPE_FLYABILITY) == false then
            call SetUnitXY(u, px, py)
            call SetUnitXY(u2, px, py)
            call SaveInteger(udg_ht, task, 1, i - 1)
        else
            call SaveInteger(udg_ht, task, 1, 0)
        endif
        set g = CreateGroup()
        call GroupEnumUnitsInRange(g, px, py, 100.0, iff)
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if GetWidgetLife(v) > 0.405 and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false and IsUnitInGroup(v, m) == false then
                call GroupAddUnit(m, v)
                if IsUnitType(v, UNIT_TYPE_HERO) then
                    call UnitMagicDamageTarget(caster, v, int * 3.5 + 100, 4)
                    call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\WardenMissile\\WardenMissile.mdl", GetUnitX(v), GetUnitY(v)))
                endif
            endif
        endloop
        call DestroyGroup(g)
    else
        call RemoveUnit(u)
        call RemoveUnit(u2)
        call ReleaseTimer(t)
        call DestroyGroup(m)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set u = null
    set u2 = null
    set v = null
    set m = null
    set g = null
    set iff = null
endfunction

function Trig_Int05_MoonArrowEffect_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit u
    local unit u2
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real tx = GetSpellTargetX()
    local real ty = GetSpellTargetY()
    local real a = Atan2(ty - oy, tx - ox)
    local group m = CreateGroup()
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    set u = CreateUnit(GetOwningPlayer(caster), 'e00K', ox, oy, bj_RADTODEG * a)
    set u2 = CreateUnit(GetOwningPlayer(caster), 'e022', ox, oy, bj_RADTODEG * a)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, u)
    call SaveGroupHandle(udg_ht, task, 2, m)
    call SaveUnitHandle(udg_ht, task, 3, u2)
    call SaveInteger(udg_ht, task, 0, GetHeroInt(caster, true))
    call SaveInteger(udg_ht, task, 1, 67)
    call SaveReal(udg_ht, task, 0, a)
    call SaveReal(udg_ht, task, 1, 24.0)
    call TimerStart(t, 0.02, true, function Trig_Int05_MoonArrowEffect_Main)
    set caster = null
    set u = null
    set u2 = null
    set m = null
    set t = null
endfunction

function InitTrig_Int05_MoonArrowEffect takes nothing returns nothing
    set gg_trg_Int05_MoonArrowEffect = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Int05_MoonArrowEffect, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Int05_MoonArrowEffect, Condition(function Trig_Int05_MoonArrowEffect_Conditions))
    call TriggerAddAction(gg_trg_Int05_MoonArrowEffect, function Trig_Int05_MoonArrowEffect_Actions)
endfunction