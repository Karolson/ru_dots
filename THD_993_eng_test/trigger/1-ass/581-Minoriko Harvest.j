function Trig_Minoriko_Harvest_Target takes nothing returns boolean
    if IsUnitType(GetFilterUnit(), UNIT_TYPE_DEAD) then
        return false
    elseif IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) == false then
        return false
    endif
    return IsUnitAlly(GetFilterUnit(), GetOwningPlayer(udg_SK_Minoriko))
endfunction

function Trig_Minoriko_Harvest_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit v
    local group g = CreateGroup()
    local filterfunc iff = Filter(function Trig_Minoriko_Harvest_Target)
    local integer heal = 60 + 6 * GetHeroLevel(caster)
    call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS, 10.0, "|c00ffff00Minoriko just shared the fruits of the harvest!|r")
    call GroupEnumUnitsInRange(g, GetUnitX(caster), GetUnitY(caster), 99999.0, iff)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        call UnitHealingTarget(caster, v, heal)
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Items\\AIhe\\AIheTarget.mdl", GetUnitX(v), GetUnitY(v)))
    endloop
    call DestroyGroup(g)
    call DestroyFilter(iff)
    set caster = null
    set v = null
    set g = null
    set iff = null
endfunction

function InitTrig_Minoriko_Harvest takes nothing returns nothing
endfunction