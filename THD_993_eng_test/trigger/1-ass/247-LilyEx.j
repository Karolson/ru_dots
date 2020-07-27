function LilyEx_Func takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit u = LoadUnitHandle(udg_ht, task, 1)
    call DebugMsg("Lily Ex Effect")
    if GetUnitTypeId(u) == 'E023' then
        call UnitAddAbility(u, 'A1AB')
        call UnitRemoveAbility(u, 'A1AB')
        call UnitAddAbility(u, 'A1AD')
        call UnitRemoveAbility(u, 'A1AD')
        call UnitAddAbility(u, 'A1AE')
        call UnitRemoveAbility(u, 'A1AE')
        call UnitAddAbility(u, 'A1AF')
        call UnitRemoveAbility(u, 'A1AF')
    else
        call UnitAddAbility(u, 'A1AA')
        call UnitRemoveAbility(u, 'A1AA')
        call UnitAddAbility(u, 'A1AG')
        call UnitRemoveAbility(u, 'A1AG')
        call UnitAddAbility(u, 'A1AH')
        call UnitRemoveAbility(u, 'A1AH')
        call UnitAddAbility(u, 'A1AI')
        call UnitRemoveAbility(u, 'A1AI')
    endif
    set t = null
    set u = null
endfunction

function Trig_LilyEx_Conditions takes nothing returns boolean
    local timer t
    local unit u
    if GetTriggerEventId() == EVENT_UNIT_HERO_REVIVABLE then
        set u = GetTriggerUnit()
        call UnitAddAbility(u, 'A1AB')
        call UnitRemoveAbility(u, 'A1AB')
        call UnitAddAbility(u, 'A1AD')
        call UnitRemoveAbility(u, 'A1AD')
        call UnitAddAbility(u, 'A1AE')
        call UnitRemoveAbility(u, 'A1AE')
        call UnitAddAbility(u, 'A1AF')
        call UnitRemoveAbility(u, 'A1AF')
        set u = null
        return false
    endif
    if GetSpellAbilityId() == 'A0WQ' then
        call DebugMsg("Lily Ex")
        set t = CreateTimer()
        call SaveUnitHandle(udg_ht, GetHandleId(t), 1, GetTriggerUnit())
        call TimerStart(t, 0.05, false, function LilyEx_Func)
        set t = null
    endif
    return false
endfunction

function Trig_LilyEx_Actions takes nothing returns nothing
endfunction

function InitTrig_LilyEx takes nothing returns nothing
endfunction