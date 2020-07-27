function Trig_Cirno01_IceNova takes unit caster, unit target returns nothing
    local integer level = GetUnitAbilityLevel(caster, 'A03W')
    local real damage = 0
    local real dur
    local group g = CreateGroup()
    local unit v
    if IsUnitType(target, UNIT_TYPE_HERO) then
        set damage = 30 + 30 * level + GetHeroInt(target, true) * 0.9
    else
        set damage = 30 + 30 * level
    endif
    call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Undead\\FrostNova\\FrostNovaTarget.mdl", target, "origin"))
    call GroupEnumUnitsInRange(g, GetUnitX(target), GetUnitY(target), 200.0, null)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if IsUnitEnemy(v, GetOwningPlayer(caster)) then
            if IsUnitType(v, UNIT_TYPE_HERO) then
                set dur = 3.0
            else
                set dur = 9.0
            endif
            call UnitDebuffTarget(caster, v, dur, 1, true, 'A06F', level, 'B01A', "frostnova", 0, "")
            call CCSystem_textshow("Slow", v, DebuffDuration(v, dur))
        endif
    endloop
    call DestroyGroup(g)
    call UnitMagicDamageTarget(caster, target, damage * 0.5, 1)
    call UnitMagicDamageArea(caster, GetUnitX(target), GetUnitY(target), 200, damage * 0.5, 5)
    set g = null
    set v = null
endfunction

function Trig_Cirno01_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A03W'
endfunction

function Trig_Cirno01_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A03W')
    call AbilityCoolDownResetion(caster, 'A03W', 10 - level)
    call Trig_Cirno01_IceNova(caster, target)
    set caster = null
    set target = null
endfunction

function InitTrig_Cirno01 takes nothing returns nothing
endfunction