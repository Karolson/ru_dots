function Trig_Kogasa01_Conditions takes nothing returns boolean
    if GetSpellAbilityId() == 'A0C3' then
        return true
    endif
    return false
endfunction

function Trig_Kogasa01_Reset_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 1)
    call UnitRemoveAbility(caster, 'A1GA')
    call UnitRemoveAbility(caster, 'A1G9')
    call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A0C3', true)
    call FlushChildHashtable(udg_ht, task)
    set caster = null
    set t = null
endfunction

function Trig_Kogasa01_Reset takes unit caster, real coldtime returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call SaveUnitHandle(udg_ht, task, 1, caster)
    call TimerStart(t, coldtime, false, function Trig_Kogasa01_Reset_Main)
    set t = null
endfunction

function Trig_Kogasa01_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A0C3')
    call AbilityCoolDownResetion(caster, 'A0C3', 15)
    call UnitBuffTarget(caster, caster, 15, 'A0C4', 0)
    call SetUnitAbilityLevel(caster, 'A0C4', level)
    call UnitMakeAbilityPermanent(caster, true, 'A0C4')
    call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A0C3', false)
    call Trig_Kogasa01_Reset(caster, GetAbilityCoolDownTime(caster, 'A0C3', 15))
    set caster = null
endfunction

function InitTrig_Kogasa01 takes nothing returns nothing
endfunction