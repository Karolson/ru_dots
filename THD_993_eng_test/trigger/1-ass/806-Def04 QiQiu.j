function QiQiu takes nothing returns boolean
    local real x
    local real y
    local unit u
    local unit v
    if GetItemTypeId(GetManipulatedItem()) == 'I00I' then
        set v = GetTriggerUnit()
        set x = GetUnitX(v)
        set y = GetUnitY(v)
        set u = NewDummy(GetOwningPlayer(v), x, y, 0)
        call UnitAddAbility(u, 'A03M')
        call IssueTargetOrder(u, "frostarmor", v)
        call UnitRemoveAbility(u, 'A03M')
        call ReleaseDummy(u)
    endif
    set u = null
    set v = null
    return false
endfunction

function InitTrig_Def04_QiQiu takes nothing returns nothing
    set gg_trg_Def04_QiQiu = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Def04_QiQiu, EVENT_PLAYER_UNIT_USE_ITEM)
    call TriggerAddCondition(gg_trg_Def04_QiQiu, Condition(function QiQiu))
endfunction