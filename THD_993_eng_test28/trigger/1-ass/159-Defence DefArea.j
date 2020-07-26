function Trig_Defence_DefArea_Conditions takes nothing returns boolean
    local unit u = GetSoldUnit()
    local unit v = GetSellingUnit()
    if GetUnitTypeId(u) != 'n02J' then
        set u = null
        set v = null
        return false
    endif
    if GetUnitTypeId(u) == 'n02J' and GetPlayerState(GetOwningPlayer(u), PLAYER_STATE_RESOURCE_LUMBER) < 6 then
        call DisplayTextToPlayer(GetOwningPlayer(u), 0, 0, "Insufficient faith! 6 faith is required to cast the defensive enchantment")
        call RemoveUnit(u)
        call AddUnitToStock(v, 'n02J', 1, 1)
        set u = null
        set v = null
        return false
    endif
    set u = null
    set v = null
    return true
endfunction

function Trig_Defence_DefArea_MagicResist_Filter takes nothing returns boolean
    local unit u = GetFilterUnit()
    if GetWidgetLife(u) > 0.405 and not IsUnitType(u, UNIT_TYPE_STRUCTURE) and IsUnitAlly(u, bj_groupEnumOwningPlayer) then
        call UnitAddAbility(u, 'A0NR')
        set u = null
        return true
    endif
    set u = null
    return false
endfunction

function Trig_Defence_DefArea_MagicResist_Clear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local group g = LoadGroupHandle(udg_ht, task, 0)
    local unit v
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        call UnitRemoveAbility(v, 'A0NR')
    endloop
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    call DestroyGroup(g)
    set g = null
    set t = null
    set v = null
endfunction

function Trig_Defence_DefArea_MagicResist_Main takes nothing returns nothing
    local unit v = GetEnumUnit()
    call UnitAddAbility(v, 'A0NR')
    set v = null
endfunction

function Trig_Defence_DefArea_Actions takes nothing returns nothing
    local unit caster = GetSellingUnit()
    local unit u = GetSoldUnit()
    local player PLY = GetOwningPlayer(u)
    local filterfunc filter = Filter(function Trig_Defence_DefArea_MagicResist_Filter)
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local group g
    local unit v
    call THD_AddSpirit(GetOwningPlayer(caster), -6)
    call UnitAddAbility(u, 'A0CT')
    call IssueImmediateOrderById(u, 852269)
    call UnitRemoveAbility(u, 'A0CT')
    call RemoveUnit(u)
    call RemoveUnitFromStock(caster, 'n02K')
    call AddUnitToStock(caster, 'n02K', 0, 1)
    set g = CreateGroup()
    set bj_groupEnumOwningPlayer = PLY
    call GroupEnumUnitsInRange(g, GetUnitX(caster), GetUnitY(caster), 250.0, filter)
    set bj_groupEnumOwningPlayer = null
    call SaveGroupHandle(udg_ht, task, 0, g)
    call TimerStart(t, 7.0, false, function Trig_Defence_DefArea_MagicResist_Clear)
    call DestroyFilter(filter)
    call BroadcastMessageFriend(udg_PN[GetPlayerId(PLY)] + " has summoned a defensive enchantment", PLY)
    set t = null
    set filter = null
    set caster = null
    set u = null
    set PLY = null
    set g = null
    set v = null
endfunction

function InitTrig_Defence_DefArea takes nothing returns nothing
    set gg_trg_Defence_DefArea = CreateTrigger()
    call TriggerAddCondition(gg_trg_Defence_DefArea, Condition(function Trig_Defence_DefArea_Conditions))
    call TriggerAddAction(gg_trg_Defence_DefArea, function Trig_Defence_DefArea_Actions)
endfunction