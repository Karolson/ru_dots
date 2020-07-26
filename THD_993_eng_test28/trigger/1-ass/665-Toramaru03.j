function Trig_Toramaru03_Conditions takes nothing returns boolean
    if IsUnitAlly(GetEventDamageSource(), GetOwningPlayer(GetTriggerUnit())) then
        return false
    elseif GetEventDamage() <= 0.0 then
        return false
    elseif IsUnitType(GetTriggerUnit(), UNIT_TYPE_DEAD) then
        return false
    endif
    return GetUnitTypeId(GetPlayerCharacter(GetOwningPlayer(GetEventDamageSource()))) == 'H01N'
endfunction

function Trig_Toramaru03_Actions takes nothing returns nothing
    local unit target = GetTriggerUnit()
    call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\FaerieDragonMissile\\FaerieDragonMissile.mdl", GetUnitX(target), GetUnitY(target)))
    set target = null
endfunction

function InitTrig_Toramaru03 takes nothing returns nothing
endfunction