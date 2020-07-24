function Trig_Def06_ThunderSlave_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A17K'
endfunction

function Trig_Def06_ThunderSlave_Effect_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit target = LoadUnitHandle(udg_ht, task, 0)
    local real a = LoadReal(udg_ht, task, 1)
    local integer i = LoadInteger(udg_ht, task, 2)
    call SetUnitXYGround(target, GetUnitX(target) + 20 * Cos(a), GetUnitY(target) + 20 * Sin(a))
    if i * 5 / 5 == i then
        call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\FarseerMissile\\FarseerMissile.mdl", GetUnitX(target), GetUnitY(target)))
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

function Trig_Def06_ThunderSlave_Effect_Start takes unit caster, unit target returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local real a = Atan2(GetUnitY(target) - GetUnitY(caster), GetUnitX(target) - GetUnitX(caster))
    call SetUnitFlag(target, 3, true)
    call SaveUnitHandle(udg_ht, task, 0, target)
    call SaveReal(udg_ht, task, 1, a)
    call SaveInteger(udg_ht, task, 2, 15)
    call TimerStart(t, 0.02, true, function Trig_Def06_ThunderSlave_Effect_Main)
    set t = null
endfunction

function Trig_Def06_ThunderSlave_Water_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local real x = LoadReal(udg_ht, task, 0)
    local real y = LoadReal(udg_ht, task, 1)
    local real a = LoadReal(udg_ht, task, 2)
    local integer i = LoadInteger(udg_ht, task, 3)
    call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\FarseerMissile\\FarseerMissile.mdl", x + i * 56 * CosBJ(a), y + i * 56 * SinBJ(a)))
    call SaveInteger(udg_ht, task, 3, i + 1)
    if i >= 5 then
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
endfunction

function Trig_Def06_ThunderSlave_Water_Start takes real x, real y, real a returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call SaveReal(udg_ht, task, 0, x)
    call SaveReal(udg_ht, task, 1, y)
    call SaveReal(udg_ht, task, 2, a)
    call SaveInteger(udg_ht, task, 3, 1)
    call TimerStart(t, 0.06, true, function Trig_Def06_ThunderSlave_Water_Main)
    set t = null
endfunction

function Trig_Def06_ThunderSlave_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit v
    local real x = GetUnitX(caster)
    local real y = GetUnitY(caster)
    local integer i
    local group g
    local boolexpr iff
    set i = 0
    loop
        call Trig_Def06_ThunderSlave_Water_Start(x, y, i * 60)
    exitwhen i == 5
        set i = i + 1
    endloop
    set g = CreateGroup()
    set iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    call GroupEnumUnitsInRange(g, x, y, 450.0, iff)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if IsUnitType(v, UNIT_TYPE_DEAD) == false and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false and GetUnitAbilityLevel(v, 'A0IL') > 0 == false and IsUnitType(v, UNIT_TYPE_ANCIENT) == false then
            call Trig_Def06_ThunderSlave_Effect_Start(caster, v)
        endif
    endloop
    call DestroyGroup(g)
    set caster = null
    set v = null
    set g = null
    set iff = null
endfunction

function InitTrig_Def06_ThunderSlave takes nothing returns nothing
    set gg_trg_Def06_ThunderSlave = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Def06_ThunderSlave, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Def06_ThunderSlave, Condition(function Trig_Def06_ThunderSlave_Conditions))
    call TriggerAddAction(gg_trg_Def06_ThunderSlave, function Trig_Def06_ThunderSlave_Actions)
endfunction