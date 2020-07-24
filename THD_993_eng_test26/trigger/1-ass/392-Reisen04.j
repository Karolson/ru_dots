function Trig_Reisen04_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A16Z'
endfunction

function Trig_Reisen04_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit u = LoadUnitHandle(udg_ht, task, 1)
    local unit v
    local integer level = LoadInteger(udg_ht, task, 2)
    local integer i = LoadInteger(udg_ht, task, 3)
    local real ox = GetUnitX(u)
    local real oy = GetUnitY(u)
    local real px
    local real py
    local real a = LoadReal(udg_ht, task, 4)
    local real d = LoadReal(udg_ht, task, 5)
    local group g
    local boolexpr iff
    local integer niop = 0
    if i > 0 then
        set px = ox + d * Cos(a)
        set py = oy + d * Sin(a)
        call SetUnitXY(u, px, py)
        call SaveInteger(udg_ht, task, 3, i - 1)
    else
        call DestroyEffect(AddSpecialEffect("RedLaser.mdl", ox, oy))
        call DestroyEffect(AddSpecialEffect("RedLaser.mdl", ox, oy))
        set g = CreateGroup()
        set iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
        call GroupEnumUnitsInRange(g, GetUnitX(u), GetUnitY(u), 450, iff)
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if IsUnitType(v, UNIT_TYPE_STRUCTURE) == false and IsUnitType(v, UNIT_TYPE_DEAD) == false then
                set niop = niop + 1
            endif
        endloop
        call GroupEnumUnitsInRange(g, GetUnitX(u), GetUnitY(u), 450, iff)
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if IsUnitType(v, UNIT_TYPE_STRUCTURE) == false and IsUnitType(v, UNIT_TYPE_DEAD) == false then
                call UnitMagicDamageTarget(caster, v, ABCIAllInt(caster, 50 + level * 100, 2.0) / niop, 5)
            endif
        endloop
        call DestroyGroup(g)
        call KillUnit(u)
        set udg_SK_Reisen04_Light[udg_SK_Reisen04_Light_i] = CreateUnit(GetOwningPlayer(caster), 'e02H', ox, oy, 0)
        set udg_SK_Reisen04_Light_i = udg_SK_Reisen04_Light_i + 1
        if udg_SK_Reisen04_Light_i >= 11 then
            set udg_SK_Reisen04_Light_i = udg_SK_Reisen04_Light_i - 11
        endif
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set u = null
    set v = null
    set g = null
    set iff = null
endfunction

function Trig_Reisen04_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit u
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real tx = GetSpellTargetX()
    local real ty = GetSpellTargetY()
    local real a = Atan2(ty - oy, tx - ox)
    local real dis
    local real dis2
    local integer level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 60 / (level * (level - 1) + 2))
    set dis = SquareRoot((tx - ox) * (tx - ox) + (ty - oy) * (ty - oy))
    set dis2 = 45
    set u = CreateUnit(GetOwningPlayer(caster), 'n018', ox, oy, bj_RADTODEG * a)
    call SetUnitPathing(u, false)
    call EnableHeight(u)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, u)
    call SaveInteger(udg_ht, task, 2, level)
    call SaveInteger(udg_ht, task, 3, R2I(RMaxBJ(dis / dis2, 1)))
    call SaveReal(udg_ht, task, 4, a)
    call SaveReal(udg_ht, task, 5, dis2)
    call TimerStart(t, 0.02, true, function Trig_Reisen04_Main)
    set caster = null
    set u = null
    set t = null
endfunction

function InitTrig_Reisen04 takes nothing returns nothing
endfunction