function Trig_IntStr02_Heal_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A14V'
endfunction

function Trig_IntStr02_Heal_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    call UnitHealingTarget(caster, GetSpellTargetUnit(), 180 + IMaxBJ(GetHeroStr(caster, true), IMaxBJ(GetHeroAgi(caster, true), GetHeroInt(caster, true))) * 2.0)
    set caster = null
endfunction

function InitTrig_IntStr02_Heal takes nothing returns nothing
    set gg_trg_IntStr02_Heal = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_IntStr02_Heal, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_IntStr02_Heal, Condition(function Trig_IntStr02_Heal_Conditions))
    call TriggerAddAction(gg_trg_IntStr02_Heal, function Trig_IntStr02_Heal_Actions)
endfunction