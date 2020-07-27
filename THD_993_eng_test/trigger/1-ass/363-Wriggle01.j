function WRIGGLE01 takes nothing returns integer
    return 'A0FW'
endfunction

function WRIGGLE01_BUFF_ABILITY takes nothing returns integer
    return 'A0VU'
endfunction

function WRIGGLE01_DURATION takes nothing returns real
    return 4.0
endfunction

function WRIGGLE01_COOLDOWN takes nothing returns real
    return 10.0
endfunction

function Wriggle_01_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0FW'
endfunction

function Wriggle_01_Clear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_sht, task, 0)
    local integer ctask = GetHandleId(caster)
    if LoadBoolean(udg_sht, StringHash("Wriggle01"), ctask) then
        call SaveBoolean(udg_sht, StringHash("Wriggle01"), ctask, false)
        call UnitRemoveAbility(caster, 'A0VU')
        call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A0FW', true)
    endif
    call FlushChildHashtable(udg_sht, task)
    call ReleaseTimer(t)
    set t = null
    set caster = null
endfunction

function Wriggle_01_Actions takes nothing returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local unit caster = GetTriggerUnit()
    local integer ctask = GetHandleId(caster)
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 17 - GetUnitAbilityLevel(caster, GetSpellAbilityId()) * 2)
    if not LoadBoolean(udg_sht, StringHash("Wriggle01"), ctask) then
        call UnitAddAbility(caster, 'A0VU')
        call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A0FW', false)
        call UnitMakeAbilityPermanent(caster, true, 'A0VU')
        call SaveBoolean(udg_sht, StringHash("Wriggle01"), ctask, true)
        call SaveTimerHandle(udg_sht, StringHash("Wriggle01"), ctask, t)
        call SaveUnitHandle(udg_sht, task, 0, caster)
        call TimerStart(t, 4.0, false, function Wriggle_01_Clear)
    endif
    set t = null
    set caster = null
endfunction

function InitTrig_Wriggle01 takes nothing returns nothing
endfunction