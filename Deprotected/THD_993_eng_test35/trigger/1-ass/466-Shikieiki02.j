function Trig_Shikieiki02_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0I4'
endfunction

function Trig_Shikieiki02_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local unit w
    local integer level = GetUnitAbilityLevel(caster, 'A0I4')
    local integer degree = GetUnitAbilityLevel(target, 'A0B0')
    local real s
    call AbilityCoolDownResetion(caster, 'A0I4', 19 - 2 * level)
    if IsUnitAlly(GetSpellTargetUnit(), GetTriggerPlayer()) == false then
        if IsUnitType(GetSpellTargetUnit(), UNIT_TYPE_HERO) and udg_SK_BLTalismanicAvaliable[GetConvertedPlayerId(GetOwningPlayer(GetSpellTargetUnit()))] and IsUnitIllusionBJ(GetSpellTargetUnit()) == false then
            call Item_BLTalismanicRunningCD(GetSpellTargetUnit())
            set caster = null
            set target = null
            return
        endif
    endif
    if IsUnitAlly(target, GetOwningPlayer(caster)) then
        call UnitHealingTarget(caster, target, 50.0 + 50.0 * level + GetHeroInt(caster, true) * 1.3)
    endif
    if degree > 0 then
        set s = (0.12 + 0.06 * degree) * GetUnitState(target, UNIT_STATE_MAX_LIFE)
        call UnitStunTarget(caster, target, 0.8 + level * 0.3, 0, 0)
        call UnitAbsDamageTarget(caster, target, s)
        if IsUnitType(target, UNIT_TYPE_HERO) then
            call Trig_Shikieiki01_Debuff_Clear(caster, target)
        endif
    endif
    set caster = null
    set target = null
    set w = null
endfunction

function InitTrig_Shikieiki02 takes nothing returns nothing
endfunction