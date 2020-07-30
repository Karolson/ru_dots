function Trig_NewEngland01_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0HD'
endfunction

function Trig_NewEngland01_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit u
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local integer level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    call UnitPhysicalDamageArea(caster, ox, oy, 135, 48 + level * 16 + GetHeroAgi(GetCharacterHandle('H01A'), true) * 1.0)
    call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\Mortar\\MortarMissile.mdl", ox, oy))
    call KillUnit(caster)
    set caster = null
    set u = null
endfunction

function InitTrig_NewEngland01 takes nothing returns nothing
endfunction