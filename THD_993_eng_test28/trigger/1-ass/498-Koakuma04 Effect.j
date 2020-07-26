function Trig_Koakuma04_Effect_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0NI'
endfunction

function Trig_Koakuma04_Effect_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit u = LoadUnitHandle(udg_ht, task, 1)
    if GetUnitAbilityLevel(caster, 'B05B') > 0 then
        call SetUnitXY(u, GetUnitX(caster), GetUnitY(caster))
    else
        call KillUnit(u)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set u = null
endfunction

function Trig_Koakuma04_Effect_Actions takes nothing returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local unit caster = GetTriggerUnit()
    local unit u
    local integer level = GetUnitAbilityLevel(caster, 'A0NI')
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 105 - 20 * level)
    if GetUnitAbilityLevel(caster, 'A05F') > 0 and false then
        call UnitRemoveAbility(caster, 'A05F')
        call UnitRemoveAbility(caster, 'B05O')
        call Trig_Koakuma03_Timer_Set(caster)
    endif
    set u = CreateUnit(GetOwningPlayer(caster), 'e01H', GetUnitX(caster), GetUnitY(caster), 0)
    call SetUnitPathing(u, false)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, u)
    call TimerStart(t, 0.02, true, function Trig_Koakuma04_Effect_Main)
    set t = null
    set caster = null
    set u = null
endfunction

function InitTrig_Koakuma04_Effect takes nothing returns nothing
endfunction