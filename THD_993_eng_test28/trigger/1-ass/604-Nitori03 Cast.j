function Trig_Nitori03_Cast_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A17F'
endfunction

function Trig_Nitori03_Cast_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A17F')
    local integer i
    local real a = GetUnitFacing(caster) - 90
    call AbilityCoolDownResetion(caster, 'A17F', 8 - level)
    call SetUnitAnimation(caster, "Attack")
    call UnitMagicDamageArea(caster, GetUnitX(caster), GetUnitY(caster), 300, 40 * level + 0.6 * udg_Nitori_RealInt + 0.3 * GetUnitAttack(caster), 5)
    set i = 0
    loop
        set i = i + 1
        call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\WingedSerpentMissile\\WingedSerpentMissile.mdl", GetUnitX(caster) + (227 + i * 10) * CosBJ(a + i * 20), GetUnitY(caster) + (227 + i * 10) * SinBJ(a + i * 20)))
    exitwhen i == 10
    endloop
    set i = 0
    loop
        set i = i + 1
        call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\WingedSerpentMissile\\WingedSerpentMissile.mdl", GetUnitX(caster) + (127 + i * 5) * CosBJ(a + i * 20), GetUnitY(caster) + (127 + i * 5) * SinBJ(a + i * 20)))
    exitwhen i == 10
    endloop
    set caster = null
endfunction

function InitTrig_Nitori03_Cast takes nothing returns nothing
endfunction