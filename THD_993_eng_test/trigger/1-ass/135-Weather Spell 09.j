function Trig_Weather_Spell_09_Actions takes nothing returns nothing
    call SetUnitState(GetTriggerUnit(), UNIT_STATE_LIFE, GetUnitState(GetTriggerUnit(), UNIT_STATE_LIFE) - 0.08 * GetUnitState(GetTriggerUnit(), UNIT_STATE_LIFE))
endfunction

function InitTrig_Weather_Spell_09 takes nothing returns nothing
    set gg_trg_Weather_Spell_09 = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Weather_Spell_09, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddAction(gg_trg_Weather_Spell_09, function Trig_Weather_Spell_09_Actions)
    call DisableTrigger(gg_trg_Weather_Spell_09)
endfunction