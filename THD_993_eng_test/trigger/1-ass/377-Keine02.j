function Trig_Keine_02_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0M6'
endfunction

function Trig_Keine_02_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local integer count = LoadInteger(udg_ht, task, 4)
    local unit caster = udg_SK_Keine
    local unit target = LoadUnitHandle(udg_ht, task, 1)
    local effect e = LoadEffectHandle(udg_ht, task, 2)
    local effect f = LoadEffectHandle(udg_ht, task, 3)
    if count < 40 then
        set count = count + 1
        call SaveInteger(udg_ht, task, 4, count)
        if IsUnitInvulnerable(caster) == false then
            call SetUnitInvulnerable(caster, true)
            call DestroyEffect(e)
            set e = AddSpecialEffectTarget("Abilities\\Spells\\Human\\DivineShield\\DivineShieldTarget.mdl", caster, "origin")
            call SaveEffectHandle(udg_ht, task, 2, e)
        endif
        if target != null and IsUnitInvulnerable(target) == false then
            call SetUnitInvulnerable(target, true)
            call DestroyEffect(f)
            set f = AddSpecialEffectTarget("Abilities\\Spells\\Human\\DivineShield\\DivineShieldTarget.mdl", target, "origin")
            call SaveEffectHandle(udg_ht, task, 3, f)
        endif
    elseif count >= 40 then
        call SetUnitInvulnerable(caster, false)
        call DestroyEffect(e)
        if target != null then
            call SetUnitInvulnerable(target, false)
            call DestroyEffect(f)
        endif
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set target = null
    set e = null
    set f = null
endfunction

function Trig_Keine_02_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local unit u
    local effect e
    local effect f
    local timer t
    local integer task
    local integer level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 32 - 4 * level)
    if IsUnitAlly(GetSpellTargetUnit(), GetTriggerPlayer()) == false then
        if IsUnitType(GetSpellTargetUnit(), UNIT_TYPE_HERO) and udg_SK_BLTalismanicAvaliable[GetConvertedPlayerId(GetOwningPlayer(GetSpellTargetUnit()))] and IsUnitIllusionBJ(GetSpellTargetUnit()) == false then
            call Item_BLTalismanicRunningCD(GetSpellTargetUnit())
            set caster = null
            set target = null
            set u = null
            set e = null
            set f = null
            set t = null
            return
        endif
    endif
    if udg_SK_Keine_Wolf == 0 then
        call UnitMagicDamageTarget(caster, caster, GetUnitState(caster, UNIT_STATE_LIFE) * 0.35, 1)
    endif
    if IsUnitAlly(target, GetOwningPlayer(caster)) then
        call SetUnitInvulnerable(caster, true)
        call SetUnitInvulnerable(target, true)
        set e = AddSpecialEffectTarget("Abilities\\Spells\\Human\\DivineShield\\DivineShieldTarget.mdl", caster, "origin")
        set f = AddSpecialEffectTarget("Abilities\\Spells\\Human\\DivineShield\\DivineShieldTarget.mdl", target, "origin")
        set t = CreateTimer()
        set task = GetHandleId(t)
        call SaveUnitHandle(udg_ht, task, 0, caster)
        call SaveUnitHandle(udg_ht, task, 1, target)
        call SaveEffectHandle(udg_ht, task, 2, e)
        call SaveEffectHandle(udg_ht, task, 3, f)
        call SaveInteger(udg_ht, task, 4, 1)
        call TimerStart(t, 0.05, true, function Trig_Keine_02_Main)
    else
        call SetUnitInvulnerable(caster, true)
        set e = AddSpecialEffectTarget("Abilities\\Spells\\Human\\DivineShield\\DivineShieldTarget.mdl", caster, "origin")
        set u = CreateUnit(GetOwningPlayer(caster), 'n001', GetUnitX(caster), GetUnitY(caster), GetUnitFacing(caster))
        set t = CreateTimer()
        set task = GetHandleId(t)
        call SaveUnitHandle(udg_ht, task, 0, caster)
        call SaveUnitHandle(udg_ht, task, 1, null)
        call SaveEffectHandle(udg_ht, task, 2, e)
        call SaveEffectHandle(udg_ht, task, 3, null)
        call SaveInteger(udg_ht, task, 4, 1)
        call TimerStart(t, 0.05, true, function Trig_Keine_02_Main)
        if udg_NewDebuffSys then
            call UnitDebuffTarget(caster, target, 2.0 * 1.0, 2, true, 'A0QI', 1, 'B07T', "drunkenhaze", 'A04N', "")
        else
            call UnitCurseTarget(caster, target, 2.0, 'A0MC', "drunkenhaze")
            call CE_Input(caster, target, 200)
        endif
    endif
    set caster = null
    set target = null
    set u = null
    set e = null
    set f = null
    set t = null
endfunction

function InitTrig_Keine02 takes nothing returns nothing
endfunction