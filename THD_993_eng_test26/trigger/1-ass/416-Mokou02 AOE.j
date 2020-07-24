function Trig_Mokou02_AOE_Conditions takes nothing returns boolean
    if GetUnitAbilityLevel(GetAttacker(), 'A00G') > 0 then
        return true
    endif
    return false
endfunction

function Trig_Mokou02_AOE_Main takes nothing returns nothing
    local trigger trg = GetTriggeringTrigger()
    local integer task = GetHandleId(trg)
    local unit caster
    local unit target = GetTriggerUnit()
    local real x
    local real y
    local real damage
    local group g
    local unit v
    local boolexpr iff
    local integer k
    if GetTriggerEventId() != EVENT_UNIT_DAMAGED then
        call TriggerRemoveAction(trg, LoadTriggerActionHandle(udg_ht, task, 1))
        call DestroyTrigger(trg)
        call FlushChildHashtable(udg_ht, task)
        set trg = null
        set caster = null
        set target = null
        return
    endif
    set caster = LoadUnitHandle(udg_ht, task, 0)
    if GetEventDamageSource() != caster then
        set trg = null
        set caster = null
        set target = null
        return
    endif
    set x = GetUnitX(target)
    set y = GetUnitY(target)
    call DisableTrigger(trg)
    set k = GetPlayerId(GetOwningPlayer(caster)) + 1
    set udg_SK_Mokou02_Count[k] = udg_SK_Mokou02_Count[k] + 1
    if udg_SK_Mokou02_Count[k] >= 5 then
        set udg_SK_Mokou02_Count[k] = 0
        set damage = ABCIExtraAtk(caster, 15 + 30 * GetUnitAbilityLevel(caster, 'A00G'), 0.5)
        call DestroyEffect(AddSpecialEffect("Objects\\Spawnmodels\\Other\\NeutralBuildingExplosion\\NeutralBuildingExplosion.mdl", x, y))
        set g = CreateGroup()
        set iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
        call GroupEnumUnitsInRange(g, x, y, 250, iff)
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if IsUnitType(v, UNIT_TYPE_DEAD) == false and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false then
                call UnitMagicDamageTarget(caster, v, damage, 6)
            endif
        endloop
        call DestroyGroup(g)
    endif
    call TriggerRemoveAction(trg, LoadTriggerActionHandle(udg_ht, task, 1))
    call DestroyTrigger(trg)
    call FlushChildHashtable(udg_ht, task)
    set caster = null
    set target = null
    set g = null
    set v = null
    set trg = null
endfunction

function Trig_Mokou02_AOE_Actions takes nothing returns nothing
    local unit caster = GetAttacker()
    local unit target = GetTriggerUnit()
    local trigger trg
    local triggeraction tga
    set trg = CreateTrigger()
    set tga = TriggerAddAction(trg, function Trig_Mokou02_AOE_Main)
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

function InitTrig_Mokou02_AOE takes nothing returns nothing
endfunction