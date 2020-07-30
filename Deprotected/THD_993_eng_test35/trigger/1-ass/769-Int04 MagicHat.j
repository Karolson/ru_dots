function Trig_Int04_MagicHat_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0QR'
endfunction

function Trig_Int04_MagicHat_Actions takes nothing returns nothing
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
    call UnitDebuffTarget(caster, target, 4.0, 1, true, 'A1BC', 1, 'BUsl', "sleep", 0, "")
    call CCSystem_textshow("Sleep", target, DebuffDuration(target, 4.0))
    set caster = null
    set target = null
endfunction

function InitTrig_Int04_MagicHat takes nothing returns nothing
    set gg_trg_Int04_MagicHat = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Int04_MagicHat, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Int04_MagicHat, Condition(function Trig_Int04_MagicHat_Conditions))
    call TriggerAddAction(gg_trg_Int04_MagicHat, function Trig_Int04_MagicHat_Actions)
endfunction