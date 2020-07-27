function Trig_Satsuki_Attack_Conditions takes nothing returns boolean
    if GetUnitAbilityLevel(GetEventDamageSource(), 'A1H5') == 0 and GetUnitAbilityLevel(GetEventDamageSource(), 'A1I8') == 0 then
        return false
    elseif GetEventDamage() == 0.0 then
        return false
    elseif IsUnitAlly(GetEventDamageSource(), GetOwningPlayer(GetTriggerUnit())) then
        return false
    elseif IsUnitType(GetTriggerUnit(), UNIT_TYPE_STRUCTURE) then
        return false
    elseif IsUnitIllusion(GetEventDamageSource()) then
        return false
    endif
    return true
endfunction

function Trig_Satsuki_Attack_Actions takes nothing returns nothing
    local unit caster = GetEventDamageSource()
    local unit target = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A1H5')
    if GetUnitAbilityLevel(target, 'A1H6') != 0 or GetUnitAbilityLevel(caster, 'A1HE') != 0 then
        call UnitBuffTarget(caster, caster, 1.5, 'A1HG' + level, 'B0A4')
    endif
    if GetUnitAbilityLevel(caster, 'A1I8') != 0 then
        call UnitAbsDamageTarget(caster, target, 50 + GetHeroLevel(caster) * 5)
        call UnitRemoveAbility(caster, 'A1I8')
    endif
    set caster = null
    set target = null
endfunction

function InitTrig_Satsuki_Attack takes nothing returns nothing
    set gg_trg_Satsuki_Attack = CreateTrigger()
    call TriggerAddCondition(gg_trg_Satsuki_Attack, Condition(function Trig_Satsuki_Attack_Conditions))
    call TriggerAddAction(gg_trg_Satsuki_Attack, function Trig_Satsuki_Attack_Actions)
endfunction