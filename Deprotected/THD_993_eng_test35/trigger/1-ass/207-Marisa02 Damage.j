function Trig_Marisa02_Damage_Conditions takes nothing returns boolean
    if GetEventDamage() != 0.0 then
        return false
    endif
    if GetUnitAbilityLevel(GetEventDamageSource(), 'A043') >= 1 then
        return true
    endif
    if GetUnitAbilityLevel(GetEventDamageSource(), 'A044') >= 1 then
        return true
    endif
    if GetUnitAbilityLevel(GetEventDamageSource(), 'A045') >= 1 then
        return true
    endif
    return false
endfunction

function Trig_Marisa02_Damage_Actions takes nothing returns nothing
    local unit caster = GetPlayerCharacter(GetOwningPlayer(GetEventDamageSource()))
    local unit target = GetTriggerUnit()
    local integer level01 = GetUnitAbilityLevel(GetEventDamageSource(), 'A043')
    local integer level02 = GetUnitAbilityLevel(GetEventDamageSource(), 'A044')
    local integer level03 = GetUnitAbilityLevel(GetEventDamageSource(), 'A045')
    local real damage = 0
    call DisableTrigger(gg_trg_Marisa02_Damage)
    if level01 >= 1 then
        set damage = ABCIAllInt(caster, level01 * 45, 1.6) * 0.33
    endif
    if level02 >= 1 then
        set damage = ABCIAllInt(caster, level02 * 45, 1.6) * 0.33
    endif
    if level03 >= 1 then
        if GetUnitAbilityLevel(target, 'B00O') >= 1 then
            if IsUnitType(target, UNIT_TYPE_STRUCTURE) == false then
                set damage = ABCIAllInt(caster, 5 + level03 * 10, 0.35)
            else
                set damage = ABCIAllInt(caster, 5 + level03 * 10, 0.35) * 0.5
            endif
            call UnitRemoveAbility(target, 'B00O')
        endif
    endif
    call DebugMsg(R2S(damage))
    call UnitMagicDamageTarget(caster, target, damage, 5)
    set caster = null
    set target = null
    call EnableTrigger(gg_trg_Marisa02_Damage)
endfunction

function InitTrig_Marisa02_Damage takes nothing returns nothing
endfunction