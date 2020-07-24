function Trig_Lunasa04_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0V2'
endfunction

function Trig_Lunasa04_Finish takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit target = LoadUnitHandle(udg_ht, task, 1)
    local integer level = LoadInteger(udg_ht, task, 2)
    call Trig_LunasaDamage(caster, target, ABCIAllInt(caster, level * 50 + 100, 0.6), 1)
    call FlushChildHashtable(udg_ht, task)
    call UnitRemoveAbility(target, 'A0V4')
    call UnitRemoveAbility(target, 'A0DS')
    call UnitRemoveAbility(target, 'B014')
    if udg_BlinkEnableUnit[GetPlayerId(GetOwningPlayer(target))] == null and GetUnitAbilityLevel(target, 'A0A1') == 0 then
        set udg_BlinkEnableUnit[GetPlayerId(GetOwningPlayer(target))] = CreateUnit(GetOwningPlayer(target), 'e036', -5344.0, -3968.0, 0)
    endif
    call ReleaseTimer(t)
    set t = null
    set caster = null
    set target = null
endfunction

function Trig_Lunasa04_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local integer level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    local timer t
    local integer task
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 140 - 20 * level)
    call PlaySoundOnUnitBJ(gg_snd_ViolinChorus02, 100, caster)
    call Trig_LunasaDamage(caster, target, ABCIAllInt(caster, level * 50 + 100, 0.6), 1)
    set t = CreateTimer()
    set task = GetHandleId(t)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, target)
    call SaveInteger(udg_ht, task, 2, level)
    call TimerStart(t, 6, false, function Trig_Lunasa04_Finish)
    call UnitAddAbility(target, 'A0V4')
    call UnitAddAbility(target, 'A0DS')
    call VE_Spellcast(caster)
    if not IsUnitIllusion(target) and udg_BlinkEnableUnit[GetPlayerId(GetOwningPlayer(target))] != null then
        call RemoveUnit(udg_BlinkEnableUnit[GetPlayerId(GetOwningPlayer(target))])
        set udg_BlinkEnableUnit[GetPlayerId(GetOwningPlayer(target))] = null
        call CE_Input(caster, target, 50.0)
    endif
    set caster = null
    set target = null
    set t = null
endfunction

function InitTrig_Lunasa04 takes nothing returns nothing
endfunction