function Trig_All06_MoonWeapon_Trans_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A1HV'
endfunction

function Trig_All06_MoonWeapon_Trans_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local boolean oldinabas = YDWEUnitHasItemOfTypeBJNull(caster, 'I095')
    local boolean oldinabal = YDWEUnitHasItemOfTypeBJNull(caster, 'I094')
    local boolean newinabas = YDWEUnitHasItemOfTypeBJNull(caster, 'I098')
    local boolean newinabal = YDWEUnitHasItemOfTypeBJNull(caster, 'I099')
    local item i
    local integer sit
    local integer transtarget
    if oldinabas or oldinabal then
        set i = YDWEGetItemOfTypeFromUnitBJNull(caster, 'I095')
        set transtarget = 'I094'
        set sit = YDWEGetInventoryIndexOfItemTypeBJNull(caster, 'I095') - 1
        if i == null then
            set i = YDWEGetItemOfTypeFromUnitBJNull(caster, 'I094')
            set sit = YDWEGetInventoryIndexOfItemTypeBJNull(caster, 'I094') - 1
            set transtarget = 'I095'
        endif
        call UnitRemoveItem(caster, i)
        call RemoveItem(i)
        call UnitAddItemToSlotById(caster, transtarget, sit)
    elseif newinabas or newinabal then
        call SetUnitAbilityLevel(caster, 'A1HV', 2)
        set i = YDWEGetItemOfTypeFromUnitBJNull(caster, 'I098')
        set transtarget = 'I099'
        set sit = YDWEGetInventoryIndexOfItemTypeBJNull(caster, 'I098') - 1
        if i == null then
            set i = YDWEGetItemOfTypeFromUnitBJNull(caster, 'I099')
            set sit = YDWEGetInventoryIndexOfItemTypeBJNull(caster, 'I099') - 1
            set transtarget = 'I098'
        endif
        call UnitRemoveItem(caster, i)
        call RemoveItem(i)
        call UnitAddItemToSlotById(caster, transtarget, sit)  
    endif
    set caster = null
endfunction

function InitTrig_All06_MoonWeapon_Trans takes nothing returns nothing
    set gg_trg_All06_MoonWeapon_Trans = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_All06_MoonWeapon_Trans, EVENT_PLAYER_UNIT_SPELL_FINISH)
    call TriggerAddCondition(gg_trg_All06_MoonWeapon_Trans, Condition(function Trig_All06_MoonWeapon_Trans_Conditions))
    call TriggerAddAction(gg_trg_All06_MoonWeapon_Trans, function Trig_All06_MoonWeapon_Trans_Actions)
endfunction