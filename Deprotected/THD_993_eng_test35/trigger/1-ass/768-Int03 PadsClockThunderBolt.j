function Trig_Int03_PadsClockThunderBolt_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0QQ'
endfunction

function Trig_Int03_PadsClockThunderBolt_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    if IsUnitAlly(GetSpellTargetUnit(), GetTriggerPlayer()) == false then
        if IsUnitType(GetSpellTargetUnit(), UNIT_TYPE_HERO) and udg_SK_BLTalismanicAvaliable[GetConvertedPlayerId(GetOwningPlayer(GetSpellTargetUnit()))] and IsUnitIllusionBJ(GetSpellTargetUnit()) == false then
            call Item_BLTalismanicRunningCD(GetSpellTargetUnit())
            set caster = null
            set target = null
            return
        endif
    endif
    call UnitStunTarget(caster, target, 1.7, 0, 0)
    set caster = null
    set target = null
endfunction

function InitTrig_Int03_PadsClockThunderBolt takes nothing returns nothing
    set gg_trg_Int03_PadsClockThunderBolt = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Int03_PadsClockThunderBolt, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Int03_PadsClockThunderBolt, Condition(function Trig_Int03_PadsClockThunderBolt_Conditions))
    call TriggerAddAction(gg_trg_Int03_PadsClockThunderBolt, function Trig_Int03_PadsClockThunderBolt_Actions)
endfunction