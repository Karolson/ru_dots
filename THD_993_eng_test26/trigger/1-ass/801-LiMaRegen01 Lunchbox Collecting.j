function Trig_LiMaRegen01_Lunchbox_CollectingConditions takes nothing returns boolean
    return IsUnitType(GetTriggerUnit(), UNIT_TYPE_HERO) and GetSpellAbilityId() != 'A0QP' and GetSpellAbilityId() != 'A0OS' and GetSpellAbilityId() != 'A0OR' and GetSpellAbilityId() != 'A029' and GetSpellAbilityId() != 'A02A' and GetSpellAbilityId() != 'A015' and GetSpellAbilityId() != 'A02B' and GetSpellAbilityId() != 'A035' and GetSpellAbilityId() != 'A02C' and GetSpellAbilityId() != 'A02K' and GetSpellAbilityId() != 'A0LC' and GetSpellAbilityId() != 'A0I1' and GetSpellAbilityId() != 'A04O' and GetSpellAbilityId() != 'A0FK' and GetSpellAbilityId() != 'A0CI'
endfunction

function Trig_LiMaRegen01_Lunchbox_CollectingFunc019001003 takes nothing returns boolean
    return IsUnitEnemy(GetFilterUnit(), GetTriggerPlayer())
endfunction

function Trig_LiMaRegen01_Lunchbox_CollectingFunc019A takes nothing returns nothing
    if YDWEUnitHasItemOfTypeBJNull(GetEnumUnit(), 'I02Z') and GetItemCharges(YDWEGetItemOfTypeFromUnitBJNull(GetEnumUnit(), 'I02Z')) < 8 then
        call SetItemCharges(YDWEGetItemOfTypeFromUnitBJNull(GetEnumUnit(), 'I02Z'), GetItemCharges(YDWEGetItemOfTypeFromUnitBJNull(GetEnumUnit(), 'I02Z')) + 1)
    else
        call DoNothing()
    endif
    if YDWEUnitHasItemOfTypeBJNull(GetEnumUnit(), 'I05W') and GetItemCharges(YDWEGetItemOfTypeFromUnitBJNull(GetEnumUnit(), 'I05W')) < 8 then
        call SetItemCharges(YDWEGetItemOfTypeFromUnitBJNull(GetEnumUnit(), 'I05W'), GetItemCharges(YDWEGetItemOfTypeFromUnitBJNull(GetEnumUnit(), 'I05W')) + 1)
    else
    endif
endfunction

function Trig_LiMaRegen01_Lunchbox_CollectingActions takes nothing returns nothing
    local group ydl_group
    local unit ydl_unit
    set udg_SK_TempLocation = GetUnitLoc(GetTriggerUnit())
    set bj_wantDestroyGroup = true
    call ForGroupBJ(YDWEGetUnitsInRangeOfLocMatchingNull(1500.0, udg_SK_TempLocation, Condition(function Trig_LiMaRegen01_Lunchbox_CollectingFunc019001003)), function Trig_LiMaRegen01_Lunchbox_CollectingFunc019A)
    call RemoveLocation(udg_SK_TempLocation)
    set ydl_group = null
    set ydl_unit = null
endfunction

function InitTrig_LiMaRegen01_Lunchbox_Collecting takes nothing returns nothing
    set gg_trg_LiMaRegen01_Lunchbox_Collecting = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_LiMaRegen01_Lunchbox_Collecting, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_LiMaRegen01_Lunchbox_Collecting, Condition(function Trig_LiMaRegen01_Lunchbox_CollectingConditions))
    call TriggerAddAction(gg_trg_LiMaRegen01_Lunchbox_Collecting, function Trig_LiMaRegen01_Lunchbox_CollectingActions)
endfunction