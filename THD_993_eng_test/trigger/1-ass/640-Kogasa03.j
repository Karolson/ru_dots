function Trig_Kogasa03_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0C8'
endfunction

function Trig_Kogasa03_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A0C8')
    call AbilityCoolDownResetion(caster, 'A0C8', 50 - 10 * level)
    call PauseUnit(caster, true)
    call SetUnitInvulnerable(caster, true)
    call SetUnitAnimation(caster, "spell")
    call TriggerSleepAction(1.0)
    call SetUnitAnimation(caster, "stand")
    call SetUnitInvulnerable(caster, false)
    call PauseUnit(caster, false)
    set caster = null
endfunction

function InitTrig_Kogasa03 takes nothing returns nothing
endfunction