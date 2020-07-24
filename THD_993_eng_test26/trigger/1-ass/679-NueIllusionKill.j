function Trig_NueIllusionKill_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0LZ'
endfunction

function Trig_NueIllusionKill_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local effect e
    local real nmdamage = NueDamageCounting(caster) * 2.0
    local real abilitycooldownlv01 = 13
    if YDWEUnitHasItemOfTypeBJNull(caster, 'I00B') then
        call Item_KeineAbilityCoolDownReset(caster, GetSpellAbilityId(), abilitycooldownlv01)
    endif
    if IsUnitAlly(GetSpellTargetUnit(), GetTriggerPlayer()) == false then
        if IsUnitType(GetSpellTargetUnit(), UNIT_TYPE_HERO) and udg_SK_BLTalismanicAvaliable[GetConvertedPlayerId(GetOwningPlayer(GetSpellTargetUnit()))] and IsUnitIllusionBJ(GetSpellTargetUnit()) == false then
            call Item_BLTalismanicRunningCD(GetSpellTargetUnit())
            set caster = null
            set target = null
            set e = null
            return
        endif
    endif
    set e = AddSpecialEffectTarget("Abilities\\Spells\\Human\\ControlMagic\\ControlMagicTarget.mdl", target, "overhead")
    call DestroyEffect(e)
    if IsUnitIllusion(target) then
        call UnitMagicDamageTarget(caster, target, 400 + GetUnitAttack(caster) * 2.0 + GetHeroInt(caster, true) * 2.0 + nmdamage, 2)
    else
        call UnitMagicDamageTarget(caster, target, 40 + GetUnitAttack(caster) * 0.2 + GetHeroInt(caster, true) * 0.2 + nmdamage, 2)
    endif
    set caster = null
    set target = null
    set e = null
endfunction

function InitTrig_NueIllusionKill takes nothing returns nothing
endfunction