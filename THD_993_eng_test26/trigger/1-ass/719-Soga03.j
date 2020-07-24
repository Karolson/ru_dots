function Trig_Soga03_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A00M'
endfunction

function Trig_Soga03_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A00M')
    local real tx
    local real ty
    local unit u
    local unit v
    local group g
    local real damage
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    local boolean k1 = false
    local boolean k2 = false
    call AbilityCoolDownResetion(caster, 'A00M', 12 - level)
    set damage = ABCIAllInt(caster, 30 + level * 30, 1.2)
    if udg_SK_Soga03efgroup != null then
        set tx = udg_SK_Soga03tx
        set ty = udg_SK_Soga03ty
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Orc\\Purge\\PurgeBuffTarget.mdl", tx, ty))
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Orc\\Purge\\PurgeBuffTarget.mdl", tx, ty))
        call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\AncestralGuardianMissile\\AncestralGuardianMissile.mdl", tx, ty))
        call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\AncestralGuardianMissile\\AncestralGuardianMissile.mdl", tx, ty))
        set g = CreateGroup()
        call GroupEnumUnitsInRange(g, tx, ty, 185.0, iff)
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if IsUnitType(v, UNIT_TYPE_DEAD) == false and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false then
                call UnitMagicDamageTarget(caster, v, damage, 5)
                if IsUnitType(v, UNIT_TYPE_HERO) then
                    set k1 = true
                endif
            endif
        endloop
        call DestroyGroup(g)
        loop
            set v = FirstOfGroup(udg_SK_Soga03efgroup)
        exitwhen v == null
            call GroupRemoveUnit(udg_SK_Soga03efgroup, v)
            call KillUnit(v)
        endloop
        call DestroyGroup(udg_SK_Soga03efgroup)
        set udg_SK_Soga03efgroup = null
    endif
    set tx = GetSpellTargetX()
    set ty = GetSpellTargetY()
    set udg_SK_Soga03tx = tx
    set udg_SK_Soga03ty = ty
    set udg_SK_Soga03efgroup = CreateGroup()
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Orc\\Purge\\PurgeBuffTarget.mdl", tx, ty))
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Orc\\Purge\\PurgeBuffTarget.mdl", tx, ty))
    call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\AncestralGuardianMissile\\AncestralGuardianMissile.mdl", tx, ty))
    call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\AncestralGuardianMissile\\AncestralGuardianMissile.mdl", tx, ty))
    set u = CreateUnit(GetOwningPlayer(caster), 'e02P', tx, ty, 0)
    call SetUnitVertexColor(u, 255, 255, 255, 155)
    call GroupAddUnit(udg_SK_Soga03efgroup, u)
    set g = CreateGroup()
    call GroupEnumUnitsInRange(g, tx, ty, 185.0, iff)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if IsUnitType(v, UNIT_TYPE_DEAD) == false and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false then
            call UnitMagicDamageTarget(caster, v, damage, 5)
            if IsUnitType(v, UNIT_TYPE_HERO) then
                set k2 = true
            endif
        endif
    endloop
    call DestroyGroup(g)
    if k1 or k2 then
        call UnitBuffTarget(caster, caster, 6, 'A00O', 0)
        call SetUnitAbilityLevel(caster, 'A19Z', level)
        call SetUnitAbilityLevel(caster, 'A1A2', level)
        if k1 and k2 then
            call UnitBuffTarget(caster, caster, 6, 'A00O', 0)
            call SetUnitAbilityLevel(caster, 'A19Z', level + 4)
            call SetUnitAbilityLevel(caster, 'A1A2', level + 4)
            call DMG_DamageReduce(caster, 1 - (level * 0.05 + 0.25), 6, "Physcial")
        else
            call DMG_DamageReduce(caster, 1 - (level * 0.05 + 0.05), 6, "Physcial")
        endif
    endif
    set caster = null
    set u = null
    set v = null
    set g = null
    set iff = null
endfunction

function InitTrig_Soga03 takes nothing returns nothing
endfunction