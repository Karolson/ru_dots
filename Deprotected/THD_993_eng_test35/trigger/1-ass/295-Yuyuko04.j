function Trig_Yuyuko04_Conditions1 takes nothing returns boolean
    return GetSpellAbilityId() == 'A05C'
endfunction

function Trig_Yuyuko04_Target takes nothing returns boolean
    if IsUnitType(GetFilterUnit(), UNIT_TYPE_DEAD) then
        return false
    elseif IsUnitType(GetFilterUnit(), UNIT_TYPE_MECHANICAL) then
        return false
    elseif GetUnitAbilityLevel(GetFilterUnit(), 'Aloc') != 0 then
        return false
    elseif IsUnitAlly(GetFilterUnit(), GetOwningPlayer(LoadUnitHandle(udg_ht, GetHandleId(GetExpiredTimer()), 0))) then
        return false
    elseif IsUnitInvulnerable(GetFilterUnit()) then
        return false
    elseif GetUnitAbilityLevel(GetFilterUnit(), 'A0IL') > 0 then
        return false
    endif
    return true
endfunction

function Trig_Yuyuko04_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit u
    local real x
    local real y
    local real a
    local real t1 = udg_YuyukoTimer[GetPlayerId(GetOwningPlayer(caster))]
    local group g
    local boolexpr f
    local real hp
    local integer level = LoadInteger(udg_ht, task, 0)
    local integer i = LoadInteger(udg_ht, task, 1)
    local real i1 = LoadReal(udg_ht, task, 2)
    local integer j
    local integer k
    if i1 == 0 then
        if i > 0 and GetWidgetLife(caster) > 0.405 then
            set g = CreateGroup()
            set f = Filter(function Trig_Yuyuko04_Target)
            call GroupEnumUnitsInRange(g, GetUnitX(caster), GetUnitY(caster), 650, f)
            set u = GroupPickRandomUnit(g)
            if u != null then
                set hp = GetWidgetLife(u)
                if IsUnitType(u, UNIT_TYPE_HERO) then
                    call UnitAbsDamageTarget(caster, u, (GetUnitState(u, UNIT_STATE_MAX_LIFE) - hp) * 0.35)
                else
                    call UnitAbsDamageTarget(caster, u, 800)
                endif
                call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Items\\TomeOfRetraining\\TomeOfRetrainingCaster.mdl", u, "origin"))
                set x = GetUnitX(u)
                set y = GetUnitY(u)
                set u = NewDummy(GetOwningPlayer(caster), x, y, 0.0)
                call SetUnitScale(u, 2.0, 2.0, 2.0)
                set k = 'A05G' + GetRandomInt(0, 3)
                call UnitAddAbility(u, k)
                set j = 1
                loop
                    set a = j * 36.0
                    call IssuePointOrder(u, "carrionswarm", x + 100 * CosBJ(a), y + 100 * SinBJ(a))
                    set j = j + 1
                exitwhen j > 10
                endloop
                call SetUnitScale(u, 1.0, 1.0, 1.0)
                call UnitRemoveAbility(u, k)
                call ReleaseDummy(u)
            endif
            call DestroyGroup(g)
            call DestroyBoolExpr(f)
            call SaveInteger(udg_ht, task, 1, i - 1)
            if i - 1 > 0 then
                set i1 = i1 + 6
                call SaveReal(udg_ht, task, 2, i1)
            endif
            call SetUnitTimeScale(caster, 1)
            call TimerStart(t, 0.05 + udg_YuyukoTimer[GetPlayerId(GetOwningPlayer(caster))], false, function Trig_Yuyuko04_Main)
            set udg_YuyukoTimer[GetPlayerId(GetOwningPlayer(caster))] = 0
        else
            set t1 = 0
            set udg_YuyukoBool[GetPlayerId(GetOwningPlayer(caster))] = false
            set udg_YuyukoTimer[GetPlayerId(GetOwningPlayer(caster))] = 0
            set u = LoadUnitHandle(udg_sht, GetHandleId(caster), 0)
            call SetUnitTimeScale(caster, 1)
            call PauseUnit(caster, false)
            call IssueImmediateOrder(caster, "stop")
            call KillUnit(u)
            call ReleaseTimer(t)
            call FlushChildHashtable(udg_ht, task)
        endif
        set t = null
        set caster = null
        set u = null
        set g = null
        set f = null
    else
        set i1 = i1 - 1
        call SaveReal(udg_ht, task, 2, i1)
        call TimerStart(t, 0.05 + udg_YuyukoTimer[GetPlayerId(GetOwningPlayer(caster))], false, function Trig_Yuyuko04_Main)
        set udg_YuyukoTimer[GetPlayerId(GetOwningPlayer(caster))] = 0
    endif
endfunction

function Yuyuko04_Delayed_Cast takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local integer n = LoadInteger(udg_ht, task, 1)
    local unit u
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    if GetWidgetLife(caster) > 0.405 then
        call PauseTimer(t)
        call UnitMagicDamageArea(caster, GetUnitX(caster), GetUnitY(caster), 600, ABCIAllInt(caster, 150, 1.5), 6)
        call TimerStart(t, 0.35, false, function Trig_Yuyuko04_Main)
    else
        set udg_YuyukoBool[GetPlayerId(GetOwningPlayer(caster))] = false
        set udg_YuyukoTimer[GetPlayerId(GetOwningPlayer(caster))] = 0
        set u = LoadUnitHandle(udg_sht, GetHandleId(caster), 0)
        call IssueImmediateOrder(caster, "stop")
        call KillUnit(u)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
endfunction

function Trig_Yuyuko04_Actions1 takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local timer t
    local integer task
    local unit u
    local real ox
    local real oy
    local real i1 = 7.0
    local integer level = GetUnitAbilityLevel(caster, 'A05C')
    local integer n
    local real a = GetUnitFacing(caster)
    if GetTriggerEventId() == EVENT_UNIT_SPELL_EFFECT then
        call AbilityCoolDownResetion(caster, 'A05C', 120)
        call VE_Spellcast(caster)
        call ClearAllNegativeBuff(caster, true)
        set ox = GetUnitX(caster)
        set oy = GetUnitY(caster)
        if 0.0 <= a and a < 45.0 then
            set a = 45.0
        elseif 45.0 <= a and a < 135.0 then
            set a = 90.0
        elseif 135.0 <= a and a < 180.0 then
            set a = 135.0
        elseif 180.0 <= a and a < 225.0 then
            set a = 225.0
        elseif 225.0 <= a and a < 315.0 then
            set a = 270.0
        else
            set a = 315.0
        endif
        call SetUnitFacing(caster, a)
        set u = CreateUnit(GetOwningPlayer(caster), 'h00P', ox, oy, a)
        call SaveUnitHandle(udg_sht, GetHandleId(caster), 0, u)
        set n = 4 + level
        set t = CreateTimer()
        set task = GetHandleId(t)
        call SaveUnitHandle(udg_ht, task, 0, caster)
        call SaveInteger(udg_ht, task, 0, level)
        call SaveInteger(udg_ht, task, 1, n)
        call SaveReal(udg_ht, task, 2, i1)
        call PauseUnit(caster, true)
        set udg_YuyukoBool[GetPlayerId(GetOwningPlayer(caster))] = true
        call TimerStart(t, 1.7, false, function Yuyuko04_Delayed_Cast)
    endif
    set caster = null
    set t = null
    set u = null
endfunction

function InitTrig_Yuyuko04 takes nothing returns nothing
endfunction