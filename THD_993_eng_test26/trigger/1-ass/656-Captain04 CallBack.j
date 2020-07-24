function Trig_Captain04_CallBack_Actions takes nothing returns nothing
    local location loc = GetUnitLoc(udg_SK_Caption04_Hero)
    local unit u = GetTriggerUnit()
    call SetUnitPositionLoc(u, loc)
    call RemoveLocation(loc)
    set loc = null
    set u = null
endfunction

function Trig_Captain04_CallBack_Conditions takes nothing returns boolean
    local unit caster = GetEventDamageSource()
    local unit target = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A10I')
    local real decene = GetEventDamage() * (0.05 + 0.05 * level) + level * 4 + 2
    if GetSpellAbilityId() == 'A0AI' then
        call Trig_Captain04_CallBack_Actions()
    endif
    if GetEventDamage() > 1.0 and level >= 1 and IsUnitType(target, UNIT_TYPE_GIANT) == false and IsDamageNotUnitAttack(GetEventDamageSource()) == false and GetUnitAbilityLevel(target, 'A10J') == 0 and IsUnitType(target, UNIT_TYPE_STRUCTURE) == false and IsUnitAlly(target, GetOwningPlayer(caster)) == false and IsUnitIllusion(caster) == false then
        call UnitBuffTarget(caster, target, 7, 'A10J', 'B01Z')
        if IsUnitType(target, UNIT_TYPE_HERO) and udg_SK_BLTalismanicAvaliable[GetConvertedPlayerId(GetOwningPlayer(target))] and IsUnitIllusionBJ(target) == false then
            call Item_BLTalismanicRunningCD(target)
            call UnitBuffTarget(caster, target, 7, 'A10J', 'B01Z')
        else
            call UnitMagicDamageTarget(caster, target, (-35 + level * 55 + GetUnitAttack(caster) * 0.2 + GetHeroInt(caster, true) * 0.2) * 2, 2)
            if IsUnitType(target, UNIT_TYPE_HERO) then
                call UnitStunTarget(caster, target, (0.3 + level * 0.2) * 2, 0, 0)
            endif
        endif
    endif
    set caster = null
    set target = null
    return false
endfunction

function InitTrig_Captain04_CallBack takes nothing returns nothing
endfunction