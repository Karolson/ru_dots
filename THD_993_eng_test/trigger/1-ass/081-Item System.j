function Teleport_FixDoubleClick takes item it, unit u, trigger t returns nothing
    local unit base
    if GetItemTypeId(it) == 'I00A' or GetItemTypeId(it) == 'I02P' or GetItemTypeId(it) == 'I077' then
        set base = GetUnitBase(u)
        call SetItemPosition(it, GetUnitX(base), GetUnitY(base))
        call DisableTrigger(t)
        call UnitAddItem(u, it)
        call EnableTrigger(t)
    endif
    set base = null
endfunction

function THD_IsItemTypePrivate takes integer d returns boolean
    if d == 'I000' then
        return false
    endif
    if d == 'I03H' then
        return false
    endif
    if 'I03C' <= d and d <= 'I03E' then
        return false
    endif
    if d == 'I02U' then
        return false
    endif
    if d == 'I016' then
        return false
    endif
    if d == 'I08K' then
        return false
    endif
    if d == 'I06P' then
        return false
    endif
    if d == 'I02R' then
        return false
    endif
    if d == 'I02Q' then
        return false
    endif
    if d == 'I02U' then
        return false
    endif
    if d == 'I00F' then
        return false
    endif
    if d == 'I00L' then
        return false
    endif
    if d == 'I029' then
        return false
    endif
    return true
endfunction

function THD_SetItemOwner takes item w, player who returns nothing
    if w == null or GetWidgetLife(w) <= 0 then
        return
    endif
    if who == null or GetPlayerId(who) >= 12 then
        call SetItemPlayer(w, Player(PLAYER_NEUTRAL_PASSIVE), false)
    else
        call SetItemPlayer(w, who, false)
    endif
endfunction

function THD_GetItemOwner takes item w returns player
    if w == null or GetWidgetLife(w) <= 0 then
        return null
    else
        return GetItemPlayer(w)
    endif
endfunction

function Trig_Item_Check_Owner takes nothing returns boolean
    local player who = THD_GetItemOwner(GetManipulatedItem())
    local item thing = GetManipulatedItem()
    local unit u = GetTriggerUnit()
    local player p = GetTriggerPlayer()
    if who == Player(PLAYER_NEUTRAL_PASSIVE) or who == null then
        if GetPlayerSlotState(p) == PLAYER_SLOT_STATE_PLAYING then
            call THD_SetItemOwner(thing, p)
        endif
        set who = null
        set thing = null
        set u = null
        set p = null
        return true
    endif
    if who != p then
        call UnitRemoveItem(u, thing)
        call DisplayTextToPlayer(p, 0, 0, "This item is not yours")
        set who = null
        set thing = null
        set u = null
        set p = null
        return false
    endif
    if GetItemTypeId(thing) == 'I00F' and GetUnitTypeId(u) == 'h00B' or GetUnitTypeId(u) == 'h00I' then
        call UnitRemoveItem(u, thing)
        call DisplayTextToPlayer(p, 0, 0, "Can't pick up yukkuri!")
        set who = null
        set thing = null
        set u = null
        set p = null
    endif
    set who = null
    set thing = null
    set u = null
    set p = null
    return true
endfunction

function Trig_Item_Auto_Stack takes nothing returns nothing
    local unit u = GetTriggerUnit()
    local item pick = GetManipulatedItem()
    local item hold = null
    local item temp = null
    local integer w = GetItemTypeId(pick)
    local integer get = GetItemCharges(pick)
    local integer has = 99
    local integer max = 12
    local integer i
    set i = 0
    loop
    exitwhen i >= bj_MAX_INVENTORY
        set temp = UnitItemInSlot(u, i)
        if GetItemTypeId(temp) == w and temp != pick then
            if GetItemCharges(temp) < has then
                set hold = temp
                set has = GetItemCharges(hold)
            endif
        endif
        set i = i + 1
    endloop
    if hold != null then
        if has <= max - get then
            call RemoveItem(pick)
            call SetItemCharges(hold, has + get)
        else
            call SetItemCharges(hold, max)
            call SetItemCharges(pick, has + get - max)
        endif
    endif
    set u = null
    set pick = null
    set hold = null
    set temp = null
endfunction

function Trig_Item_System_Conditions takes nothing returns boolean
    if GetUnitAbilityLevel(GetTriggerUnit(), 'Aloc') > 0 then
        return false
    endif
    if THD_IsItemTypePrivate(GetItemTypeId(GetManipulatedItem())) then
        if Trig_Item_Check_Owner() == false then
            return false
        endif
    endif
    if GetItemTypeId(GetManipulatedItem()) == 'I016' then
        call BroadcastMessageFriend(udg_PN[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))] + " picked up " + GetItemName(GetManipulatedItem()), GetOwningPlayer(GetTriggerUnit()))
    elseif GetItemType(GetManipulatedItem()) == ITEM_TYPE_PURCHASABLE then
        call Trig_Item_Auto_Stack()
    endif
    return true
endfunction

function Trig_Item_System_Try_Craft takes unit hero, unit yukkuri, item w returns boolean
    local integer c = GetItemTypeId(w)
    local integer i = 0
    local integer n = udg_HC_Database_01[2000]
    local boolean k = false
    if w == null then
        return false
    endif
    call ExecuteFunc("HC_FlushRegisters")
    set udg_HC_Lock = true
    call Teleport_FixDoubleClick(w, hero, GetTriggeringTrigger())
    loop
    exitwhen i >= n
        if not HC_IsValidSN(i) then
            set k = false
        elseif HC_CheckPossibilty(i, c) == false then
            set k = false
        elseif HC_PopFormula(i) == false then
            set k = false
        elseif HC_CheckMaterials(hero, yukkuri) == false then
            set k = false
        elseif HC_ActivateFormula(hero, yukkuri, w) then
            set k = true
        endif
    exitwhen k
        set i = i + 1
    endloop
    set udg_HC_Lock = false
    set w = null
    return k
endfunction

function Trig_Item_System_Actions takes nothing returns nothing
    call Trig_Item_System_Try_Craft(GetTriggerUnit(), null, GetManipulatedItem())
endfunction

function InitTrig_Item_System takes nothing returns nothing
    set gg_trg_Item_System = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Item_System, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddCondition(gg_trg_Item_System, Condition(function Trig_Item_System_Conditions))
    call TriggerAddAction(gg_trg_Item_System, function Trig_Item_System_Actions)
endfunction