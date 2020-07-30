function Trig_Merlin04_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0RY'
endfunction

function Trig_Merlin04_Clear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit target = LoadUnitHandle(udg_ht, task, 1)
    set udg_SK_Merlin04_Target = null
    call UnitRemoveAbility(caster, 'A084')
    call UnitRemoveAbility(target, 'A084')
    call DisableTrigger(gg_trg_Merlin04_Damage)
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    set t = null
    set caster = null
    set target = null
endfunction

function Trig_Merlin04_Actions takes nothing returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local integer level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 110 - 10 * level)
    call VE_Spellcast(caster)
    call PlaySoundOnUnitBJ(gg_snd_TrumpetChorus_03, 100, caster)
    set udg_SK_Merlin04_Target = target
    call UnitAddAbility(caster, 'A084')
    call UnitAddAbility(target, 'A084')
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, target)
    call EnableTrigger(gg_trg_Merlin04_Damage)
    call TimerStart(t, 5 + level, false, function Trig_Merlin04_Clear)
    set t = null
    set caster = null
    set target = null
endfunction

function InitTrig_Merlin04 takes nothing returns nothing
endfunction