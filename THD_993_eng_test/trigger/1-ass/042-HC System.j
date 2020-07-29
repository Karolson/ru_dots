function AI_GetPlayerForceId takes player w returns integer
    return GetPlayerForceId(w)
endfunction

function AI_GetAllFoes takes unit h, real range returns group
    local player w = GetOwningPlayer(h)
    local group g = CreateGroup()
    local unit v
    local integer i = 0
    loop
    exitwhen i >= 12
        set v = udg_PlayerHeroes[i]
        if v != null and GetWidgetLife(v) >= 0.405 then
            if IsUnitEnemy(v, w) and IsUnitInRange(h, v, range) then
                call GroupAddUnit(g, v)
            endif
        endif
        set i = i + 1
    endloop
    set bj_lastCreatedGroup = g
    set g = null
    set v = null
    set w = null
    return bj_lastCreatedGroup
endfunction

function AI_GetAllFriends takes unit h, real range returns group
    local player w = GetOwningPlayer(h)
    local group g = CreateGroup()
    local unit v
    local integer i = 0
    loop
    exitwhen i >= 12
        set v = udg_PlayerHeroes[i]
        if v != null and GetWidgetLife(v) >= 0.405 then
            if IsUnitAlly(v, w) and IsUnitInRange(h, v, range) then
                call GroupAddUnit(g, v)
            endif
        endif
        set i = i + 1
    endloop
    set bj_lastCreatedGroup = g
    set g = null
    set v = null
    set w = null
    return bj_lastCreatedGroup
endfunction

function AI_ClearInventorySlot takes unit h returns nothing
    local item w
    local integer i
    if h == null or IsUnitDead(h) then
        set w = null
        return
    endif
    set i = 0
    loop
        set w = UnitItemInSlot(h, i)
        if w != null and GetItemType(w) == ITEM_TYPE_PURCHASABLE then
            call UnitRemoveItem(h, w)
            set w = null
        exitwhen true
        endif
        set i = i + 1
    exitwhen i >= bj_MAX_INVENTORY
    endloop
    set w = null
endfunction

function AI_UnitAddItem_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit h = LoadUnitHandle(udg_ht, task, 0)
    local item w = LoadItemHandle(udg_ht, task, 1)
    local integer i = LoadInteger(udg_ht, task, 1)
    if GetWidgetLife(h) > 0.405 or i <= 0 then
        if LoadBoolean(udg_ht, task, 0) then
            call AI_ClearInventorySlot(h)
        endif
        call SetItemVisible(w, true)
        call SetItemPosition(w, GetUnitX(h), GetUnitY(h))
        call UnitAddItem(h, w)
        call FlushChildHashtable(udg_ht, task)
        call ReleaseTimer(t)
    else
        call SaveInteger(udg_ht, task, 1, i - 1)
    endif
    set t = null
    set h = null
    set w = null
endfunction

function AI_UnitAddItem takes unit h, item w, boolean clear returns timer
    local timer t
    if h == null or w == null then
        set t = null
        return null
    endif
    if GetWidgetLife(h) >= 0.405 then
        if clear then
            call AI_ClearInventorySlot(h)
        endif
        call UnitAddItem(h, w)
        return null
    endif
    set t = CreateTimer()
    call SetItemVisible(w, false)
    call SaveUnitHandle(udg_ht, GetHandleId(t), 0, h)
    call SaveItemHandle(udg_ht, GetHandleId(t), 1, w)
    call SaveBoolean(udg_ht, GetHandleId(t), 0, clear)
    call SaveInteger(udg_ht, GetHandleId(t), 1, 800)
    call SaveTimerHandle(udg_ht, GetHandleId(t), 99, t)
    call TimerStart(t, 0.25, true, function TSU_UnitAddItem_Main)
    set bj_lastStartedTimer = t
    set t = null
    return bj_lastStartedTimer
endfunction

function AI_CountUnitsInGroup_Count takes nothing returns nothing
    set udg_AI_register[7] = udg_AI_register[7] + 1
endfunction

