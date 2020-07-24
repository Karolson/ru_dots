function KOMACHI02_EFFECT takes nothing returns string
    return "Abilities\\Spells\\Demon\\DemonBoltImpact\\DemonBoltImpact.mdl"
endfunction

function Komachi02_Damage_Conditions takes nothing returns boolean
    local unit u
    local unit v
    local unit w
    local integer i
    local integer level
    local group g
    local player p
    if GetTriggerEventId() == EVENT_PLAYER_UNIT_ATTACKED then
        set u = GetAttacker()
        set i = LoadInteger(udg_sht, StringHash("Komachi02"), GetHandleId(u))
        if i == 3 then
            call SetUnitAnimation(u, "Attack Slam")
        endif
        set u = null
        set v = null
        set w = null
        set g = null
        set p = null
        return false
    endif
    set u = GetEventDamageSource()
    set v = GetTriggerUnit()
    set level = GetUnitAbilityLevel(u, 'A0JK')
    if level == 0 or IsUnitIllusion(u) or IsUnitType(v, UNIT_TYPE_STRUCTURE) or IsUnitAlly(v, GetOwningPlayer(u)) or GetEventDamage() == 0 or IsDamageNotUnitAttack(u) then
        set u = null
        set v = null
        set w = null
        set g = null
        set p = null
        return false
    endif
    if udg_GameMode / 100 != 3 and udg_NewMid == false then
    else
    endif
    set i = LoadInteger(udg_sht, StringHash("Komachi02"), GetHandleId(u))
    if i == 1 or i == 2 then
        set i = i + 1
        call SaveInteger(udg_sht, StringHash("Komachi02"), GetHandleId(u), i)
        call UnitPhysicalDamageTarget(u, v, 20.0 + 20.0 * level)
        call Komachi_Soul(u, v, 1)
        call Komachi_Soul(u, v, 1)
        call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Demon\\DemonBoltImpact\\DemonBoltImpact.mdl", v, "origin"))
    elseif i == 3 then
        set i = 0
        call SaveInteger(udg_sht, StringHash("Komachi02"), GetHandleId(u), i)
        call UnitPhysicalDamageArea(u, GetUnitX(u), GetUnitY(u), 230.0, 25.0 + 25.0 * level + GetUnitAttack(u))
        set p = GetOwningPlayer(u)
        set g = CreateGroup()
        call GroupEnumUnitsInRange(g, GetUnitX(u), GetUnitY(u), 230.0, null)
        loop
            set w = FirstOfGroup(g)
        exitwhen w == null
            call GroupRemoveUnit(g, w)
            if GetWidgetLife(w) > 0.405 and IsUnitEnemy(w, p) and GetUnitAbilityLevel(w, 'Avul') <= 0 and GetUnitAbilityLevel(w, 'Aloc') <= 0 then
                call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Demon\\DemonBoltImpact\\DemonBoltImpact.mdl", w, "origin"))
                call Komachi_Soul(u, w, 1)
                call Komachi_Soul(u, w, 1)
            endif
        endloop
        call DestroyGroup(g)
    endif
    set u = null
    set v = null
    set w = null
    set g = null
    set p = null
    return false
endfunction

function InitTrig_Komachi02_Damage takes nothing returns nothing
endfunction