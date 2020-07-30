function Trig_Merlin04_Damage_Conditions takes nothing returns boolean
    if udg_SK_Merlin04_Target == null then
        return false
    endif
    if IsUnitType(udg_SK_Merlin04_Target, UNIT_TYPE_DEAD) then
        return false
    endif
    if IsUnitType(GetPlayerCharacter(GetOwningPlayer(GetEventDamageSource())), UNIT_TYPE_HERO) == false then
        return false
    endif
    if IsDamageADamage(GetEventDamageSource()) then
        return true
    endif
    return false
endfunction

function Trig_Merlin04_Damage_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = udg_SK_Merlin04_Target
    local integer level = GetUnitAbilityLevel(caster, 'A0RY')
    local real damage = GetEventDamage() * (0.9 + 0.3 * level)
    call UnitMagicDamageTarget(caster, target, damage, 2)
    set caster = null
    set target = null
endfunction

function InitTrig_Merlin04_Damage takes nothing returns nothing
endfunction