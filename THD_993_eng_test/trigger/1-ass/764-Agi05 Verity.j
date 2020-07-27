function Trig_Agi05_Verity_Conditions takes nothing returns boolean
    if YDWEUnitHasItemOfTypeBJNull(GetEventDamageSource(), 'I05T') != true then
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

function Trig_Agi05_Verity_Actions takes nothing returns nothing
    local unit caster = GetEventDamageSource()
    local unit target = GetTriggerUnit()
    local real amount = 30 + GetUnitState(target, UNIT_STATE_MAX_MANA) * 0.05
    if IsUnitType(caster, UNIT_TYPE_RANGED_ATTACKER) then
        set amount = amount * 0.5
    endif
    call SetUnitState(target, UNIT_STATE_MANA, GetUnitState(target, UNIT_STATE_MANA) - amount)
    if IsUnitType(caster, UNIT_TYPE_RANGED_ATTACKER) then
        call UnitPhysicalDamageTarget_Item(caster, target, amount * 0.35)
    else
        call UnitPhysicalDamageTarget_Item(caster, target, amount * 0.7)
    endif
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Human\\Feedback\\SpellBreakerAttack.mdl", GetUnitX(target), GetUnitY(target)))
    set caster = null
    set target = null
endfunction

function InitTrig_Agi05_Verity takes nothing returns nothing
    set gg_trg_Agi05_Verity = CreateTrigger()
    call RegisterAnyUnitDamage(gg_trg_Agi05_Verity)
    call TriggerAddCondition(gg_trg_Agi05_Verity, Condition(function Trig_Agi05_Verity_Conditions))
    call TriggerAddAction(gg_trg_Agi05_Verity, function Trig_Agi05_Verity_Actions)
endfunction