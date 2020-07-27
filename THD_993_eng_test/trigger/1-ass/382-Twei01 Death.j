function Trig_Twei01_Death_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local real x = GetUnitX(caster)
    local real y = GetUnitY(caster)
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    local group g = CreateGroup()
    local unit v
    local unit u
    if GetUnitAbilityLevel(caster, 'A0N2') != 0 then
        call DestroyEffect(AddSpecialEffect("Objects\\Spawnmodels\\Other\\NeutralBuildingExplosion\\NeutralBuildingExplosion.mdl", x, y))
        call GroupEnumUnitsInRange(g, x, y, 260.0, iff)
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if GetWidgetLife(v) > 0.405 and IsUnitEnemy(v, GetOwningPlayer(caster)) then
                call UnitMagicDamageTarget(caster, v, 150 * GetUnitAbilityLevel(caster, 'A0N2') + 4.5 * GetHeroInt(caster, true), 5)
                call UnitStunTarget(caster, v, 0.5 * GetUnitAbilityLevel(caster, 'A0N2'), 0, 0)
            endif
        endloop
    endif
    call DestroyGroup(g)
    set caster = null
    set iff = null
    set g = null
    set v = null
    set u = null
endfunction

function InitTrig_Twei01_Death takes nothing returns nothing
endfunction