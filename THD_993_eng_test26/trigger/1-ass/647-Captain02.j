function Trig_Captain02_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0AA'
endfunction

function Trig_Captain02_Target takes nothing returns boolean
    if GetUnitAbilityLevel(GetFilterUnit(), 'Aloc') != 0 then
        return false
    elseif IsUnitType(GetFilterUnit(), UNIT_TYPE_STRUCTURE) then
        return false
    elseif GetCustomState(GetFilterUnit(), 5) != 0 then
        return false
    elseif GetCustomState(GetFilterUnit(), 1) != 0 then
        return false
    elseif IsUnitAntiDebuff(GetFilterUnit()) then
        return false
    elseif IsUnitType(GetFilterUnit(), UNIT_TYPE_GIANT) then
        return false
    elseif GetUnitAbilityLevel(GetFilterUnit(), 'B04B') >= 1 then
        return false
    elseif GetUnitAbilityLevel(GetFilterUnit(), 'BOvc') >= 1 then
        return false
    elseif GetUnitAbilityLevel(GetFilterUnit(), 'B052') >= 1 then
        return false
    elseif GetUnitAbilityLevel(GetFilterUnit(), 'Avul') >= 1 then
        return false
    endif
    return IsMobileUnit(GetFilterUnit())
endfunction

function Trig_Captain02_Damage takes nothing returns nothing
    local integer task = GetHandleId(GetExpiredTimer())
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local integer level = LoadInteger(udg_ht, task, 0)
    call UnitMagicDamageTarget(caster, GetEnumUnit(), 20 + level * 10, 6)
    set caster = null
endfunction

function Trig_Captain02_Release takes nothing returns nothing
    local unit u = GetEnumUnit()
    call PauseUnit(u, false)
    call SetUnitPathing(u, true)
    call SetUnitFlag(u, 2, false)
    call SetUnitFlag(u, 3, false)
    set u = null
endfunction

function Trig_Captain02_Rise takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local real tx = LoadReal(udg_ht, task, 0)
    local real ty = LoadReal(udg_ht, task, 1)
    local unit u = GetEnumUnit()
    call SetUnitXY(u, tx, ty)
    call ShowUnitXumn(u, true)
    call PauseUnit(u, false)
    call SetUnitPathing(u, false)
    call SetUnitFlag(u, 3, false)
    call SetUnitFlag(u, 2, false)
    call SetUnitFlag(u, 1, false)
    call EnableHeight(u)
    call SetUnitFlyHeight(u, 400.0, 500.0)
    set u = null
    set t = null
endfunction

function Trig_Captain02_Fall takes nothing returns nothing
    local unit u = GetEnumUnit()
    call SetUnitFlyHeight(u, 0.0, 600.0)
    call SetUnitPathing(u, true)
    if GetLocalPlayer() == GetOwningPlayer(u) then
        call ClearSelection()
        call SelectUnit(u, true)
    endif
    set u = null
endfunction

