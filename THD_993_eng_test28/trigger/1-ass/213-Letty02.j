function LettyAb02 takes nothing returns integer
    return 'A0UL'
endfunction

function Trig_Letty02_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0UL'
endfunction

function Trig_Letty02_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit u = LoadUnitHandle(udg_ht, task, 1)
    local integer level = LoadInteger(udg_ht, task, 2)
    local integer i = LoadInteger(udg_ht, task, 3)
    local real a = LoadReal(udg_ht, task, 4)
    local real d = LoadReal(udg_ht, task, 5)
    local integer k = LoadInteger(udg_ht, task, 6)
    local group m = udg_SK_Letty02_Group
    local real ox = GetUnitX(u)
    local real oy = GetUnitY(u)
    local real px
    local real py
    local group g
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    local unit v
    if i > 0 and udg_SK_Letty02_Hit < udg_SK_Letty02_Max then
        call SetUnitFacing(u, bj_RADTODEG * a + 60.0 * Sin(k * 3.141592654 / 25.0))
        set px = ox + d * CosBJ(GetUnitFacing(u))
        set py = oy + d * SinBJ(GetUnitFacing(u))
        call SetUnitXY(u, px, py)
        call SaveInteger(udg_ht, task, 3, i - 1)
        call SaveInteger(udg_ht, task, 6, k + 1)
        set g = CreateGroup()
        call GroupEnumUnitsInRange(g, px, py, 120.0, iff)
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if IsUnitType(v, UNIT_TYPE_DEAD) == false and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false and IsUnitInGroup(v, m) == false then
                call GroupAddUnit(m, v)
                set udg_SK_Letty02_Hit = udg_SK_Letty02_Hit + 1
                call UnitStunTarget(caster, v, 1.1 + 0.3 * I2R(level), 0, 0)
                call UnitMagicDamageTarget(caster, v, ABCIAllInt(caster, 35 + 35 * level, 1.5), 1)
            endif
        endloop
        call DestroyGroup(g)
    else
        call RemoveUnit(u)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set u = null
    set m = null
    set g = null
    set iff = null
    set v = null
endfunction

function Trig_Letty02_Functioned takes unit caster, real ox, real oy, integer level returns nothing
    local timer t
    local integer task
    local unit u
    local real a = GetUnitFacing(caster) / bj_RADTODEG
    local integer i
    call GroupClear(udg_SK_Letty02_Group)
    set udg_SK_Letty02_Hit = 0
    set udg_SK_Letty02_Max = 5
    set i = 0
    loop
        set t = CreateTimer()
        set task = GetHandleId(t)
        set u = CreateUnit(GetOwningPlayer(caster), 'e00P', ox, oy, bj_RADTODEG * a + i * 90)
        call SaveUnitHandle(udg_ht, task, 0, caster)
        call SaveUnitHandle(udg_ht, task, 1, u)
        call SaveInteger(udg_ht, task, 2, level)
        call SaveInteger(udg_ht, task, 3, 90)
        call SaveReal(udg_ht, task, 4, a + i * 90 / bj_RADTODEG)
        call SaveReal(udg_ht, task, 5, 10)
        call SaveInteger(udg_ht, task, 6, 0)
        call TimerStart(t, 0.02, true, function Trig_Letty02_Main)
        set i = i + 1
    exitwhen i == 4
    endloop
    set t = null
    set u = null
endfunction

function Trig_Letty02_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local integer level = GetUnitAbilityLevel(caster, 'A0UL')
    call AbilityCoolDownResetion(caster, 'A0UL', 13.0)
    call Trig_Letty02_Functioned(caster, ox, oy, level)
    set caster = null
endfunction

function InitTrig_Letty02 takes nothing returns nothing
endfunction