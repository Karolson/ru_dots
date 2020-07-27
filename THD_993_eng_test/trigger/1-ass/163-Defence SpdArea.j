function Trig_Defence_SpdArea_Conditions takes nothing returns boolean
    local unit u = GetSoldUnit()
    local unit v = GetSellingUnit()
    if GetUnitTypeId(u) != 'n02K' then
        set u = null
        set v = null
        return false
    endif
    if GetUnitTypeId(u) == 'n02K' and GetPlayerState(GetOwningPlayer(u), PLAYER_STATE_RESOURCE_LUMBER) < 6 then
        call DisplayTextToPlayer(GetOwningPlayer(u), 0, 0, "Insufficient faith! 6 faith is required to cast wind's blessing")
        call RemoveUnit(u)
        call AddUnitToStock(v, 'n02K', 1, 1)
        set u = null
        set v = null
        return false
    endif
    set u = null
    set v = null
    return true
endfunction

function Trig_Defence_SpdArea_Actions takes nothing returns nothing
    local unit caster = GetSellingUnit()
    local unit u = GetSoldUnit()
    call THD_AddSpirit(GetOwningPlayer(caster), -6)
    call BroadcastMessageFriend(udg_PN[GetPlayerId(GetOwningPlayer(u))] + " has summoned blessing of the wind", GetOwningPlayer(u))
    call UnitAddAbility(u, 'A0A2')
    call IssueImmediateOrderById(u, 852285)
    call RemoveUnit(u)
    call RemoveUnitFromStock(caster, 'n02J')
    call AddUnitToStock(caster, 'n02J', 0, 1)
    set caster = null
    set u = null
endfunction

function InitTrig_Defence_SpdArea takes nothing returns nothing
    set gg_trg_Defence_SpdArea = CreateTrigger()
    call TriggerAddCondition(gg_trg_Defence_SpdArea, Condition(function Trig_Defence_SpdArea_Conditions))
    call TriggerAddAction(gg_trg_Defence_SpdArea, function Trig_Defence_SpdArea_Actions)
endfunction