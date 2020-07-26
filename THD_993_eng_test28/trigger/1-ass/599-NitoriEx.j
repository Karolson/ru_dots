function NitoriEx takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local integer atkbonus = LoadInteger(udg_sht, task, 0)
    local integer intbonus = LoadInteger(udg_sht, task, 1)
    local unit u = LoadUnitHandle(udg_sht, task, 0)
    local integer currentint = GetHeroInt(u, true)
    local integer currentatk = GetUnitAttack(u)
    local integer adelta = R2I(0.6 * currentint)
    local integer idelta = R2I(0.2 * (currentatk - atkbonus))
    if u == null then
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_sht, task)
    endif
    if adelta > atkbonus then
        call UnitAddAttackDamage(u, adelta - atkbonus)
        call SaveInteger(udg_sht, task, 0, adelta)
    elseif adelta < atkbonus then
        call UnitReduceAttackDamage(u, atkbonus - adelta)
        call SaveInteger(udg_sht, task, 0, adelta)
    endif
    if idelta != intbonus then
        call SaveInteger(udg_sht, task, 1, idelta)
    endif
    set udg_Nitori_RealInt = currentint + idelta
    set t = null
    set u = null
endfunction

function InitTrig_NitoriEx takes nothing returns nothing
endfunction