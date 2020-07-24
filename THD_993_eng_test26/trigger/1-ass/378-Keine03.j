function Trig_Keine_03_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0M7'
endfunction

function Trig_Keine_03_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local unit u
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real tx = GetUnitX(target)
    local real ty = GetUnitY(target)
    local real a = Atan2(ty - oy, tx - ox)
    local real px = tx - 90 * Cos(a)
    local real py = ty - 90 * Sin(a)
    local integer level = GetUnitAbilityLevel(caster, 'A0M7')
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 8)
    if IsUnitAlly(GetSpellTargetUnit(), GetTriggerPlayer()) == false then
        if IsUnitType(GetSpellTargetUnit(), UNIT_TYPE_HERO) and udg_SK_BLTalismanicAvaliable[GetConvertedPlayerId(GetOwningPlayer(GetSpellTargetUnit()))] and IsUnitIllusionBJ(GetSpellTargetUnit()) == false then
            call Item_BLTalismanicRunningCD(GetSpellTargetUnit())
            set caster = null
            set target = null
            set u = null
            return
        endif
    endif
    if GetUnitAbilityLevel(caster, 'A0V4') == 1 or GetUnitAbilityLevel(caster, 'A0A1') == 1 then
        set caster = null
        set target = null
        set u = null
        return
    endif
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\NightElf\\Blink\\BlinkTarget.mdl", ox, oy))
    call IssueTargetOrderById(caster, 851983, target)
    call SetUnitAnimation(caster, "attack slam")
    call SetUnitXY(caster, px, py)
    call UnitBuffTarget(caster, caster, 0.5, 'A0VZ', 0)
    call UnitPhysicalDamageTarget(caster, target, 0.5 * (GetUnitAttack(caster) + 10 + level * 40 + ABCIExtraInt(caster, 0, 1.0)))
    call UnitPhysicalDamageTarget(caster, target, 0.5 * (GetUnitAttack(caster) + 10 + level * 40 + ABCIExtraInt(caster, 0, 1.0)))
    call UnitStunTarget(caster, target, 0.8 + 0.1 * level, 0, 0)
    set caster = null
    set target = null
    set u = null
endfunction

function InitTrig_Keine03 takes nothing returns nothing
endfunction