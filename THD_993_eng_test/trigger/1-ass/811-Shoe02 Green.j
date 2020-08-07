function Trig_Shoe02_Green_Conditions takes nothing returns boolean
    if GetItemTypeId(GetManipulatedItem()) == 'I03A' or GetItemTypeId(GetManipulatedItem()) == 'I091' then
        if not IsUnitType(GetTriggerUnit(), UNIT_TYPE_HERO) then
            return false
        elseif udg_SK_Li_Shoe02_Green[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))] != 0 then
            return false
        elseif GetItemPlayer(GetManipulatedItem()) != GetTriggerPlayer() then
            return false
        else 
            return true
        endif
    endif
endfunction

function Trig_Shoe02_Green_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer k = GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))
    set udg_SK_Li_Shoe02_Green[k] = 1
    call UnitAddAbility(caster, 'A17L')
    call UnitMakeAbilityPermanent(caster, true, 'A17L')
    call DebugMsg("Green Llama Effect Start")
    set caster = null
endfunction

function InitTrig_Shoe02_Green takes nothing returns nothing
    set gg_trg_Shoe02_Green = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Shoe02_Green, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddCondition(gg_trg_Shoe02_Green, Condition(function Trig_Shoe02_Green_Conditions))
    call TriggerAddAction(gg_trg_Shoe02_Green, function Trig_Shoe02_Green_Actions)
endfunction