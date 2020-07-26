function Trig_Item_Announce_Conditions takes nothing returns boolean
    local integer array a
    local integer i = 1
    local item w = GetSoldItem()
    local unit h = GetBuyingUnit()
    local player p = GetOwningPlayer(h)
    local integer id = GetItemTypeId(w)
    set a[1] = 'I00F'
    set a[2] = 'I02Q'
    set a[3] = 'I02R'
    set a[4] = 'I02U'
    set a[5] = 'I05X'
    set a[6] = 'I02O'
    set a[7] = 'I05Y'
    set a[8] = 'I025'
    loop
    exitwhen i > 8
        if id == a[i] then
            call BroadcastMessageFriend(udg_PN[GetPlayerId(p)] + " purchased " + GetItemName(w), p)
            set w = null
            set h = null
            set p = null
            return false
        endif
        set i = i + 1
    endloop
    set w = null
    set h = null
    set p = null
    return false
endfunction

function InitTrig_Item_Announce takes nothing returns nothing
    set gg_trg_Item_Announce = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Item_Announce, EVENT_PLAYER_UNIT_SELL_ITEM)
    call TriggerAddCondition(gg_trg_Item_Announce, Condition(function Trig_Item_Announce_Conditions))
endfunction