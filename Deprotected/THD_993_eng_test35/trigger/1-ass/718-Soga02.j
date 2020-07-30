function Trig_Soga02_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A19Y'
endfunction

function Trig_Soga02_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local integer level = LoadInteger(udg_ht, task, 1)
    local real tx
    local real ty
    local real tx2 = LoadReal(udg_ht, task, 2)
    local real ty2 = LoadReal(udg_ht, task, 3)
    local unit u
    local unit v
    local real px
    local real py
    local group g
    local integer i
    local real damage
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    local boolean k = false
    set damage = ABCIAllInt(caster, 40 + level * 30, 1.45)
    if udg_SK_Soga02efgroup != null then
        set tx = udg_SK_Soga02tx
        set ty = udg_SK_Soga02ty
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\Monsoon\\MonsoonBoltTarget.mdl", tx, ty))
        set i = 1
        loop
        exitwhen i > 8
            set px = tx + 160 * Cos(i * 45 / bj_RADTODEG)
            set py = ty + 160 * Sin(i * 45 / bj_RADTODEG)
            call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\ChimaeraLightningMissile\\ChimaeraLightningMissile.mdl", px, py))
            set i = i + 1
        endloop
        set g = CreateGroup()
        call GroupEnumUnitsInRange(g, tx, ty, 200.0, iff)
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if IsUnitType(v, UNIT_TYPE_DEAD) == false and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false then
                if IsUnitType(v, UNIT_TYPE_HERO) then
                    set k = true
                endif
            endif
        endloop
        call GroupEnumUnitsInRange(g, tx, ty, 200.0, iff)
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if IsUnitType(v, UNIT_TYPE_DEAD) == false and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false then
                if k then
                    call UnitMagicDamageTarget(caster, v, damage * 1.35, 5)
                else
                    call UnitMagicDamageTarget(caster, v, damage, 5)
                endif
            endif
        endloop
        call DestroyGroup(g)
        loop
            set v = FirstOfGroup(udg_SK_Soga02efgroup)
        exitwhen v == null
            call GroupRemoveUnit(udg_SK_Soga02efgroup, v)
            call KillUnit(v)
            call RemoveUnit(v)
        endloop
        call DestroyGroup(udg_SK_Soga02efgroup)
        set udg_SK_Soga02efgroup = null
    endif
    set k = false
    set tx = tx2
    set ty = ty2
    set udg_SK_Soga02tx = tx
    set udg_SK_Soga02ty = ty
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\Monsoon\\MonsoonBoltTarget.mdl", tx, ty))
    set udg_SK_Soga02efgroup = CreateGroup()
    set i = 1
    loop
    exitwhen i > 8
        set px = tx + 160 * Cos(i * 0.78543)
        set py = ty + 160 * Sin(i * 0.78543)
        call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\ChimaeraLightningMissile\\ChimaeraLightningMissile.mdl", px, py))
        set u = CreateUnit(GetOwningPlayer(caster), 'e02P', px, py, 0)
        call SetUnitVertexColor(u, 255, 255, 255, 155)
        call GroupAddUnit(udg_SK_Soga02efgroup, u)
        set i = i + 1
    endloop
    set g = CreateGroup()
    call GroupEnumUnitsInRange(g, tx, ty, 200.0, iff)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if IsUnitType(v, UNIT_TYPE_DEAD) == false and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false then
            if IsUnitType(v, UNIT_TYPE_HERO) then
                set k = true
            endif
        endif
    endloop
    call GroupEnumUnitsInRange(g, tx, ty, 200.0, iff)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if IsUnitType(v, UNIT_TYPE_DEAD) == false and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false then
            if k then
                call UnitMagicDamageTarget(caster, v, damage * 1.35, 5)
            else
                call UnitMagicDamageTarget(caster, v, damage, 5)
            endif
        endif
    endloop
    call DestroyGroup(g)
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    set caster = null
    set u = null
    set v = null
    set g = null
    set iff = null
    set t = null
endfunction

function Trig_Soga02_Actions takes nothing returns nothing
    local timer t
    local integer task
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A19Y')
    local real tx
    local real ty
    call AbilityCoolDownResetion(caster, 'A19Y', 8 - level)
    if udg_SK_Soga02efgroup != null then
        set tx = udg_SK_Soga02tx
        set ty = udg_SK_Soga02ty
        call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\ChimaeraLightningMissile\\ChimaeraLightningMissile.mdl", tx, ty))
    endif
    set tx = GetSpellTargetX()
    set ty = GetSpellTargetY()
    call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\ChimaeraLightningMissile\\ChimaeraLightningMissile.mdl", tx, ty))
    set t = CreateTimer()
    set task = GetHandleId(t)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveInteger(udg_ht, task, 1, level)
    call SaveReal(udg_ht, task, 2, tx)
    call SaveReal(udg_ht, task, 3, ty)
    call TimerStart(t, 0.75, false, function Trig_Soga02_Main)
    set t = null
    set caster = null
endfunction

function InitTrig_Soga02 takes nothing returns nothing
endfunction