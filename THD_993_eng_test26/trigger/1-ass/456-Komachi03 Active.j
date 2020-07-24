function Komachi03_Active_Conditions takes nothing returns boolean
    local unit u
    if GetTriggerEventId() == EVENT_UNIT_SPELL_CAST and GetSpellAbilityId() == 'A0CN' then
        set u = GetTriggerUnit()
        if not HaveSavedHandle(udg_sht, StringHash("Komachi03"), GetHandleId(u)) then
            call PauseUnit(u, true)
            call IssueImmediateOrder(u, "stop")
            call PauseUnit(u, false)
            call DisplayTextToPlayer(GetOwningPlayer(u), 0, 0, "No souls available!")
        endif
        set u = null
        return false
    endif
    set u = null
    return GetSpellAbilityId() == 'A0CN'
endfunction

function Komachi03_Explosion_Damage takes nothing returns boolean
    local unit target = GetFilterUnit()
    if GetWidgetLife(target) > 0.405 and IsUnitEnemy(target, bj_groupEnumOwningPlayer) and not IsUnitType(target, UNIT_TYPE_STRUCTURE) and not (GetUnitAbilityLevel(target, 'A0IL') > 0) then
        call UnitMagicDamageTarget(bj_groupRandomCurrentPick, target, 20.0 + 0.02 * GetUnitState(target, UNIT_STATE_MAX_LIFE), 5)
    endif
    set target = null
    return false
endfunction

function Komachi03_Move_Spirit takes nothing returns nothing
    local unit u = GetEnumUnit()
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_sht, task, 1)
    local player p = LoadPlayerHandle(udg_sht, task, 2)
    local real cx = GetUnitX(u)
    local real cy = GetUnitY(u)
    local real tx = LoadReal(udg_sht, task, 3)
    local real ty = LoadReal(udg_sht, task, 4)
    local real a = Atan2(ty - cy, tx - cx)
    local group g
    local boolexpr f
    local unit v
    if IsUnitInRangeXY(u, tx, ty, 18.75) then
        set g = CreateGroup()
        set f = LoadBooleanExprHandle(udg_sht, task, 5)
        call GroupEnumUnitsInRange(g, tx, ty, 250, null)
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if GetWidgetLife(v) > 0.405 and IsUnitEnemy(v, p) and not IsUnitType(v, UNIT_TYPE_STRUCTURE) and not (GetUnitAbilityLevel(v, 'A0IL') > 0) then
                call UnitMagicDamageTarget(caster, v, 25.0 + 0.02 * GetUnitState(v, UNIT_STATE_MAX_LIFE), 5)
            endif
        endloop
        call KillUnit(u)
        call DestroyGroup(g)
        call GroupRemoveUnit(LoadGroupHandle(udg_sht, task, 0), u)
    else
        call SetUnitX(u, cx + 18.75 * Cos(a))
        call SetUnitY(u, cy + 18.75 * Sin(a))
    endif
    set caster = null
    set u = null
    set v = null
    set p = null
    set g = null
    set f = null
    set t = null
endfunction

function Komachi03_Send_Spirit_Loop takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local group g = LoadGroupHandle(udg_sht, task, 0)
    local unit u = LoadUnitHandle(udg_sht, task, 1)
    local boolexpr f
    local integer count
    call ForGroup(g, function Komachi03_Move_Spirit)
    set bj_groupCountUnits = 0
    call ForGroup(g, function CountUnitsInGroupEnum)
    set count = bj_groupCountUnits
    set bj_groupCountUnits = 0
    call SaveInteger(udg_sht, StringHash("Komachi03"), GetHandleId(u), count)
    if count == 0 then
        call DestroyGroup(g)
        call ReleaseTimer(t)
        set f = LoadBooleanExprHandle(udg_sht, task, 5)
        call DestroyBoolExpr(f)
        call FlushChildHashtable(udg_sht, task)
    endif
    set u = null
    set f = null
    set t = null
    set g = null
endfunction

function Komachi03_Active_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local timer t = LoadTimerHandle(udg_sht, StringHash("Komachi03"), GetHandleId(caster))
    local integer task = GetHandleId(t)
    local group g = LoadGroupHandle(udg_sht, task, 0)
    local boolexpr f = Filter(function Komachi03_Explosion_Damage)
    call AbilityCoolDownResetion(caster, 'A0CN', 12)
    call RemoveSavedHandle(udg_sht, StringHash("Komachi03"), GetHandleId(caster))
    call SavePlayerHandle(udg_sht, task, 2, GetOwningPlayer(caster))
    call SaveReal(udg_sht, task, 3, GetSpellTargetX())
    call SaveReal(udg_sht, task, 4, GetSpellTargetY())
    call SaveBooleanExprHandle(udg_sht, task, 5, f)
    call PauseTimer(t)
    call TimerStart(t, 0.02, true, function Komachi03_Send_Spirit_Loop)
    set caster = null
    set t = null
    set g = null
    set f = null
endfunction

function InitTrig_Komachi03_Active takes nothing returns nothing
endfunction