function ReimuAbEx takes nothing returns integer
    return 'A0T4'
endfunction

function Trig_ReimuEx_Actions takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local integer goldadd = udg_SK_ReimuEx_Record_Salary
    if caster == null then
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
        set t = null
        set caster = null
        return
    endif
    call THD_AddCredit(GetOwningPlayer(caster), goldadd)
    if udg_GameMode / 100 == 3 or udg_NewMid then
        call THD_AddCredit(GetOwningPlayer(caster), goldadd)
    endif
    set t = null
    set caster = null
endfunction

function InitTrig_ReimuEx takes nothing returns nothing
endfunction