function Trig_Captain02_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit u = LoadUnitHandle(udg_ht, task, 1)
    local unit v
    local real ox
    local real oy
    local real tx = LoadReal(udg_ht, task, 0)
    local real ty = LoadReal(udg_ht, task, 1)
    local real r
    local real a
    local real d
    local integer level = LoadInteger(udg_ht, task, 0)
    local integer i = LoadInteger(udg_ht, task, 1)
    local boolexpr f = Filter(function Trig_Captain02_Target)
    local group w = LoadGroupHandle(udg_ht, task, 2)
    local group m = LoadGroupHandle(udg_ht, task, 3)
    local group g
    if i <= 100 then
        call SaveInteger(udg_ht, task, 1, i + 1)
        set r = 100.0 + 60.0 * level
        loop
            set v = FirstOfGroup(w)
        exitwhen v == null
            call GroupRemoveUnit(w, v)
            if not IsUnitInRange(v, u, r) then
                call PauseUnit(v, false)
                call SetUnitPathing(v, true)
                call SetUnitFlag(v, 2, false)
            endif
        endloop
        set d = 3.0 + 2.0 * level
        set g = CreateGroup()
        call GroupEnumUnitsInRange(g, tx, ty, r, f)
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if IsUnitAlly(v, GetOwningPlayer(caster)) == false then
                call PauseUnit(v, true)
                call SetUnitPathing(v, false)
                call SetUnitFlag(v, 3, true)
                call SetUnitFlag(v, 2, true)
                set ox = GetUnitX(v)
                set oy = GetUnitY(v)
                set a = Atan2(ty - oy, tx - ox) - bj_DEGTORAD * 60.0
                call SetUnitXY(v, ox + d * Cos(a), oy + d * Sin(a))
                if IsUnitInRange(v, u, 30.0) then
                    call ShowUnit(v, false)
                    call SetUnitFlag(v, 1, true)
                    call GroupAddUnit(m, v)
                else
                    call GroupAddUnit(w, v)
                endif
            endif
        endloop
        call DestroyBoolExpr(f)
        call DestroyGroup(g)
        if i / 25 * 25 == i then
            call ForGroup(m, function Trig_Captain02_Damage)
        endif
        if i / 6 * 6 == i then
            set u = CreateUnit(GetOwningPlayer(caster), 'e00S', ox, oy, 0)
            call UnitApplyTimedLife(u, 'BTLF', 1.0)
        endif
    elseif i == 101 then
        call SaveInteger(udg_ht, task, 1, i + 1)
        call RemoveUnit(u)
        call DestroyEffect(AddSpecialEffect("Objects\\Spawnmodels\\Naga\\NagaDeath\\NagaDeath.mdl", tx, ty))
        call ForGroup(w, function Trig_Captain02_Release)
        call ForGroup(m, function Trig_Captain02_Rise)
        call TimerStart(t, 1.0, false, function Trig_Captain02_Main)
    elseif i == 102 then
        call ForGroup(m, function Trig_Captain02_Fall)
        call DestroyGroup(w)
        call DestroyGroup(m)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set u = null
    set v = null
    set w = null
    set m = null
    set g = null
    set f = null
endfunction

function Trig_Captain02_Frame takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit u
    local real tx = LoadReal(udg_ht, task, 0)
    local real ty = LoadReal(udg_ht, task, 1)
    local real s
    local integer level = LoadInteger(udg_ht, task, 0)
    local integer i = LoadInteger(udg_ht, task, 1)
    local group g1 = CreateGroup()
    local group g2 = CreateGroup()
    set s = 2.0 + level
    set u = CreateUnit(GetOwningPlayer(caster), 'e00R', tx, ty, 270.0)
    call SetUnitScale(u, s, s, s)
    call PlaySoundOnUnitBJ(gg_snd_BattleShipDeath1, 100, u)
    call SaveUnitHandle(udg_ht, task, 1, u)
    call SaveGroupHandle(udg_ht, task, 2, g1)
    call SaveGroupHandle(udg_ht, task, 3, g2)
    call SaveInteger(udg_ht, task, 1, i + 1)
    call TimerStart(t, 0.03, true, function Trig_Captain02_Main)
    set g1 = null
    set g2 = null
    set t = null
    set caster = null
    set u = null
endfunction

function Trig_Captain02_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real tx = GetSpellTargetX()
    local real ty = GetSpellTargetY()
    local real a = bj_RADTODEG * Atan2(ty - oy, tx - ox)
    local real d = SquareRoot(Pow(ty - oy, 2) + Pow(tx - ox, 2))
    local integer level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 25)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveInteger(udg_ht, task, 0, level)
    call SaveInteger(udg_ht, task, 1, 0)
    call SaveReal(udg_ht, task, 0, tx)
    call SaveReal(udg_ht, task, 1, ty)
    call TimerStart(t, 1.5, false, function Trig_Captain02_Frame)
    set caster = null
    set t = null
endfunction

function InitTrig_Captain02 takes nothing returns nothing
endfunction