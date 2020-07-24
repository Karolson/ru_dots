function Trig_Spirit_Item_Conditions takes nothing returns boolean
    return true
endfunction

function Trig_Spirit_Item_Actions takes nothing returns nothing
    local integer cost = 75
    local unit caster = GetSellingUnit()
    local unit u = GetSoldUnit()
    local unit h = GetPlayerCharacter(GetOwningPlayer(u))
    local unit tower = GetTriggerUnit()
    local player PLY = GetOwningPlayer(u)
    local string str01
    local item w
    if GetUnitTypeId(u) == 'n088' then
        if THD_GetSpirit(PLY) < cost then
            call DisplayTextToPlayer(GetOwningPlayer(u), 0, 0, "Insufficient faith! Need " + I2S(cost) + " faith to buy")
            call RemoveUnit(u)
            call AddUnitToStock(caster, GetUnitTypeId(u), 1, 1)
            set u = null
            set tower = null
            set PLY = null
            set str01 = ""
            set h = null
            set w = null
            return
        endif
        call THD_AddSpirit(PLY, -cost)
        set w = CreateItem('I04Z', GetUnitX(h), GetUnitY(h))
        call UnitAddItem(h, w)
        call THD_SetItemOwner(w, PLY)
    endif
    set u = null
    set tower = null
    set PLY = null
    set h = null
    set w = null
endfunction

function InitTrig_Spirit_Item takes nothing returns nothing
    set gg_trg_Spirit_Item = CreateTrigger()
    call TriggerAddCondition(gg_trg_Spirit_Item, Condition(function Trig_Spirit_Item_Conditions))
    call TriggerAddAction(gg_trg_Spirit_Item, function Trig_Spirit_Item_Actions)
endfunction