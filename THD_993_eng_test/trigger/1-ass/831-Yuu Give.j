function YuuGive_FindChildren takes integer node, integer findID returns integer
    local integer n = udg_YuuGiveItem[1000 + node]
    loop
        if udg_YuuGiveItem[3000 + n] == findID then
            return n
        endif
        set n = udg_YuuGiveItem[2000 + n]
    exitwhen n == 0
    endloop
    return 0
endfunction

function YuuGive_InsertChlidNode takes integer parent, integer id, integer data returns integer
    local integer node
    local integer tmp
    set udg_YuuGiveItem[5000] = udg_YuuGiveItem[5000] + 1
    set node = udg_YuuGiveItem[5000]
    set tmp = udg_YuuGiveItem[1000 + parent]
    set udg_YuuGiveItem[1000 + parent] = node
    set udg_YuuGiveItem[2000 + node] = tmp
    set udg_YuuGiveItem[1000 + node] = 0
    set udg_YuuGiveItem[3000 + node] = id
    set udg_YuuGiveItem[4000 + node] = data
    return node
endfunction

function YuuGive_InsertFormula takes integer sn returns nothing
    local integer i
    local integer node = 0
    local integer tmp
    local boolean end = false
    set i = 0
    loop
        if i >= 5 or udg_YuuGiveItem[i + 1] == 0 then
            set end = true
        endif
        set tmp = YuuGive_FindChildren(node, udg_YuuGiveItem[i])
        if tmp > 0 then
            set node = tmp
        else
            if end then
                set node = YuuGive_InsertChlidNode(node, udg_YuuGiveItem[i], sn)
            else
                set node = YuuGive_InsertChlidNode(node, udg_YuuGiveItem[i], 0)
            endif
        endif
        set i = i + 1
    exitwhen end
    endloop
endfunction

function YuuGive_ReadHCDataBase takes integer sn returns nothing
    local integer i
    local integer j
    local integer c
    local integer id
    local integer tmp
    set i = 8
    set c = 0
    loop
        set id = HC_DataBaseRead(0, sn, i)
        set j = 0
        loop
        exitwhen j >= c
            if id < udg_YuuGiveItem[j] and id != 0 then
                set tmp = id
                set id = udg_YuuGiveItem[j]
                set udg_YuuGiveItem[j] = tmp
            endif
            set j = j + 1
        endloop
        set udg_YuuGiveItem[c] = id
        set c = c + 1
        set i = i + 2
    exitwhen i >= 20
    endloop
endfunction

function YuuGive_InitGiveItem takes nothing returns nothing
    local integer sn
    local integer capSn = udg_HC_Database_01[2000]
    set sn = 0
    loop
    exitwhen sn >= capSn or not HC_IsValidSN(sn)
        call YuuGive_ReadHCDataBase(sn)
        call YuuGive_InsertFormula(sn + 1)
        set sn = sn + 1
    endloop
endfunction

function YuuGive_InRealdyQueue takes integer offset, item Item, unit OwningUnit returns integer
    local integer hashkey = udg_YuuGiveItem[offset]
    local integer Id = GetItemTypeId(Item)
    local integer count = udg_YuuGiveItem[offset + 1]
    local integer now
    local integer i = 0
    local integer iTmp
    local integer max = 12
    local item loadItem
    if THD_GetItemOwner(Item) != GetOwningPlayer(OwningUnit) and THD_IsItemTypePrivate(GetItemTypeId(Item)) then
        set Item = null
        set loadItem = null
        return 0
    endif
    if GetItemType(Item) == ITEM_TYPE_PURCHASABLE then
        set i = 0
        loop
        exitwhen i >= count or udg_YuuGiveItem[offset + 2 + i * 2] == 0
            if Id == udg_YuuGiveItem[offset + 2 + i * 2] then
                set loadItem = LoadItemHandle(udg_ht, hashkey, udg_YuuGiveItem[offset + 2 + i * 2 + 1] * 2)
                if GetItemCharges(loadItem) + GetItemCharges(Item) <= max then
                    call SetItemCharges(loadItem, GetItemCharges(loadItem) + GetItemCharges(Item))
                    call UnitRemoveItem(OwningUnit, Item)
                    call RemoveItem(Item)
                    set Item = null
                    set loadItem = null
                    return 0
                else
                    call SetItemCharges(Item, GetItemCharges(Item) - (max - GetItemCharges(loadItem)))
                    call SetItemCharges(loadItem, max)
                endif
            endif
            set i = i + 1
        endloop
    endif
    set count = count + 1
    set now = count
    set Id = GetItemTypeId(Item)
    set udg_YuuGiveItem[offset + 1] = count
    call SaveItemHandle(udg_ht, hashkey, count * 2, Item)
    call SaveUnitHandle(udg_ht, hashkey, count * 2 + 1, OwningUnit)
    set i = 0
    loop
    exitwhen i + 1 >= count or udg_YuuGiveItem[offset + 2 + i * 2] == 0
        if Id < udg_YuuGiveItem[offset + 2 + i * 2] then
            set iTmp = Id
            set Id = udg_YuuGiveItem[offset + 2 + i * 2]
            set udg_YuuGiveItem[offset + 2 + i * 2] = iTmp
            set iTmp = now
            set now = udg_YuuGiveItem[offset + 2 + i * 2 + 1]
            set udg_YuuGiveItem[offset + 2 + i * 2 + 1] = iTmp
        endif
        set i = i + 1
    endloop
    set udg_YuuGiveItem[offset + 2 + i * 2] = Id
    set udg_YuuGiveItem[offset + 2 + i * 2 + 1] = now
    set Item = null
    set loadItem = null
    return i
