function Trig_Str05_Kafziel_Conditions takes nothing returns boolean
    if YDWEUnitHasItemOfTypeBJNull(GetEventDamageSource(), 'I04D') != true then
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
    return GetRandomInt(0, 100) < 25
endfunction

function Trig_Str05_Kafziel_Actions takes nothing returns nothing
    local unit caster = GetEventDamageSource()
    local unit target = GetTriggerUnit()
    local real k1
    local real r1
    local real damage
    set k1 = GetUnitState(caster, UNIT_STATE_LIFE)
    set r1 = GetUnitState(target, UNIT_STATE_LIFE)
    if k1 > r1 then
        set damage = (k1 - r1) * 0.12 + 10
    else
        set damage = 10
    endif
    call UnitMagicDamageTarget(caster, target, damage, 4)
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Undead\\DeathCoil\\DeathCoilSpecialArt.mdl", GetUnitX(target), GetUnitY(target)))
    set caster = null
    set target = null
endfunction

function InitTrig_Str05_Kafziel takes nothing returns nothing
    set gg_trg_Str05_Kafziel = CreateTrigger()
    call RegisterAnyUnitDamage(gg_trg_Str05_Kafziel)
    call TriggerAddCondition(gg_trg_Str05_Kafziel, Condition(function Trig_Str05_Kafziel_Conditions))
    call TriggerAddAction(gg_trg_Str05_Kafziel, function Trig_Str05_Kafziel_Actions)
endfunction