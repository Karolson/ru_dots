function Trig_Agi03_Fox_Actions takes nothing returns boolean
    if YDWEUnitHasItemOfTypeBJNull(GetEventDamageSource(), 'I02Y') == false then
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
    call UnitBuffTarget(GetEventDamageSource(), GetEventDamageSource(), 5, 'A1BF', 'B09G')
    return false
endfunction

function InitTrig_Agi03_Fox takes nothing returns nothing
    set gg_trg_Agi03_Fox = CreateTrigger()
    call RegisterAnyUnitDamage(gg_trg_Agi03_Fox)
    call TriggerAddCondition(gg_trg_Agi03_Fox, Condition(function Trig_Agi03_Fox_Actions))
endfunction