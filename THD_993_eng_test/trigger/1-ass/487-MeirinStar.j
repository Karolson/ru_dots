function Trig_MeirinStar_Clear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    set udg_SK_MeirinStar = udg_SK_MeirinStar - 1
    set t = null
endfunction

function Trig_MeirinStar_Cast takes nothing returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    set udg_SK_MeirinStar = udg_SK_MeirinStar + 1
    call TimerStart(t, 5.0, false, function Trig_MeirinStar_Clear)
    set t = null
endfunction

function Trig_MeirinStar_Actions takes nothing returns nothing
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
    if udg_SK_MeirinStar > 0 then
        call DebugMsg(R2S(1 + udg_SK_MeirinStar * 1))
    endif
    set t = null
    set caster = null
endfunction

function InitTrig_MeirinStar takes nothing returns nothing
endfunction