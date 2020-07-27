function Trig_Satori02_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0IX'
endfunction

function Trig_Satori02_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local real x = GetSpellTargetX()
    local real y = GetSpellTargetY()
    local real rate
    local real c
    local real d = 0.0
    local integer level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    local unit v
    local group g = CreateGroup()
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    local texttag e
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 16 - 3 * level)
    set v = CreateUnit(GetOwningPlayer(caster), 'n03P', x, y, 0.0)
    call SetUnitTimeScale(v, 1.5)
    call KillUnit(v)
    set v = CreateUnit(GetOwningPlayer(caster), 'n03P', x, y, 120.0)
    call SetUnitTimeScale(v, 1.5)
    call KillUnit(v)
    set v = CreateUnit(GetOwningPlayer(caster), 'n03P', x, y, 240.0)
    call SetUnitTimeScale(v, 1.5)
    call KillUnit(v)
    call GroupEnumUnitsInRange(g, x, y, 160.0, iff)
    loop
        set c = 0.0
        set d = 0.0
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if IsUnitType(v, UNIT_TYPE_DEAD) == false and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false and GetUnitAbilityLevel(v, 'A0IL') > 0 == false and GetUnitAbilityLevel(v, 'B04B') == 0 and GetUnitAbilityLevel(v, 'BOvc') == 0 then
            if GetUnitAbilityLevel(v, 'A1FD') != 0 then
                set rate = 1.5
            else
                set rate = 1.0
            endif
            call UnitSlowTarget(caster, v, 10, 'A1FD', 'B0A0')
            if GetUnitState(v, UNIT_STATE_MAX_MANA) > 0.0 then
                set c = rate * 0.15 * GetUnitState(v, UNIT_STATE_MAX_MANA)
                call SetUnitState(v, UNIT_STATE_MANA, GetUnitState(v, UNIT_STATE_MANA) - c)
            endif
            call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Demon\\DemonBoltImpact\\DemonBoltImpact.mdl", v, "head"))
            if IsUnitType(v, UNIT_TYPE_HERO) then
                set d = (ABCIExtraInt(caster, 0.15, 0.0006) * GetUnitState(v, UNIT_STATE_MAX_LIFE) + GetHeroInt(caster, true) * 1.0) * rate
                set d = UnitMagicDamageTarget(caster, v, d, 5)
                set x = GetUnitX(v)
                set y = GetUnitY(v)
                set e = CreateTextTag()
                call SetTextTagTextBJ(e, "-" + R2SW(c, 3, 0), 14.0)
                call SetTextTagPos(e, x, y, 50.0)
                call SetTextTagColor(e, 0, 0, 255, 240)
                call SetTextTagVelocityBJ(e, 150, 90)
                call SetTextTagPermanent(e, false)
                call SetTextTagLifespan(e, 1.67)
                set e = CreateTextTag()
                call SetTextTagTextBJ(e, "-" + R2SW(d, 3, 0), 14.0)
                call SetTextTagPos(e, x, y, 100.0)
                call SetTextTagColor(e, 220, 0, 0, 240)
                call SetTextTagVelocityBJ(e, 150, 90)
                call SetTextTagPermanent(e, false)
                call SetTextTagLifespan(e, 1.67)
            else
                call UnitMagicDamageTarget(caster, v, GetHeroInt(caster, true) * 1.0 * rate, 5)
            endif
        endif
    endloop
    call DestroyGroup(g)
    set caster = null
    set e = null
    set v = null
    set g = null
    set iff = null
endfunction

function InitTrig_Satori02 takes nothing returns nothing
endfunction