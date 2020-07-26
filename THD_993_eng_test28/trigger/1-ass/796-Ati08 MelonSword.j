function Trig_Ati08_MelonSword_Conditions takes nothing returns boolean
    if YDWEUnitHasItemOfTypeBJNull(GetEventDamageSource(), 'I03S') != true then
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

function Trig_Ati08_MelonSword_Actions takes nothing returns nothing
    local unit caster = GetEventDamageSource()
    local unit target = GetTriggerUnit()
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Orc\\FeralSpirit\\feralspiritdone.mdl", GetUnitX(target), GetUnitY(target)))
    call DummyCastTargetInstant_WW(caster, target, 'A1B1', 2, "faeriefire")
    call UnitSlowTarget(caster, target, 4, 'A1B4', 0)
    call UnitSlowTarget(caster, target, 4, 'A175', 0)
    set caster = null
    set target = null
endfunction

function InitTrig_Ati08_MelonSword takes nothing returns nothing
    set gg_trg_Ati08_MelonSword = CreateTrigger()
    call RegisterAnyUnitDamage(gg_trg_Ati08_MelonSword)
    call TriggerAddCondition(gg_trg_Ati08_MelonSword, Condition(function Trig_Ati08_MelonSword_Conditions))
    call TriggerAddAction(gg_trg_Ati08_MelonSword, function Trig_Ati08_MelonSword_Actions)
endfunction