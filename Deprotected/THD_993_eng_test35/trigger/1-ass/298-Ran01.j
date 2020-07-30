function Trig_Ran_01_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0TH'
endfunction

function Trig_Ran_01_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real tx = GetSpellTargetX()
    local real ty = GetSpellTargetY()
    local real px
    local real py
    local real a = Atan2(ty - oy, tx - ox)
    local real d = SquareRoot(Pow(ty - oy, 2) + Pow(tx - ox, 2))
    local integer level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    if udg_SK_Ran01 != null then
        set px = GetUnitX(udg_SK_Ran01)
        set py = GetUnitY(udg_SK_Ran01)
    endif
    if udg_SK_Ran01 != null and SquareRoot((px - tx) * (px - tx) + (py - ty) * (py - ty)) <= 175 then
        if GetUnitAbilityLevel(caster, 'A0V4') == 1 or GetUnitAbilityLevel(caster, 'A0A1') == 1 then
            set caster = null
            return
        endif
        call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 17 - 2 * level)
        set ox = GetUnitX(caster)
        set oy = GetUnitY(caster)
        set tx = GetUnitX(udg_SK_Ran01)
        set ty = GetUnitY(udg_SK_Ran01)
        call SetUnitXY(udg_SK_Ran01, ox, oy)
        call SetUnitXY(caster, tx, ty)
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Orc\\AncestralSpirit\\AncestralSpiritCaster.mdl", ox, oy))
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Orc\\AncestralSpirit\\AncestralSpiritCaster.mdl", tx, ty))
    else
        set tx = GetSpellTargetX()
        set ty = GetSpellTargetY()
        call Trig_BlinkPlaceRealer(ox + d * Cos(a), oy + d * Sin(a), d, a)
        set tx = udg_SK_BlinkPlace_x
        set ty = udg_SK_BlinkPlace_y
        if udg_SK_Ran01 == null or IsUnitType(udg_SK_Ran01, UNIT_TYPE_DEAD) then
            set udg_SK_Ran01 = CreateUnit(GetOwningPlayer(caster), 'o012', tx, ty, 0)
        else
            call SetUnitXY(udg_SK_Ran01, tx, ty)
        endif
        call SetUnitAbilityLevel(udg_SK_Ran01, 'A0TK', level)
        call SetUnitAbilityLevel(udg_SK_Ran01, 'A0TL', level)
        call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Human\\MarkOfChaos\\MarkOfChaosTarget.mdl", udg_SK_Ran01, "origin"))
        call UnitRemoveAbility(caster, 'A0TH')
        call UnitAddAbility(caster, 'A0TH')
        call SetUnitAbilityLevel(caster, 'A0TH', level)
    endif
    set caster = null
endfunction

function InitTrig_Ran01 takes nothing returns nothing
endfunction