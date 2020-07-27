function Trig_Point_Creat_Conditions takes nothing returns boolean
    local real rate = 15.0
    if IsUnitType(GetTriggerUnit(), UNIT_TYPE_TAUREN) then
        return false
    elseif udg_SK_Nazrin04_ON and udg_SK_Nazrin04 != null and IsUnitInRange(GetTriggerUnit(), udg_SK_Nazrin04, 1200.0) then
        set rate = rate + 12.0 * GetUnitAbilityLevel(udg_SK_Nazrin04, 'A0D6')
    endif
    if GetOwningPlayer(GetKillingUnit()) == udg_PlayerA[0] then
        return GetRandomReal(0, 100) <= rate
    elseif GetOwningPlayer(GetKillingUnit()) == udg_PlayerB[0] then
        return GetRandomReal(0, 100) <= rate
    endif
    return false
endfunction

function Trig_Point_Remove takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local item w = LoadItemHandle(udg_ht, task, 0)
    local integer i = LoadInteger(udg_ht, task, 0)
    if i == 0 and GetWidgetLife(w) > 0 then
        call SetWidgetLife(w, -1)
        call SaveInteger(udg_ht, task, 0, 1)
        call TimerStart(t, 0.7, false, function Trig_Point_Remove)
    else
        call RemoveItem(w)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set w = null
endfunction

function Trig_Point_Creat_Actions takes nothing returns nothing
    local unit u = GetTriggerUnit()
    local item w = CreateItem('I03F', GetUnitX(u), GetUnitY(u))
    local timer t
    local integer task
    set t = CreateTimer()
    set task = GetHandleId(t)
    call SaveInteger(udg_ht, task, 0, 0)
    call SaveItemHandle(udg_ht, task, 0, w)
    call TimerStart(t, 10.0, false, function Trig_Point_Remove)
    set w = null
    set t = null
    set u = null
endfunction

function InitTrig_Point_Creat takes nothing returns nothing
    set gg_trg_Point_Creat = CreateTrigger()
    call TriggerAddCondition(gg_trg_Point_Creat, Condition(function Trig_Point_Creat_Conditions))
    call TriggerAddAction(gg_trg_Point_Creat, function Trig_Point_Creat_Actions)
endfunction