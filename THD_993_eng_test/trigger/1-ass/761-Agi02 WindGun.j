function Trig_Agi02_WindGun_Conditions takes nothing returns boolean
    if YDWEUnitHasItemOfTypeBJNull(GetEventDamageSource(), 'I04F') == false and YDWEUnitHasItemOfTypeBJNull(GetEventDamageSource(), 'I094') == false and YDWEUnitHasItemOfTypeBJNull(GetEventDamageSource(), 'I095') == false and YDWEUnitHasItemOfTypeBJNull(GetEventDamageSource(), 'I099') == false and YDWEUnitHasItemOfTypeBJNull(GetEventDamageSource(), 'I098') == false and YDWEUnitHasItemOfTypeBJNull(GetEventDamageSource(), 'I09A') == false and YDWEUnitHasItemOfTypeBJNull(GetEventDamageSource(), 'I033') == false then
        return false
    elseif IsUnitAlly(GetTriggerUnit(), GetOwningPlayer(GetEventDamageSource())) then
        return false
    elseif IsUnitType(GetTriggerUnit(), UNIT_TYPE_STRUCTURE) then
        return false
    elseif IsUnitType(GetTriggerUnit(), UNIT_TYPE_HERO) then
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

function Trig_Agi02_WindGun_Actions takes nothing returns nothing
    local unit caster = GetEventDamageSource()
    local unit target = GetTriggerUnit()
    if YDWEUnitHasItemOfTypeBJNull(GetEventDamageSource(), 'I04F') == true then
        call UnitPhysicalDamageTarget_Item(caster, target, 48)
    else
        call UnitPhysicalDamageTarget_Item(caster, target, 25) 
    endif  
    set caster = null
    set target = null
endfunction

function InitTrig_Agi02_WindGun takes nothing returns nothing
    set gg_trg_Agi02_WindGun = CreateTrigger()
    call RegisterAnyUnitDamage(gg_trg_Agi02_WindGun)
    call TriggerAddCondition(gg_trg_Agi02_WindGun, Condition(function Trig_Agi02_WindGun_Conditions))
    call TriggerAddAction(gg_trg_Agi02_WindGun, function Trig_Agi02_WindGun_Actions)
endfunction