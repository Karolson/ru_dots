function InitTrig_Ati09_LeafDagger_Conditions takes nothing returns boolean
    if YDWEUnitHasItemOfTypeBJNull(GetEventDamageSource(), 'I033') != true then
        return false
    elseif GetEventDamage() == 0 then
        return false
    elseif IsUnitIllusion(GetEventDamageSource()) then
        return false
    elseif IsUnitType(GetTriggerUnit(), UNIT_TYPE_STRUCTURE) then
        return false
    elseif IsUnitAlly(GetTriggerUnit(), GetOwningPlayer(GetEventDamageSource())) then
        return false
    elseif IsUnitType(GetEventDamageSource(), UNIT_TYPE_MELEE_ATTACKER) != true then
        return false
    elseif IsDamageNotUnitAttack(GetEventDamageSource()) then
        return false
    endif
    return true
endfunction

function InitTrig_Ati09_LeafDagger_Actions takes nothing returns nothing
    local unit caster = GetEventDamageSource()
    local group g = CreateGroup()
    local unit target = GetTriggerUnit()
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    local unit v
    local real angle
    local location targetLoc = Location(GetUnitX(caster) - GetUnitX(target), GetUnitY(caster) - GetUnitY(target))
    local location vLoc
    call GroupEnumUnitsInRange(g, GetUnitX(caster), GetUnitY(caster), 400.0, iff)
    call GroupRemoveUnit(g, target)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if IsUnitType(v, UNIT_TYPE_DEAD) != true and IsUnitType(v, UNIT_TYPE_STRUCTURE) != true and IsUnitWard(v) != true then
            set vLoc = Location(GetUnitX(caster) - GetUnitX(v), GetUnitY(caster) - GetUnitY(v))
            set angle = bj_RADTODEG * (Atan2(GetLocationY(targetLoc), GetLocationX(targetLoc)) - Atan2(GetLocationY(vLoc), GetLocationX(vLoc)))
            if angle > 180 then
                set angle  =  angle - 360
            endif
            if angle <= -180 then
                set angle  =  angle + 360
            endif
            if angle >= -75 and angle <= 75 then
                call UnitPhysicalDamageTarget(caster, v, GetUnitAttack(caster) * 0.4)
            endif
            call RemoveLocation(vLoc)
        endif
    endloop
    call RemoveLocation(targetLoc)
    call DestroyGroup(g)
    set caster  =  null
    set g  =  null
    set target  =  null
    set iff  =  null
    set targetLoc  =  null
    set vLoc  =  null
endfunction

function InitTrig_Ati09_LeafDagger takes nothing returns nothing
    set gg_trg_Ati09_LeafDagger = CreateTrigger()
    call RegisterAnyUnitDamage(gg_trg_Ati09_LeafDagger)
    call TriggerAddCondition(gg_trg_Ati09_LeafDagger, Condition(function InitTrig_Ati09_LeafDagger_Conditions))
    call TriggerAddAction(gg_trg_Ati09_LeafDagger, function InitTrig_Ati09_LeafDagger_Actions)
endfunction