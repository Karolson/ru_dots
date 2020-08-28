function Trig_Renko03_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A12S'
endfunction

function Trig_Renko03_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A12S')
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local group g = CreateGroup()
    local filterfunc f = Filter(function Trig_Renko01_Target02)
    local unit v
    local real damage = 15 + 25 * level + GetUnitAttack(caster) * 0.35
    call AbilityCoolDownResetion(caster, 'A12S', 11 - 1.5 * level)
    call Trig_RenkoEx_TurnsOn(caster)
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Human\\Thunderclap\\ThunderClapCaster.mdl", ox, oy))
    if udg_SK_Renko_LastSpell == 3 then
        call GroupEnumUnitsInRange(g, ox, oy, 600.0, f)
    else
        call GroupEnumUnitsInRange(g, ox, oy, 300.0, f)
    endif
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        call UnitPhysicalDamageTarget(caster, v, damage)
        if udg_SK_Renko_LastSpell == 3 then
            call SetUnitState(caster, UNIT_STATE_MANA, GetUnitState(caster, UNIT_STATE_MANA) + damage * 0.4)
        endif
    endloop
    call DestroyFilter(f)
    call DestroyGroup(g)
    if udg_SK_Renko_LastSpell == 1 then
        call UnitBuffTarget(caster, caster, 4.0, 'A0UD', 0)
        call UnitBuffTarget(caster, caster, 4.0, 'A14I', 0)
    elseif udg_SK_Renko_LastSpell == 2 then
        call UnitBuffTarget(caster, caster, 4.0, 'A14J', 0)
    elseif udg_SK_Renko_LastSpell == 4 then
        call UnitBuffTarget(caster, caster, 4.0, 'A14K', 0)
    endif
    set udg_SK_Renko_LastSpell = 3
    set caster = null
    set g = null
    set f = null
    set v = null
endfunction

function InitTrig_Renko03 takes nothing returns nothing
endfunction