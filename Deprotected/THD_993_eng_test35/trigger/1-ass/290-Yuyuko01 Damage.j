function Trig_Yuyuko01_Damage_Conditions takes nothing returns boolean
    if GetUnitTypeId(GetEventDamageSource()) != 'n04K' then
        return false
    endif
    return GetEventDamage() == 0.0
endfunction

function Trig_Yuyuko01_Damage_Actions takes nothing returns nothing
    local unit caster = GetPlayerCharacter(GetOwningPlayer(GetEventDamageSource()))
    local unit target = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A05D')
    call UnitMagicDamageTarget(caster, target, ABCIAllInt(caster, 50 + level * 50, 0.5), 5)
    set caster = null
    set target = null
endfunction

function InitTrig_Yuyuko01_Damage takes nothing returns nothing
endfunction