endfunction

function YuuGive_ScanUnitsItem takes integer offset, unit unit1, unit unit2 returns nothing
    local integer i
    local item Item
    set udg_YuuGiveItem[offset + 1] = 0
    set i = 0
    loop
        set udg_YuuGiveItem[offset + 2 + i * 2] = 0
        set udg_YuuGiveItem[offset + 2 + i * 2 + 1] = 0
        set i = i + 1
    exitwhen i >= 12
    endloop
    set i = 0
    loop
        if i < 6 then
            set Item = UnitItemInSlot(unit1, i)
            if Item != null then
                call YuuGive_InRealdyQueue(offset, Item, unit1)
            endif
        else
            set Item = UnitItemInSlot(unit2, i - 6)
            if Item != null then
                call YuuGive_InRealdyQueue(offset, Item, unit2)
            endif
        endif
        set i = i + 1
    exitwhen i >= 12
    endloop
    set unit1 = null
    set unit2 = null
    set Item = null
endfunction

function YuuGive_CheckResource takes integer offset, integer sn returns boolean
    local unit h = LoadUnitHandle(udg_ht, udg_YuuGiveItem[offset], 0)
    local integer CostA = HC_DataBaseRead(0, sn, 6)
    local integer CostB = HC_DataBaseRead(0, sn, 7)
    local integer costItem
    local integer i
    local integer j
    local integer id
    local integer n
    local boolean have
    if GetPlayerState(GetOwningPlayer(h), PLAYER_STATE_RESOURCE_GOLD) < CostA then
        return false
    endif
    if GetPlayerState(GetOwningPlayer(h), PLAYER_STATE_RESOURCE_LUMBER) < CostB then
        return false
    endif
    set udg_YuuGiveItem[offset + 30] = CostA
    set udg_YuuGiveItem[offset + 31] = CostB
    set i = 0
    loop
        set udg_YuuGiveItem[offset + 32 + i] = -1
        set i = i + 1
    exitwhen i >= 12
    endloop
    set i = 0
    loop
        set id = HC_DataBaseRead(0, sn, 8 + i * 2)
    exitwhen id == 0
        set costItem = HC_DataBaseRead(0, sn, 8 + i * 2 + 1)
        set j = 0
        set have = false
        loop
            if id == udg_YuuGiveItem[offset + 2 + j * 2] and udg_YuuGiveItem[offset + 32 + j] == -1 then
                set n = GetItemCharges(LoadItemHandle(udg_ht, udg_YuuGiveItem[offset], udg_YuuGiveItem[offset + 2 + j * 2 + 1] * 2))
                if n == 0 then
                    set n = 1
                endif
                if costItem > 0 then
                    if n < costItem then
                        set h = null
                        return false
                    else
                        set udg_YuuGiveItem[offset + 32 + j] = costItem
                        set have = true
                    endif
                elseif costItem < 0 then
                    set udg_YuuGiveItem[offset + 32 + j] = n
                    set have = true
                endif
            endif
            set j = j + 1
        exitwhen j >= 12 or have
        endloop
        if have == false then
            set h = null
            return false
        endif
        set i = i + 1
    exitwhen i >= 6
    endloop
    set h = null
    return true
endfunction

