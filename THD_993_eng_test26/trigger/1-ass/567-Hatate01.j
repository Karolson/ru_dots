function Trig_Hatate01_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A08N'
endfunction

function Trig_Hatate01_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real dx = GetSpellTargetX() - ox
    local real dy = GetSpellTargetY() - oy
    local real px
    local real py
    local real a = Atan2(dy, dx)
    local real d = SquareRoot(dx * dx + dy * dy)
    local integer level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 12)
    if GetUnitAbilityLevel(caster, 'A0V4') == 1 or GetUnitAbilityLevel(caster, 'A0A1') == 1 then
        set caster = null
        return
    endif
    set d = RMinBJ(300.0 + level * 100.0, d)
    set px = ox + d * Cos(a)
    set py = oy + d * Sin(a)
    call Trig_BlinkPlaceRealer(px, py, d, a)
    set px = udg_SK_BlinkPlace_x
    set py = udg_SK_BlinkPlace_y
    call DestroyEffect(AddSpecialEffect("Shot_02.mdx", ox, oy))
    call SetUnitXY(caster, px, py)
    call DestroyEffect(AddSpecialEffect("Shot_02.mdx", GetUnitX(caster), GetUnitY(caster)))
    set caster = null
endfunction

function InitTrig_Hatate01 takes nothing returns nothing
endfunction