function Trig_ToramaruDB_Change takes nothing returns nothing
    local unit caster = udg_SK_Toramaru
    if GetUnitAbilityLevel(caster, 'A0P4') == 1 then
        call UnitRemoveAbility(caster, 'A0P4')
    elseif GetUnitAbilityLevel(caster, 'A0QX') == 1 then
        call UnitRemoveAbility(caster, 'A0QX')
    elseif GetUnitAbilityLevel(caster, 'A0QY') == 1 then
        call UnitRemoveAbility(caster, 'A0QY')
    elseif GetUnitAbilityLevel(caster, 'A0QZ') == 1 then
        call UnitRemoveAbility(caster, 'A0QZ')
    elseif GetUnitAbilityLevel(caster, 'A0R0') == 1 then
        call UnitRemoveAbility(caster, 'A0R0')
    elseif GetUnitAbilityLevel(caster, 'A0R1') == 1 then
        call UnitRemoveAbility(caster, 'A0R1')
    elseif GetUnitAbilityLevel(caster, 'A0R2') == 1 then
        call UnitRemoveAbility(caster, 'A0R2')
    endif
    if udg_SK_ToramaruDB_Count == 0 then
        call UnitAddAbility(caster, 'A0P4')
    elseif udg_SK_ToramaruDB_Count == 1 then
        call UnitAddAbility(caster, 'A0QX')
    elseif udg_SK_ToramaruDB_Count == 2 then
        call UnitAddAbility(caster, 'A0QY')
    elseif udg_SK_ToramaruDB_Count == 3 then
        call UnitAddAbility(caster, 'A0QZ')
    elseif udg_SK_ToramaruDB_Count == 4 then
        call UnitAddAbility(caster, 'A0R0')
    elseif udg_SK_ToramaruDB_Count == 5 then
        call UnitAddAbility(caster, 'A0R1')
    elseif udg_SK_ToramaruDB_Count == 6 then
        call UnitAddAbility(caster, 'A0R2')
    endif
    set caster = null
endfunction

function Trig_ToramaruDB_Actions takes nothing returns nothing
    if udg_SK_ToramaruDB_Count < 6 then
        set udg_SK_ToramaruDB_Count = udg_SK_ToramaruDB_Count + 1
        call Trig_ToramaruDB_Change()
    endif
endfunction

function InitTrig_ToramaruDB takes nothing returns nothing
endfunction