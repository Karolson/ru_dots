function Trig_All04_IceFrog_Conditions takes nothing returns boolean
    if YDWEUnitHasItemOfTypeBJNull(GetEventDamageSource(), 'I00C') != true then
        return false
    elseif IsUnitAlly(GetTriggerUnit(), GetOwningPlayer(GetEventDamageSource())) then
        return false
    elseif IsUnitType(GetTriggerUnit(), UNIT_TYPE_STRUCTURE) then
        return false
    elseif IsUnitIllusion(GetEventDamageSource()) then
        return false
    elseif GetEventDamage() == 0 then
        return false
    elseif IsDamageNotUnitAttack(GetEventDamageSource()) then
        return false
    endif
    return true
endfunction

function Trig_All04_IceFrog_Actions takes nothing returns nothing
    local unit caster = GetEventDamageSource()
    local unit target = GetTriggerUnit()
    local effect e = AddSpecialEffect("Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl", GetUnitX(target), GetUnitY(target))
    call DestroyEffect(e)
    if IsUnitType(caster, UNIT_TYPE_RANGED_ATTACKER) then
        if udg_NewDebuffSys then
            call UnitSlowTargetMspd(caster, target, 30, 1.0, 3, 0)
        else
            call UnitSlowTarget(caster, target, 1.0, 'A19A', 'B06U')
        endif
    else
        if udg_NewDebuffSys then
            call UnitSlowTargetMspd(caster, target, 45, 1.0, 3, 0)
        else
            call UnitSlowTarget(caster, target, 1.0, 'A15G', 'B06U')
        endif
    endif
    set e = null
    set caster = null
    set target = null
endfunction

function InitTrig_All04_IceFrog takes nothing returns nothing
    set gg_trg_All04_IceFrog = CreateTrigger()
    call RegisterAnyUnitDamage(gg_trg_All04_IceFrog)
    call TriggerAddCondition(gg_trg_All04_IceFrog, Condition(function Trig_All04_IceFrog_Conditions))
    call TriggerAddAction(gg_trg_All04_IceFrog, function Trig_All04_IceFrog_Actions)
endfunction