function AI_CountUnitsInGroup takes group g returns integer
    set udg_AI_register[7] = 0
    call ForGroup(g, function AI_CountUnitsInGroup_Count)
    return udg_AI_register[7]
endfunction

function AI_DataBaseWrite takes integer index, integer key, integer value returns nothing
    set udg_AI_DataBase[index * 16 + key] = value
endfunction

function AI_DataBaseRead takes integer index, integer key returns integer
    return udg_AI_DataBase[index * 16 + key]
endfunction

function AI_HeroSkill takes integer index, integer s1, integer s2, integer s3, integer s4, integer s5 returns nothing
    set udg_AI_DataBase[index * 16 + 1] = s1
    set udg_AI_DataBase[index * 16 + 2] = s2
    set udg_AI_DataBase[index * 16 + 3] = s3
    set udg_AI_DataBase[index * 16 + 4] = s4
    set udg_AI_DataBase[index * 16 + 5] = s5
endfunction

function AI_LearnSkill takes unit h returns nothing
    local integer index = GetHeroIndex(GetUnitTypeId(h))
    local integer i = GetHeroSkillPoints(h)
    if index == 0 then
        return
    endif
    loop
    exitwhen i == 0
        call SelectHeroSkill(h, udg_AI_DataBase[index * 16 + 1])
        call SelectHeroSkill(h, udg_AI_DataBase[index * 16 + 2])
        call SelectHeroSkill(h, udg_AI_DataBase[index * 16 + 3])
        call SelectHeroSkill(h, udg_AI_DataBase[index * 16 + 4])
        call SelectHeroSkill(h, udg_AI_DataBase[index * 16 + 5])
        set i = i - 1
    endloop
endfunction

function CountAIPlayerSum takes nothing returns integer
    set udg_AI_DataBase[0] = CountPlayersInForceBJ(udg_AI_Players)
    return udg_AI_DataBase[0]
endfunction

function HC_GetResourceA takes unit h returns integer
    return GetPlayerState(GetOwningPlayer(h), PLAYER_STATE_RESOURCE_GOLD)
endfunction

function HC_GetResourceB takes unit h returns integer
    return GetPlayerState(GetOwningPlayer(h), PLAYER_STATE_RESOURCE_LUMBER)
endfunction

function HC_SetResourceA takes unit h, integer value returns nothing
    call SetPlayerState(GetOwningPlayer(h), PLAYER_STATE_RESOURCE_GOLD, value)
endfunction

function HC_SetResourceB takes unit h, integer value returns nothing
    call SetPlayerState(GetOwningPlayer(h), PLAYER_STATE_RESOURCE_LUMBER, value)
endfunction

function HC_DataBaseRead takes integer DB, integer SN, integer offset returns integer
    return udg_HC_Database_01[SN * 20 + offset]
endfunction

function HC_DataBaseWrite takes integer DB, integer SN, integer offset, integer value returns nothing
    set udg_HC_Database_01[SN * 20 + offset] = value
endfunction

function HC_GetCapSN takes nothing returns integer
    return udg_HC_Database_01[2000]
endfunction

function HC_SetCapSN takes integer m returns nothing
    set udg_HC_Database_01[2000] = m
endfunction

function HC_IsValidSN takes integer SN returns boolean
    return SN >= 0 and SN < udg_HC_Database_01[2000]
endfunction

function HC_GetCurrentGlobalSN takes nothing returns integer
    return udg_HC_Database_01[2000] + 1000
endfunction

function HC_ConvertGlobalSN takes integer GlobalSN returns integer
    return GlobalSN - 1000
endfunction

function HC_FlushRegisters takes nothing returns nothing
    local integer i
    set i = 0
    loop
        set udg_HC_register[i] = 0
        set i = i + 1
    exitwhen i >= 32
    endloop
    set i = 100
    loop
        set udg_HC_register[i*2] = 0
        set udg_HC_register[i*2+1] = 0
        set i = i + 1
    exitwhen i >= 106
    endloop
endfunction

