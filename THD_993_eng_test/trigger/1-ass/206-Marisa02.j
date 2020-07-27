function MarisaAb02 takes nothing returns integer
    return 'A041'
endfunction

function Trig_Stars_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A041'
endfunction

function AngleBetweenTwoAngles takes real a1, real a2 returns real
    local real tmp
    set tmp = a1 - a2
    if tmp > 270 then
        set tmp = 360 - tmp
    endif
    if tmp < -270 then
        set tmp = 360 + tmp
    endif
    if tmp < 0 then
        set tmp = -tmp
    endif
    return tmp
endfunction

function UnitMagicDamageAreaForMarisa takes unit caster, real range, real damage, real extradamage returns nothing
    local unit v
    local real facing = GetUnitFacing(caster)
    local real distance
    local location l = Location(GetUnitX(caster) - CosBJ(facing) * 90, GetUnitY(caster) - SinBJ(facing) * 90)
    local location vl
    local real t
    local real angle
    local group g = CreateGroup()
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    call GroupEnumUnitsInRange(g, GetUnitX(caster), GetUnitY(caster), range, iff)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        set vl = GetUnitLoc(v)
        set angle = AngleBetweenPoints(l, vl)
        set t = AngleBetweenTwoAngles(facing, angle)
        set distance = DistanceBetweenPoints(l, vl)
        if t < 22 and distance > 60 then
            call UnitMagicDamageTarget(caster, v, damage, 5)
        endif
        if distance < 60 + 150 + 100 and t < 22 and distance > 60 then
            call UnitMagicDamageTarget(caster, v, extradamage, 5)
        endif
        call RemoveLocation(vl)
    endloop
    call RemoveLocation(l)
    call DestroyGroup(g)
    set v = null
    set l = null
    set vl = null
    set g = null
endfunction

function Trig_Stars_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit u1 = LoadUnitHandle(udg_ht, task, 1)
    local unit u2 = LoadUnitHandle(udg_ht, task, 2)
    local location p = LoadLocationHandle(udg_ht, task, 3)
    local integer i = LoadInteger(udg_ht, task, 1)
    local real damage = LoadReal(udg_ht, task, 4)
    if GetUnitCurrentOrder(caster) == OrderId("breathoffire") then
        call UnitMagicDamageAreaForMarisa(caster, 60 + 350 + 350, damage, damage)
        if i == 2 then
            call SetUnitTimeScale(caster, 0.25)
        endif
        call SaveInteger(udg_ht, task, 1, i + 1)
    else
        call RemoveLocation(p)
        call KillUnit(u1)
        call KillUnit(u2)
        call SetUnitTimeScale(caster, 1.0)
        call FlushChildHashtable(udg_ht, task)
        call ReleaseTimer(t)
    endif
    set t = null
    set caster = null
    set u1 = null
    set u2 = null
    set p = null
endfunction

function Trig_Stars_Functioned takes unit caster, location o, location p, integer level returns nothing
    local unit u1
    local unit u2
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local real damage = ABCIAllInt(caster, level * 45, 1.6) * 0.5
    call SetUnitTimeScale(caster, 2.5)
    set u1 = CreateUnitAtLoc(GetOwningPlayer(caster), 'n00N', o, GetUnitFacing(caster))
    set u2 = CreateUnitAtLoc(GetOwningPlayer(caster), 'n00N', o, GetUnitFacing(caster))
    call UnitAddAbility(u1, 'A043')
    call SetUnitAbilityLevel(u1, 'A043', level)
    call UnitAddAbility(u2, 'A044')
    call SetUnitAbilityLevel(u2, 'A044', level)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, u1)
    call SaveUnitHandle(udg_ht, task, 2, u2)
    call SaveInteger(udg_ht, task, 1, 0)
    call SaveLocationHandle(udg_ht, task, 3, p)
    call SaveReal(udg_ht, task, 4, damage)
    call TimerStart(t, 0.2, true, function Trig_Stars_Main)
    call RemoveLocation(o)
    set t = null
    set u1 = null
    set u2 = null
endfunction

function Trig_Stars_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local location o = GetUnitLoc(caster)
    local location p = PolarProjectionBJ(o, 256, GetUnitFacing(caster))
    local integer level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    local integer abid = GetSpellAbilityId()
    call AbilityCoolDownResetion(caster, abid, 11 - level * 1)
    call MarisaEx_ColdTimer(caster)
    call Trig_Stars_Functioned(caster, o, p, level)
    set caster = null
    set o = null
    set p = null
endfunction

function InitTrig_Marisa02 takes nothing returns nothing
endfunction