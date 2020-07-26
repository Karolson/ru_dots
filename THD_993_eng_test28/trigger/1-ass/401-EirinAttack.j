function Trig_EirinAttack_Conditions takes nothing returns boolean
    if GetUnitAbilityLevel(GetEventDamageSource(), 'A0OU') == 0 then
        return false
    endif
    if IsUnitAlly(GetTriggerUnit(), GetOwningPlayer(GetEventDamageSource())) then
        return false
    endif
    if IsUnitIllusion(GetEventDamageSource()) then
        return false
    endif
    if GetEventDamage() == 0 then
        return false
    endif
    if IsDamageNotUnitAttack(GetEventDamageSource()) then
        return false
    endif
    return true
endfunction

function Trig_EirinAttack_Actions takes nothing returns nothing
    local unit caster = GetEventDamageSource()
    local unit target = GetTriggerUnit()
    local real damage = GetHeroInt(caster, true) * 0.3
    if udg_SK_EirinD then
        call UnitMagicDamageArea(caster, GetUnitX(target), GetUnitY(target), 300, damage * 3, 6)
    else
        call UnitMagicDamageTarget(caster, target, damage, 6)
    endif
    set caster = null
    set target = null
endfunction

function InitTrig_EirinAttack takes nothing returns nothing
endfunction