function HC_Formula_Begin takes integer GlobalSN, integer ID, integer Product returns nothing
    local integer SN = GlobalSN - 1000
    set udg_HC_register[12] = SN
    set udg_HC_register[13] = ID
    set udg_HC_register[14] = 1
    set udg_HC_register[15] = 1
    set udg_HC_register[16] = Product
    set udg_HC_register[17] = 1
    set udg_HC_register[18] = 0
    set udg_HC_register[19] = 0
    set udg_HC_register[20] = 0
    set udg_HC_register[21] = 0
    set udg_HC_register[22] = 0
    set udg_HC_register[23] = 0
    set udg_HC_register[24] = 0
    set udg_HC_register[25] = 0
    set udg_HC_register[26] = 0
    set udg_HC_register[27] = 0
    set udg_HC_register[28] = 0
    set udg_HC_register[29] = 0
    set udg_HC_register[30] = 0
    set udg_HC_register[31] = 0
endfunction

function HC_Formula_Config takes boolean CheckAllUnits, boolean AutoActivate, boolean AllowRecursive returns nothing
    set udg_HC_register[14] = Integer(AutoActivate)
    set udg_HC_register[15] = Integer(CheckAllUnits)
    set udg_HC_register[17] = Integer(AllowRecursive)
endfunction

function HC_Formula_SetResourceAB takes integer value1, integer value2 returns nothing
    set udg_HC_register[18] = value1
    set udg_HC_register[19] = value2
endfunction

function HC_Formula_SetMaterialA takes integer t1, integer n1, integer t2, integer n2, integer t3, integer n3 returns nothing
    set udg_HC_register[20] = t1
    set udg_HC_register[21] = n1
    set udg_HC_register[22] = t2
    set udg_HC_register[23] = n2
    set udg_HC_register[24] = t3
    set udg_HC_register[25] = n3
endfunction

function HC_Formula_SetMaterialB takes integer t4, integer n4, integer t5, integer n5, integer t6, integer n6 returns nothing
    set udg_HC_register[26] = t4
    set udg_HC_register[27] = n4
    set udg_HC_register[28] = t5
    set udg_HC_register[29] = n5
    set udg_HC_register[30] = t6
    set udg_HC_register[31] = n6
endfunction

function HC_Formula_End takes nothing returns nothing
    local integer SN = udg_HC_register[12]
    local integer i
    local integer j
    local integer c
    local integer n
    if SN < 0 or SN >= 200 then
        call ExecuteFunc("HC_FlushRegisters")
        return
    endif
    set i = 0
    loop
        call HC_DataBaseWrite(0, SN, i, udg_HC_register[12 + i])
        set i = i + 1
    exitwhen i >= 8
    endloop
    set i = 0
    set j = 0
    loop
        set c = udg_HC_register[20 + 2 * i]
        set n = udg_HC_register[20 + 2 * i + 1]
        if c != 0 then
            call HC_DataBaseWrite(0, SN, 8 + 2 * j, c)
            call HC_DataBaseWrite(0, SN, 8 + 2 * j + 1, n)
            set j = j + 1
        endif
        set i = i + 1
    exitwhen i >= 6
    endloop
    set SN = IMaxBJ(udg_HC_Database_01[2000], SN + 1)
    set udg_HC_Database_01[2000] = SN
    return
endfunction

function HC_SearchFormulaID takes integer TargetID returns integer
    local integer DB = 0
    local integer SN
    local integer ID
    local integer m = udg_HC_Database_01[2000]
    set SN = 0
    loop
    exitwhen SN >= m
        set ID = HC_DataBaseRead(DB, SN, 1)
        if ID == TargetID then
            return SN
        endif
        set SN = SN + 1
    endloop
    return -1
endfunction

function HC_CheckPossibilty takes integer SN, integer ItemTypeID returns boolean
    local integer c
    local integer i = 8
    loop
        set c = HC_DataBaseRead(0, SN, i)
    exitwhen c == 0
        if c == ItemTypeID then
            return true
        endif
        set i = i + 2
    exitwhen i >= 20
    endloop
    return false
endfunction

