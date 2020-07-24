function Trig_Hatate03_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0D9'
endfunction

function Trig_Hatate03_Clear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    if GetUnitAbilityLevel(caster, 'A0E5') == 1 then
        call UnitRemoveAbility(caster, 'A0E5')
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    else
        call SetUnitAbilityLevel(caster, 'A0E5', GetUnitAbilityLevel(caster, 'A0E5') - 1)
    endif
    set t = null
    set caster = null
endfunction

function Trig_Hatate03_Actions takes nothing returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A0D9')
    call AbilityCoolDownResetion(caster, 'A0D9', 17 - level * 1.5)
    call UnitAddAbility(caster, 'A0E5')
    call SetUnitAbilityLevel(caster, 'A0E5', 4)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call TimerStart(t, (2.0 + level) * 0.25, true, function Trig_Hatate03_Clear)
    set t = null
    set caster = null
endfunction

function InitTrig_Hatate03 takes nothing returns nothing
endfunction