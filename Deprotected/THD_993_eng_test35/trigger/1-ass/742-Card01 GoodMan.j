function Trig_Card01_GoodMan_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A1FU'
endfunction

function Trig_Card01_GoodMan_Actions takes nothing returns nothing
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
    if udg_NewDebuffSys then
        call UnitSlowTargetNew(caster, target, 45, 4, 3, 0)
        if YDWEUnitHasItemOfTypeBJNull(caster, 'I032') then
            call UnitSlowTargetNew(caster, target, 45, 4 * 1.3, 3, 0)
        endif
    else
        call UnitSlowTarget(caster, target, 4, 'A137', 'B007')
        if YDWEUnitHasItemOfTypeBJNull(caster, 'I032') then
            call UnitSlowTarget(caster, target, 4 * 1.3, 'A137', 'B007')
        endif
    endif
    set caster = null
    set target = null
endfunction

function InitTrig_Card01_GoodMan takes nothing returns nothing
    set gg_trg_Card01_GoodMan = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Card01_GoodMan, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(gg_trg_Card01_GoodMan, Condition(function Trig_Card01_GoodMan_Conditions))
    call TriggerAddAction(gg_trg_Card01_GoodMan, function Trig_Card01_GoodMan_Actions)
endfunction