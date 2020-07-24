function DMG_DamageReduceClear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local integer i = LoadInteger(udg_ht, task, 0)
    local integer id = LoadInteger(udg_ht, task, 1)
    local real reduce = LoadReal(udg_ht, task, 0)
    if i == 0 then
        set udg_DMG_AllMagicDamage[id] = udg_DMG_AllMagicDamage[id] / reduce
    elseif i == 1 then
        set udg_DMG_AllPhyscialDamage[id] = udg_DMG_AllPhyscialDamage[id] / reduce
    elseif i == 2 then
        set udg_DMG_AllDamage[id] = udg_DMG_AllDamage[id] / reduce
    endif
    call FlushChildHashtable(udg_ht, task)
    call ReleaseTimer(t)
    set t = null
endfunction

function DMG_DamageReduce takes unit target, real reduce, real time, string typ returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local integer id = GetPlayerId(GetOwningPlayer(target))
    if IsUnitType(target, UNIT_TYPE_HERO) then
        if typ == "Magic" then
            set udg_DMG_AllMagicDamage[id] = udg_DMG_AllMagicDamage[id] * reduce
            call SaveInteger(udg_ht, task, 0, 0)
        elseif typ == "Physcial" then
            set udg_DMG_AllPhyscialDamage[id] = udg_DMG_AllPhyscialDamage[id] * reduce
            call SaveInteger(udg_ht, task, 0, 1)
        elseif typ == "All" then
            set udg_DMG_AllDamage[id] = udg_DMG_AllDamage[id] * reduce
            call SaveInteger(udg_ht, task, 0, 2)
        endif
        call SaveReal(udg_ht, task, 0, reduce)
        call SaveInteger(udg_ht, task, 1, id)
        call TimerStart(t, time, false, function DMG_DamageReduceClear)
    endif
    set t = null
endfunction

function InitTrig_AllDamageReduceSystem takes nothing returns nothing
endfunction