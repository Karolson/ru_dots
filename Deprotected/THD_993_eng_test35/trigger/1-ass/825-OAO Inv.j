function Trig_OAO_Inv_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    if GetSpellAbilityId() == 'A02W' then
        call UnitBuffTarget(caster, caster, 2, 'A1BG', 0)
    endif
    set caster = null
endfunction

function InitTrig_OAO_Inv takes nothing returns nothing
    set gg_trg_OAO_Inv = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_OAO_Inv, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddAction(gg_trg_OAO_Inv, function Trig_OAO_Inv_Actions)
endfunction