function YuuGive_EnumFormula takes integer offset returns integer
    local integer stackOffset = offset + 50
    local integer stackPos = 0
    local integer itemPos = 0
    local integer max = udg_YuuGiveItem[offset + 1] * 2
    local integer parentNode
    local integer node
    local integer key
    local boolean popStack = false
    set udg_YuuGiveItem[stackOffset + 0] = 0
    set udg_YuuGiveItem[stackOffset + 1] = 0
    set stackPos = 0
    loop
        set popStack = true
        set parentNode = udg_YuuGiveItem[stackOffset + stackPos]
        set itemPos = udg_YuuGiveItem[stackOffset + stackPos + 1]
        loop
            set key = udg_YuuGiveItem[offset + 2 + itemPos]
            set node = YuuGive_FindChildren(parentNode, key)
            call DebugMsg("key=" + GetItemName(LoadItemHandle(udg_ht, udg_YuuGiveItem[offset], udg_YuuGiveItem[offset + 2 + itemPos + 1] * 2)) + ",node=" + I2S(node))
            if key > 0 and node > 0 then
                if udg_YuuGiveItem[4000 + node] > 0 then
                    if YuuGive_CheckResource(offset, udg_YuuGiveItem[4000 + node] - 1) then
                        return udg_YuuGiveItem[4000 + node] - 1
                    endif
                endif
                if itemPos + 2 < max and udg_YuuGiveItem[offset + 4 + itemPos] != 0 then
                    set popStack = false
                exitwhen true
                endif
            endif
            loop
                set itemPos = itemPos + 2
            exitwhen udg_YuuGiveItem[offset + itemPos] != udg_YuuGiveItem[offset + 2 + itemPos] or udg_YuuGiveItem[offset + 2 + itemPos] == 0 or itemPos >= max
            endloop
        exitwhen udg_YuuGiveItem[offset + 2 + itemPos] == 0 or itemPos >= max
        endloop
        if popStack then
            set stackPos = stackPos - 2
            call DebugMsg("POP  " + I2S(stackPos / 2) + " node:" + I2S(udg_YuuGiveItem[stackOffset + stackPos]) + ",itemPos:" + I2S(udg_YuuGiveItem[stackOffset + stackPos + 1]))
            if stackPos < 0 then
                return 0
            endif
        else
            call DebugMsg("PUSH " + I2S(stackPos / 2) + " node:" + I2S(node) + ",itemPos:" + I2S(itemPos + 2))
            set udg_YuuGiveItem[stackOffset + stackPos + 1] = itemPos + 2
            set stackPos = stackPos + 2
            set udg_YuuGiveItem[stackOffset + stackPos] = node
            set udg_YuuGiveItem[stackOffset + stackPos + 1] = itemPos + 2
        endif
    endloop
    return 0
endfunction

function YuuGive_ActivateFormula takes integer offset, integer sn returns nothing
    local unit h = LoadUnitHandle(udg_ht, udg_YuuGiveItem[offset], 0)
    local integer hashkey = udg_YuuGiveItem[offset]
    local integer max = udg_YuuGiveItem[offset + 1]
    local integer CostA = udg_YuuGiveItem[offset + 30]
    local integer CostB = udg_YuuGiveItem[offset + 31]
    local integer i
    local integer j
    local integer id
    local integer n
    local item Item
    local unit Owning
    if CostA > 0 then
        call HC_SetResourceA(h, GetPlayerState(GetOwningPlayer(h), PLAYER_STATE_RESOURCE_GOLD) - CostA)
    endif
    if CostB > 0 then
        call HC_SetResourceB(h, GetPlayerState(GetOwningPlayer(h), PLAYER_STATE_RESOURCE_LUMBER) - CostB)
    endif
    set i = 0
    loop
        if udg_YuuGiveItem[offset + 32 + i] != -1 then
            set id = offset + 2 + i * 2
            set Item = LoadItemHandle(udg_ht, hashkey, udg_YuuGiveItem[id + 1] * 2)
            set Owning = LoadUnitHandle(udg_ht, hashkey, udg_YuuGiveItem[id + 1] * 2 + 1)
            set n = GetItemCharges(Item)
            if n == 0 then
                set n = 1
            endif
            if n <= udg_YuuGiveItem[offset + 32 + i] then
                call UnitRemoveItem(Owning, Item)
                call RemoveItem(Item)
                set udg_YuuGiveItem[id] = 0
            else
                call SetItemCharges(Item, n - udg_YuuGiveItem[offset + 32 + i])
            endif
        endif
        set i = i + 1
    exitwhen i >= 12
    endloop
    set i = 0
    set j = 0
    loop
        set id = offset + 2 + i * 2
        if udg_YuuGiveItem[id] == 0 then
            call RemoveSavedHandle(udg_ht, hashkey, udg_YuuGiveItem[id + 1] * 2)
            call RemoveSavedHandle(udg_ht, hashkey, udg_YuuGiveItem[id + 1] * 2 + 1)
        else
            if i > j then
                set udg_YuuGiveItem[offset + 2 + j * 2] = udg_YuuGiveItem[id]
                set udg_YuuGiveItem[offset + 2 + j * 2 + 1] = udg_YuuGiveItem[id + 1]
                set udg_YuuGiveItem[id] = 0
                set udg_YuuGiveItem[id + 1] = 0
            endif
            set j = j + 1
        endif
        set i = i + 1
    exitwhen i >= max
    endloop
    set udg_YuuGiveItem[offset + 2 + j * 2] = 0
    set udg_YuuGiveItem[offset + 2 + j * 2 + 1] = 0
    set id = HC_DataBaseRead(0, sn, 4)
    set Item = CreateItem(id, GetUnitX(h), GetUnitY(h))
    if Item != null then
        if id == 'I08H' or id == 'I08J' or id == 'I08E' or id == 'I030' or id == 'I08M' then
            call BroadcastMessageFriend(udg_PN[GetPlayerId(GetOwningPlayer(h))] + " synthesized " + GetItemName(Item) + "(Halo equipment)", GetOwningPlayer(h))
        else
            call BroadcastMessageFriend(udg_PN[GetPlayerId(GetOwningPlayer(h))] + " synthesized " + GetItemName(Item), GetOwningPlayer(h))
        endif
        call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Items\\AIem\\AIemTarget.mdl", h, "origin"))
        call DebugMsg("Item successfully synthesized!")
        call THD_SetItemOwner(Item, GetOwningPlayer(h))
        set udg_HC_Lock = false
        call UnitAddItem(h, Item)
    endif
    set Item = null
    set Owning = null
