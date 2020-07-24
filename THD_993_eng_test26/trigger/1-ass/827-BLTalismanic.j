function Trig_BLTalismanic_Conditions takes nothing returns boolean
    return IsUnitType(GetTriggerUnit(), UNIT_TYPE_HERO) and GetItemTypeId(GetManipulatedItem()) == 'I00E' and udg_SK_BLTalismanicCoolDown[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))] == false and GetItemPlayer(GetManipulatedItem()) == GetTriggerPlayer()
endfunction

function Trig_BLTalismanic_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer k = GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))
    set udg_SK_BLTalismanicAvaliable[k] = true
    call UnitAddAbility(caster, 'A0QL')
    call UnitMakeAbilityPermanent(caster, true, 'A0QK')
    call UnitMakeAbilityPermanent(caster, true, 'A0QL')
    call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A0QL', false)
    set caster = null
endfunction

function InitTrig_BLTalismanic takes nothing returns nothing
    set gg_trg_BLTalismanic = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_BLTalismanic, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddCondition(gg_trg_BLTalismanic, Condition(function Trig_BLTalismanic_Conditions))
    call TriggerAddAction(gg_trg_BLTalismanic, function Trig_BLTalismanic_Actions)
endfunction