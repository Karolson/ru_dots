function Trig_Twei02_Conditions takes nothing returns boolean
    if GetUnitAbilityLevel(GetEventDamageSource(), 'A03T') == 0 then
        return false
    endif
    if IsUnitType(GetTriggerUnit(), UNIT_TYPE_STRUCTURE) then
        return false
    endif
    if IsUnitAlly(GetTriggerUnit(), GetOwningPlayer(GetEventDamageSource())) then
        return false
    endif
    if GetEventDamage() == 0 then
        return false
    endif
    if IsDamageNotUnitAttack(GetEventDamageSource()) then
        return false
    endif
    return true
endfunction

function Trig_Twei02_Actions takes nothing returns nothing
    local unit caster = GetEventDamageSource()
    local unit target = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A03T')
    local real a
    local real b
    local real x1
    local real x2
    local real y1
    local real y2
    local real dis
    local real damage
    local integer r
    if GetUnitAbilityLevel(caster, 'B03O') != 0 and GetUnitState(caster, UNIT_STATE_MANA) > 4 + level * 2 then
        call SetUnitState(caster, UNIT_STATE_MANA, GetUnitState(caster, UNIT_STATE_MANA) - (4 + level * 2))
        if GetUnitAbilityLevel(caster, 'A0N4') != 0 then
            if GetUnitAbilityLevel(caster, 'A0N4') == 1 then
                call UnitSlowTarget(caster, target, 3.0, 'A08E', 0)
            elseif GetUnitAbilityLevel(caster, 'A0N4') == 2 then
                call UnitRemoveAbility(target, 'A08E')
                call UnitSlowTarget(caster, target, 3.0, 'A12B', 0)
            elseif GetUnitAbilityLevel(caster, 'A0N4') == 3 then
                call UnitRemoveAbility(target, 'A08E')
                call UnitRemoveAbility(target, 'A12B')
                call UnitSlowTarget(caster, target, 3.0, 'A12C', 0)
            else
                call UnitRemoveAbility(target, 'A08E')
                call UnitRemoveAbility(target, 'A12B')
                call UnitRemoveAbility(target, 'A12C')
                call UnitSlowTarget(caster, target, 3.0, 'A12D', 0)
            endif
        endif
        set a = AngleBetweenUnits(caster, target)
        set b = GetUnitFacing(target)
        set x1 = GetUnitX(caster)
        set x2 = GetUnitX(target)
        set y1 = GetUnitY(caster)
        set y2 = GetUnitY(target)
        set dis = SquareRoot((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2))
        set damage = RMinBJ(GetUnitState(target, UNIT_STATE_MAX_LIFE) * (0.025 + level * 0.01), 250)
        set a = RAbsBJ(YawError(a, b))
        set r = GetRandomInt(0, 100)
        if a <= 45.0 then
            set r = r - 15
        endif
        call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\GyroCopter\\GyroCopterMissile.mdl", GetUnitX(target), GetUnitY(target)))
        if r <= 15 then
            call UnitStunTarget(caster, target, 0.2, 0, 0)
            call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Demon\\DemonBoltImpact\\DemonBoltImpact.mdl", GetUnitX(target), GetUnitY(target)))
            set damage = damage * 1.0
            call DebugMsg(R2S(damage))
        endif
        call TriggerSleepAction(0.01)
        call UnitPhysicalDamageTarget(caster, target, damage)
    endif
    set caster = null
    set target = null
endfunction

function InitTrig_Twei02 takes nothing returns nothing
endfunction