function Trig_SakuyaAttack_Conditions takes nothing returns boolean
    if GetUnitAbilityLevel(GetEventDamageSource(), 'A1IB') == 0 then
        return false
    elseif IsUnitAlly(GetTriggerUnit(), GetOwningPlayer(GetEventDamageSource())) then
        return false
    elseif GetEventDamage() == 0 then
        return false
    elseif IsDamageNotUnitAttack(GetEventDamageSource()) then
        return false
    endif
    return IsUnitType(GetTriggerUnit(), UNIT_TYPE_HERO)
endfunction

function Trig_SakuyaAttack_Actions takes nothing returns nothing
    call UnitManaingTarget(GetEventDamageSource(), GetEventDamageSource(), ABCIAllAtk(GetEventDamageSource(), 0, 0.16))
endfunction

function InitTrig_SakuyaAttack takes nothing returns nothing
endfunction