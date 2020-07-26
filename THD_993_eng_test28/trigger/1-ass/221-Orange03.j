function Trig_Orange03_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0Z3'
endfunction

function Trig_Orange03_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local group g
    local unit v
    local boolexpr iff
    local integer level = GetUnitAbilityLevel(caster, 'A0Z3')
    local real x = GetUnitX(caster)
    local real y = GetUnitY(caster)
    call AbilityCoolDownResetion(caster, 'A0Z3', 10)
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Human\\Thunderclap\\ThunderClapCaster.mdl", x, y))
    set g = CreateGroup()
    set iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    call GroupEnumUnitsInRange(g, x, y, 500, iff)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if IsUnitType(v, UNIT_TYPE_DEAD) == false and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false then
            if udg_NewDebuffSys then
                call UnitSlowTargetNew(caster, v, 10 + 5 * level, 2.0, 2, 0)
            else
                if level == 1 then
                    call UnitSlowTarget(caster, v, 2.0, 'A10W', 'B03E')
                elseif level == 2 then
                    call UnitSlowTarget(caster, v, 2.0, 'A10X', 'B03E')
                elseif level == 3 then
                    call UnitSlowTarget(caster, v, 2.0, 'A10Y', 'B03E')
                elseif level == 4 then
                    call UnitSlowTarget(caster, v, 2.0, 'A10Z', 'B03E')
                endif
            endif
        endif
    endloop
    call DestroyGroup(g)
    call UnitMagicDamageArea(caster, x, y, 500, Orange03Damage(caster) * 2, 5)
    set g = null
    set iff = null
    set v = null
    set caster = null
endfunction

function InitTrig_Orange03 takes nothing returns nothing
endfunction