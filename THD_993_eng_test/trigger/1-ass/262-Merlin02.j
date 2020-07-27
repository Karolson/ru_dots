function Trig_Merlin02_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0RS'
endfunction

function Trig_Merlin02_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit target = LoadUnitHandle(udg_ht, task, 0)
    call SetUnitVertexColor(target, 255, 255, 255, 255)
    call UnitRemoveAbility(target, 'A0S1')
    if GetUnitAbilityLevel(target, 'A0S7') >= 1 then
        call UnitRemoveAbility(target, 'A0S7')
    elseif GetUnitAbilityLevel(target, 'A0SB') >= 1 then
        call UnitRemoveAbility(target, 'A0SB')
    elseif GetUnitAbilityLevel(target, 'A0SC') >= 1 then
        call UnitRemoveAbility(target, 'A0SC')
    elseif GetUnitAbilityLevel(target, 'A0SD') >= 1 then
        call UnitRemoveAbility(target, 'A0SD')
    endif
    call UnitRemoveAbility(target, 'B060')
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    set t = null
    set target = null
endfunction

function Trig_Merlin02_Actions takes nothing returns nothing
    local timer t
    local integer task
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local integer level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 9)
    if IsUnitAlly(GetSpellTargetUnit(), GetTriggerPlayer()) == false then
        if IsUnitType(GetSpellTargetUnit(), UNIT_TYPE_HERO) and udg_SK_BLTalismanicAvaliable[GetConvertedPlayerId(GetOwningPlayer(GetSpellTargetUnit()))] and IsUnitIllusionBJ(GetSpellTargetUnit()) == false then
            call Item_BLTalismanicRunningCD(GetSpellTargetUnit())
            set t = null
            set caster = null
            set target = null
            return
        endif
    endif
    call PlaySoundOnUnitBJ(gg_snd_TrumpetChorus_02, 100, caster)
    call SetUnitVertexColor(target, 255, 255, 155, 255)
    call UnitAddAbility(target, 'A0S1')
    call SetUnitAbilityLevel(target, 'A0S2', level)
    call SetUnitAbilityLevel(target, 'A0S4', level)
    call SetUnitAbilityLevel(target, 'A0SE', level)
    call UnitAddAbility(target, 'A0SC')
    set t = CreateTimer()
    set task = GetHandleId(t)
    call SaveUnitHandle(udg_ht, task, 0, target)
    call TimerStart(t, 8.0, false, function Trig_Merlin02_Main)
    set t = null
    set caster = null
    set target = null
endfunction

function InitTrig_Merlin02 takes nothing returns nothing
endfunction