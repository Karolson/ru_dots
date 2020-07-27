function Trig_Momizi03_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0QO'
endfunction

function Trig_Momizi03_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local unit w
    local integer level = GetUnitAbilityLevel(caster, 'A0QO')
    call AbilityCoolDownResetion(caster, 'A0QO', 10)
    if IsUnitAlly(GetSpellTargetUnit(), GetTriggerPlayer()) == false then
        if IsUnitType(GetSpellTargetUnit(), UNIT_TYPE_HERO) and udg_SK_BLTalismanicAvaliable[GetConvertedPlayerId(GetOwningPlayer(GetSpellTargetUnit()))] and IsUnitIllusionBJ(GetSpellTargetUnit()) == false then
            call Item_BLTalismanicRunningCD(GetSpellTargetUnit())
            set caster = null
            set target = null
            set w = null
            return
        endif
    endif
    call UnitPhysicalDamageTarget(caster, target, level * 10 + GetHeroInt(caster, true) * 4.0)
    call UnitStunTarget(caster, target, 1.75 + level * 0.25, 0, 0)
    call IssueTargetOrder(caster, "attack", target)
    set caster = null
    set target = null
    set w = null
endfunction

function InitTrig_Momizi03 takes nothing returns nothing
endfunction