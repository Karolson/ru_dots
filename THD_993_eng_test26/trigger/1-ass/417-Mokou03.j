function Trig_Mokou03_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A00B'
endfunction

function Trig_Mokou03_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = null
    local integer level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    local real tx = GetUnitX(caster)
    local real ty = GetUnitY(caster)
    local real damage = 0
    local real atkspeed = 0
    local integer k = 0
    local integer i = 0
    local group g = CreateGroup()
    local unit v
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 11 - level)
    call GroupEnumUnitsInRange(g, tx, ty, 300.0, null)
    call DebugMsg("Select Target1")
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null or IsUnitType(target, UNIT_TYPE_HERO)
        call GroupRemoveUnit(g, v)
        if IsUnitAlly(v, GetOwningPlayer(caster)) == false and GetWidgetLife(v) > 0.405 then
            set target = v
        endif
    endloop
    call DebugMsg("Select Target")
    call DestroyGroup(g)
    if target == null then
        call AbilityCoolDownResetion(caster, GetSpellAbilityId(), (11 - level) * 0.75)
        set caster = null
        set target = null
        set v = null
        return
    endif
    set tx = GetUnitX(target)
    set ty = GetUnitY(target)
    call DebugMsg("Select Target2")
    if IsUnitAlly(GetSpellTargetUnit(), GetTriggerPlayer()) == false then
        if IsUnitType(GetSpellTargetUnit(), UNIT_TYPE_HERO) and udg_SK_BLTalismanicAvaliable[GetConvertedPlayerId(GetOwningPlayer(GetSpellTargetUnit()))] and IsUnitIllusionBJ(GetSpellTargetUnit()) == false then
            call Item_BLTalismanicRunningCD(GetSpellTargetUnit())
            set caster = null
            set target = null
            return
        endif
    endif
    set k = GetPlayerId(GetOwningPlayer(caster)) + 1
    set udg_SK_Mokou02_Count[k] = udg_SK_Mokou02_Count[k] + 1
    call SaveInteger(udg_sht, GetHandleId(caster), 1, LoadInteger(udg_sht, GetHandleId(caster), 1) + 1)
    if udg_SK_Mokou02_Count[k] >= 4 then
        set udg_SK_Mokou02_Count[k] = 4
    endif
    call UnitMagicDamageTarget(caster, caster, 40 + level * 30, 1)
    call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\FragDriller\\FragDriller.mdl", tx, ty))
    set atkspeed = GetUnitAttackSpeed(caster)
    if atkspeed > 0 then
        set damage = 15 + level * 15 + 0.035 * GetUnitState(caster, UNIT_STATE_MAX_LIFE) + atkspeed * 100 * (0.45 + 0.2 * level)
    else
        set damage = 15 + level * 15 + 0.035 * GetUnitState(caster, UNIT_STATE_MAX_LIFE)
    endif
    set i = 0
    loop
        set i = i + 1
        call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\RedDragonBreath\\RedDragonMissile.mdl", tx + 80 * CosBJ(i * 120), ty + 80 * SinBJ(i * 120)))
    exitwhen i == 3
    endloop
    call ClearAllNegativeBuff(caster, false)
    call UnitMagicDamageTarget(caster, target, damage, 1)
    set caster = null
    set target = null
    set v = null
endfunction

function InitTrig_Mokou03 takes nothing returns nothing
endfunction