function Misfurtune_onPickup takes nothing returns boolean
    local unit u = GetTriggerUnit()
    local integer i3
    local integer i2
    if GetItemTypeId(GetManipulatedItem()) == 'I07Z' then
        set i3 = GetItemCharges(GetManipulatedItem())
        call UnitAddBonusDmg(u, i3)
    endif
    if GetItemTypeId(GetManipulatedItem()) == 'I073' then
        set i2 = GetItemCharges(GetManipulatedItem())
        call UnitAddBonusInt(u, i2)
        if LoadInteger(udg_HeroDatabase, GetUnitTypeId(u), 'PRIM') == 3 then
            call UnitAddBonusDmg(u, -i2)
        endif
    endif
    return false
endfunction

function Misfurtune_onDrop takes nothing returns boolean
    local unit u = GetTriggerUnit()
    local integer i3
    local integer i2
    if GetItemTypeId(GetManipulatedItem()) == 'I07Z' then
        set i3 = GetItemCharges(GetManipulatedItem())
        call UnitAddBonusDmg(u, -i3)
    endif
    if GetItemTypeId(GetManipulatedItem()) == 'I073' then
        set i2 = GetItemCharges(GetManipulatedItem())
        call UnitAddBonusInt(u, -i2)
        if LoadInteger(udg_HeroDatabase, GetUnitTypeId(u), 'PRIM') == 3 then
            call UnitAddBonusDmg(u, i2)
        endif
    endif
    return false
endfunction

function InitTrig_Misfurtune_Drop takes nothing returns nothing
    local trigger t1 = CreateTrigger()
    local trigger t2 = CreateTrigger()
    local integer i = 0
    call TriggerAddCondition(t1, Condition(function Misfurtune_onPickup))
    call TriggerAddCondition(t2, Condition(function Misfurtune_onDrop))
    loop
        call TriggerRegisterPlayerUnitEvent(t1, Player(i), EVENT_PLAYER_UNIT_PICKUP_ITEM, null)
        call TriggerRegisterPlayerUnitEvent(t2, Player(i), EVENT_PLAYER_UNIT_DROP_ITEM, null)
        set i = i + 1
    exitwhen i > 11
    endloop
    set t1 = null
    set t2 = null
endfunction