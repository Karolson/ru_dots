function Trig_Point_Delete_Conditions takes nothing returns boolean
    return GetItemTypeId(GetManipulatedItem()) == 'I03F' or GetItemTypeId(GetManipulatedItem()) == 'I06O'
endfunction

function Trig_Point_Delete_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer i
    local unit v
    if GetItemTypeId(GetManipulatedItem()) == 'I06O' then
        set i = 0
        loop
        exitwhen i >= 12
            set v = udg_PlayerHeroes[i]
            if v != null and IsUnitAlly(v, GetOwningPlayer(caster)) and GetOwningPlayer(v) != GetOwningPlayer(caster) then
                call THD_AddCredit(GetOwningPlayer(v), 100)
            endif
            set i = i + 1
        endloop
    endif
    if GetItemTypeId(GetManipulatedItem()) == 'I03F' and GetUnitAbilityLevel(caster, 'A0PP') != 0 and GetRandomInt(0, 100) < 15 then
        call THD_AddCredit(GetOwningPlayer(caster), 35)
    endif
    call RemoveItem(GetManipulatedItem())
    set caster = null
    set v = null
endfunction

function InitTrig_Point_Delete takes nothing returns nothing
    set gg_trg_Point_Delete = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Point_Delete, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddCondition(gg_trg_Point_Delete, Condition(function Trig_Point_Delete_Conditions))
    call TriggerAddAction(gg_trg_Point_Delete, function Trig_Point_Delete_Actions)
endfunction