function Trig_Card03_LoveMan_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A1FX'
endfunction

function Trig_Card03_LoveMan_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local item ti = GetSpellTargetItem()
    call SetCardAbility(caster, GetSpellAbilityId(), false)
    call SetUnitAnimation(caster, "attack")
    if ti != null then
        set target = caster
    endif
    if GetUnitAbilityLevel(target, 'A19G') == 0 then
        if YDWEUnitHasItemOfTypeBJNull(caster, 'I032') == false then
            call UnitHealingTarget(caster, target, 150 + GetHeroLevel(caster) * 15)
        else
            call UnitHealingTarget(caster, target, 1.3 * (150 + GetHeroLevel(caster) * 15))
        endif
    else
        if YDWEUnitHasItemOfTypeBJNull(caster, 'I032') == false then
            call UnitHealingTarget(caster, target, 75 + GetHeroLevel(caster) * 7.5)
        else
            call UnitHealingTarget(caster, target, 1.3 * (75 + GetHeroLevel(caster) * 7.5))
        endif
    endif
    call UnitBuffTarget(caster, target, 20, 'A19G', 0)
    set caster = null
    set ti = null
    set target = null
endfunction

function InitTrig_Card03_LoveMan takes nothing returns nothing
    set gg_trg_Card03_LoveMan = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Card03_LoveMan, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(gg_trg_Card03_LoveMan, Condition(function Trig_Card03_LoveMan_Conditions))
    call TriggerAddAction(gg_trg_Card03_LoveMan, function Trig_Card03_LoveMan_Actions)
endfunction