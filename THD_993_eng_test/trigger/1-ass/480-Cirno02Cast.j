function Trig_Cirno02Cast_Conditions takes nothing returns boolean
    return false
endfunction

function Trig_Cirno02Cast_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    local group g
    local unit v
    local boolexpr iff
    call AbilityCoolDownResetion(caster, 'A03X', 13)
    set g = CreateGroup()
    set iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    call GroupEnumUnitsInRange(g, GetUnitX(caster), GetUnitY(caster), 325, iff)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if GetWidgetLife(v) > 0.405 and IsUnitType(v, UNIT_TYPE_HERO) then
            call UnitSlowTarget(caster, v, 6.0, 'A04J', 0)
            call SetUnitAbilityLevel(v, 'A04J', level)
            call UnitSlowTarget(caster, v, 6.0, 'A057', 'B05A')
        endif
    endloop
    call DestroyGroup(g)
    set caster = null
    set g = null
    set v = null
    set iff = null
endfunction

function InitTrig_Cirno02Cast takes nothing returns nothing
endfunction