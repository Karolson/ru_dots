function Trig_Reisen_Attack_Conditions takes nothing returns boolean
    local real k
    local real l
    if GetTriggerEventId() == EVENT_UNIT_DAMAGED then
        if GetUnitTypeId(GetEventDamageSource()) != 'O007' and GetUnitTypeId(GetEventDamageSource()) != 'O015' then
            return false
        elseif GetEventDamage() == 0.0 then
            return false
        elseif IsUnitAlly(GetEventDamageSource(), GetOwningPlayer(GetTriggerUnit())) then
            return false
        elseif IsUnitType(GetTriggerUnit(), UNIT_TYPE_STRUCTURE) then
            return false
        elseif IsUnitIllusion(GetEventDamageSource()) then
            return false
        elseif GetUnitAbilityLevel(GetTriggerUnit(), 'B043') != 0 then
            call UnitRemoveAbility(GetTriggerUnit(), 'B043')
            return true
        elseif GetUnitAbilityLevel(GetEventDamageSource(), 'A0PJ') > 0 and YDWEUnitHasItemOfTypeBJNull(GetEventDamageSource(), 'I08P') and udg_SK_Reisen02 then
            return true
        endif
        return false
    elseif GetTriggerEventId() == EVENT_PLAYER_UNIT_SUMMON then
        if GetUnitTypeId(GetSummonedUnit()) != 'O007' and GetUnitTypeId(GetSummonedUnit()) != 'O015' then
            return false
        elseif IsUnitIllusion(GetSummonedUnit()) != true then
            return false
        endif
        set k = GetRandomReal(0, 6.28344)
        set l = GetRandomReal(50, 200)
        call SetUnitXYGround(GetSummonedUnit(), GetUnitX(GetSummoningUnit()) + l * Cos(k), GetUnitY(GetSummoningUnit()) + l * Sin(k))
        if udg_SK_Reisen01_Target != null and IsUnitType(udg_SK_Reisen01_Target, UNIT_TYPE_DEAD) == false then
            call IssueTargetOrder(GetSummonedUnit(), "attack", udg_SK_Reisen01_Target)
        endif
        return false
    endif
    return false
endfunction

function Trig_Reisen_Attack_Actions takes nothing returns nothing
    local unit caster = GetEventDamageSource()
    local unit target = GetTriggerUnit()
    local integer ab02level = GetUnitAbilityLevel(GetPlayerCharacter(GetOwningPlayer(caster)), 'A0PJ')
    local real damage = 1.0
    local real krsv = 0.0
    local real krsu = 0.0
    local real a = AngleBetweenUnits(target, caster)
    local real b = GetUnitFacing(target)
    set udg_SK_Reisen01_Target = target
    set krsv = GetUnitMagicResist(target) * 3.5
    if krsv != 0 then
        call UnitAbsDamageTarget(caster, target, krsv)
    endif
    if ab02level >= 1 and not IsUnitType(target, UNIT_TYPE_MECHANICAL) and caster != target then
        if udg_SK_Reisen02 then
            set udg_SK_Reisen02 = false
            set a = RAbsBJ(b - a)
            set damage = 1.0
            if a >= 135.0 then
                set damage = 1.5
            endif
            call DestroyEffect(AddSpecialEffectTarget("Abilities\\Weapons\\VengeanceMissile\\VengeanceMissile.mdl", target, "chest"))
            if udg_NewDebuffSys then
                call UnitSlowTargetMspd(caster, target, 10 + ab02level * 10, 2.0 * damage, 2, 0)
                call UnitCurseTargetNew(caster, target, 10 + ab02level * 10, 2.0 * damage, 1, 'A04W')
            else
                if ab02level == 1 then
                    call UnitSlowTarget(caster, target, 2.0 * damage, 'A12H', 'B06N')
                    call UnitCurseTarget(caster, target, 2.0 * damage, 'A000', "curse")
                elseif ab02level == 2 then
                    call UnitSlowTarget(caster, target, 2.0 * damage, 'A12I', 'B06N')
                    call UnitCurseTarget(caster, target, 2.0 * damage, 'A12E', "curse")
                elseif ab02level == 3 then
                    call UnitSlowTarget(caster, target, 2.0 * damage, 'A12J', 'B06N')
                    call UnitCurseTarget(caster, target, 2.0 * damage, 'A12F', "curse")
                else
                    call UnitSlowTarget(caster, target, 2.0 * damage, 'A12K', 'B06N')
                    call UnitCurseTarget(caster, target, 2.0 * damage, 'A12G', "curse")
                endif
            endif
            set krsu = ABCIAllInt(caster, 30 * ab02level, 1.0) * damage
            call UnitMagicDamageTarget(caster, target, krsu, 1)
            call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Human\\Feedback\\ArcaneTowerAttack.mdl", target, "chest"))
        endif
    endif
    set caster = null
    set target = null
endfunction

function InitTrig_Reisen_Attack takes nothing returns nothing
endfunction