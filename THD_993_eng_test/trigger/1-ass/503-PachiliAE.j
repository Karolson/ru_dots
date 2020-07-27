function Trig_PachiliAE_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0WF'
endfunction

function Trig_PachiliAE_Effect_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit target = LoadUnitHandle(udg_ht, task, 1)
    local integer level = LoadInteger(udg_ht, task, 2)
    local integer i = LoadInteger(udg_ht, task, 3)
    local real x = LoadReal(udg_ht, task, 4)
    local real y = LoadReal(udg_ht, task, 5)
    local real h = (i - 40) * (i - 40) / 2
    call SetUnitFlyHeight(target, 800 - h, 0)
    call SaveInteger(udg_ht, task, 3, i + 1)
    call SetUnitXY(target, x, y)
    if i > 80 then
        call SetUnitFlyHeight(target, GetUnitDefaultFlyHeight(target), 0)
        call SetUnitPathing(target, true)
        call SetUnitFlag(target, 4, false)
        call SetUnitFlag(target, 3, false)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set target = null
endfunction

function Trig_PachiliAE_Effect_Start takes unit caster, unit target, integer level returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local real ox = GetUnitX(target)
    local real oy = GetUnitY(target)
    call SetUnitPathing(target, false)
    call EnableHeight(target)
    call SetUnitFlag(target, 4, true)
    call SetUnitFlag(target, 3, true)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, target)
    call SaveInteger(udg_ht, task, 2, level)
    call SaveInteger(udg_ht, task, 3, 1)
    call SaveReal(udg_ht, task, 4, GetUnitX(target))
    call SaveReal(udg_ht, task, 5, GetUnitY(target))
    call TimerStart(t, 0.02, true, function Trig_PachiliAE_Effect_Main)
    call Public_PacQ_MagicDamage(caster, target, 53 + 53 * level + 2.3 * GetHeroInt(caster, true), 5)
    set t = null
endfunction

function Trig_PachiliAE_Stone_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit u = LoadUnitHandle(udg_ht, task, 0)
    local integer i = LoadInteger(udg_ht, task, 1)
    call SetUnitScale(u, 0.1 * i, 0.1 * i, 0.1 * i)
    call SaveInteger(udg_ht, task, 1, i + 1)
    if i >= 10 then
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set u = null
endfunction

function Trig_PachiliAE_Stone_Start takes unit u returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call SetUnitScale(u, 0.1, 0.1, 0.1)
    call SaveUnitHandle(udg_ht, task, 0, u)
    call SaveInteger(udg_ht, task, 1, 2)
    call TimerStart(t, 0.01, true, function Trig_PachiliAE_Stone_Main)
    set t = null
endfunction

function Trig_PachiliAE_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit u
    local unit v
    local integer level = GetUnitAbilityLevel(caster, 'A0WF')
    local real x = GetUnitX(caster)
    local real y = GetUnitY(caster)
    local integer i
    local group g
    local boolexpr iff
    call Public_PacQ_AbilityCoolDownRestore(caster, level, 'A0WF')
    set i = 0
    loop
        if level == 1 then
            set u = CreateUnit(GetOwningPlayer(caster), 'h01S', x + 144 * Cos(i * 72 * 0.017454), y + 144 * Sin(i * 72 * 0.017454), 72 * i)
        elseif level == 2 then
            set u = CreateUnit(GetOwningPlayer(caster), 'h01S', x + 160 * Cos(i * 72 * 0.017454), y + 160 * Sin(i * 72 * 0.017454), 72 * i)
        elseif level == 3 then
            set u = CreateUnit(GetOwningPlayer(caster), 'h01S', x + 186 * Cos(i * 72 * 0.017454), y + 186 * Sin(i * 72 * 0.017454), 72 * i)
        elseif level == 4 then
            set u = CreateUnit(GetOwningPlayer(caster), 'h01S', x + 213 * Cos(i * 72 * 0.017454), y + 213 * Sin(i * 72 * 0.017454), 72 * i)
        endif
        call Trig_PachiliAE_Stone_Start(u)
    exitwhen i == 4
        set i = i + 1
    endloop
    set g = CreateGroup()
    set iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    call GroupEnumUnitsInRange(g, x, y, 160 + level * 40, iff)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if IsUnitType(v, UNIT_TYPE_DEAD) == false and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false and GetUnitAbilityLevel(v, 'Avul') == 0 then
            call Trig_PachiliAE_Effect_Start(caster, v, level)
        endif
    endloop
    call DestroyGroup(g)
    set caster = null
    set u = null
    set v = null
    set g = null
    set iff = null
endfunction

function InitTrig_PachiliAE takes nothing returns nothing
endfunction