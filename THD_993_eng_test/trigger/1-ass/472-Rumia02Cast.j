function Trig_Rumia02Cast_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A11N'
endfunction

function Trig_Rumia02Cast_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local integer level = GetUnitAbilityLevel(caster, 'A11N')
    local group g
    local unit v
    local boolexpr iff
    local integer i
    local integer j
    local real duration = 1
    call AbilityCoolDownResetion(caster, 'A11N', 12)
    set i = 0
    loop
        set i = i + 1
        set j = 0
        loop
            set j = j + 1
            call DestroyEffect(AddSpecialEffect("Objects\\Spawnmodels\\Human\\HumanBlood\\BloodElfSpellThiefBlood.mdl", ox + CosBJ(i * 60) * (40 * j), oy + SinBJ(i * 60) * (40 * j)))
        exitwhen j == 6
        endloop
    exitwhen i == 6
    endloop
    set g = CreateGroup()
    set iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    call GroupEnumUnitsInRange(g, ox, oy, 275, iff)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if IsUnitType(v, UNIT_TYPE_DEAD) == false and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false then
            if udg_NewDebuffSys then
                call UnitDebuffTarget(caster, v, duration * 1.0, 2, true, 'A0QV', 1, 'B07U', "firebolt", 0, "")
            else
                call UnitStunTarget(caster, v, duration, 0, 0)
            endif
        endif
    endloop
    call DestroyGroup(g)
    call UnitMagicDamageArea(caster, ox, oy, 275, 30 * level + 0.65 * GetUnitAttack(caster), 5)
    set g = null
    set iff = null
    set v = null
    set caster = null
endfunction

function InitTrig_Rumia02Cast takes nothing returns nothing
endfunction