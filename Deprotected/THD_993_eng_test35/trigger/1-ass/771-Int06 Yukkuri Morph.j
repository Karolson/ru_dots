function Trig_Int06_Yukkuri_Morph_Conditions takes nothing returns boolean
    if GetSpellAbilityId() != 'A0G4' then
        return false
    elseif GetCustomState(GetSpellTargetUnit(), 6) != 0 then
        return false
    elseif IsUnitAntiDebuff(GetSpellTargetUnit()) then
        return false
    elseif GetUnitAbilityLevel(GetSpellTargetUnit(), 'B02O') >= 1 then
        return false
    endif
    return true
endfunction

function Trig_Int06_Yukkuri_Morph_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local real tx = GetUnitX(target)
    local real ty = GetUnitY(target)
    if IsUnitAlly(GetSpellTargetUnit(), GetTriggerPlayer()) == false then
        if IsUnitType(GetSpellTargetUnit(), UNIT_TYPE_HERO) and udg_SK_BLTalismanicAvaliable[GetConvertedPlayerId(GetOwningPlayer(GetSpellTargetUnit()))] and IsUnitIllusionBJ(GetSpellTargetUnit()) == false then
            call Item_BLTalismanicRunningCD(GetSpellTargetUnit())
            set caster = null
            set target = null
            return
        endif
    endif
    call PreMorphReset(target)
    call UnitDebuffTarget(caster, target, 3.0, 1, true, 'A01K', 1, 'B00N', "polymorph", 0, "")
    call CCSystem_textshow("Hex", target, DebuffDuration(target, 3.0))
    set caster = null
    set target = null
endfunction

function InitTrig_Int06_Yukkuri_Morph takes nothing returns nothing
    set gg_trg_Int06_Yukkuri_Morph = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Int06_Yukkuri_Morph, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Int06_Yukkuri_Morph, Condition(function Trig_Int06_Yukkuri_Morph_Conditions))
    call TriggerAddAction(gg_trg_Int06_Yukkuri_Morph, function Trig_Int06_Yukkuri_Morph_Actions)
endfunction