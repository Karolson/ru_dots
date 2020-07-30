function Trig_Suika03_Conditions takes nothing returns boolean
    if GetSpellAbilityId() == 'A10B' then
        call UnitBuffTarget(GetTriggerUnit(), GetTriggerUnit(), 3, 'A1F7', 'B09V')
        call SetUnitAbilityLevel(GetTriggerUnit(), 'A10B', GetUnitAbilityLevel(GetTriggerUnit(), 'A10B') + 1)
    endif
    return GetSpellAbilityId() == 'A05V'
endfunction

function Trig_Suika03_Frame takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit u
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local integer level = LoadInteger(udg_ht, task, 0)
    local integer i = LoadInteger(udg_ht, task, 1)
    if GetUnitAbilityLevel(caster, 'B03G') > 0 then
        set u = CreateUnit(GetOwningPlayer(caster), 'n030', ox, oy, GetRandomReal(0, 360))
        call UnitApplyTimedLife(u, 'BTLF', 6.0)
        call IssueImmediateOrder(u, "elementalfury")
    else
        call SetUnitMoveSpeed(caster, GetUnitDefaultMoveSpeed(caster))
        call UnitRemoveAbility(caster, 'A0BC')
        call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A05R', true)
        call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A05V', true)
        call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A05W', true)
        call SetUnitVertexColor(caster, 255, 255, 255, 255)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_Hashtable, task)
    endif
    set t = null
    set caster = null
    set u = null
endfunction

function Trig_Suika03_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    local integer i = level * 2 * 5
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 35 - 5 * level)
    call IssueImmediateOrder(caster, "stop")
    call SetUnitMoveSpeed(caster, 150)
    call UnitAddAbility(caster, 'A0BC')
    call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A05R', false)
    call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A05V', false)
    call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A05W', false)
    call SetUnitVertexColor(caster, 255, 255, 255, 1)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveInteger(udg_ht, task, 0, level)
    call SaveInteger(udg_ht, task, 1, i)
    call TimerStart(t, 0.4, true, function Trig_Suika03_Frame)
    set caster = null
    set t = null
endfunction

function InitTrig_Suika03 takes nothing returns nothing
endfunction