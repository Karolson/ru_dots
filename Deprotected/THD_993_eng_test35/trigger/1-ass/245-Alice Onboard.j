function Trig_Alice_Onboard_Conditions takes nothing returns boolean
    return IsUnitLoaded(GetTriggerUnit())
endfunction

function Trig_Alice_Onboard_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit target = LoadUnitHandle(udg_ht, task, 1)
    if IsUnitInTransport(caster, target) then
        call SetUnitX(caster, GetUnitX(target))
        call SetUnitY(caster, GetUnitY(target))
    else
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set target = null
endfunction

function Trig_Alice_Onboard_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetTransportUnit()
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, target)
    call TimerStart(t, 0.03, true, function Trig_Alice_Onboard_Main)
    set caster = null
    set target = null
    set t = null
endfunction

function InitTrig_Alice_Onboard takes nothing returns nothing
endfunction