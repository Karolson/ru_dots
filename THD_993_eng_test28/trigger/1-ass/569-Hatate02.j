function Trig_Hatate02_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A09B'
endfunction

function Trig_Hatate02_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local real tx = GetSpellTargetX()
    local real ty = GetSpellTargetY()
    local integer level = GetUnitAbilityLevel(caster, 'A09B')
    local real damage
    local unit v
    local group g = CreateGroup()
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 5)
    call GroupEnumUnitsInRange(g, tx, ty, 300, iff)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if GetWidgetLife(v) > 0.405 and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false then
            call UnitDebuffTarget(caster, v, 13.0, 1, true, 'A0D4', 1, 'B05Z', "faeriefire", 0, "")
            set damage = level * 40.0 + GetUnitAttack(caster) * 0.15
            call UnitMagicDamageTarget(caster, v, damage, 5)
        endif
    endloop
    call DestroyGroup(g)
    set caster = null
    set v = null
    set g = null
    set iff = null
endfunction

function InitTrig_Hatate02 takes nothing returns nothing
endfunction