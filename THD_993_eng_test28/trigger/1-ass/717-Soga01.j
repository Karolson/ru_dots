function Trig_Soga01_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A19X'
endfunction

function Trig_Soga01_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A19X')
    local real ox
    local real oy
    local real tx
    local real ty
    local real a
    local unit u
    local unit v
    local real px
    local real py
    local real kx
    local real ky
    local group m
    local group g
    local integer i
    local integer j
    local real damage
    local real stun
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    local boolean k = false
    call AbilityCoolDownResetion(caster, 'A19X', 10)
    set damage = ABCIAllInt(caster, 40 + level * 40, 1.5)
    set stun = 1.75
    set j = 8
    if udg_SK_Soga01efgroup != null then
        set ox = udg_SK_Soga01ox
        set oy = udg_SK_Soga01oy
        set tx = udg_SK_Soga01tx
        set ty = udg_SK_Soga01ty
        set a = Atan2(ty - oy, tx - ox)
        set m = CreateGroup()
        set i = 1
        loop
        exitwhen i > j
            set px = ox + i * 75 * Cos(a)
            set py = oy + i * 75 * Sin(a)
            if i / 2 * 2 == i then
                set kx = px - 50 * Cos(a + 1.570796)
                set ky = py - 50 * Sin(a + 1.570796)
                call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\Monsoon\\MonsoonBoltTarget.mdl", kx, ky))
                set kx = px + 50 * Cos(a + 1.570796)
                set ky = py + 50 * Sin(a + 1.570796)
                call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\Monsoon\\MonsoonBoltTarget.mdl", kx, ky))
            endif
            set g = CreateGroup()
            call GroupEnumUnitsInRange(g, px, py, 150.0, iff)
            loop
                set v = FirstOfGroup(g)
            exitwhen v == null
                call GroupRemoveUnit(g, v)
                if IsUnitType(v, UNIT_TYPE_DEAD) == false and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false and IsUnitInGroup(v, m) == false then
                    call GroupAddUnit(m, v)
                    if IsUnitType(v, UNIT_TYPE_HERO) then
                        set k = true
                    endif
                endif
            endloop
            call DestroyGroup(g)
            set i = i + 1
        endloop
        loop
            set v = FirstOfGroup(m)
        exitwhen v == null
            call GroupRemoveUnit(m, v)
            if k then
                call UnitStunTarget(caster, v, stun, 0, 0)
            endif
            call UnitMagicDamageTarget(caster, v, damage, 5)
        endloop
        call DestroyGroup(m)
        loop
            set v = FirstOfGroup(udg_SK_Soga01efgroup)
        exitwhen v == null
            call GroupRemoveUnit(udg_SK_Soga01efgroup, v)
            call KillUnit(v)
        endloop
        call DestroyGroup(udg_SK_Soga01efgroup)
        set udg_SK_Soga01efgroup = null
    endif
    set k = false
    set ox = GetUnitX(caster)
    set oy = GetUnitY(caster)
    set tx = GetSpellTargetX()
    set ty = GetSpellTargetY()
    set udg_SK_Soga01ox = ox
    set udg_SK_Soga01oy = oy
    set udg_SK_Soga01tx = tx
    set udg_SK_Soga01ty = ty
    set a = Atan2(ty - oy, tx - ox)
    set udg_SK_Soga01efgroup = CreateGroup()
    set m = CreateGroup()
    set i = 1
    loop
    exitwhen i > j
        set px = ox + i * 75 * Cos(a)
        set py = oy + i * 75 * Sin(a)
        if i / 2 * 2 == i then
            set kx = px - 50 * Cos(a + 1.570796)
            set ky = py - 50 * Sin(a + 1.570796)
            call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\Monsoon\\MonsoonBoltTarget.mdl", kx, ky))
            set u = CreateUnit(GetOwningPlayer(caster), 'e02P', kx, ky, 57.29578 * a)
            call SetUnitVertexColor(u, 255, 255, 255, 155)
            call GroupAddUnit(udg_SK_Soga01efgroup, u)
            set kx = px + 50 * Cos(a + 1.570796)
            set ky = py + 50 * Sin(a + 1.570796)
            call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\Monsoon\\MonsoonBoltTarget.mdl", kx, ky))
            set u = CreateUnit(GetOwningPlayer(caster), 'e02P', kx, ky, 57.29578 * a)
            call SetUnitVertexColor(u, 255, 255, 255, 155)
            call GroupAddUnit(udg_SK_Soga01efgroup, u)
        endif
        set g = CreateGroup()
        call GroupEnumUnitsInRange(g, px, py, 150.0, iff)
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if IsUnitType(v, UNIT_TYPE_DEAD) == false and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false and IsUnitInGroup(v, m) == false then
                call GroupAddUnit(m, v)
                if IsUnitType(v, UNIT_TYPE_HERO) then
                    set k = true
                endif
            endif
        endloop
        call DestroyGroup(g)
        set i = i + 1
    endloop
    loop
        set v = FirstOfGroup(m)
    exitwhen v == null
        call GroupRemoveUnit(m, v)
        if k then
            call UnitStunTarget(caster, v, stun, 0, 0)
        endif
        call UnitMagicDamageTarget(caster, v, damage, 5)
    endloop
    call DestroyGroup(m)
    set caster = null
    set u = null
    set v = null
    set m = null
    set g = null
    set iff = null
endfunction

function InitTrig_Soga01 takes nothing returns nothing
endfunction