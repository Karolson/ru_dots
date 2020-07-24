function Trig_Rumia01_Conditions takes nothing returns boolean
    if GetSpellAbilityId() != 'A07C' then
        return false
    endif
    return GetUnitTypeId(GetTriggerUnit()) == 'E00I'
endfunction

function Trig_Rumia01_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_Hashtable, task, 0)
    local unit u = LoadUnitHandle(udg_Hashtable, task, 1)
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local integer i = LoadInteger(udg_Hashtable, task, 1)
    local integer level03 = GetUnitAbilityLevel(caster, 'A07G')
    if GetWidgetLife(caster) >= 0.405 and i < 10 or GetUnitTypeId(caster) == 'E00J' then
        call SetUnitX(u, ox)
        call SetUnitY(u, oy)
        if i / 20 * 20 == i then
            call IssuePointOrder(u, "silence", ox, oy)
        endif
        call SaveInteger(udg_Hashtable, task, 1, i + 1)
        if GetUnitAbilityLevel(caster, 'A07I') == 0 and level03 >= 1 then
            call UnitAddAbility(caster, 'A07I')
            call UnitMakeAbilityPermanent(caster, true, 'A07I')
            call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A07I', false)
            if (GetFloatGameState(GAME_STATE_TIME_OF_DAY) >= 6 and GetFloatGameState(GAME_STATE_TIME_OF_DAY) < 18) == false and GetUnitAbilityLevel(caster, 'A07H') != level03 * 2 then
                call SetUnitAbilityLevel(caster, 'A07H', level03 * 2)
            elseif (GetFloatGameState(GAME_STATE_TIME_OF_DAY) >= 6 and GetFloatGameState(GAME_STATE_TIME_OF_DAY) < 18) and GetUnitAbilityLevel(caster, 'A07H') != level03 then
                call SetUnitAbilityLevel(caster, 'A07H', level03)
            endif
        endif
    else
        if GetUnitAbilityLevel(caster, 'A07I') == 0 and level03 >= 1 then
            call UnitAddAbility(caster, 'A07I')
            call UnitMakeAbilityPermanent(caster, true, 'A07I')
            call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A07I', false)
            if (GetFloatGameState(GAME_STATE_TIME_OF_DAY) >= 6 and GetFloatGameState(GAME_STATE_TIME_OF_DAY) < 18) == false and GetUnitAbilityLevel(caster, 'A07H') != level03 * 2 then
                call SetUnitAbilityLevel(caster, 'A07H', level03 * 2)
            elseif (GetFloatGameState(GAME_STATE_TIME_OF_DAY) >= 6 and GetFloatGameState(GAME_STATE_TIME_OF_DAY) < 18) and GetUnitAbilityLevel(caster, 'A07H') != level03 then
                call SetUnitAbilityLevel(caster, 'A07H', level03)
            endif
        endif
        call RemoveUnit(u)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_Hashtable, task)
        call DebugMsg("OFF")
    endif
    set t = null
    set caster = null
    set u = null
endfunction

function Trig_Rumia01_Actions takes nothing returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local unit caster = GetTriggerUnit()
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local unit u = CreateUnit(GetOwningPlayer(caster), 'n01K', ox, oy, 90.0)
    local integer level = GetUnitAbilityLevel(caster, 'A07C')
    call AbilityCoolDownResetion(caster, 'A07C', 15)
    call DebugMsg("ON")
    call SaveUnitHandle(udg_Hashtable, task, 0, caster)
    call SaveUnitHandle(udg_Hashtable, task, 1, u)
    call SaveInteger(udg_Hashtable, task, 1, 0)
    call TimerStart(t, 0.02, true, function Trig_Rumia01_Main)
    set t = null
    set caster = null
    set u = null
endfunction

function InitTrig_Rumia01 takes nothing returns nothing
endfunction