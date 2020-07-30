function Kumoi04 takes nothing returns integer
    return 'A111'
endfunction

function Trig_Kumoi04_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A111'
endfunction

function Trig_Kumoi04_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local real x = GetUnitX(caster)
    local real y = GetUnitY(caster)
    local integer level = GetUnitAbilityLevel(caster, 'A111')
    if GetUnitTypeId(caster) == 'E03K' then
        call VE_Spellcast(caster)
        set udg_Kumoi04_SK = GetUnitState(caster, UNIT_STATE_LIFE)
        call UnitPhysicalDamageArea(caster, x, y, 250.0, 150.0 * level - 50.0 + GetUnitAttack(caster))
        call SetUnitState(caster, UNIT_STATE_LIFE, GetUnitState(caster, UNIT_STATE_MAX_LIFE))
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Human\\Thunderclap\\ThunderClapCaster.mdl", x, y))
        return
    endif
    call SetUnitState(caster, UNIT_STATE_LIFE, udg_Kumoi04_SK)
    set caster = null
endfunction

function InitTrig_Kumoi04 takes nothing returns nothing
endfunction