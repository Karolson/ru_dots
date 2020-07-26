function Trig_Life01_GoldHand_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A177'
endfunction

function Trig_Life01_GoldHand_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local effect e = AddSpecialEffect("Abilities\\Spells\\Other\\Transmute\\GoldBottleMissile.mdl", GetUnitX(target), GetUnitY(target))
    call DestroyEffect(e)
    if IsUnitUngoldable(target) == false then
        call UnitDelDamageTarget(caster, target, 600 + 20 * GetHeroLevel(caster))
    else
        call UnitDelDamageTarget(caster, target, 200 + 8 * GetHeroLevel(caster))
    endif
    if IsUnitType(target, UNIT_TYPE_DEAD) then
        call THD_AddCredit(GetOwningPlayer(caster), 20)
    endif
    set caster = null
    set target = null
    set e = null
endfunction

function InitTrig_Life01_GoldHand takes nothing returns nothing
    set gg_trg_Life01_GoldHand = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Life01_GoldHand, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Life01_GoldHand, Condition(function Trig_Life01_GoldHand_Conditions))
    call TriggerAddAction(gg_trg_Life01_GoldHand, function Trig_Life01_GoldHand_Actions)
endfunction