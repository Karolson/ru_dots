function Trig_Byakuren03_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0O0'
endfunction

function Trig_Byakuren03_Clear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit target = LoadUnitHandle(udg_ht, task, 0)
    local real tx = LoadReal(udg_ht, task, 1)
    local real ty = LoadReal(udg_ht, task, 2)
    if IsUnitType(target, UNIT_TYPE_DEAD) == false and not IsUnitCCImmune(target) then
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\Charm\\CharmTarget.mdl", GetUnitX(target), GetUnitY(target)))
        call SetUnitXY(target, tx, ty)
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\Charm\\CharmTarget.mdl", tx, ty))
    endif
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    set t = null
    set target = null
endfunction

function Trig_Byakuren03_Actions takes nothing returns nothing
    local timer t
    local integer task
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real tx = GetUnitX(target)
    local real ty = GetUnitY(target)
    local unit e1
    local unit e2
    local unit e3
    local unit e4
    local integer level = GetUnitAbilityLevel(caster, 'A0O0')
    call AbilityCoolDownResetion(caster, 'A0O0', 15 - level)
    if IsUnitAlly(GetSpellTargetUnit(), GetTriggerPlayer()) == false and not IsUnitCCImmune(target) then
        call CE_Input(caster, target, 150)
        if IsUnitType(GetSpellTargetUnit(), UNIT_TYPE_HERO) and udg_SK_BLTalismanicAvaliable[GetConvertedPlayerId(GetOwningPlayer(GetSpellTargetUnit()))] and IsUnitIllusionBJ(GetSpellTargetUnit()) == false then
            call Item_BLTalismanicRunningCD(GetSpellTargetUnit())
            set caster = null
            set target = null
            set e1 = null
            set e2 = null
            set e3 = null
            set e4 = null
            set t = null
            return
        endif
    endif
    if GetUnitAbilityLevel(target, 'A0V4') == 1 or GetUnitAbilityLevel(target, 'A0A1') == 1 then
        set caster = null
        set target = null
        set e1 = null
        set e2 = null
        set e3 = null
        set e4 = null
        set t = null
        return
    endif
    set e1 = CreateUnit(GetOwningPlayer(caster), 'e01K', tx, ty, GetRandomInt(0, 360))
    set e2 = CreateUnit(GetOwningPlayer(caster), 'e01K', tx, ty, GetRandomInt(0, 360))
    set e3 = CreateUnit(GetOwningPlayer(caster), 'e01K', tx, ty, GetRandomInt(0, 360))
    call SetUnitPathing(e1, false)
    call SetUnitPathing(e2, false)
    call SetUnitPathing(e3, false)
    call SetUnitXY(e1, tx, ty)
    call SetUnitXY(e2, tx, ty)
    call SetUnitXY(e3, tx, ty)
    call SetUnitFlyHeight(e1, 0, 0)
    call SetUnitFlyHeight(e2, 100, 0)
    call SetUnitFlyHeight(e3, 200, 0)
    call AttachSoundToUnit(gg_snd_PaladinDivineShieldDeath1, caster)
    call SetSoundVolume(gg_snd_PaladinDivineShieldDeath1, 127)
    call StartSound(gg_snd_PaladinDivineShieldDeath1)
    if IsUnitAlly(target, GetOwningPlayer(caster)) then
        if GetUnitTypeId(target) != 'U00M' then
            call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\Charm\\CharmTarget.mdl", GetUnitX(target), GetUnitY(target)))
            call SetUnitXY(target, ox, oy)
            call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\Charm\\CharmTarget.mdl", tx, ty))
        endif
    else
        if udg_SK_Byakuren02_Record > 0 then
            call UnitMagicDamageTarget(caster, target, udg_SK_Byakuren02_Record, 1)
            set e4 = CreateUnit(GetOwningPlayer(caster), 'e01M', tx, ty, 0)
            call SetUnitPathing(e4, false)
            call SetUnitXY(e4, tx, ty)
            set udg_SK_Byakuren02_Record = 0
        endif
        set t = CreateTimer()
        set task = GetHandleId(t)
        call SaveUnitHandle(udg_ht, task, 0, target)
        call SaveReal(udg_ht, task, 1, tx)
        call SaveReal(udg_ht, task, 2, ty)
        call TimerStart(t, 3.0, false, function Trig_Byakuren03_Clear)
    endif
    set caster = null
    set target = null
    set e1 = null
    set e2 = null
    set e3 = null
    set e4 = null
    set t = null
endfunction

function InitTrig_Byakuren03 takes nothing returns nothing
endfunction