function HC_PopFormula takes integer SN returns boolean
    local integer i
    set i = 0
    loop
        set udg_HC_register[i] = 0
        set i = i + 1
    exitwhen i >= 12
    endloop
    set i = 0
    loop
        set udg_HC_register[12 + i] = HC_DataBaseRead(0, SN, i)
        set i = i + 1
    exitwhen i >= 20
    endloop
    return true
endfunction

function HC_PopFormulaByGlobalSN takes integer GlobalSN returns boolean
    local integer SN = GlobalSN - 1000
    return HC_PopFormula(SN)
endfunction

function HC_GetItemQuantity takes item w returns integer
    local integer n
    if w == null then
        return 0
    endif
    set n = GetItemCharges(w)
    if n == 0 then
        return 1
    endif
    return n
endfunction

function HC_LocateMaterial takes unit h, unit yukkuri, integer c returns integer
    local integer i
    local item w
    set i = 0
    loop
        set w = UnitItemInSlot(h, i)
        if w != null and GetItemTypeId(w) == c then
            if udg_HC_register[i * 2] == 0 then
                set w = null
                return i
            endif
        endif
        set i = i + 1
    exitwhen i >= bj_MAX_INVENTORY
    endloop
    if yukkuri != null then
        set i = 0
        loop
            set w = UnitItemInSlot(yukkuri, i)
            if w != null and GetItemTypeId(w) == c then
                if udg_HC_register[(i + 100) * 2] == 0 then
                    set w = null
                    return i + 100
                endif
            endif
            set i = i + 1
        exitwhen i >= bj_MAX_INVENTORY
        endloop
    endif
    set w = null
    return -1
endfunction

function HC_CheckMaterials takes unit hero, unit yukkuri returns boolean
    local integer slot
    local integer c
    local integer n
    local integer m
    local integer i = 0
    local integer CostA = udg_HC_register[18]
    local integer CostB = udg_HC_register[19]
    local item Item
    if GetPlayerState(GetOwningPlayer(hero), PLAYER_STATE_RESOURCE_GOLD) < CostA then
        return false
    endif
    if GetPlayerState(GetOwningPlayer(hero), PLAYER_STATE_RESOURCE_LUMBER) < CostB then
        return false
    endif
    loop
        set c = udg_HC_register[20 + 2 * i]
        set n = udg_HC_register[20 + 2 * i + 1]
    exitwhen c == 0
        set slot = HC_LocateMaterial(hero, yukkuri, c)
        if slot < 0 then
            return false
        elseif slot >= 100 then
            set Item = UnitItemInSlot(yukkuri, slot - 100)
        else
            set Item = UnitItemInSlot(hero, slot)
        endif
        set udg_HC_register[slot * 2] = c
        set udg_HC_register[slot * 2 + 1] = 0
        if n > 0 then
            set m = HC_GetItemQuantity(Item)
            if slot < 100 and YDWEUnitHasItemOfTypeBJNull(yukkuri, c) then
                set m = m + HC_GetItemQuantity(YDWEGetItemOfTypeFromUnitBJNull(yukkuri, c))
            endif
            if m < n then
                return false
            endif
            set udg_HC_register[slot * 2 + 1] = n
        elseif n < 0 then
            set udg_HC_register[slot * 2 + 1] = HC_GetItemQuantity(Item)
            if slot < 100 and YDWEUnitHasItemOfTypeBJNull(yukkuri, c) then
                set udg_HC_register[slot * 2 + 1] = udg_HC_register[slot * 2 + 1] + HC_GetItemQuantity(YDWEGetItemOfTypeFromUnitBJNull(yukkuri, c))
            endif
        endif
        set i = i + 1
    exitwhen i >= 6
    endloop
    set Item = null
    return true
endfunction

