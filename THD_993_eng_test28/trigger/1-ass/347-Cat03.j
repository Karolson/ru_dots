function Trig_Cat03_Conditions takes nothing returns boolean
    return GetUnitAbilityLevel(GetSummonedUnit(), 'BUan') > 0
endfunction

function Trig_Cat03_Actions takes nothing returns nothing
    local unit u = GetSummonedUnit()
    local unit caster = GetSummoningUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A0BO')
    local real life = GetUnitState(u, UNIT_STATE_MAX_LIFE)
    call AbilityCoolDownResetion(caster, 'A0BO', 20 - 4 * level)
    call UnitAddAbility(u, 'A0WJ')
    call UnitAddMaxLife(u, R2I(life * 0.1 * level))
    set u = null
    set caster = null
endfunction

function InitTrig_Cat03 takes nothing returns nothing
endfunction