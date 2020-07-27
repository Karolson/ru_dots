function Trig_All06_MoonWeapon_Trans_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A1HV'
endfunction

function Trig_All06_MoonWeapon_Trans_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local item i = YDWEGetItemOfTypeFromUnitBJNull(caster, 'I095')
    local integer sit
    local integer transtarget = 'I094'
    set sit = YDWEGetInventoryIndexOfItemTypeBJNull(caster, 'I095') - 1
    if i == null then
        set i = YDWEGetItemOfTypeFromUnitBJNull(caster, 'I094')
        set sit = YDWEGetInventoryIndexOfItemTypeBJNull(caster, 'I094') - 1
        set transtarget = 'I095'
    endif
    call UnitRemoveItem(caster, i)
    call RemoveItem(i)
    call UnitAddItemToSlotById(caster, transtarget, sit)
    set caster = null
endfunction

function InitTrig_All06_MoonWeapon_Trans takes nothing returns nothing
    set gg_trg_All06_MoonWeapon_Trans = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_All06_MoonWeapon_Trans, EVENT_PLAYER_UNIT_SPELL_FINISH)
    call TriggerAddCondition(gg_trg_All06_MoonWeapon_Trans, Condition(function Trig_All06_MoonWeapon_Trans_Conditions))
    call TriggerAddAction(gg_trg_All06_MoonWeapon_Trans, function Trig_All06_MoonWeapon_Trans_Actions)
endfunction