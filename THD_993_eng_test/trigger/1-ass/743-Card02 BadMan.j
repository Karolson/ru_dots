function Trig_Card02_BadMan_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A1FV'
endfunction

function Trig_Card02_BadMan_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    call SetCardAbility(caster, GetSpellAbilityId(), false)
    call SetUnitAnimation(caster, "attack")
    call UnitBuffTarget(caster, caster, 8, 'A139', 'B05L')
    if YDWEUnitHasItemOfTypeBJNull(caster, 'I032') then
        call UnitBuffTarget(caster, caster, 8, 'A0RQ', 'B05L')
    endif
    set caster = null
endfunction

function InitTrig_Card02_BadMan takes nothing returns nothing
    set gg_trg_Card02_BadMan = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Card02_BadMan, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(gg_trg_Card02_BadMan, Condition(function Trig_Card02_BadMan_Conditions))
    call TriggerAddAction(gg_trg_Card02_BadMan, function Trig_Card02_BadMan_Actions)
endfunction