function HC_ActivateFormula takes unit hero, unit yukkuri, item w1 returns boolean
    local integer c
    local integer n
    local integer i
    local item w
    local integer m
    local integer d = udg_HC_register[16]
    local integer CostA = udg_HC_register[18]
    local integer CostB = udg_HC_register[19]
    local boolean AllowRecursive = udg_HC_register[17] != 0
    local item yukkuriItem
    if CostA > 0 then
        call HC_SetResourceA(hero, GetPlayerState(GetOwningPlayer(hero), PLAYER_STATE_RESOURCE_GOLD) - CostA)
    endif
    if CostB > 0 then
        call HC_SetResourceB(hero, GetPlayerState(GetOwningPlayer(hero), PLAYER_STATE_RESOURCE_LUMBER) - CostB)
    endif
    set i = 0
    loop
		if i > 5 and i < 101 then
			set i = 100
		endif
        set c = udg_HC_register[i * 2]
        if c != 0 then
            set n = udg_HC_register[i * 2 + 1]
            if i < 6 then
                set w = UnitItemInSlot(hero, i)
            elseif yukkuri != null then
                set w = UnitItemInSlot(yukkuri, i - 100)
            else
                set w = null
            endif
            if w != null and n > 0 then
                set m = GetItemCharges(w)
                if i < 6 and YDWEUnitHasItemOfTypeBJNull(yukkuri, c) then
                    set yukkuriItem = YDWEGetItemOfTypeFromUnitBJNull(yukkuri, c)
                    set m = m + GetItemCharges(yukkuriItem)
                endif
                if m <= n then
                    if w != w1 then
                        if i < 6 then
                            call UnitRemoveItem(hero, w)
                        else
                            call UnitRemoveItem(yukkuri, w)
                        endif
                    endif
                    call RemoveItem(w)
                else
                    if yukkuri != null and GetItemCharges(w) < m then
                        if GetItemCharges(yukkuriItem) == (m - GetItemCharges(w)) then
                            call UnitRemoveItem(yukkuri, yukkuriItem)
                            call RemoveItem(yukkuriItem)
                        else
                            call SetItemCharges(yukkuriItem, m - GetItemCharges(w))
                        endif
                        call UnitRemoveItem(hero, w)
                        call RemoveItem(w)
                    else
                        call SetItemCharges(w, m - n)
                    endif
                endif
            endif
        endif
        set i = i + 1
    exitwhen i >= 106
    endloop
    set w = CreateItem(d, GetUnitX(hero), GetUnitY(hero))
    call UnitAddItem(hero, w)
    set i = GetItemTypeId(w)
    if GetItemName(w) != "" and w != null and i != 0 then
        call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Items\\AIem\\AIemTarget.mdl", hero, "origin"))
        if i == 'I08H' or i == 'I08J' or i == 'I08E' or i == 'I030' or i == 'I08M' then
            call BroadcastMessageFriend(udg_PN[GetPlayerId(GetOwningPlayer(hero))] + " got " + GetItemName(w) + " (aura)", GetOwningPlayer(hero))
        else
            call BroadcastMessageFriend(udg_PN[GetPlayerId(GetOwningPlayer(hero))] + " got " + GetItemName(w), GetOwningPlayer(hero))
        endif
    endif
    set w = null
    set yukkuriItem = null
    return true
endfunction

function HCxGUIxFormulaBegin takes integer GlobalSN, integer ID, integer Product returns nothing
    call HC_Formula_Begin(GlobalSN, ID, Product)
endfunction

function HCxGUIxFormulaSetResourceAB takes integer A, integer B returns nothing
    call HC_Formula_SetResourceAB(A, B)
endfunction

function HCxGUIxFormulaSetMaterialA takes integer t1, integer n1, integer t2, integer n2, integer t3, integer n3 returns nothing
    call HC_Formula_SetMaterialA(t1, n1, t2, n2, t3, n3)
endfunction

function HCxGUIxFormulaSetMaterialB takes integer t4, integer n4, integer t5, integer n5, integer t6, integer n6 returns nothing
    call HC_Formula_SetMaterialB(t4, n4, t5, n5, t6, n6)
endfunction

function HCxGUIxFormulaEnd takes nothing returns nothing
    call ExecuteFunc("HC_Formula_End")
endfunction

function InitTrig_HC_System takes nothing returns nothing
endfunction