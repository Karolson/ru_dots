function Trig_bocai_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0A6'
endfunction

function bocai_stop takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_Hashtable, task, 0)
    local integer declife = LoadInteger(udg_Hashtable, task, 3)
    local integer atk = LoadInteger(udg_Hashtable, task, 4)
    local trigger trg
    set trg = LoadTriggerHandle(udg_ht, task, 1)
    call TriggerRemoveAction(trg, LoadTriggerActionHandle(udg_ht, task, 2))
    call DestroyTrigger(trg)
    call UnitAddMaxLife(caster, -declife)
    call UnitReduceAttackDamage(caster, atk)
    call UnitRemoveAbility(caster, 'A0A7')
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_Hashtable, task)
    set trg = null
    set t = null
    set caster = null
endfunction

function Trig_Captain_AreaAttack_Damaged takes nothing returns nothing
    local trigger trg = GetTriggeringTrigger()
    local integer task = GetHandleId(trg)
    local unit caster
    local unit target = GetTriggerUnit()
    local real x
    local real y
    local unit v
    local group g
    local boolexpr iff
    if GetTriggerEventId() != EVENT_UNIT_DAMAGED then
        call TriggerRemoveAction(trg, LoadTriggerActionHandle(udg_ht, task, 1))
        call DestroyTrigger(trg)
        call FlushChildHashtable(udg_ht, task)
        set trg = null
        set caster = null
        set target = null
        set v = null
        set g = null
        set iff = null
        return
    endif
    set caster = LoadUnitHandle(udg_ht, task, 0)
    if GetEventDamageSource() != caster then
        set trg = null
        set caster = null
        set target = null
        set v = null
        set g = null
        set iff = null
        return
    endif
    set x = GetUnitX(target)
    set y = GetUnitY(target)
    call DisableTrigger(trg)
    set g = CreateGroup()
    set iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    call GroupEnumUnitsInRange(g, x, y, 300, iff)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if IsUnitType(v, UNIT_TYPE_DEAD) == false and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false then
            call UnitAbsDamageTarget(caster, v, 17 + 5 * GetUnitAbilityLevel(caster, 'A0A6') + GetHeroLevel(caster) * 2.5)
        endif
    endloop
    call DestroyGroup(g)
    call TriggerRemoveAction(trg, LoadTriggerActionHandle(udg_ht, task, 1))
    call DestroyTrigger(trg)
    call FlushChildHashtable(udg_ht, task)
    set caster = null
    set target = null
    set trg = null
endfunction

function Trig_Captain_AreaAttack_Conditions takes nothing returns boolean
    return GetUnitAbilityLevel(GetAttacker(), 'A0A8') > 0
endfunction

function Trig_Captain_AreaAttack_Action takes nothing returns nothing
    local unit caster = GetAttacker()
    local unit target = GetTriggerUnit()
    local trigger trg
    local triggeraction tga
    set trg = CreateTrigger()
    set tga = TriggerAddAction(trg, function Trig_Captain_AreaAttack_Damaged)
    call SaveUnitHandle(udg_ht, GetHandleId(trg), 0, caster)
    call SaveTriggerActionHandle(udg_ht, GetHandleId(trg), 1, tga)
    call TriggerRegisterUnitEvent(trg, target, EVENT_UNIT_DAMAGED)
    call TriggerRegisterUnitEvent(trg, caster, EVENT_UNIT_ISSUED_ORDER)
    call TriggerRegisterUnitEvent(trg, caster, EVENT_UNIT_ISSUED_POINT_ORDER)
    call TriggerRegisterUnitEvent(trg, caster, EVENT_UNIT_ISSUED_TARGET_ORDER)
    set trg = null
    set tga = null
    set caster = null
    set target = null
endfunction

function Trig_bocai_Actions takes nothing returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A0A6')
    local trigger trg
    local triggeraction tga
    local integer adlife
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 21)
    set trg = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(trg, EVENT_PLAYER_UNIT_ATTACKED)
    call TriggerAddCondition(trg, Condition(function Trig_Captain_AreaAttack_Conditions))
    set tga = TriggerAddAction(trg, function Trig_Captain_AreaAttack_Action)
    call UnitAddAbility(caster, 'A0A7')
    call SetUnitAbilityLevel(caster, 'A0A8', level)
    call SetUnitAbilityLevel(caster, 'A0A9', level)
    call SetUnitAbilityLevel(caster, 'A1A3', GetHeroLevel(caster))
    set adlife = 200 + 200 * level
    call UnitAddMaxLife(caster, adlife)
    call UnitInitAddAttack(caster)
    call UnitAddAttackDamage(caster, 10 + level * 10 + GetHeroLevel(caster) * 2)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveTriggerHandle(udg_ht, task, 1, trg)
    call SaveTriggerActionHandle(udg_ht, task, 2, tga)
    call SaveInteger(udg_ht, task, 3, adlife)
    call SaveInteger(udg_ht, task, 4, 10 + level * 10 + GetHeroLevel(caster) * 2)
    call TimerStart(t, 7, true, function bocai_stop)
    call TriggerSleepAction(0.6)
    call PlaySoundOnUnitBJ(gg_snd_Dlss, 100, caster)
    set t = null
    set caster = null
    set trg = null
    set tga = null
endfunction

function InitTrig_Captain03 takes nothing returns nothing
endfunction