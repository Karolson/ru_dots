function Trig_Captain01_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0AB'
endfunction

function Trig_Captain01_Target takes nothing returns boolean
    local unit caster = LoadUnitHandle(udg_ht, GetHandleId(GetExpiredTimer()), 0)
    if caster == GetFilterUnit() then
        set caster = null
        return false
    elseif IsUnitType(GetFilterUnit(), UNIT_TYPE_DEAD) then
        set caster = null
        return false
    elseif IsUnitType(GetFilterUnit(), UNIT_TYPE_STRUCTURE) then
        set caster = null
        return false
    elseif IsUnitType(GetFilterUnit(), UNIT_TYPE_ANCIENT) then
        set caster = null
        return false
    elseif GetCustomState(GetFilterUnit(), 5) != 0 then
        set caster = null
        return false
    elseif GetCustomState(GetFilterUnit(), 1) != 0 then
        set caster = null
        return false
    elseif IsUnitAntiDebuff(GetFilterUnit()) then
        set caster = null
        return false
    elseif GetUnitAbilityLevel(GetFilterUnit(), 'B04B') >= 1 then
        set caster = null
        return false
    elseif GetUnitAbilityLevel(GetFilterUnit(), 'BOvc') >= 1 then
        set caster = null
        return false
    elseif GetUnitAbilityLevel(GetFilterUnit(), 'A0IL') > 0 then
        set caster = null
        return false
    endif
    set caster = null
    return IsMobileUnit(GetFilterUnit())
endfunction

function Trig_Captain01_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit target = LoadUnitHandle(udg_ht, task, 2)
    local unit u
    local unit v = LoadUnitHandle(udg_ht, task, 1)
    local group g = CreateGroup()
    local real damage = LoadReal(udg_ht, task, 0)
    local real a = LoadReal(udg_ht, task, 1)
    local real ox = LoadReal(udg_ht, task, 2)
    local real oy = LoadReal(udg_ht, task, 3)
    local real px
    local real py
    local boolexpr f = Filter(function Trig_Captain01_Target)
    local integer i = LoadInteger(udg_ht, task, 1)
    local integer z = LoadInteger(udg_ht, task, 2)
    local boolean k = LoadBoolean(udg_ht, task, 3)
    if i < z and z != 0 then
        set px = ox + 20 * i * Cos(a * 0.017454)
        set py = oy + 20 * i * Sin(a * 0.017454)
        set u = CreateUnit(GetOwningPlayer(caster), 'e00U', px, py, a)
        call SaveUnitHandle(udg_ht, task, 3 + i, u)
        if v != null then
            call SetUnitXY(v, px + 50 * Cos(a * 0.017454), py + 50 * Sin(a * 0.017454))
        else
            set v = CreateUnit(GetOwningPlayer(caster), 'e00T', px + 60 * Cos(a * 0.017454), py + 60 * Sin(a * 0.017454), a)
            call SaveUnitHandle(udg_ht, task, 1, v)
        endif
        if i > 3 and k == false then
            call GroupEnumUnitsInRange(g, px, py, 100, f)
            if FirstOfGroup(g) != null then
                set target = FirstOfGroup(g)
                call SetUnitFlag(target, 3, true)
                if IsUnitEnemy(target, GetOwningPlayer(caster)) then
                    call UnitAbsDamageTarget(caster, target, damage)
                    call UnitStunTarget(caster, target, 1.2, 0, 0)
                endif
                call SaveUnitHandle(udg_ht, task, 2, target)
                call SaveBoolean(udg_ht, task, 3, true)
                call SaveInteger(udg_ht, task, 2, 0)
            endif
        endif
        set i = i + 1
        if i == z or GetUnitCurrentOrder(caster) != OrderId("thunderbolt") then
            set z = 0
            call SaveInteger(udg_ht, task, 2, z)
        endif
        call SaveInteger(udg_ht, task, 1, i)
    elseif i != -1 and z == 0 then
        set px = ox + 20 * i * Cos(a * 0.017454)
        set py = oy + 20 * i * Sin(a * 0.017454)
        set v = LoadUnitHandle(udg_ht, task, 1)
        call SetUnitXY(v, px + 50 * Cos(a * 0.017454), py + 50 * Sin(a * 0.017454))
        if k then
            call SetUnitXY(target, px, py)
            if GetUnitAbilityLevel(target, 'A17X') == 0 and GetUnitAbilityLevel(target, 'A0PF') == 0 and GetUnitAbilityLevel(target, 'A0AN') == 0 and GetUnitCurrentOrder(target) != OrderId("metamorphosis") then
                call IssueImmediateOrder(target, "stop")
            endif
        else
            call GroupEnumUnitsInRange(g, px, py, 100, f)
            if FirstOfGroup(g) != null then
                set target = FirstOfGroup(g)
                if IsUnitEnemy(target, GetOwningPlayer(caster)) then
                    call UnitAbsDamageTarget(caster, target, damage)
                    call UnitStunTarget(caster, target, 1.0, 0, 0)
                endif
                call SaveUnitHandle(udg_ht, task, 2, target)
                call SaveBoolean(udg_ht, task, 3, true)
                call SetUnitFlag(target, 3, true)
            endif
        endif
        set u = LoadUnitHandle(udg_ht, task, 3 + i)
        call RemoveUnit(u)
        set i = i - 1
        call SaveInteger(udg_ht, task, 1, i)
    elseif i == -1 and z == 0 then
        if k then
            call SetUnitFlag(target, 3, false)
        endif
        call ReleaseTimer(t)
        call IssueImmediateOrder(caster, "stop")
        set v = LoadUnitHandle(udg_ht, task, 1)
        call SetUnitScale(v, 0.01, 0.01, 0.01)
        call KillUnit(v)
        call FlushChildHashtable(udg_ht, task)
    endif
    call DestroyBoolExpr(f)
    call DestroyGroup(g)
    set t = null
    set caster = null
    set target = null
    set u = null
    set v = null
    set g = null
    set f = null
endfunction

function Trig_Captain01_Actions takes nothing returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local unit caster = GetTriggerUnit()
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real tx = GetSpellTargetX()
    local real ty = GetSpellTargetY()
    local real a = 57.29578 * Atan2(ty - oy, tx - ox)
    local real d
    local integer level = GetUnitAbilityLevel(caster, 'A0AB')
    call AbilityCoolDownResetion(caster, 'A0AB', 10)
    if level == 1 then
        set d = 550
    elseif level == 2 then
        set d = 700
    elseif level == 3 then
        set d = 850
    elseif level == 4 then
        set d = 1000
    endif
    call SaveReal(udg_ht, task, 0, 45.0 + 45.0 * level)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveInteger(udg_ht, task, 1, 0)
    call SaveInteger(udg_ht, task, 2, R2I(d / 20))
    call SaveBoolean(udg_ht, task, 3, false)
    call SaveReal(udg_ht, task, 1, a)
    call SaveReal(udg_ht, task, 2, GetUnitX(caster) + 80 * Cos(a * 0.017454))
    call SaveReal(udg_ht, task, 3, GetUnitY(caster) + 80 * Sin(a * 0.017454))
    call TimerStart(t, 0.01, true, function Trig_Captain01_Main)
    set t = null
    set caster = null
endfunction

function InitTrig_Captain01 takes nothing returns nothing
endfunction