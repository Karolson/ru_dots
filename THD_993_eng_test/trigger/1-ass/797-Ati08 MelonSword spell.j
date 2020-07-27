function Trig_Ati08_MelonSword_spell_Conditions takes nothing returns boolean
    if IsUnitIllusion(GetSpellTargetUnit()) then
        return false
    endif
    return GetSpellAbilityId() == 'A1B3'
endfunction

function Trig_Ati08_MelonSword_spell_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    if BlockingSpell(caster, target) == false then
        call UnitSlowTarget(caster, target, 10, 'A1B4', 0)
        call AddTimedEffectToUnit(target, 10, "Abilities\\Spells\\Undead\\FrostArmor\\FrostArmorDamage.mdl", "chest")
        call DummyCastTargetInstant_WW(caster, target, 'A1B1', 2, "faeriefire")
    endif
    set caster = null
    set target = null
endfunction

function InitTrig_Ati08_MelonSword_spell takes nothing returns nothing
    set gg_trg_Ati08_MelonSword_spell = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Ati08_MelonSword_spell, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Ati08_MelonSword_spell, Condition(function Trig_Ati08_MelonSword_spell_Conditions))
    call TriggerAddAction(gg_trg_Ati08_MelonSword_spell, function Trig_Ati08_MelonSword_spell_Actions)
endfunction