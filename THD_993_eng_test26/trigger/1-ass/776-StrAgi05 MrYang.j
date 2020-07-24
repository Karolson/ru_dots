function Trig_StrAgi05_MrYang_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A062'
endfunction

function IQ takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit target = LoadUnitHandle(udg_Hashtable, task, 1)
    call UnitRemoveAbility(target, 'A0A1')
    call UnitRemoveAbility(target, 'A0DT')
    call UnitRemoveAbility(target, 'B015')
    if udg_BlinkEnableUnit[GetPlayerId(GetOwningPlayer(target))] == null and GetUnitAbilityLevel(target, 'A0V4') == 0 then
        set udg_BlinkEnableUnit[GetPlayerId(GetOwningPlayer(target))] = CreateUnit(GetOwningPlayer(target), 'e036', -5344.0, -3968.0, 0)
    endif
    call FlushChildHashtable(udg_Hashtable, task)
    call ReleaseTimer(t)
    set t = null
    set target = null
endfunction

function Trig_StrAgi05_MrYang_Actions takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit target = LoadUnitHandle(udg_Hashtable, task, 1)
    local unit caster = LoadUnitHandle(udg_Hashtable, task, 0)
    if IsUnitType(target, UNIT_TYPE_DEAD) == false and GetUnitTypeId(target) != 'E009' then
        call UnitAddAbility(target, 'A0A1')
        call UnitAddAbility(target, 'A0DT')
        if not IsUnitIllusion(target) and udg_BlinkEnableUnit[GetPlayerId(GetOwningPlayer(target))] != null then
            call RemoveUnit(udg_BlinkEnableUnit[GetPlayerId(GetOwningPlayer(target))])
            set udg_BlinkEnableUnit[GetPlayerId(GetOwningPlayer(target))] = null
            call CE_Input(caster, target, 40.0)
        endif
        call TimerStart(t, DebuffDuration(target, 4.0), false, function IQ)
    else
        call FlushChildHashtable(udg_Hashtable, task)
        call ReleaseTimer(t)
    endif
    set t = null
    set caster = null
    set target = null
endfunction

function Trig_StrAgi05_MrYang_Start takes nothing returns nothing
    local timer t
    local integer task
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    if IsUnitAlly(GetSpellTargetUnit(), GetTriggerPlayer()) == false then
        if IsUnitType(GetSpellTargetUnit(), UNIT_TYPE_HERO) and udg_SK_BLTalismanicAvaliable[GetConvertedPlayerId(GetOwningPlayer(GetSpellTargetUnit()))] and IsUnitIllusionBJ(GetSpellTargetUnit()) == false then
            call Item_BLTalismanicRunningCD(GetSpellTargetUnit())
            set t = null
            set caster = null
            set target = null
            return
        endif
    endif
    call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Other\\Monsoon\\MonsoonBoltTarget.mdl", target, "chest"))
    call UnitDebuffTarget(caster, target, 4.0, 1, true, 'A0AZ', 1, 'Bprg', "purge", 0, "")
    set t = CreateTimer()
    set task = GetHandleId(t)
    call SaveUnitHandle(udg_Hashtable, task, 0, caster)
    call SaveUnitHandle(udg_Hashtable, task, 1, target)
    call TimerStart(t, 0.01, false, function Trig_StrAgi05_MrYang_Actions)
    set t = null
    set caster = null
    set target = null
endfunction

function InitTrig_StrAgi05_MrYang takes nothing returns nothing
    set gg_trg_StrAgi05_MrYang = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_StrAgi05_MrYang, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_StrAgi05_MrYang, Condition(function Trig_StrAgi05_MrYang_Conditions))
    call TriggerAddAction(gg_trg_StrAgi05_MrYang, function Trig_StrAgi05_MrYang_Start)
endfunction