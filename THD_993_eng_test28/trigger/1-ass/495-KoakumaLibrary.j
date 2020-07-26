function Trig_KoakumaLibrary_Actions takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    if caster == null then
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
        set t = null
        set caster = null
        return
    endif
    call SetUnitState(caster, UNIT_STATE_MANA, GetUnitState(caster, UNIT_STATE_MANA) + (1 - GetUnitState(caster, UNIT_STATE_MANA) / GetUnitState(caster, UNIT_STATE_MAX_MANA)) * 5.0)
    set t = null
    set caster = null
endfunction

function Trig_Koakuma03_Timer takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 1)
    call UnitBuffTarget(caster, caster, 99999.0, 'A05F', 'B05O')
    call SaveTimerHandle(udg_ht, GetHandleId(caster), 954, null)
    call PauseTimer(t)
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, GetHandleId(t))
    call DebugMsg("Koakuma03 Effect")
    set t = null
    set caster = null
endfunction

function Trig_Koakuma03_Timer_Set takes unit u returns nothing
    local timer t = null
    if GetUnitAbilityLevel(u, 'A05A') != 0 then
        set t = LoadTimerHandle(udg_ht, GetHandleId(u), 954)
        if t == null then
            set t = CreateTimer()
            call SaveTimerHandle(udg_ht, GetHandleId(u), 954, t)
            call DebugMsg("NewTimer")
        endif
        call DebugMsg("Koakuma03 Start")
        call TimerStart(t, 12, false, function Trig_Koakuma03_Timer)
        call SaveUnitHandle(udg_ht, GetHandleId(t), 1, u)
    endif
    set t = null
endfunction

function InitTrig_KoakumaLibrary takes nothing returns nothing
endfunction