function Trig_Agi08_Camara_Conditions takes nothing returns boolean
    if YDWEUnitHasItemOfTypeBJNull(GetEventDamageSource(), 'I060') != true then
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
    return GetRandomReal(0, 100.0) <= 100
endfunction

function Trig_Agi08_Camara_Actions takes nothing returns nothing
    local unit caster = GetEventDamageSource()
    local unit target = GetTriggerUnit()
    local real damage
    set damage = RMinBJ(GetUnitState(target, UNIT_STATE_MAX_LIFE) * 0.035, 175)
    call UnitPhysicalDamageTarget(caster, target, damage)
    call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\PriestMissile\\PriestMissile.mdl", GetUnitX(target), GetUnitY(target)))
    call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\PriestMissile\\PriestMissile.mdl", GetUnitX(target) + 50, GetUnitY(target) + 50))
    call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\PriestMissile\\PriestMissile.mdl", GetUnitX(target) - 50, GetUnitY(target) - 50))
    set caster = null
    set target = null
endfunction

function InitTrig_Agi08_Camara takes nothing returns nothing
    set gg_trg_Agi08_Camara = CreateTrigger()
    call RegisterAnyUnitDamage(gg_trg_Agi08_Camara)
    call TriggerAddCondition(gg_trg_Agi08_Camara, Condition(function Trig_Agi08_Camara_Conditions))
    call TriggerAddAction(gg_trg_Agi08_Camara, function Trig_Agi08_Camara_Actions)
endfunction