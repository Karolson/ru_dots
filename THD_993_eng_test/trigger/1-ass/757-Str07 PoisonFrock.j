function Trig_Str07_PoisonFrock_Conditions takes nothing returns boolean
    if YDWEUnitHasItemOfTypeBJNull(GetTriggerUnit(), 'I06K') != true then
        return false
    elseif IsUnitAlly(GetTriggerUnit(), GetOwningPlayer(GetEventDamageSource())) then
        return false
    elseif IsUnitType(GetEventDamageSource(), UNIT_TYPE_STRUCTURE) then
        return false
    elseif GetEventDamage() == 0 then
        return false
    elseif IsDamageNotUnitAttack(GetEventDamageSource()) then
        return false
    endif
    return true
endfunction

function Trig_Str07_PoisonFrock_Actions takes nothing returns nothing
    local unit caster = GetEventDamageSource()
    local unit target = GetTriggerUnit()
    local real damage = 0.0
    if IsUnitType(caster, UNIT_TYPE_HERO) then
        set damage = GetUnitAttack(caster) * 0.3
    endif
    if damage <= 50 then
        set damage = 50
    endif
    call UnitMagicDamageTarget(target, caster, damage, 4)
    call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\MurgulMagicMissile\\MurgulMagicMissile.mdl", GetUnitX(caster), GetUnitY(caster)))
    set caster = null
    set target = null
endfunction

function InitTrig_Str07_PoisonFrock takes nothing returns nothing
    set gg_trg_Str07_PoisonFrock = CreateTrigger()
    call RegisterAnyUnitDamage(gg_trg_Str07_PoisonFrock)
    call TriggerAddCondition(gg_trg_Str07_PoisonFrock, Condition(function Trig_Str07_PoisonFrock_Conditions))
    call TriggerAddAction(gg_trg_Str07_PoisonFrock, function Trig_Str07_PoisonFrock_Actions)
endfunction