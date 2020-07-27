function Miko02 takes nothing returns integer
    return 'A185'
endfunction

function Miko02_Buff takes nothing returns integer
    return 'A0UY'
endfunction

function Miko02_Debuff takes nothing returns integer
    return 'A0UX'
endfunction

function Trig_Miko02_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A185'
endfunction

function Trig_Miko02_Main_Conditions takes nothing returns boolean
    if IsUnitType(GetTriggerUnit(), UNIT_TYPE_MECHANICAL) or IsUnitType(GetTriggerUnit(), UNIT_TYPE_ANCIENT) then
        return false
    endif
    if IsUnitAlly(GetTriggerUnit(), GetOwningPlayer(GetAttacker())) then
        return false
    endif
    return GetUnitAbilityLevelSwapped('A0UY', GetAttacker()) > 0 and GetUnitAbilityLevelSwapped('A0UX', GetTriggerUnit()) < 1
endfunction

function Trig_Miko02_Effectend takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local effect e = LoadEffectHandle(udg_ht, task, 0)
    call DestroyEffect(e)
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    set t = null
    set e = null
endfunction

function Trig_Miko02_Deldebuff takes nothing returns nothing
    local timer t2 = GetExpiredTimer()
    local integer task2 = GetHandleId(t2)
    local unit target = LoadUnitHandle(udg_ht, task2, 0)
    call UnitRemoveAbilityBJ('A0UX', target)
    call ReleaseTimer(t2)
    call FlushChildHashtable(udg_ht, task2)
    set t2 = null
    set target = null
endfunction

function Trig_Miko02_Main takes nothing returns nothing
    local unit caster = GetAttacker()
    local unit target = GetTriggerUnit()
    local effect e = AddSpecialEffectTarget("Abilities\\Spells\\Items\\OrbCorruption\\OrbCorruptionSpecialArt.mdl", target, "origin")
    local timer t = CreateTimer()
    local timer t2 = CreateTimer()
    local integer task = GetHandleId(t)
    local integer task2 = GetHandleId(t2)
    local integer task3
    local integer level = GetUnitAbilityLevel(caster, 'A185')
    local real damage = 1.65 * GetHeroInt(caster, true) + 20.0 + 40.0 * level
    local trigger trg
    local triggeraction tga
    set trg = GetTriggeringTrigger()
    set task3 = GetHandleId(trg)
    set tga = LoadTriggerActionHandle(udg_ht, task3, 0)
    call UnitMagicDamageTarget(caster, target, damage, 1)
    call UnitRidiculeTarget(caster, target, 1.0 + 0.3 * level)
    call SaveEffectHandle(udg_ht, task, 0, e)
    call TimerStart(t, 1.0 + 0.3 * level, false, function Trig_Miko02_Effectend)
    call UnitAddAbilityBJ('A0UX', target)
    call SaveUnitHandle(udg_ht, task2, 0, target)
    call TimerStart(t2, 6.0, false, function Trig_Miko02_Deldebuff)
    call UnitRemoveAbilityBJ('A0UY', caster)
    set caster = null
    set target = null
    set e = null
    set t = null
    set t2 = null
    call TriggerRemoveAction(trg, tga)
    call DestroyTrigger(trg)
    set trg = null
    set tga = null
endfunction

function Trig_Miko02_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local trigger trg = CreateTrigger()
    local triggeraction tga = TriggerAddAction(trg, function Trig_Miko02_Main)
    local integer task3 = GetHandleId(trg)
    call AbilityCoolDownResetion(caster, 'A185', 11)
    call TriggerRegisterAnyUnitEventBJ(trg, EVENT_PLAYER_UNIT_ATTACKED)
    call TriggerAddCondition(trg, Condition(function Trig_Miko02_Main_Conditions))
    call UnitAddAbilityBJ('A0UY', caster)
    call UnitMakeAbilityPermanent(caster, true, 'A0UY')
    call SaveTriggerActionHandle(udg_ht, task3, 0, tga)
    set trg = null
    set tga = null
    set caster = null
endfunction

function InitTrig_Miko02 takes nothing returns nothing
endfunction