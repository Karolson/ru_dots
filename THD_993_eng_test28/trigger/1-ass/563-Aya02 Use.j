function Trig_Aya02_Use_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A05L'
endfunction

function Trig_Aya02_Use_BLT_Clear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit target = LoadUnitHandle(udg_Hashtable, task, 0)
    call UnitRemoveAbility(target, 'B00Y')
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_Hashtable, task)
    set t = null
    set target = null
endfunction

function Trig_Aya02_Use_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local timer t
    local integer task
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 5)
    if IsUnitEnemy(target, GetTriggerPlayer()) then
        if IsUnitType(target, UNIT_TYPE_HERO) and udg_SK_BLTalismanicAvaliable[GetConvertedPlayerId(GetOwningPlayer(target))] and IsUnitIllusion(target) == false then
            call Item_BLTalismanicRunningCD(target)
            set t = CreateTimer()
            set task = GetHandleId(t)
            call SaveUnitHandle(udg_Hashtable, task, 0, target)
            call TimerStart(t, 0.01, false, function Trig_Aya02_Use_BLT_Clear)
            set caster = null
            set t = null
            return
        endif
    endif
    set caster = null
    set t = null
endfunction

function InitTrig_Aya02_Use takes nothing returns nothing
endfunction