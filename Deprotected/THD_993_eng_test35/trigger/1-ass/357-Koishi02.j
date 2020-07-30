function KOISHI02 takes nothing returns integer
    return 'A0GJ'
endfunction

function Koishi02_Conditions takes nothing returns boolean
    local unit caster = GetEventDamageSource()
    local unit target = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A0ZB')
    local real decene = GetEventDamage() * (0.1 + 0.05 * level)
    local real damage
    if GetEventDamage() > 1.0 and level >= 1 and IsDamageNotUnitAttack(GetEventDamageSource()) == false and GetUnitState(target, UNIT_STATE_MAX_MANA) > 10 then
        if GetUnitState(target, UNIT_STATE_MANA) > decene then
            call SetUnitState(target, UNIT_STATE_MANA, GetUnitState(target, UNIT_STATE_MANA) - decene)
        else
            set damage = decene - GetUnitState(target, UNIT_STATE_MANA)
            call SetUnitState(target, UNIT_STATE_MANA, 0)
            call UnitPhysicalDamageTarget(caster, target, damage)
        endif
    endif
    set caster = null
    set target = null
    return false
endfunction

function InitTrig_Koishi02 takes nothing returns nothing
endfunction