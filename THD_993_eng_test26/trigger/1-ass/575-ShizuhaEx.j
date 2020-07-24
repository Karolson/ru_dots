function Trig_ShizuhaEx_Target takes nothing returns boolean
    if IsUnitType(GetFilterUnit(), UNIT_TYPE_DEAD) then
        return false
    elseif IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) == false then
        return false
    endif
    return IsUnitEnemy(GetFilterUnit(), GetOwningPlayer(udg_SK_Shizuha))
endfunction

function Trig_ShizuhaEx_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit v
    local group g = CreateGroup()
    local filterfunc iff = Filter(function Trig_ShizuhaEx_Target)
    local integer damage = 60 + 6 * GetHeroLevel(caster)
    call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS, 10.0, "|c00ffff00Leaves again have scattered on the ground|r")
    call GroupEnumUnitsInRange(g, GetUnitX(caster), GetUnitY(caster), 99999.0, iff)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        call UnitDelDamageTarget(caster, v, damage)
        call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\IllidanMissile\\IllidanMissile.mdl", GetUnitX(v), GetUnitY(v)))
    endloop
    call DestroyGroup(g)
    call DestroyFilter(iff)
    set caster = null
    set v = null
    set g = null
    set iff = null
endfunction

function InitTrig_ShizuhaEx takes nothing returns nothing
endfunction