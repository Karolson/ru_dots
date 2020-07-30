function Trig_Str03_GetItemLvUp_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    if YDWEUnitHasItemOfTypeBJNull(caster, 'I032') == false then
        set caster = null
    endif
    if GetItemTypeId(GetManipulatedItem()) == 'I02P' or (GetItemTypeId(GetManipulatedItem()) == 'I032' and YDWEUnitHasItemOfTypeBJNull(caster, 'I02P') != false) then
        call SetUnitAbilityLevel(caster, 'A07Y', 2)
    endif
    if GetItemTypeId(GetManipulatedItem()) == 'I02Q' or (GetItemTypeId(GetManipulatedItem()) == 'I032' and YDWEUnitHasItemOfTypeBJNull(caster, 'I02Q') != false)  then
        call SetUnitAbilityLevel(caster, 'A028', 2)
    endif
    if GetItemTypeId(GetManipulatedItem()) == 'I02R' or (GetItemTypeId(GetManipulatedItem()) == 'I032' and YDWEUnitHasItemOfTypeBJNull(caster, 'I02R') != false)  then
        call SetUnitAbilityLevel(caster, 'A029', 2)
    endif
    set caster = null
endfunction

function dropI032 takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    if GetItemTypeId(GetManipulatedItem()) == 'I032' then
        call SetUnitAbilityLevel(caster, 'A07Y', 1)
        call SetUnitAbilityLevel(caster, 'A028', 1)
        call SetUnitAbilityLevel(caster, 'A029', 1)
    endif
    set caster = null
endfunction

function InitTrig_Str03_GetItemLvUp takes nothing returns nothing
    local trigger trig = CreateTrigger()
    set gg_trg_Str03_GetItemLvUp = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Str03_GetItemLvUp, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddAction(gg_trg_Str03_GetItemLvUp, function Trig_Str03_GetItemLvUp_Actions)
    call TriggerRegisterAnyUnitEventBJ(trig, EVENT_PLAYER_UNIT_DROP_ITEM)
    call TriggerAddAction(trig, function dropI032)
endfunction