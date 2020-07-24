function HINA03 takes nothing returns integer
    return 'A0E8'
endfunction

function Trig_Hina03_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A0E8')
    call AbilityCoolDownResetion(caster, 'A0E8', 6)
    if IsUnitAlly(GetSpellTargetUnit(), GetTriggerPlayer()) == false then
        if IsUnitType(GetSpellTargetUnit(), UNIT_TYPE_HERO) and udg_SK_BLTalismanicAvaliable[GetConvertedPlayerId(GetOwningPlayer(GetSpellTargetUnit()))] and IsUnitIllusionBJ(GetSpellTargetUnit()) == false then
            call Item_BLTalismanicRunningCD(GetSpellTargetUnit())
            set caster = null
            set target = null
            return
        endif
    endif
    call UnitAbsDamageTarget(caster, target, 40 + level * 20)
    call UnitSlowTarget(caster, target, 6.0, 'A182', 0)
    call SetUnitAbilityLevel(target, 'A182', level)
    set caster = null
    set target = null
endfunction

function HINA03FLAG takes nothing returns integer
    return 'A0JL'
endfunction

function Trig_Hina03_End_New takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit u = LoadUnitHandle(udg_ht, task, 1)
    call UnitRemoveAbility(u, 'A0JL')
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    set t = null
    set t = null
endfunction

function Hina03_ShieldClear_New takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local unit u = LoadUnitHandle(udg_ht, GetHandleId(t), 0)
    call RemoveSavedReal(udg_Hashtable_Slow, GetHandleId(u), 'A070' * -10)
    call RemoveSavedHandle(udg_Hashtable_Slow, GetHandleId(u), 'A070' * -10)
    call FlushChildHashtable(udg_ht, GetHandleId(t))
    if IsUnitType(u, UNIT_TYPE_HERO) then
        set udg_DMG_AllMagicDamage[GetPlayerId(GetOwningPlayer(u))] = udg_DMG_AllMagicDamage[GetPlayerId(GetOwningPlayer(u))] / (1 + GetUnitAbilityLevel(u, 'A0JL') * 0.05 + 0.15)
    endif
    call UnitRemoveAbility(u, 'A0JL')
    call ReleaseTimer(t)
    set u = null
    set t = null
endfunction

function Trig_Hina03_Actions_New takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A0E8')
    local timer t = CreateTimer()
    call AbilityCoolDownResetion(caster, 'A0E8', 17.5 - level * 1.5)
    set udg_SK_HinaEx_Count = GetUnitState(caster, UNIT_STATE_MAX_LIFE) * 0.1
    call UnitBuffTarget(caster, target, 6.0, 'A070', 'B07B')
    call SaveReal(udg_Hashtable_Slow, GetHandleId(target), 'A070' * -10, GetUnitState(caster, UNIT_STATE_MAX_LIFE) * 0.1)
    call SaveUnitHandle(udg_Hashtable_Slow, GetHandleId(target), 'A070' * -10, caster)
    call SaveUnitHandle(udg_ht, GetHandleId(t), 1, target)
    call UnitAddAbility(target, 'A0JL')
    call UnitMakeAbilityPermanent(target, true, 'A0JL')
    call TimerStart(t, 4, false, function Trig_Hina03_End_New)
    set t = CreateTimer()
    call SaveUnitHandle(udg_ht, GetHandleId(t), 0, target)
    if IsUnitType(target, UNIT_TYPE_HERO) then
        set udg_DMG_AllMagicDamage[GetPlayerId(GetOwningPlayer(target))] = udg_DMG_AllMagicDamage[GetPlayerId(GetOwningPlayer(target))] * (1 + level * 0.05 + 0.15)
    endif
    call TimerStart(t, 6.0, false, function Hina03_ShieldClear_New)
    set t = null
    set caster = null
endfunction

function Trig_Hina03_Conditions takes nothing returns boolean
    if GetSpellAbilityId() == 'A0E8' then
        call Trig_Hina03_Actions()
    endif
    return false
endfunction

function InitTrig_Hina03 takes nothing returns nothing
endfunction