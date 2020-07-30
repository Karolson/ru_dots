function Trig_Sunny03_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0VY'
endfunction

function Trig_Sunny03_Target takes nothing returns boolean
    if GetFilterUnit() == GetSpellTargetUnit() then
        return false
    elseif GetWidgetLife(GetFilterUnit()) < 0.405 then
        return false
    elseif GetUnitAbilityLevel(GetFilterUnit(), 'Aloc') != 0 then
        return false
    endif
    return IsUnitEnemy(GetFilterUnit(), GetOwningPlayer(GetTriggerUnit()))
endfunction

function Trig_Sunny03_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local unit target2
    local integer level = GetUnitAbilityLevel(caster, 'A0VY')
    local real ltx1
    local real ltx2
    local real lty1
    local real lty2
    local real ltz1
    local real ltz2
    local lightning e
    local timer t
    local integer task
    local group g
    local filterfunc iff
    local unit v
    call AbilityCoolDownResetion(caster, 'A0VY', 6)
    if IsUnitAlly(GetSpellTargetUnit(), GetTriggerPlayer()) == false then
        if IsUnitType(GetSpellTargetUnit(), UNIT_TYPE_HERO) and udg_SK_BLTalismanicAvaliable[GetConvertedPlayerId(GetOwningPlayer(GetSpellTargetUnit()))] and IsUnitIllusionBJ(GetSpellTargetUnit()) == false then
            call Item_BLTalismanicRunningCD(GetSpellTargetUnit())
            set t = null
            set caster = null
            set target = null
            set target2 = null
            set e = null
            set g = null
            set iff = null
            set v = null
            return
        endif
    endif
    call UnitMagicDamageTarget(caster, target, ABCIAllInt(caster, 10 + 40 * level, 1), 1)
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Undead\\AbsorbMana\\AbsorbManaBirthMissile.mdl", GetUnitX(target), GetUnitY(target)))
    set ltx1 = GetUnitX(caster)
    set lty1 = GetUnitY(caster)
    set ltz1 = GetPositionZ(ltx1, lty1) + 80.0
    set ltx2 = GetUnitX(target)
    set lty2 = GetUnitY(target)
    set ltz2 = GetPositionZ(ltx2, lty2) + 80.0
    set e = AddLightningEx("TCLE", false, ltx1, lty1, ltz1, ltx2, lty2, ltz2)
    call SetLightningColor(e, 0.0, 0.0, 1.0, 1.0)
    set t = CreateTimer()
    set task = GetHandleId(t)
    call SaveLightningHandle(udg_ht, task, 0, e)
    call TimerStart(t, 0.4, false, function Trig_Sunny02_ClearLightning)
    set g = CreateGroup()
    set iff = Filter(function Trig_Sunny03_Target)
    call GroupEnumUnitsInRange(g, GetUnitX(target), GetUnitY(target), 400.0, iff)
    set v = FirstOfGroup(g)
    if v != null then
        set target2 = GroupPickRandomUnit(g)
        call UnitMagicDamageTarget(caster, target2, ABCIAllInt(caster, 10 + 40 * level, 1) * 2, 1)
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Undead\\AbsorbMana\\AbsorbManaBirthMissile.mdl", GetUnitX(target2), GetUnitY(target2)))
        set ltx1 = GetUnitX(target)
        set lty1 = GetUnitY(target)
        set ltz1 = GetPositionZ(ltx1, lty1) + 80.0
        set ltx2 = GetUnitX(target2)
        set lty2 = GetUnitY(target2)
        set ltz2 = GetPositionZ(ltx2, lty2) + 80.0
        set e = AddLightningEx("TCLE", false, ltx1, lty1, ltz1, ltx2, lty2, ltz2)
        call SetLightningColor(e, 0.0, 0.0, 1.0, 1.0)
        set t = CreateTimer()
        set task = GetHandleId(t)
        call SaveLightningHandle(udg_ht, task, 0, e)
        call TimerStart(t, 0.4, false, function Trig_Sunny02_ClearLightning)
    endif
    call DestroyFilter(iff)
    call DestroyGroup(g)
    set caster = null
    set target = null
    set target2 = null
    set e = null
    set t = null
    set g = null
    set iff = null
    set v = null
endfunction

function InitTrig_Sunny03 takes nothing returns nothing
endfunction