endfunction

function YuuGive_ClearBufferData takes integer offset returns nothing
    local integer i
    local integer n
    local integer hashkey = udg_YuuGiveItem[offset]
    local integer max = udg_YuuGiveItem[offset + 1]
    call RemoveSavedHandle(udg_ht, udg_YuuGiveItem[offset], 0)
    set i = 0
    loop
        set n = offset + 2 + i * 2
    exitwhen i >= max or udg_YuuGiveItem[n] == 0
        if udg_YuuGiveItem[n + 1] > 0 then
            call RemoveSavedHandle(udg_ht, hashkey, udg_YuuGiveItem[n + 1] * 2)
            call RemoveSavedHandle(udg_ht, hashkey, udg_YuuGiveItem[n + 1] * 2 + 1)
        endif
        set i = i + 1
    endloop
    set udg_YuuGiveItem[offset] = 0
    set udg_YuuGiveItem[offset + 1] = 0
endfunction

function YuuGive_GiveItem takes unit toUnit, unit fromUnit returns nothing
    local integer playerId = GetPlayerId(GetOwningPlayer(toUnit))
    local integer offset = 6000 + playerId * 100
    local integer hashkey = StringHash("GiveItem Player" + I2S(playerId))
    local integer i = 0
    local integer j = 0
    local integer retSN
    local item Item
    local item array Items
    local boolean b = false
    local boolean b2 = false
    loop
        if UnitItemInSlot(toUnit, i) == null then
            set j = 0
            loop
                set Item = UnitItemInSlot(fromUnit, j)
                set j = j + 1
                if Item != null then
                    call UnitRemoveItem(fromUnit, Item)
                    call UnitAddItem(toUnit, Item)
                exitwhen true
                endif
            exitwhen j >= 6
            endloop
        endif
        set i = i + 1
    exitwhen i >= 6
    endloop
    loop
        set i = 0
        loop
            set Item = UnitItemInSlot(toUnit, i)
            if b then
                call Trig_Item_System_Try_Craft(toUnit, fromUnit, Item)
            else
                set b = Trig_Item_System_Try_Craft(toUnit, fromUnit, Item)
            endif
            set Item = UnitItemInSlot(fromUnit, i)
            if b2 then
                call Trig_Item_System_Try_Craft(toUnit, fromUnit, Item)
            else
                set b2 = Trig_Item_System_Try_Craft(toUnit, fromUnit, Item)
            endif
            set i = i + 1
        exitwhen i >= 6
        endloop
        exitwhen not (b or b2)
    endloop
    set toUnit = null
    set fromUnit = null
    set Item = null
endfunction

function Trig_Yuu_Give_Conditions takes nothing returns boolean
    if not (GetSpellAbilityId() == 'A1EQ') then
        return false
    endif
    return true
endfunction

function Trig_Yuu_Give_Actions takes nothing returns nothing
    if udg_InitYuuGiveItem == false then
        set udg_InitYuuGiveItem = true
        call YuuGive_InitGiveItem()
    endif
    call YuuGive_GiveItem(GetSpellTargetUnit(), GetTriggerUnit())
endfunction

function InitTrig_Yuu_Give takes nothing returns nothing
    set gg_trg_Yuu_Give = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Yuu_Give, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Yuu_Give, Condition(function Trig_Yuu_Give_Conditions))
    call TriggerAddAction(gg_trg_Yuu_Give, function Trig_Yuu_Give_Actions)
endfunction