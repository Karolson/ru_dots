function Trig_Lunasa01_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0LM'
endfunction

function Trig_Lunasa01_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real tx = GetSpellTargetX()
    local real ty = GetSpellTargetY()
    local real px
    local real py
    local integer i
    local real a = Atan2(ty - oy, tx - ox)
    local group g
    local group m
    local boolexpr iff
    local unit v
    local unit w
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 11 - level * 1)
    set m = CreateGroup()
    set iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    call PlaySoundOnUnitBJ(gg_snd_ViolinChorus01, 100, caster)
    set i = 1
    loop
    exitwhen i == 21
        set px = ox + i * 50 * Cos(a)
        set py = oy + i * 50 * Sin(a)
        call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\AvengerMissile\\AvengerMissile.mdl", px, py))
        set g = CreateGroup()
        call GroupEnumUnitsInRange(g, px, py, 100.0, iff)
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if IsUnitType(v, UNIT_TYPE_DEAD) == false and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false and IsUnitInGroup(v, m) == false then
                call GroupAddUnit(m, v)
                call Trig_LunasaDamage(caster, v, ABCIAllInt(caster, level * 50 + 50, 0.9), 5)
                if udg_NewDebuffSys then
                    call UnitDebuffTarget(caster, v, (0.2 + 0.1 * level) * 1.0, 2, true, 'A04D', 1, 'B084', "drunkenhaze", 'A04N', "")
                else
                    call UnitCurseTarget(caster, v, 0.2 + 0.1 * level, 'A0OK', "drunkenhaze")
                endif
            endif
        endloop
        call DestroyGroup(g)
        set i = i + 1
    endloop
    call DestroyGroup(m)
    set caster = null
    set g = null
    set m = null
    set iff = null
    set v = null
    set w = null
endfunction

function InitTrig_Lunasa01 takes nothing returns nothing
endfunction