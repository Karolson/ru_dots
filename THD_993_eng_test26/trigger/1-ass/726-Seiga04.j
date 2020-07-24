function Seiga04 takes nothing returns integer
    return 'A1FM'
endfunction

function Trig_Seiga04_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A1FM'
endfunction

function Trig_Seiga04_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local real x = GetUnitX(caster)
    local real y = GetUnitY(caster)
    local real px = GetUnitX(target)
    local real py = GetUnitY(target)
    local integer level = GetUnitAbilityLevel(caster, 'A1FM')
    call AbilityCoolDownResetion(caster, 'A1FM', 150 - 30 * level)
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\Charm\\CharmTarget.mdl", x, y))
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\Charm\\CharmTarget.mdl", px, py))
    call SetUnitX(target, x)
    call SetUnitY(target, y)
    set caster = null
    set target = null
endfunction

function InitTrig_Seiga04 takes nothing returns nothing
endfunction