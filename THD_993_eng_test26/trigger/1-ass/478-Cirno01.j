function Trig_Cirno01_IceNova takes unit caster, unit target returns nothing
    local integer level = GetUnitAbilityLevel(caster, 'A03W')
    local real damage = 0
    local real dur = 3.0
    if IsUnitType(target, UNIT_TYPE_HERO) then
        set damage = 30 + 30 * level + GetHeroInt(target, true) * 0.9
    else
        set damage = 30 + 30 * level
        set dur = 9.0
    endif
    call UnitDebuffTarget(caster, target, dur, 1, true, 'A06F', level, 'B01A', "frostnova", 0, "")
    call CCSystem_textshow("Slow", target, dur)
    call UnitMagicDamageTarget(caster, target, damage * 0.5, 1)
    call UnitMagicDamageArea(caster, GetUnitX(target), GetUnitY(target), 200, damage * 0.5, 5)
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