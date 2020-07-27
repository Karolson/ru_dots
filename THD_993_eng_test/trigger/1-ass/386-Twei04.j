function Trig_Twei04_Conditions takes nothing returns boolean
    if GetUnitAbilityLevel(udg_SK_Twei04_Twei, 'A0N5') == 0 then
        return false
    endif
    if GetEventDamage() <= 10.0 then
        return false
    endif
    return GetRandomInt(0, 100) <= 40
endfunction

function Trig_Twei04_Actions takes nothing returns nothing
    local unit caster = GetEventDamageSource()
    local unit target = GetTriggerUnit()
    local unit casterhero = GetPlayerCharacter(GetOwningPlayer(caster))
    local integer level = GetUnitAbilityLevel(udg_SK_Twei04_Twei, 'A0N5')
    local real damage = GetEventDamage() * 0.133 * level
    local unit u
    if GetUnitAbilityLevel(casterhero, 'B058') >= 1 then
        call UnitDelDamageTarget(caster, target, damage)
        call DebugMsg("ExtraDamage:" + R2S(damage))
    endif
    if GetUnitAbilityLevel(target, 'B058') >= 1 then
        if GetEventDamage() < GetUnitState(target, UNIT_STATE_LIFE) then
            call SetUnitState(target, UNIT_STATE_LIFE, GetUnitState(target, UNIT_STATE_LIFE) + damage)
            call DebugMsg("Healing:" + R2S(damage))
        else
            call DebugMsg("Healing:DeathFail")
        endif
    endif
    set caster = null
    set target = null
    set casterhero = null
    set u = null
endfunction

function InitTrig_Twei04 takes nothing returns nothing
endfunction