function Trig_Refresh_Order_Filter takes nothing returns boolean
    if IsUnitType(GetFilterUnit(), UNIT_TYPE_DEAD) then
        return false
    elseif IsUnitHidden(GetFilterUnit()) then
        return false
    endif
    return IsUnitSpawn(GetFilterUnit())
endfunction

function Trig_Refresh_Order_Actions takes nothing returns nothing
    local group g
    local boolexpr f = Filter(function Trig_Refresh_Order_Filter)
    local unit u
    set g = CreateGroup()
    call GroupEnumUnitsOfPlayer(g, udg_SpawnPlayer[0], f)
    loop
        set u = FirstOfGroup(g)
    exitwhen u == null
        call GroupRemoveUnit(g, u)
        if GetUnitCurrentOrder(u) == 0 then
            call SpawnIssueOrderA(u)
        endif
    endloop
    call DestroyGroup(g)
    set g = CreateGroup()
    call GroupEnumUnitsOfPlayer(g, udg_SpawnPlayer[1], f)
    loop
        set u = FirstOfGroup(g)
    exitwhen u == null
        call GroupRemoveUnit(g, u)
        if GetUnitCurrentOrder(u) == 0 then
            call SpawnIssueOrderB(u)
        endif
    endloop
    call DestroyGroup(g)
    call DestroyBoolExpr(f)
    set g = null
    set f = null
    set u = null
endfunction

function InitTrig_Refresh_Order takes nothing returns nothing
    set udg_NPC_cycleIndex = 0
    set gg_trg_Refresh_Order = CreateTrigger()
    call TriggerAddAction(gg_trg_Refresh_Order, function Trig_Refresh_Order_Actions)
endfunction