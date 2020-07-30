function Trig_Yuu_Death_Conditions takes nothing returns boolean
    return GetUnitTypeId(GetTriggerUnit()) == 'h00B' or GetUnitTypeId(GetTriggerUnit()) == 'h00I'
endfunction

function Trig_Yuu_Death_Actions takes nothing returns nothing
    local unit u = GetTriggerUnit()
    local unit killer = GetKillingUnit()
    local integer id
    if GetUnitTypeId(GetTriggerUnit()) == 'h00I' then
        set id = 'I03F'
    else
        set id = 'I03F'
    endif
    if IsUnitAlly(u, udg_PlayerA[0]) then
        if GetUnitTypeId(GetTriggerUnit()) == 'h00I' then
            call CreateItemLoc(id, udg_RevivePoint[1])
            call CreateItemLoc(id, udg_RevivePoint[1])
        endif
        call CreateItemLoc(id, udg_RevivePoint[1])
        call BroadcastMessage(udg_PN[GetPlayerId(GetOwningPlayer(killer))] + " just pwned yukkuri of " + udg_PN[GetPlayerId(GetOwningPlayer(u))])
    else
        if GetUnitTypeId(GetTriggerUnit()) == 'h00I' then
            call CreateItemLoc(id, udg_RevivePoint[0])
            call CreateItemLoc(id, udg_RevivePoint[0])
        endif
        call CreateItemLoc(id, udg_RevivePoint[0])
        call BroadcastMessage(udg_PN[GetPlayerId(GetOwningPlayer(killer))] + " just pwned yukkuri of " + udg_PN[GetPlayerId(GetOwningPlayer(u))])
    endif
    set u = null
    set killer = null
endfunction

function InitTrig_Yuu_Death takes nothing returns nothing
    set gg_trg_Yuu_Death = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Yuu_Death, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_Yuu_Death, Condition(function Trig_Yuu_Death_Conditions))
    call TriggerAddAction(gg_trg_Yuu_Death, function Trig_Yuu_Death_Actions)
endfunction