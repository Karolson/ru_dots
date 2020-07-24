function MEDI03 takes nothing returns integer
    return 'A0FO'
endfunction

function MEDI03_BUFF_DURATION takes nothing returns real
    return 6.0
endfunction

function MEDI03_ACTIVE takes nothing returns integer
    return 'A0FM'
endfunction

function MEDI03_BUFF takes nothing returns integer
    return 'B07K'
endfunction

function Trig_Medi03_Conditions takes nothing returns boolean
    if GetTriggerEventId() == EVENT_UNIT_SPELL_EFFECT then
        return GetSpellAbilityId() == 'A0FO'
    elseif GetUnitAbilityLevel(GetTriggerUnit(), 'A0FO') == 0 then
        return false
    elseif IsUnitType(GetEventDamageSource(), UNIT_TYPE_STRUCTURE) then
        return false
    elseif IsUnitAlly(GetTriggerUnit(), GetOwningPlayer(GetEventDamageSource())) then
        return false
    elseif GetEventDamage() == 0 then
        return false
    elseif IsDamageNotUnitAttack(GetEventDamageSource()) then
        return false
    endif
    return IsUnitInRange(GetTriggerUnit(), GetEventDamageSource(), 250.0)
endfunction

function Trig_Medi03_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target
    local integer level = GetUnitAbilityLevel(caster, 'A0FO')
    local real damage
    if GetTriggerEventId() == EVENT_UNIT_SPELL_EFFECT then
        call UnitBuffTarget(caster, caster, 6.0, 'A0FM', 'B07K')
        call DMG_DamageReduce(caster, 1 - (level * 0.05 + 0.15), 6.0, "All")
    else
        set target = GetEventDamageSource()
        set damage = 3.0 + 7.0 * level + GetUnitAttack(target) * 0.25
        if GetUnitAbilityLevel(caster, 'B07K') > 0 then
            set damage = damage * 2.0
        endif
        call UnitMagicDamageTarget(caster, target, damage, 2)
    endif
    set caster = null
    set target = null
endfunction

function InitTrig_Medi03 takes nothing returns nothing
endfunction