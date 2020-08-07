function s__grayalpaca_reAdd takes nothing returns nothing
    local integer g = LoadInteger(udg_ht, GetHandleId(GetExpiredTimer()), 0)
    call UnitAddAbility(udg_s__grayalpaca_u[g], udg_HiddenSpellBook)
    call UnitMakeAbilityPermanent(udg_s__grayalpaca_u[g], true, udg_HiddenSpellBook)
    call UnitMakeAbilityPermanent(udg_s__grayalpaca_u[g], true, udg_MovementBonusAbility)
    call PauseTimer(GetExpiredTimer())
endfunction

function s__grayalpaca_tempRemove takes integer this returns nothing
    call UnitRemoveAbility(udg_s__grayalpaca_u[this], udg_HiddenSpellBook)
    call UnitRemoveAbility(udg_s__grayalpaca_u[this], udg_MovementBonusAbility)
    call UnitRemoveAbility(udg_s__grayalpaca_u[this], udg_MovementBonusBuffId)
    call TimerStart(udg_s__grayalpaca_t[this], udg_ReAddAbilityDelay, true, function s__grayalpaca_reAdd)
endfunction

function s__grayalpaca_create takes unit u returns integer
    local integer g = s__grayalpaca__allocate()
    local integer i = GetPlayerId(GetOwningPlayer(u))
    set udg_s__grayalpaca_u[g] = u
    set udg_s__grayalpaca_t[g] = CreateTimer()
    call SaveInteger(udg_ht, GetHandleId(udg_s__grayalpaca_t[g]), 0, g)
    call UnitAddAbility(u, udg_HiddenSpellBook)
    call UnitMakeAbilityPermanent(u, true, udg_HiddenSpellBook)
    call UnitMakeAbilityPermanent(u, true, udg_MovementBonusAbility)
    set udg_s__grayalpaca_stack[i] = g
    set udg_GrayAlpacaCount[i] = 1
    return g
endfunction

function s__grayalpaca_destroy takes integer this returns nothing
    set udg_s__grayalpaca_stack[GetPlayerId(GetOwningPlayer(udg_s__grayalpaca_u[this]))] = 0
    call UnitRemoveAbility(udg_s__grayalpaca_u[this], udg_HiddenSpellBook)
    call UnitRemoveAbility(udg_s__grayalpaca_u[this], udg_MovementBonusAbility)
    call UnitRemoveAbility(udg_s__grayalpaca_u[this], udg_MovementBonusBuffId)
    set udg_s__grayalpaca_u[this] = null
    call ReleaseTimer(udg_s__grayalpaca_t[this])
    set udg_s__grayalpaca_t[this] = null
    call s__grayalpaca_deallocate(this)
endfunction

function s__grayalpaca_onPickup takes nothing returns boolean
    if GetItemTypeId(GetManipulatedItem()) == udg_ItemID or GetItemTypeId(GetManipulatedItem()) == 'I090' then
        if IsUnitType(GetTriggerUnit(), UNIT_TYPE_HERO) and udg_GrayAlpacaCount[GetPlayerId(GetTriggerPlayer())] == 0 and GetItemPlayer(GetManipulatedItem()) == GetTriggerPlayer() or GetItemPlayer(GetManipulatedItem()) == Player(15) then
            call s__grayalpaca_create(GetTriggerUnit())
            call s__grayalpaca_tempRemove(udg_s__grayalpaca_stack[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))])
        endif
    endif
    return false
endfunction

function s__grayalpaca_onDelayedCheck takes nothing returns nothing
    local unit u = LoadUnitHandle(udg_ht, GetHandleId(GetExpiredTimer()), 0)
    call FlushChildHashtable(udg_ht, GetHandleId(GetExpiredTimer()))
    call ReleaseTimer(GetExpiredTimer())
    if not YDWEUnitHasItemOfTypeBJNull(u, udg_ItemID) and not YDWEUnitHasItemOfTypeBJNull(u, 'I090') then
        call s__grayalpaca_destroy(udg_s__grayalpaca_stack[GetPlayerId(GetOwningPlayer(u))])
        set udg_GrayAlpacaCount[GetPlayerId(GetOwningPlayer(u))] = 0
    endif
    set u = null
endfunction

function s__grayalpaca_onDrop takes nothing returns boolean
    local timer t
    if GetItemTypeId(GetManipulatedItem()) == udg_ItemID or GetItemTypeId(GetManipulatedItem()) == 'I090' then
        if IsUnitType(GetTriggerUnit(), UNIT_TYPE_HERO) and GetItemPlayer(GetManipulatedItem()) == GetTriggerPlayer() then
            set t = CreateTimer()
            call SaveUnitHandle(udg_ht, GetHandleId(t), 0, GetTriggerUnit())
            call TimerStart(t, 0.0, false, function s__grayalpaca_onDelayedCheck)
            set t = null
        endif
    endif
    return false
endfunction

function s__grayalpaca_onDamage takes nothing returns boolean
    local unit u
    if GetEventDamage() > 0.0 then
        set u = GetPlayerCharacter(GetOwningPlayer(GetTriggerUnit()))
        if YDWEUnitHasItemOfTypeBJNull(u, udg_ItemID) or YDWEUnitHasItemOfTypeBJNull(u, 'I090') then
            call s__grayalpaca_tempRemove(udg_s__grayalpaca_stack[GetPlayerId(GetOwningPlayer(u))])
        endif
        set u = GetPlayerCharacter(GetOwningPlayer(GetEventDamageSource()))
        if YDWEUnitHasItemOfTypeBJNull(u, udg_ItemID) or YDWEUnitHasItemOfTypeBJNull(u, 'I090') then
            call s__grayalpaca_tempRemove(udg_s__grayalpaca_stack[GetPlayerId(GetOwningPlayer(u))])
        endif
    endif
    return false
endfunction

function InitTrig_ShoeX_HuiMa takes nothing returns nothing
    local trigger t1 = CreateTrigger()
    local trigger t2 = CreateTrigger()
    local integer i = 0
    set gg_trg_ShoeX_HuiMa = CreateTrigger()
    call TriggerAddCondition(t1, Condition(function s__grayalpaca_onPickup))
    call TriggerAddCondition(t2, Condition(function s__grayalpaca_onDrop))
    call TriggerAddCondition(gg_trg_ShoeX_HuiMa, Condition(function s__grayalpaca_onDamage))
    call RegisterAnyUnitDamage(gg_trg_ShoeX_HuiMa)
    loop
        call SetPlayerAbilityAvailable(Player(i), udg_HiddenSpellBook, false)
        call TriggerRegisterPlayerUnitEvent(t1, Player(i), EVENT_PLAYER_UNIT_PICKUP_ITEM, null)
        call TriggerRegisterPlayerUnitEvent(t2, Player(i), EVENT_PLAYER_UNIT_DROP_ITEM, null)
        set udg_GrayAlpacaCount[i] = 0
        set i = i + 1
    exitwhen i > 11
    endloop
    set t1 = null
    set t2 = null
endfunction