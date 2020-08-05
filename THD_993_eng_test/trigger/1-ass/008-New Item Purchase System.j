function GetItemMaxCharges takes integer id returns integer
    if id == 'I02P' or id == 'I02S' or id == 'I02T' or id == 'I02R' or id == 'I02Q' or id == 'I02U' or id == 'I02N' or id == 'I03J' then
        return 12
    elseif id == 'I00R' or id == 'I00T' or id == 'I00S' then
        return 1
    elseif id == 'dust' then
        return 2
    endif
    return 0
endfunction

function Key_Id_U2I takes nothing returns integer
    return StringHash("Id_U2I")
endfunction

function GetActualItem takes integer unitid returns integer
    return LoadInteger(udg_Hashtable_Data, unitid, StringHash("Id_U2I"))
endfunction

function LogActualItem takes integer unitid, integer abilid returns nothing
    call SaveInteger(udg_Hashtable_Data, unitid, StringHash("Id_U2I"), abilid)
endfunction

function AddPlayerGold takes unit u, integer delta returns nothing
    call SetPlayerState(GetOwningPlayer(u), PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(GetOwningPlayer(u), PLAYER_STATE_RESOURCE_GOLD) + delta)
endfunction

function UnitAddItemTry takes unit u, integer id returns boolean
    local integer i = 0
    local integer max = GetItemMaxCharges(id)
    local item it
    loop
        set it = UnitItemInSlot(u, i)
        if GetItemTypeId(it) == id and GetItemCharges(it) < max then
            call AddItemCharges(it, 1)
            set it = null
            return true
        endif
    exitwhen i >= 5
        set i = i + 1
    endloop
    set i = 0
    loop
        set it = UnitItemInSlot(u, i)
        if it == null then
            call UnitAddItemById(u, id)
            set it = null
            return true
        endif
    exitwhen i >= 5
        set i = i + 1
    endloop
    set it = null
    return false
endfunction

function Trig_New_Item_Purchase_System_Actions takes nothing returns boolean
    local unit u = GetSoldUnit()
    local integer id = LoadInteger(udg_Hashtable_Data, GetUnitTypeId(u), StringHash("Id_U2I"))
    local unit user
    if id != 0 then
        call DebugMsg("Actual Item Type ID = " + I2S(id))
        set user = GetBuyingUnit()
        call RemoveUnit(u)
        if UnitAddItemTry(user, id) == false then
            call LocalErrorMessage(user, "Inventory is full!")
            call AddPlayerGold(user, LoadInteger(udg_ItemDatabase, id, 0))
        endif
        set user = null
    endif
    set u = null
    return false
endfunction

function InitTrig_New_Item_Purchase_System takes nothing returns nothing
    call SaveInteger(udg_Hashtable_Data, 'u01G', StringHash("Id_U2I"), 'I02P')
    call SaveInteger(udg_Hashtable_Data, 'u01B', StringHash("Id_U2I"), 'I02S')
    call SaveInteger(udg_Hashtable_Data, 'u01C', StringHash("Id_U2I"), 'I02T')
    call SaveInteger(udg_Hashtable_Data, 'u01A', StringHash("Id_U2I"), 'I02R')
    call SaveInteger(udg_Hashtable_Data, 'u019', StringHash("Id_U2I"), 'I02Q')
    call SaveInteger(udg_Hashtable_Data, 'u01D', StringHash("Id_U2I"), 'I02U')
    call SaveInteger(udg_Hashtable_Data, 'u017', StringHash("Id_U2I"), 'I02N')
    call SaveInteger(udg_Hashtable_Data, 'h02Q', StringHash("Id_U2I"), 'I03J')
    set gg_trg_New_Item_Purchase_System = CreateTrigger()
    call TriggerRegisterAnyUnitEventFix(gg_trg_New_Item_Purchase_System, EVENT_PLAYER_UNIT_SELL)
    call TriggerAddCondition(gg_trg_New_Item_Purchase_System, Condition(function Trig_New_Item_Purchase_System_Actions))
endfunction