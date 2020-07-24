function Trig_BLTalismanicDrop_Conditions takes nothing returns boolean
    return IsUnitType(GetTriggerUnit(), UNIT_TYPE_HERO) and GetItemTypeId(GetManipulatedItem()) == 'I00E' and GetItemPlayer(GetManipulatedItem()) == GetTriggerPlayer()
endfunction

function Trig_BLTalismanicDrop_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer k = GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))
    if udg_SK_BLTalismanicCoolDown[k] == false then
        set udg_SK_BLTalismanicAvaliable[k] = false
        call UnitRemoveAbility(caster, 'A0QL')
    endif
    set caster = null
endfunction

function InitTrig_BLTalismanicDrop takes nothing returns nothing
    set gg_trg_BLTalismanicDrop = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_BLTalismanicDrop, EVENT_PLAYER_UNIT_DROP_ITEM)
    call TriggerAddCondition(gg_trg_BLTalismanicDrop, Condition(function Trig_BLTalismanicDrop_Conditions))
    call TriggerAddAction(gg_trg_BLTalismanicDrop, function Trig_BLTalismanicDrop_Actions)
endfunction