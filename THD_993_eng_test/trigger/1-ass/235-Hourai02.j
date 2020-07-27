function Trig_Hourai02_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0HC'
endfunction

function Trig_Hourai02_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    if GetTriggerEventId() == EVENT_PLAYER_UNIT_SPELL_EFFECT then
        call UnitAddAbility(caster, 'A0HB')
        if GetUnitTypeId(caster) == 'h01F' then
            call UnitRemoveAbility(caster, 'Agho')
            call UnitAddAbility(caster, 'Aeth')
        endif
    else
        call UnitRemoveAbility(caster, 'A0HB')
        if GetUnitTypeId(caster) == 'h01F' then
            call UnitRemoveAbility(caster, 'Aeth')
            call UnitAddAbility(caster, 'Agho')
        endif
    endif
    set caster = null
endfunction

function InitTrig_Hourai02 takes nothing returns nothing
endfunction