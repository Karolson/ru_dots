function Trig_Reisen2ExAttacked_Conditions takes nothing returns boolean
    if GetUnitAbilityLevel(GetTriggerUnit(), 'A090') == 0 then
        return false
    elseif IsUnitAlly(GetTriggerUnit(), GetOwningPlayer(GetEventDamageSource())) then
        return false
    elseif IsUnitIllusion(GetEventDamageSource()) then
        return false
    elseif GetEventDamage() == 0 then
        return false
    elseif IsDamageNotUnitAttack(GetEventDamageSource()) then
        return false
    endif
    return true
endfunction

function Trig_Reisen2ExAttacked_Actions takes nothing returns nothing
    set udg_SK_Reisen2Ex_Time = udg_SK_Reisen2Ex_Time + 1.0
endfunction

function InitTrig_Reisen2ExAttacked takes nothing returns nothing
endfunction