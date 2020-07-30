function Trig_Cirno02_Conditions takes nothing returns boolean
    local integer level = GetUnitAbilityLevel(GetEventDamageSource(), 'A03X')
    if level == 0 then
        return false
    elseif GetUnitAbilityLevel(GetEventDamageSource(), 'A03W') == 0 then
        return false
    elseif IsUnitType(GetTriggerUnit(), UNIT_TYPE_STRUCTURE) then
        return false
    elseif IsUnitAlly(GetTriggerUnit(), GetOwningPlayer(GetEventDamageSource())) then
        return false
    elseif GetEventDamage() == 0 then
        return false
    elseif IsDamageNotUnitAttack(GetEventDamageSource()) then
        return false
    elseif udg_SK_Cirno02_Count < 7 - level then
        set udg_SK_Cirno02_Count = udg_SK_Cirno02_Count + 1
        if GetUnitAbilityLevel(GetTriggerUnit(), 'A04J') >= 1 then
            set udg_SK_Cirno02_Count = udg_SK_Cirno02_Count + 1
        endif
        return false
    else
        set udg_SK_Cirno02_Count = 0
        return true
    endif
    return false
endfunction

function Trig_Cirno02_Actions takes nothing returns nothing
    local unit caster = GetEventDamageSource()
    local unit target = GetTriggerUnit()
    call Trig_Cirno01_IceNova(caster, target)
    set caster = null
    set target = null
endfunction

function InitTrig_Cirno02 takes nothing returns nothing
endfunction