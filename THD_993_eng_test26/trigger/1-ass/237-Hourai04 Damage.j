function Trig_Hourai04_Damage_Conditions takes nothing returns boolean
    if GetEventDamage() != 0.0 then
        return false
    endif
    if GetUnitAbilityLevel(GetEventDamageSource(), 'A0H1') >= 1 then
        return true
    endif
    return false
endfunction

function Trig_Hourai04_Damage_Actions takes nothing returns nothing
    local unit caster = GetPlayerCharacter(GetOwningPlayer(GetEventDamageSource()))
    local unit target = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(GetEventDamageSource(), 'A0H1')
    local real damage = 32 + level * 6 + GetHeroInt(GetCharacterHandle('H01A'), true) * 0.3
    if GetUnitAbilityLevel(target, 'BCbf') >= 1 then
        call UnitMagicDamageTarget(caster, target, damage, 5)
        call UnitRemoveAbility(target, 'BCbf')
    endif
    set caster = null
    set target = null
endfunction

function InitTrig_Hourai04_Damage takes nothing returns nothing
endfunction