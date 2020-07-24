function Trig_Captain04_nihility_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0RP' or GetSpellAbilityId() == 'A10O'
endfunction

function Trig_Captain04_nihility_Clear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    call UnitRemoveAbility(caster, 'A0AH')
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    set t = null
    set caster = null
endfunction

function Trig_Captain04_nihility_Actions takes nothing returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local unit caster = GetTriggerUnit()
    if GetSpellAbilityId() == 'A0RP' then
        call UnitAddAbility(udg_SK_Caption04_Ship, 'A0AH')
        call SaveUnitHandle(udg_ht, task, 0, udg_SK_Caption04_Ship)
        call TimerStart(t, 6.0, false, function Trig_Captain04_nihility_Clear)
    elseif GetSpellAbilityId() == 'A10O' then
        call UnitAddAbility(caster, 'A0AH')
        call SaveUnitHandle(udg_ht, task, 0, caster)
        call TimerStart(t, 2.0, false, function Trig_Captain04_nihility_Clear)
    endif
    set t = null
    set caster = null
endfunction

function InitTrig_Captain04_nihility takes nothing returns nothing
endfunction