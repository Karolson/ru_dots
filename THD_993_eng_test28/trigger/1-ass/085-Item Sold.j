function Trig_Item_Sold_Actions takes nothing returns nothing
    local unit u = GetTriggerUnit()
    local item i = GetSoldItem()
    if GetItemLevel(i) == 50 and udg_smodestat then
        call THD_AddCredit(GetOwningPlayer(u), -R2I(0.75 * LoadInteger(udg_ItemDatabase, GetItemTypeId(i), 0) * GetItemCharges(i)))
    endif
    if GetItemTypeId(i) == 'I04Z' then
        call THD_AddSpirit(GetOwningPlayer(u), -75)
    endif
    set u = null
    set i = null
endfunction

function InitTrig_Item_Sold takes nothing returns nothing
    set gg_trg_Item_Sold = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Item_Sold, EVENT_PLAYER_UNIT_SELL_ITEM)
    call TriggerAddAction(gg_trg_Item_Sold, function Trig_Item_Sold_Actions)
endfunction