function FLANDRE02 takes nothing returns integer
    return 'A19I'
endfunction

function Flandre02_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A19I'
endfunction

function Flandre02_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A19I')
    local integer id
    local real dis
    local real a
    call AbilityCoolDownResetion(caster, 'A19I', 8)
    if level < 4 then
        set id = 'A0EH' + level
    elseif level == 4 then
        set id = 'A0EQ'
    endif
    set a = Atan2(GetUnitY(target) - GetUnitY(caster), GetUnitX(target) - GetUnitX(caster))
    set dis = DistanceBetweenPoints(GetUnitLoc(caster), GetUnitLoc(target))
    loop
    exitwhen dis < 30
        call AddTimedEffectToPoint(GetUnitX(caster) + dis * Cos(a), GetUnitY(caster) + dis * Sin(a), 1, "Abilities\\Weapons\\LordofFlameMissile\\LordofFlameMissile.mdl")
        set dis = dis - 60
    endloop
    call UnitSlowTarget(caster, target, 4.0, id, 'B012')
    call UnitBuffTarget(caster, caster, 4.0, 'A0IA', 0)
    set caster = null
    set target = null
endfunction

function InitTrig_Flandre02 takes nothing returns nothing
endfunction