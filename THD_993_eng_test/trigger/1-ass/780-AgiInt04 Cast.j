function Trig_AgiInt04_Cast_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A156'
endfunction

function Trig_AgiInt04_Cast_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    call UnitBuffTarget(caster, caster, 4.0, 'A0YQ', 0)
    call UnitMakeAbilityPermanent(caster, true, 'A0YQ')
    call UnitMakeAbilityPermanent(caster, true, 'A155')
    set caster = null
endfunction

function InitTrig_AgiInt04_Cast takes nothing returns nothing
    set gg_trg_AgiInt04_Cast = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_AgiInt04_Cast, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_AgiInt04_Cast, Condition(function Trig_AgiInt04_Cast_Conditions))
    call TriggerAddAction(gg_trg_AgiInt04_Cast, function Trig_AgiInt04_Cast_Actions)
endfunction