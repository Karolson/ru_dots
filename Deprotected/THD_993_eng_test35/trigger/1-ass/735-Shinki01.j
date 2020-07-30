function Shinki03 takes nothing returns integer
    return 'A1DV'
endfunction

function Shinki takes nothing returns integer
    return 'A1EZ'
endfunction

function Shinki_Range takes nothing returns real
    return 500.0
endfunction

function Shinki_Num takes nothing returns integer
    return 5
endfunction

function Shinki_Vest takes nothing returns integer
    return 'n05S'
endfunction

function Shinki_Skill takes nothing returns integer
    return 'A1DW'
endfunction

function Shinki01_If takes nothing returns boolean
    if GetUnitState(GetFilterUnit(), UNIT_STATE_LIFE) <= 0 then
        return false
    endif
    if GetUnitAbilityLevel(GetFilterUnit(), 'Aloc') != 0 then
        return false
    endif
    if IsUnitType(GetFilterUnit(), UNIT_TYPE_MECHANICAL) or GetUnitAbilityLevel(GetFilterUnit(), 'A0IL') > 0 then
        return false
    endif
    return true
endfunction

function Trig_Shinki01_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A1EZ'
endfunction

function Trig_Shinki01_Hit takes nothing returns nothing
    local trigger trg = GetTriggeringTrigger()
    local integer task = GetHandleId(trg)
    local unit caster
    local unit target
    local integer level
    local real damage
    if GetTriggerEventId() == EVENT_UNIT_DEATH then
        call DestroyTrigger(trg)
        call FlushChildHashtable(udg_ht, task)
        set caster = null
        set target = null
        set trg = null
        return
    endif
    if GetUnitTypeId(GetEventDamageSource()) != 'n05S' then
        set caster = null
        set target = null
        set trg = null
        return
    endif
    set target = GetTriggerUnit()
    set caster = LoadUnitHandle(udg_ht, task, 0)
    set level = LoadInteger(udg_ht, task, 0)
    set damage = 30.0 + level * 20.0 + 1.4 * GetHeroInt(caster, true)
    call UnitDebuffTarget(caster, target, 2.0, 1, true, 'A013', 1, 'Bfro', "shadowstrike", 0, "")
    call UnitMagicDamageTarget(caster, target, damage, 1)
    if GetUnitAbilityLevel(caster, 'A1DV') > 0 then
        call SetUnitState(caster, UNIT_STATE_LIFE, GetUnitState(caster, UNIT_STATE_LIFE) + damage * (5.0 + 5.0 * GetUnitAbilityLevel(caster, 'A1DV')) / 100.0)
    endif
    call DestroyTrigger(trg)
    call FlushChildHashtable(udg_ht, task)
    set caster = null
    set target = null
    set trg = null
endfunction

function Trig_Shinki01_Shoot takes unit u, unit v, unit caster, integer level returns nothing
    local trigger trg = CreateTrigger()
    local integer task = GetHandleId(trg)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveInteger(udg_ht, task, 0, level)
    call TriggerRegisterUnitEvent(trg, u, EVENT_UNIT_DEATH)
    call TriggerRegisterUnitEvent(trg, v, EVENT_UNIT_DAMAGED)
    call TriggerAddAction(trg, function Trig_Shinki01_Hit)
    call IssueTargetOrder(u, "shadowstrike", v)
    set trg = null
endfunction

function Trig_Shinki01_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A1EZ')
    local real x = GetUnitX(caster)
    local real y = GetUnitY(caster)
    local group g = CreateGroup()
    local unit v
    local boolexpr iff
    local integer t = 0
    local unit u
    local real damage
    call AbilityCoolDownResetion(caster, 'A1EZ', 8 - level)
    set iff = Filter(function Shinki01_If)
    call GroupEnumUnitsInRange(g, x, y, 500.0, iff)
    loop
        set v = GroupPickRandomUnit(g)
    exitwhen v == null or t == 5
        call GroupRemoveUnit(g, v)
        if IsUnitAlly(v, GetOwningPlayer(caster)) == false then
            set t = t + 1
            set u = CreateUnit(GetOwningPlayer(caster), 'n05S', x, y, 270.0)
            call UnitApplyTimedLife(u, 'BTLF', 7.0)
            call Trig_Shinki01_Shoot(u, v, caster, level)
        endif
    endloop
    if t < 5 and GetUnitAbilityLevel(caster, 'A1DV') > 0 then
        set damage = 30.0 + level * 20.0 + 1.4 * GetHeroInt(caster, true)
        call SetUnitState(caster, UNIT_STATE_LIFE, GetUnitState(caster, UNIT_STATE_LIFE) + damage * (5.0 + 5.0 * GetUnitAbilityLevel(caster, 'A1DV')) / 100.0 * 0.5 * (5 - t))
    endif
    set caster = null
    set g = null
    set v = null
    set iff = null
    set u = null
endfunction

function InitTrig_Shinki01 takes nothing returns nothing
    set gg_trg_Shinki01 = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Shinki01, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Shinki01, Condition(function Trig_Shinki01_Conditions))
    call TriggerAddAction(gg_trg_Shinki01, function Trig_Shinki01_Actions)
endfunction