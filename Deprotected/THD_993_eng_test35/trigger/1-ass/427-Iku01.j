function Trig_Iku01_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A04O'
endfunction

function Trig_Iku01_Check takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_Hashtable, task, 0)
    local integer level = LoadInteger(udg_Hashtable, task, 0)
    local integer count = LoadInteger(udg_Hashtable, task, 1) + 1
    local integer k
    call SaveInteger(udg_Hashtable, task, 1, count)
    if GetUnitAbilityLevel(caster, 'B01T') == 0 or IsUnitMorphed(caster) then
        call UnitRemoveAbility(caster, 'B01T')
        call UnitRemoveAbility(caster, 'A1ET')
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    elseif count / 10 * 10 == count then
        set k = 0
        if GetUnitAbilityLevel(caster, 'A00J') > 0 then
            set k = 3
        elseif GetUnitAbilityLevel(caster, 'A033') > 0 then
            set k = 2
        elseif GetUnitAbilityLevel(caster, 'A01G') > 0 then
            set k = 1
        endif
        if GetUnitAbilityLevel(caster, 'A1EV') != k * 4 + level then
            call SetUnitAbilityLevel(caster, 'A1EV', k * 4 + level)
        endif
    endif
    set t = null
    set caster = null
endfunction

function Trig_Iku01_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit u
    local integer level = GetUnitAbilityLevel(caster, 'A04O')
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call UnitAddAbility(caster, 'A1ET')
    call SetUnitAbilityLevel(caster, 'A1EW', level)
    call SetUnitAbilityLevel(caster, 'A1EV', level)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveInteger(udg_ht, task, 0, level)
    call SaveInteger(udg_ht, task, 1, 0)
    call TimerStart(t, 0.1, true, function Trig_Iku01_Check)
    set caster = null
    set u = null
    set t = null
endfunction

function InitTrig_Iku01 takes nothing returns nothing
endfunction