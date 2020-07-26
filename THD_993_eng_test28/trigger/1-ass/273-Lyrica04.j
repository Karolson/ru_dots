function Trig_Lyrica04_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0UK'
endfunction

function Trig_Lyrica04_Finish takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit target = LoadUnitHandle(udg_ht, task, 1)
    call FlushChildHashtable(udg_ht, task)
    call ReleaseTimer(t)
    call UnitRemoveAbility(target, 'B066')
    call UnitRemoveAbility(target, 'A0UJ')
    set t = null
    set target = null
endfunction

function Trig_Lyrica04_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local real time = GetUnitAbilityLevel(caster, 'A0UK') * 0.5 + 4.5
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local integer level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), (130 - 10 * level) * udg_SK_LyricaEx_Buff)
    call VE_Spellcast(caster)
    call PlaySoundOnUnitBJ(gg_snd_PianoChorus03a, 100, caster)
    call TimerStart(t, time, false, function Trig_Lyrica04_Finish)
    call SaveUnitHandle(udg_ht, task, 1, target)
    call UnitAddAbility(target, 'B066')
    call UnitAddAbility(target, 'A0UJ')
    call SaveEffectHandle(udg_ht, task, 4, null)
    set target = null
    set t = null
    set caster = null
endfunction

function InitTrig_Lyrica04 takes nothing returns nothing
endfunction