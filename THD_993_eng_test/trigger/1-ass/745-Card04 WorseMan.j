function Trig_Card04_WorseMan_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A1FY'
endfunction

function Trig_Card04_WorseMan_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    call SetCardAbility(caster, GetSpellAbilityId(), false)
    call SetUnitAnimation(caster, "attack")
    if IsUnitAlly(GetSpellTargetUnit(), GetTriggerPlayer()) == false then
        if IsUnitType(GetSpellTargetUnit(), UNIT_TYPE_HERO) and udg_SK_BLTalismanicAvaliable[GetConvertedPlayerId(GetOwningPlayer(GetSpellTargetUnit()))] and IsUnitIllusionBJ(GetSpellTargetUnit()) == false then
            call Item_BLTalismanicRunningCD(GetSpellTargetUnit())
            set caster = null
            set target = null
            return
        endif
    endif
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Undead\\AnimateDead\\AnimateDeadTarget.mdl", GetUnitX(target), GetUnitY(target)))
    if GetUnitAbilityLevel(target, 'A19H') == 0 then
        if YDWEUnitHasItemOfTypeBJNull(caster, 'I032') == false then
            call UnitAbsDamageTarget(caster, target, 70 + GetHeroLevel(caster) * 7)
            call SetUnitState(target, UNIT_STATE_MANA, GetUnitState(target, UNIT_STATE_MANA) - (70 + GetHeroLevel(caster) * 7.0))
            call SetUnitState(caster, UNIT_STATE_MANA, GetUnitState(caster, UNIT_STATE_MANA) + (70 + GetHeroLevel(caster) * 7.0))
        else
            call UnitAbsDamageTarget(caster, target, 1.3 * (70 + GetHeroLevel(caster) * 7))
            call SetUnitState(target, UNIT_STATE_MANA, GetUnitState(target, UNIT_STATE_MANA) - 1.3 * (70 + GetHeroLevel(caster) * 7.0))
            call SetUnitState(caster, UNIT_STATE_MANA, GetUnitState(caster, UNIT_STATE_MANA) + 1.3 * (70 + GetHeroLevel(caster) * 7.0))
        endif
    else
        if YDWEUnitHasItemOfTypeBJNull(caster, 'I032') == false then
            call UnitAbsDamageTarget(caster, target, 0.5 * (70 + GetHeroLevel(caster) * 7))
            call SetUnitState(target, UNIT_STATE_MANA, GetUnitState(target, UNIT_STATE_MANA) - 0.5 * (70 + GetHeroLevel(caster) * 7.0))
            call SetUnitState(caster, UNIT_STATE_MANA, GetUnitState(caster, UNIT_STATE_MANA) + 0.5 * (70 + GetHeroLevel(caster) * 7.0))
        else
            call UnitAbsDamageTarget(caster, target, 0.65 * (70 + GetHeroLevel(caster) * 7))
            call SetUnitState(target, UNIT_STATE_MANA, GetUnitState(target, UNIT_STATE_MANA) - 0.65 * (70 + GetHeroLevel(caster) * 7.0))
            call SetUnitState(caster, UNIT_STATE_MANA, GetUnitState(caster, UNIT_STATE_MANA) + 0.65 * (70 + GetHeroLevel(caster) * 7.0))
        endif
    endif
    call UnitBuffTarget(caster, target, 20, 'A19H', 0)
    set caster = null
    set target = null
endfunction

function InitTrig_Card04_WorseMan takes nothing returns nothing
    set gg_trg_Card04_WorseMan = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Card04_WorseMan, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(gg_trg_Card04_WorseMan, Condition(function Trig_Card04_WorseMan_Conditions))
    call TriggerAddAction(gg_trg_Card04_WorseMan, function Trig_Card04_WorseMan_Actions)
endfunction