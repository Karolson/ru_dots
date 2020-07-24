function Trig_Cirno03_Conditions takes nothing returns boolean
    local integer level = GetUnitAbilityLevel(GetTriggerUnit(), 'A056')
    if level == 0 then
        return false
    elseif IsUnitType(GetEventDamageSource(), UNIT_TYPE_STRUCTURE) then
        return false
    elseif IsUnitAlly(GetTriggerUnit(), GetOwningPlayer(GetEventDamageSource())) then
        return false
    elseif GetEventDamage() == 0 then
        return false
    elseif IsDamageNotUnitAttack(GetEventDamageSource()) then
        return false
    elseif udg_SK_Cirno03_Count < 8 - level then
        set udg_SK_Cirno03_Count = udg_SK_Cirno03_Count + 1
        if GetUnitAbilityLevel(GetTriggerUnit(), 'A058') >= 1 then
            set udg_SK_Cirno03_Count = udg_SK_Cirno03_Count + 1
        endif
        return false
    else
        set udg_SK_Cirno03_Count = 0
        return true
    endif
    return false
endfunction

function Trig_Cirno03_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetEventDamageSource()
    call Trig_Cirno01_IceNova(caster, target)
    set caster = null
    set target = null
endfunction

function InitTrig_Cirno03 takes nothing returns nothing
endfunction