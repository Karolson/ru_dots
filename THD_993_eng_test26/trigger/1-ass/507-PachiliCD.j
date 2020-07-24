function Trig_PachiliCD_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0XH'
endfunction

function Trig_PachiliCD_Clear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit target = LoadUnitHandle(udg_ht, task, 1)
    if GetUnitAbilityLevel(target, 'A0YM') == 1 then
        call UnitRemoveAbility(target, 'A0YM')
    elseif GetUnitAbilityLevel(target, 'A0YM') >= 2 then
        call SetUnitAbilityLevel(target, 'A0YM', GetUnitAbilityLevel(target, 'A0YM') - 1)
    endif
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    set caster = null
    set target = null
    set t = null
endfunction

function Trig_PachiliCD_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A0XH')
    local timer t
    local integer task
    call Public_PacQ_AbilityCoolDownRestore(caster, level, 'A0XH')
    if IsUnitAlly(GetSpellTargetUnit(), GetTriggerPlayer()) == false then
        if IsUnitType(GetSpellTargetUnit(), UNIT_TYPE_HERO) and udg_SK_BLTalismanicAvaliable[GetConvertedPlayerId(GetOwningPlayer(GetSpellTargetUnit()))] and IsUnitIllusionBJ(GetSpellTargetUnit()) == false then
            call Item_BLTalismanicRunningCD(GetSpellTargetUnit())
            set caster = null
            set target = null
            set t = null
            return
        endif
    endif
    call Public_PacQ_MagicDamage(caster, target, 45 + level * 45 + 2.0 * GetHeroInt(caster, true), 1)
    if GetUnitAbilityLevel(target, 'A0YM') == 0 then
        call UnitAddAbility(target, 'A0YM')
        call UnitMakeAbilityPermanent(target, true, 'A0YM')
    elseif GetUnitAbilityLevel(target, 'A0YM') >= 1 then
        call SetUnitAbilityLevel(target, 'A0YM', GetUnitAbilityLevel(target, 'A0YM') + 1)
    endif
    set t = CreateTimer()
    set task = GetHandleId(t)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, target)
    call TimerStart(t, 12.0, false, function Trig_PachiliCD_Clear)
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\Doom\\DoomDeath.mdl", GetUnitX(target), GetUnitY(target)))
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\StrongDrink\\BrewmasterMissile.mdl", GetUnitX(target), GetUnitY(target)))
    call DestroyEffect(AddSpecialEffectTarget("Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile.mdl", target, "chest"))
    set caster = null
    set target = null
    set t = null
endfunction

function InitTrig_PachiliCD takes nothing returns nothing
endfunction