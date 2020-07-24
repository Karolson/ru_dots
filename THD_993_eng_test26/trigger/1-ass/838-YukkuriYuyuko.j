function Trig_YukkuriYuyuko_Conditions takes nothing returns boolean
    if GetUnitTypeId(GetTriggerUnit()) != 'o00K' then
        return false
    endif
    return true
endfunction

function Trig_YukkuriYuyuko_Damaged takes nothing returns nothing
    local trigger trg = GetTriggeringTrigger()
    local integer task = GetHandleId(trg)
    local unit caster
    local unit target
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
    set target = GetTriggerUnit()
    call DisableTrigger(trg)
    call IssueTargetOrder(target, "carrionswarm", caster)
    call TriggerRemoveAction(trg, LoadTriggerActionHandle(udg_ht, task, 1))
    call DestroyTrigger(trg)
    call FlushChildHashtable(udg_ht, task)
    set trg = null
    set caster = null
    set target = null
endfunction

function Trig_YukkuriYuyuko_Actions takes nothing returns nothing
    local unit caster = GetAttacker()
    local unit target = GetTriggerUnit()
    local trigger trg
    local triggeraction tga
    set trg = CreateTrigger()
    set tga = TriggerAddAction(trg, function Trig_YukkuriYuyuko_Damaged)
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

function InitTrig_YukkuriYuyuko takes nothing returns nothing
    set gg_trg_YukkuriYuyuko = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_YukkuriYuyuko, EVENT_PLAYER_UNIT_ATTACKED)
    call TriggerAddCondition(gg_trg_YukkuriYuyuko, Condition(function Trig_YukkuriYuyuko_Conditions))
    call TriggerAddAction(gg_trg_YukkuriYuyuko, function Trig_YukkuriYuyuko_Actions)
endfunction