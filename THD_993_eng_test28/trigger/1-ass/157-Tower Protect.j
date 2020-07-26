function Trig_Tower_Protect_Conditions takes nothing returns boolean
    return GetUnitTypeId(GetSoldUnit()) == 'n04X'
endfunction

function Tower_Protect_ColdDown takes player p returns nothing
    if IsPlayerAlly(p, udg_PlayerA[0]) then
        call RemoveUnitFromStockBJ('n04X', udg_BaseA[1])
        call RemoveUnitFromStockBJ('n04X', udg_BaseA[2])
        call RemoveUnitFromStockBJ('n04X', udg_BaseA[6])
        call RemoveUnitFromStockBJ('n04X', udg_BaseA[8])
        call RemoveUnitFromStockBJ('n04X', udg_BaseA[0])
        call AddUnitToStockBJ('n04X', udg_BaseA[1], 0, 1)
        call AddUnitToStockBJ('n04X', udg_BaseA[2], 0, 1)
        call AddUnitToStockBJ('n04X', udg_BaseA[6], 0, 1)
        call AddUnitToStockBJ('n04X', udg_BaseA[8], 0, 1)
        call AddUnitToStockBJ('n04X', udg_BaseA[0], 0, 1)
    else
        call RemoveUnitFromStockBJ('n04X', udg_BaseB[1])
        call RemoveUnitFromStockBJ('n04X', udg_BaseB[2])
        call RemoveUnitFromStockBJ('n04X', udg_BaseB[6])
        call RemoveUnitFromStockBJ('n04X', udg_BaseB[8])
        call RemoveUnitFromStockBJ('n04X', udg_BaseB[0])
        call AddUnitToStockBJ('n04X', udg_BaseB[1], 0, 1)
        call AddUnitToStockBJ('n04X', udg_BaseB[2], 0, 1)
        call AddUnitToStockBJ('n04X', udg_BaseB[6], 0, 1)
        call AddUnitToStockBJ('n04X', udg_BaseB[8], 0, 1)
        call AddUnitToStockBJ('n04X', udg_BaseB[0], 0, 1)
    endif
endfunction

function Trig_Tower_Protect_Actions takes nothing returns nothing
    local unit caster = GetSellingUnit()
    local unit u = GetSoldUnit()
    local unit tower = GetTriggerUnit()
    local player PLY = GetOwningPlayer(u)
    call RemoveUnit(u)
    set u = CreateUnit(PLY, 'e03H', GetUnitX(tower), GetUnitY(tower), 0.0)
    call SetUnitPathing(u, false)
    call SetUnitX(u, GetUnitX(tower))
    call SetUnitY(u, GetUnitY(tower))
    call BroadcastMessageFriend(udg_PN[GetPlayerId(PLY)] + " has used |cff8000ffquadruple enchantment|r!", PLY)
    call UnitBuffTarget(tower, tower, 4.0, 'A0Z9', 0)
    call UnitApplyTimedLife(u, 'B07E', 4.0)
    call Tower_Protect_ColdDown(PLY)
    set caster = null
    set u = null
    set tower = null
    set PLY = null
endfunction

function InitTrig_Tower_Protect takes nothing returns nothing
    set gg_trg_Tower_Protect = CreateTrigger()
    call TriggerAddCondition(gg_trg_Tower_Protect, Condition(function Trig_Tower_Protect_Conditions))
    call TriggerAddAction(gg_trg_Tower_Protect, function Trig_Tower_Protect_Actions)
endfunction