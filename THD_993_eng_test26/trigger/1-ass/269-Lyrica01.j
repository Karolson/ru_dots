function Trig_Lyrica01_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0TR'
endfunction

function Trig_Lyrica01_Filter takes nothing returns boolean
    return true
endfunction

function Trig_Lyrica01_Actions takes nothing returns nothing
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
    local integer i
    local group g
    local unit v
    local boolexpr iff
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), (22 - 3 * level) * udg_SK_LyricaEx_Buff)
    if GetUnitAbilityLevel(caster, 'A0V4') == 1 or GetUnitAbilityLevel(caster, 'A0A1') == 1 then
        set caster = null
        set g = null
        set v = null
        set iff = null
        return
    endif
    call PlaySoundOnUnitBJ(gg_snd_PianoChorus01, 100, caster)
    set d = RMinBJ(500.0, d)
    set px = ox + d * Cos(a)
    set py = oy + d * Sin(a)
    call Trig_BlinkPlaceRealer(px, py, d, a)
    set px = udg_SK_BlinkPlace_x
    set py = udg_SK_BlinkPlace_y
    call SetUnitXY(caster, px, py)
    set g = CreateGroup()
    set iff = Filter(function Trig_Lyrica01_Filter)
    call GroupEnumUnitsInRange(g, GetUnitX(caster), GetUnitY(caster), 250.0, iff)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if IsUnitType(v, UNIT_TYPE_DEAD) == false and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false and IsUnitAlly(caster, GetOwningPlayer(v)) and GetUnitAbilityLevel(v, 'A0IL') > 0 == false then
            call UnitHealingTarget(caster, v, ABCIAllInt(caster, level * 45 + 45, 1.5))
        endif
    endloop
    call DestroyGroup(g)
    set i = 0
    loop
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Undead\\ReplenishHealth\\ReplenishHealthCasterOverhead.mdl", GetUnitX(caster) + 235 * CosBJ(i * 30), GetUnitY(caster) + 235 * SinBJ(i * 30)))
        set i = i + 1
    exitwhen i == 12
    endloop
    set caster = null
    set g = null
    set v = null
    set iff = null
endfunction

function InitTrig_Lyrica01 takes nothing returns nothing
endfunction