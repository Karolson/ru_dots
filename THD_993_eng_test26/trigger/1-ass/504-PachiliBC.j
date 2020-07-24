function Trig_PachiliBC_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0WH'
endfunction

function Trig_PachiliBC_Effect_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit target = LoadUnitHandle(udg_ht, task, 0)
    local real a = LoadReal(udg_ht, task, 1)
    local integer i = LoadInteger(udg_ht, task, 2)
    call SetUnitXYGround(target, GetUnitX(target) + 25 * Cos(a), GetUnitY(target) + 25 * Sin(a))
    if i * 5 / 5 == i then
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\CrushingWave\\CrushingWaveDamage.mdl", GetUnitX(target), GetUnitY(target)))
    endif
    call SaveInteger(udg_ht, task, 2, i - 1)
    if i == 0 then
        call SetUnitFlag(target, 3, false)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set target = null
endfunction

function Trig_PachiliBC_Effect_Start takes unit caster, unit target, integer level returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local real a = Atan2(GetUnitY(target) - GetUnitY(caster), GetUnitX(target) - GetUnitX(caster))
    call SetUnitFlag(target, 3, true)
    call SaveUnitHandle(udg_ht, task, 0, target)
    call SaveReal(udg_ht, task, 1, a)
    call SaveInteger(udg_ht, task, 2, 4 + 4 * level)
    call TimerStart(t, 0.02, true, function Trig_PachiliBC_Effect_Main)
    call Public_PacQ_MagicDamage(caster, target, 30 + 30 * level + 0.8 * GetHeroInt(caster, true), 5)
    set t = null
endfunction

function Trig_PachiliBC_Water_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local real x = LoadReal(udg_ht, task, 0)
    local real y = LoadReal(udg_ht, task, 1)
    local real a = LoadReal(udg_ht, task, 2)
    local integer i = LoadInteger(udg_ht, task, 3)
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\CrushingWave\\CrushingWaveDamage.mdl", x + i * 33 * CosBJ(a), y + i * 33 * SinBJ(a)))
    call SaveReal(udg_ht, task, 2, a - 14.4)
    call SaveInteger(udg_ht, task, 3, i + 1)
    if i >= 10 then
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
endfunction

function Trig_PachiliBC_Water_Start takes real x, real y, real a returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call SaveReal(udg_ht, task, 0, x)
    call SaveReal(udg_ht, task, 1, y)
    call SaveReal(udg_ht, task, 2, a)
    call SaveInteger(udg_ht, task, 3, 1)
    call TimerStart(t, 0.03, true, function Trig_PachiliBC_Water_Main)
    set t = null
endfunction

function Trig_PachiliBC_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit u
    local unit v
    local integer level = GetUnitAbilityLevel(caster, 'A0WH')
    local real x = GetUnitX(caster)
    local real y = GetUnitY(caster)
    local integer i
    local group g
    local boolexpr iff
    call Public_PacQ_AbilityCoolDownRestore(caster, level, 'A0WH')
    call UnitHealingTarget(caster, caster, 30 + 30 * level + 0.8 * GetHeroInt(caster, true))
    set i = 0
    loop
        call Trig_PachiliBC_Water_Start(x, y, i * 72)
    exitwhen i == 4
        set i = i + 1
    endloop
    set g = CreateGroup()
    set iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    call GroupEnumUnitsInRange(g, x, y, 350.0, iff)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if IsUnitType(v, UNIT_TYPE_DEAD) == false and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false then
            call Trig_PachiliBC_Effect_Start(caster, v, level)
        endif
    endloop
    call DestroyGroup(g)
    set caster = null
    set u = null
    set v = null
    set g = null
    set iff = null
endfunction

function InitTrig_PachiliBC takes nothing returns nothing
endfunction