function Trig_TokikoEx_Conditions takes nothing returns boolean
    local integer i = 0
    local boolean j = false
    loop
        if GetOwningPlayer(GetBuyingUnit()) == GetOwningPlayer(udg_SK_Tokiko[i]) then
            set j = true
        endif
        set i = i + 1
    exitwhen i == 16
    endloop
    return j
endfunction

function Trig_TokikoEx_Actions takes nothing returns nothing
    local player p = GetOwningPlayer(GetBuyingUnit())
    local integer n = GetPlayerId(p)
    local integer cost = R2I(GetItemLevel(GetSoldItem()) * 0.1)
    call AdjustPlayerStateBJ(cost, p, PLAYER_STATE_RESOURCE_GOLD)
    set udg_PlayerTotalGoldIncome[n] = udg_PlayerTotalGoldIncome[n] - cost
    set udg_PlayerTotalGoldLoss[n] = udg_PlayerTotalGoldLoss[n] - cost
endfunction

function InitTrig_TokikoEx takes nothing returns nothing
endfunction