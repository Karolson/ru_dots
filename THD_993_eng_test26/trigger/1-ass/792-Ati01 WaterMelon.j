function Trig_Ati01_WaterMelon_Conditions takes nothing returns boolean
    if YDWEUnitHasItemOfTypeBJNull(GetEventDamageSource(), 'I061') != true and YDWEUnitHasItemOfTypeBJNull(GetEventDamageSource(), 'I08V') != true then
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

function Trig_Ati01_WaterMelon_Actions takes nothing returns nothing
    local unit caster = GetEventDamageSource()
    local unit target = GetTriggerUnit()
    local effect e = AddSpecialEffect("Abilities\\Spells\\Orc\\FeralSpirit\\feralspiritdone.mdl", GetUnitX(target), GetUnitY(target))
    call DestroyEffect(e)
    call UnitSlowTarget(caster, target, 4.0, 'A173', 0)
    set caster = null
    set target = null
    set e = null
endfunction

function InitTrig_Ati01_WaterMelon takes nothing returns nothing
    set gg_trg_Ati01_WaterMelon = CreateTrigger()
    call RegisterAnyUnitDamage(gg_trg_Ati01_WaterMelon)
    call TriggerAddCondition(gg_trg_Ati01_WaterMelon, Condition(function Trig_Ati01_WaterMelon_Conditions))
    call TriggerAddAction(gg_trg_Ati01_WaterMelon, function Trig_Ati01_WaterMelon_Actions)
endfunction