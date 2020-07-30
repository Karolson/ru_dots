function Trig_Leaf_Conditions takes nothing returns boolean
    if YDWEUnitHasItemOfTypeBJNull(GetEventDamageSource(), 'I08P') != true then
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

function Trig_Leaf_Actions takes nothing returns nothing
    local unit caster = GetEventDamageSource()
    local unit target = GetTriggerUnit()
    local unit v
    local group g = CreateGroup()
    local real ran = GetRandomReal(0, 100)
    local effect e = null
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    call DestroyEffect(e)
    if ran < 25 then
        call UnitAbsDamageTarget(caster, target, 75)
        call GroupEnumUnitsInRange(g, GetUnitX(target), GetUnitY(target), 500, iff)
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if GetWidgetLife(v) >= 0.405 and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false and GetUnitAbilityLevel(v, 'A0IL') > 0 == false and IsUnitType(v, UNIT_TYPE_HERO) == false and IsUnitType(v, UNIT_TYPE_ANCIENT) == false then
                call UnitAbsDamageTarget(caster, v, 200)
            endif
        endloop
        call DestroyGroup(g)
        set e = AddSpecialEffect("Objects\\Spawnmodels\\NightElf\\EntBirthTarget\\EntBirthTarget.mdl", GetUnitX(target), GetUnitY(target))
    endif
    set e = null
    set caster = null
    set target = null
endfunction

function InitTrig_Leaf takes nothing returns nothing
    set gg_trg_Leaf = CreateTrigger()
    call RegisterAnyUnitDamage(gg_trg_Leaf)
    call TriggerAddCondition(gg_trg_Leaf, Condition(function Trig_Leaf_Conditions))
    call TriggerAddAction(gg_trg_Leaf, function Trig_Leaf_Actions)
endfunction