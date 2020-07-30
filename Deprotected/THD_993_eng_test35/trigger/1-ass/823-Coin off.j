function s__coin_reAdd takes nothing returns nothing
    local integer g = LoadInteger(udg_ht, GetHandleId(GetExpiredTimer()), 0)
    local item i = YDWEGetItemOfTypeFromUnitBJNull(udg_s__coin_u[g], 'I04W')
    local integer sit = YDWEGetInventoryIndexOfItemTypeBJNull(udg_s__coin_u[g], 'I04W') - 1
    if GetUnitAbilityLevel(udg_s__coin_u[g], 'A1F2') > 0 then
        if GetItemCharges(i) > 1 then
            call SetItemCharges(i, GetItemCharges(i) - 1)
        endif
        set i = null
        return
    endif
    if not IsUnitType(udg_s__coin_u[g], UNIT_TYPE_DEAD) and IsUnitPaused(udg_s__coin_u[g]) == false and IsUnitType(udg_s__coin_u[g], UNIT_TYPE_HERO) then
        if GetItemCharges(i) > 1 then
            call SetItemCharges(i, GetItemCharges(i) - 1)
            set i = null
            return
        else
            if i != null then
                call UnitRemoveItem(udg_s__coin_u[g], i)
                call RemoveItem(i)
                call UnitAddItemToSlotById(udg_s__coin_u[g], 'I077', sit)
            endif
            call PauseTimer(GetExpiredTimer())
        endif
        set i = null
        return
    endif
    call TimerStart(GetExpiredTimer(), 0.1, true, function s__coin_reAdd)
    set i = null
endfunction

function s__coin_tempRemove takes integer this returns nothing
    local item i = YDWEGetItemOfTypeFromUnitBJNull(udg_s__coin_u[this], 'I077')
    local integer sit
    set sit = YDWEGetInventoryIndexOfItemTypeBJNull(udg_s__coin_u[this], 'I077') - 1
    if i == null then
        set i = YDWEGetItemOfTypeFromUnitBJNull(udg_s__coin_u[this], 'I04W')
        set sit = YDWEGetInventoryIndexOfItemTypeBJNull(udg_s__coin_u[this], 'I04W') - 1
    endif
    if not IsUnitType(udg_s__coin_u[this], UNIT_TYPE_DEAD) and IsUnitPaused(udg_s__coin_u[this]) == false and IsUnitType(udg_s__coin_u[this], UNIT_TYPE_HERO) then
        if i != null then
            if GetItemTypeId(i) == 'I077' then
                call UnitRemoveItem(udg_s__coin_u[this], i)
                call RemoveItem(i)
                call UnitAddItemToSlotById(udg_s__coin_u[this], 'I04W', sit)
            endif
            call SetItemCharges(YDWEGetItemOfTypeFromUnitBJNull(udg_s__coin_u[this], 'I04W'), 3)
            call DebugMsg("Remove")
        endif
        call TimerStart(udg_s__coin_t[this], 1, true, function s__coin_reAdd)
    endif
    set i = null
endfunction

function s__coin_create takes unit u returns integer
    local integer g = s__coin__allocate()
    local integer i = GetPlayerId(GetOwningPlayer(u))
    set udg_s__coin_u[g] = u
    set udg_s__coin_t[g] = CreateTimer()
    call SaveInteger(udg_ht, GetHandleId(udg_s__coin_t[g]), 0, g)
    set udg_s__coin_stack[i] = g
    set udg_coinCount[i] = 1
    return g
endfunction

function s__coin_destroy takes integer this returns nothing
    set udg_s__coin_stack[GetPlayerId(GetOwningPlayer(udg_s__coin_u[this]))] = 0
    set udg_s__coin_u[this] = null
    call ReleaseTimer(udg_s__coin_t[this])
    set udg_s__coin_t[this] = null
    call s__coin_deallocate(this)
endfunction

function s__coin_onPickup takes nothing returns boolean
    if IsUnitType(GetTriggerUnit(), UNIT_TYPE_HERO) and GetItemTypeId(GetManipulatedItem()) == 'I077' and udg_coinCount[GetPlayerId(GetTriggerPlayer())] == 0 and GetItemPlayer(GetManipulatedItem()) == GetTriggerPlayer() or GetItemPlayer(GetManipulatedItem()) == Player(15) then
        call s__coin_create(GetTriggerUnit())
    endif
    return false
endfunction

function s__coin_onDelayedCheck takes nothing returns nothing
    local unit u = LoadUnitHandle(udg_ht, GetHandleId(GetExpiredTimer()), 0)
    call FlushChildHashtable(udg_ht, GetHandleId(GetExpiredTimer()))
    call ReleaseTimer(GetExpiredTimer())
    if not (YDWEUnitHasItemOfTypeBJNull(u, 'I077') or YDWEUnitHasItemOfTypeBJNull(u, 'I04W')) then
        call s__coin_destroy(udg_s__coin_stack[GetPlayerId(GetOwningPlayer(u))])
        set udg_coinCount[GetPlayerId(GetOwningPlayer(u))] = 0
    endif
    set u = null
endfunction

function s__coin_onDrop takes nothing returns boolean
    local timer t
    if IsUnitType(GetTriggerUnit(), UNIT_TYPE_HERO) and GetItemTypeId(GetManipulatedItem()) == 'I077' and GetItemPlayer(GetManipulatedItem()) == GetTriggerPlayer() then
        set t = CreateTimer()
        call SaveUnitHandle(udg_ht, GetHandleId(t), 0, GetTriggerUnit())
        call TimerStart(t, 0.0, false, function s__coin_onDelayedCheck)
        set t = null
    endif
    return false
endfunction

function s__coin_onDamage takes nothing returns boolean
    local unit u
    if GetEventDamage() > 0.0 and IsUnitType(GetTriggerUnit(), UNIT_TYPE_HERO) and IsUnitType(GetEventDamageSource(), UNIT_TYPE_HERO) or GetUnitAbilityLevel(GetEventDamageSource(), 'Aloc') > 0 then
        set u = GetPlayerCharacter(GetOwningPlayer(GetTriggerUnit()))
        if YDWEUnitHasItemOfTypeBJNull(u, 'I077') or YDWEUnitHasItemOfTypeBJNull(u, 'I04W') then
            call UnitBuffTarget(u, u, 7, 'A1HU', 0)
        endif
    endif
    return false
endfunction

function InitTrig_Coin_off takes nothing returns nothing
    local trigger t1 = CreateTrigger()
    local trigger t2 = CreateTrigger()
    local integer i = 0
    set gg_trg_Coin_off = CreateTrigger()
    call TriggerAddCondition(t1, Condition(function s__coin_onPickup))
    call TriggerAddCondition(t2, Condition(function s__coin_onDrop))
    call TriggerAddCondition(gg_trg_Coin_off, Condition(function s__coin_onDamage))
    call RegisterAnyUnitDamage(gg_trg_Coin_off)
    loop
        call TriggerRegisterPlayerUnitEvent(t1, Player(i), EVENT_PLAYER_UNIT_PICKUP_ITEM, null)
        call TriggerRegisterPlayerUnitEvent(t2, Player(i), EVENT_PLAYER_UNIT_DROP_ITEM, null)
        set udg_coinCount[i] = 0
        set i = i + 1
    exitwhen i > 11
    endloop
    set t1 = null
    set t2 = null
endfunction