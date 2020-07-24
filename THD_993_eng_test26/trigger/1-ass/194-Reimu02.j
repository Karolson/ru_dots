function ReimuAb02 takes nothing returns integer
    return 'A049'
endfunction

function Trig_Reimu02_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A049'
endfunction

function UnitBump_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit u = LoadUnitHandle(udg_ht, task, 0)
    local real v = LoadReal(udg_ht, task, 0)
    local real f = LoadReal(udg_ht, task, 1)
    local real g = -1.2
    local real h = GetUnitFlyHeight(u)
    if GetWidgetLife(u) > 0.405 then
        set h = h + v
        call SetUnitFlyHeight(u, h, 2000)
        if h < 5.0 and v < 0 then
            set v = -1 * f * v
        endif
        call SaveReal(udg_ht, task, 0, v + g)
    else
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set u = null
endfunction

function UnitBump takes unit u, real f returns integer
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call SaveUnitHandle(udg_ht, task, 0, u)
    call SaveReal(udg_ht, task, 0, 0)
    call SaveReal(udg_ht, task, 1, f)
    call TimerStart(t, 0.02, true, function UnitBump_Main)
    set t = null
    return task
endfunction

function Trig_Reimu02_Lockdown takes nothing returns boolean
    if GetUnitState(GetFilterUnit(), UNIT_STATE_LIFE) <= 0 then
        return false
    endif
    if GetUnitAbilityLevel(GetFilterUnit(), 'Aloc') != 0 then
        return false
    endif
    if IsUnitType(GetFilterUnit(), UNIT_TYPE_STRUCTURE) then
        return false
    endif
    if GetUnitAbilityLevel(GetFilterUnit(), 'A0IL') > 0 then
        return false
    endif
    if IsUnitType(GetFilterUnit(), UNIT_TYPE_MAGIC_IMMUNE) then
        return false
    endif
    return IsUnitEnemy(GetFilterUnit(), GetOwningPlayer(GetTriggerUnit()))
endfunction

function Trig_Reimu02_Target takes nothing returns boolean
    local trigger trg
    local integer task
    if GetTriggerEventId() == EVENT_UNIT_DEATH then
        set trg = GetTriggeringTrigger()
        set task = GetHandleId(trg)
        call DestroyBoolExpr(LoadBooleanExprHandle(udg_ht, task, 3))
        call TriggerRemoveCondition(trg, LoadTriggerConditionHandle(udg_ht, task, 4))
        call TriggerRemoveAction(trg, LoadTriggerActionHandle(udg_ht, task, 5))
        call DestroyTrigger(trg)
        call FlushChildHashtable(udg_ht, task)
        set trg = null
        return false
    endif
    if GetUnitState(GetTriggerUnit(), UNIT_STATE_LIFE) <= 0 then
        return false
    endif
    if IsUnitType(GetTriggerUnit(), UNIT_TYPE_STRUCTURE) then
        return false
    endif
    if GetUnitAbilityLevel(GetTriggerUnit(), 'A0IL') > 0 then
        return false
    endif
    if IsUnitType(GetTriggerUnit(), UNIT_TYPE_MAGIC_IMMUNE) then
        return false
    endif
    return true
endfunction

function Trig_Reimu02_Damage takes nothing returns nothing
    local trigger trg = GetTriggeringTrigger()
    local integer task = GetHandleId(trg)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit u = LoadUnitHandle(udg_ht, task, 1)
    local unit v = GetTriggerUnit()
    local real damage = LoadReal(udg_ht, task, 0)
    call DestroyBoolExpr(LoadBooleanExprHandle(udg_ht, task, 3))
    call TriggerRemoveCondition(trg, LoadTriggerConditionHandle(udg_ht, task, 4))
    call TriggerRemoveAction(trg, LoadTriggerActionHandle(udg_ht, task, 5))
    call DestroyTrigger(trg)
    call FlushChildHashtable(udg_ht, task)
    call UnitMagicDamageTarget(caster, v, damage, 1)
    call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Human\\StormBolt\\StormBoltMissile.mdl", v, "chest"))
    call KillUnit(u)
    set trg = null
    set caster = null
    set u = null
    set v = null
endfunction

function Trig_Reimu02_Remove takes nothing returns nothing
    call KillUnit(GetEnumUnit())
endfunction

function Trig_Reimu02_Functioned takes unit caster, integer level, integer n, real damage returns nothing
    local unit target
    local unit u
    local trigger trg
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    local triggeraction tga
    local triggercondition tgc
    local integer task
    local real a
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real px
    local real py
    local real h
    local boolexpr f
    local group g = CreateGroup()
    local group v = CreateGroup()
    local integer i
    set f = Filter(function Trig_Reimu02_Lockdown)
    call GroupEnumUnitsInRange(v, ox, oy, 650.0, f)
    set i = 1
    loop
    exitwhen i > n
        set a = GetRandomReal(0, 360)
        set px = ox + 70.0 * CosBJ(a)
        set py = oy + 70.0 * SinBJ(a)
        set h = GetRandomReal(80, 180)
        set u = CreateUnit(GetOwningPlayer(caster), 'n00T' + GetRandomInt(0, 2), px, py, a)
        call SetUnitFlyHeight(u, h, 1000.0)
        call UnitBump(u, 1.07)
        call GroupAddUnit(g, u)
        set trg = CreateTrigger()
        set task = GetHandleId(trg)
        call SaveUnitHandle(udg_ht, task, 0, caster)
        call SaveUnitHandle(udg_ht, task, 1, u)
        call SaveReal(udg_ht, task, 0, damage)
        call TriggerRegisterUnitInRange(trg, u, 120.0, iff)
        call TriggerRegisterUnitEvent(trg, u, EVENT_UNIT_DEATH)
        set f = Condition(function Trig_Reimu02_Target)
        set tgc = TriggerAddCondition(trg, f)
        set tga = TriggerAddAction(trg, function Trig_Reimu02_Damage)
        call SaveBooleanExprHandle(udg_ht, task, 3, f)
        call SaveTriggerConditionHandle(udg_ht, task, 4, tgc)
        call SaveTriggerActionHandle(udg_ht, task, 5, tga)
        set target = GroupPickRandomUnit(v)
        if target != null then
            call IssueTargetOrder(u, "attack", target)
        else
            call IssuePointOrder(u, "attack", ox + 800.0 * CosBJ(a), oy + 800.0 * SinBJ(a))
        endif
        set i = i + 1
    endloop
    call DestroyGroup(v)
    call TriggerSleepAction(3.5)
    call ForGroup(g, function Trig_Reimu02_Remove)
    call DestroyGroup(g)
    set target = null
    set trg = null
    set tgc = null
    set tga = null
    set iff = null
    set u = null
    set f = null
    set g = null
    set v = null
endfunction

function Trig_Reimu02_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer abid = GetSpellAbilityId()
    local integer level = GetUnitAbilityLevel(caster, abid)
    local integer n = level * 1 + 4
    local real damagebase = 20 + level * 5
    local real damageinc = 0.4
    local real damage = ABCIAllInt(caster, damagebase, damageinc)
    call AbilityCoolDownResetion(caster, abid, 4.0)
    call Trig_Reimu02_Functioned(caster, level, n, damage)
    set caster = null
endfunction

function InitTrig_Reimu02 takes nothing returns nothing
endfunction