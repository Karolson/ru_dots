function Trig_Keine_01_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0M5'
endfunction

function Trig_Keine_01_Kill takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit target = LoadUnitHandle(udg_ht, task, 1)
    local effect e = LoadEffectHandle(udg_ht, task, 2)
    if GetUnitState(target, UNIT_STATE_LIFE) > 0.0 then
        call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Human\\ManaFlare\\ManaFlareBoltImpact.mdl", target, "chest"))
        call UnitPhysicalDamageTarget(caster, target, 90)
    else
        call UnitManaingTarget(caster, caster, 50.0)
        call DestroyEffect(e)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set target = null
    set e = null
endfunction

function Trig_Keine_01_Clear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit target = LoadUnitHandle(udg_ht, task, 1)
    local effect e = LoadEffectHandle(udg_ht, task, 2)
    local real hp = LoadReal(udg_ht, task, 3)
    local integer style = LoadInteger(udg_ht, task, 4)
    call DestroyEffect(e)
    if style == 0 then
        call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Human\\ManaFlare\\ManaFlareBoltImpact.mdl", target, "chest"))
        call UnitHealingTarget(caster, target, hp - GetUnitState(target, UNIT_STATE_LIFE))
    else
        if GetUnitState(target, UNIT_STATE_LIFE) - hp >= 0.0 then
            call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Human\\ManaFlare\\ManaFlareBoltImpact.mdl", target, "chest"))
            call UnitHealingTarget(caster, target, (GetUnitState(target, UNIT_STATE_LIFE) - hp) * 0.5)
        else
            call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Human\\ManaFlare\\ManaFlareBoltImpact.mdl", target, "chest"))
            call UnitAbsDamageTarget(caster, target, (hp - GetUnitState(target, UNIT_STATE_LIFE)) * 0.5)
        endif
    endif
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    set t = null
    set caster = null
    set target = null
    set e = null
endfunction

function Trig_Keine_01_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local effect e
    local timer t
    local integer task
    local real hp
    local integer style
    local integer level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 32 - 4 * level)
    if IsUnitAlly(GetSpellTargetUnit(), GetTriggerPlayer()) == false then
        call CE_Input(caster, target, 150)
        if IsUnitType(GetSpellTargetUnit(), UNIT_TYPE_HERO) and udg_SK_BLTalismanicAvaliable[GetConvertedPlayerId(GetOwningPlayer(GetSpellTargetUnit()))] and IsUnitIllusionBJ(GetSpellTargetUnit()) == false then
            call Item_BLTalismanicRunningCD(GetSpellTargetUnit())
            set caster = null
            set target = null
            set e = null
            set t = null
            return
        endif
    endif
    if IsUnitType(target, UNIT_TYPE_HERO) or IsUnitIllusion(target) then
        if udg_SK_Keine_Wolf == 0 then
            set style = 0
        else
            set style = 1
        endif
        set e = AddSpecialEffectTarget("Abilities\\Spells\\Orc\\Voodoo\\VoodooAuraTarget.mdl", target, "chest")
        set t = CreateTimer()
        set task = GetHandleId(t)
        set hp = GetUnitState(target, UNIT_STATE_LIFE)
        call SaveUnitHandle(udg_ht, task, 0, caster)
        call SaveUnitHandle(udg_ht, task, 1, target)
        call SaveEffectHandle(udg_ht, task, 2, e)
        call SaveReal(udg_ht, task, 3, hp)
        call SaveInteger(udg_ht, task, 4, style)
        call TimerStart(t, 5.0, false, function Trig_Keine_01_Clear)
    else
        set e = AddSpecialEffectTarget("Abilities\\Spells\\Orc\\Voodoo\\VoodooAuraTarget.mdl", target, "chest")
        set t = CreateTimer()
        set task = GetHandleId(t)
        call SaveUnitHandle(udg_ht, task, 0, caster)
        call SaveUnitHandle(udg_ht, task, 1, target)
        call SaveEffectHandle(udg_ht, task, 2, e)
        call TimerStart(t, 0.1, true, function Trig_Keine_01_Kill)
    endif
    set caster = null
    set target = null
    set e = null
    set t = null
endfunction

function InitTrig_Keine01 takes nothing returns nothing
endfunction