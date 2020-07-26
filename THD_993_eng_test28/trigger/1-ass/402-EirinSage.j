function Trig_EirinSage_Actions takes nothing returns nothing
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
    if udg_GameMode / 100 == 3 or udg_NewMid then
        call SetHeroInt(caster, GetHeroInt(caster, false) + 2, true)
    else
        call SetHeroInt(caster, GetHeroInt(caster, false) + 1, true)
    endif
    set t = null
    set caster = null
endfunction

function InitTrig_EirinSage takes nothing returns nothing
endfunction