function Trig_Defence_SCV_Conditions takes nothing returns boolean
    local unit u = GetSoldUnit()
    local unit v = GetSellingUnit()
    if GetUnitTypeId(u) != 'e00Y' then
        set u = null
        set v = null
        return false
    endif
    if GetUnitTypeId(u) == 'e00Y' and GetPlayerState(GetOwningPlayer(u), PLAYER_STATE_RESOURCE_LUMBER) < 5 then
        call DisplayTextToPlayer(GetOwningPlayer(u), 0, 0, "Insufficient faith! 5 faith is required to order a Kappa repairman")
        call RemoveUnit(u)
        call AddUnitToStock(v, 'e00Y', 1, 1)
        set u = null
        set v = null
        return false
    endif
    set u = null
    set v = null
    return true
endfunction

function Trig_SCV_Actions takes nothing returns nothing
    local unit u = GetSellingUnit()
    local unit v = GetSoldUnit()
    call THD_AddSpirit(GetOwningPlayer(u), -5)
    call BroadcastMessageFriend(udg_PN[GetPlayerId(GetOwningPlayer(v))] + " bought a Kappa repairman", GetOwningPlayer(v))
    set u = null
    set v = null
endfunction

function InitTrig_Defence_SCV takes nothing returns nothing
    set gg_trg_Defence_SCV = CreateTrigger()
    call TriggerAddCondition(gg_trg_Defence_SCV, Condition(function Trig_Defence_SCV_Conditions))
    call TriggerAddAction(gg_trg_Defence_SCV, function Trig_SCV_Actions)
endfunction