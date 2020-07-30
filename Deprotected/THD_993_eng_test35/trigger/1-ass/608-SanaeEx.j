function Trig_Sanae03_Shoot_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit target = LoadUnitHandle(udg_ht, task, 1)
    local unit u = LoadUnitHandle(udg_ht, task, 2)
    local integer level = LoadInteger(udg_ht, task, 0)
    local integer i = LoadInteger(udg_ht, task, 1)
    if i > 0 then
        call SetUnitX(u, GetUnitX(target))
        call SetUnitY(u, GetUnitY(target))
        call SaveInteger(udg_ht, task, 1, i - 1)
    else
        call UnitMagicDamageArea(caster, GetUnitX(target), GetUnitY(target), 250, ABCIAllInt(caster, 0, 4.0), 5)
        call KillUnit(u)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set target = null
    set u = null
endfunction

function Trig_Sanae03_Shoot takes unit caster, unit target, integer level returns nothing
    local real tx = GetUnitX(target)
    local real ty = GetUnitY(target)
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local unit u = CreateUnit(GetOwningPlayer(caster), 'n03C', GetUnitX(target), GetUnitY(target), 0.0)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, target)
    call SaveUnitHandle(udg_ht, task, 2, u)
    call SaveInteger(udg_ht, task, 0, level)
    call SaveInteger(udg_ht, task, 1, 16)
    call TimerStart(t, 0.05, true, function Trig_Sanae03_Shoot_Main)
    set u = null
    set t = null
endfunction

function Trig_SanaeEx_Actions takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local integer r
    local group g
    local unit v
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    if caster == null then
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
        set t = null
        set caster = null
        return
    endif
    set r = GetRandomInt(0, 100)
    if r < 1 + GetUnitAbilityLevel(caster, 'A0G6') then
        set g = CreateGroup()
        call GroupEnumUnitsInRange(g, GetUnitX(caster), GetUnitY(caster), 900.0, iff)
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if GetWidgetLife(v) > 0.405 and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false then
                if IsUnitType(v, UNIT_TYPE_HERO) then
                    call Trig_Sanae03_Shoot(caster, v, 1)
                endif
            endif
        endloop
        call DestroyGroup(g)
    endif
    set g = null
    set v = null
    set iff = null
    set t = null
    set caster = null
endfunction

function InitTrig_SanaeEx takes nothing returns nothing
endfunction