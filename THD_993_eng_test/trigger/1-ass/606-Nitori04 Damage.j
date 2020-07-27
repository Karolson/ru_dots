function Trig_Nitori04_Damage_Conditions takes nothing returns boolean
    return GetUnitAbilityLevel(GetEventDamageSource(), 'A0OE') >= 1
endfunction

function Trig_Nitori04_Damage_Actions takes nothing returns nothing
    local unit caster = GetPlayerCharacter(GetOwningPlayer(GetEventDamageSource()))
    local unit target = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(GetEventDamageSource(), 'A0OE')
    local real damage = 40 + 0.2 * udg_Nitori_RealInt
    call UnitMagicDamageTarget(caster, target, damage, 6)
    set caster = null
    set target = null
endfunction

function InitTrig_Nitori04_Damage takes nothing returns nothing
endfunction