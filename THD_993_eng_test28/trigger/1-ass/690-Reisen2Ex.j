function Trig_Reisen203_Fire_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local real x = LoadReal(udg_ht, task, 0)
    local real y = LoadReal(udg_ht, task, 1)
    local real a = LoadReal(udg_ht, task, 2)
    local integer i = LoadInteger(udg_ht, task, 3)
    local integer l = LoadInteger(udg_ht, task, 4)
    local integer k = 0
    local integer p = LoadInteger(udg_ht, task, 5)
    if l == 0 then
        set k = 1
    else
        set k = -1
    endif
    if i <= p then
        call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\BloodElfSpellThiefMISSILE\\BloodElfSpellThiefMISSILE.mdl", x + i * 45 * CosBJ(a + i * 12 * k), y + i * 45 * SinBJ(a + i * 12 * k)))
        call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\BloodElfSpellThiefMISSILE\\BloodElfSpellThiefMISSILE.mdl", x + i * 45 * CosBJ(a + i * 12 * k + 72), y + i * 45 * SinBJ(a + i * 12 * k + 72)))
        call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\BloodElfSpellThiefMISSILE\\BloodElfSpellThiefMISSILE.mdl", x + i * 45 * CosBJ(a + i * 12 * k + 144), y + i * 45 * SinBJ(a + i * 12 * k + 144)))
        call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\BloodElfSpellThiefMISSILE\\BloodElfSpellThiefMISSILE.mdl", x + i * 45 * CosBJ(a + i * 12 * k + 216), y + i * 45 * SinBJ(a + i * 12 * k + 216)))
        call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\BloodElfSpellThiefMISSILE\\BloodElfSpellThiefMISSILE.mdl", x + i * 45 * CosBJ(a + i * 12 * k + 288), y + i * 45 * SinBJ(a + i * 12 * k + 288)))
    endif
    call SaveInteger(udg_ht, task, 3, i + 1)
    if i >= p then
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
endfunction

function Trig_Reisen203_Fire takes real x, real y, real a, integer p returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call SaveReal(udg_ht, task, 0, x)
    call SaveReal(udg_ht, task, 1, y)
    call SaveReal(udg_ht, task, 2, a)
    call SaveInteger(udg_ht, task, 3, 1)
    call SaveInteger(udg_ht, task, 4, GetRandomInt(0, 1))
    call SaveInteger(udg_ht, task, 5, p)
    call TimerStart(t, 0.05, true, function Trig_Reisen203_Fire_Main)
    set t = null
endfunction

function Trig_Reisen2Ex_Fire_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local real x = LoadReal(udg_ht, task, 0)
    local real y = LoadReal(udg_ht, task, 1)
    local real a = LoadReal(udg_ht, task, 2)
    local integer i = LoadInteger(udg_ht, task, 3)
    if i <= 5 then
        call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\AncestralGuardianMissile\\AncestralGuardianMissile.mdl", x + i * 35 * CosBJ(a), y + i * 35 * SinBJ(a)))
        call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\AncestralGuardianMissile\\AncestralGuardianMissile.mdl", x + i * 35 * CosBJ(a + 90), y + i * 35 * SinBJ(a + 90)))
        call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\AncestralGuardianMissile\\AncestralGuardianMissile.mdl", x + i * 35 * CosBJ(a + 180), y + i * 35 * SinBJ(a + 180)))
        call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\AncestralGuardianMissile\\AncestralGuardianMissile.mdl", x + i * 35 * CosBJ(a + 270), y + i * 35 * SinBJ(a + 270)))
    endif
    call SaveInteger(udg_ht, task, 3, i + 1)
    if i >= 5 then
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
endfunction

function Trig_Reisen2Ex_Fire takes real x, real y, real a returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call SaveReal(udg_ht, task, 0, x)
    call SaveReal(udg_ht, task, 1, y)
    call SaveReal(udg_ht, task, 2, a)
    call SaveInteger(udg_ht, task, 3, 1)
    call TimerStart(t, 0.04, true, function Trig_Reisen2Ex_Fire_Main)
    set t = null
endfunction

function Trig_Reisen2Ex_Conditions takes nothing returns boolean
    if GetUnitAbilityLevel(GetEventDamageSource(), 'A090') == 0 then
        return false
    elseif IsUnitAlly(GetTriggerUnit(), GetOwningPlayer(GetEventDamageSource())) then
        return false
    elseif IsUnitType(GetTriggerUnit(), UNIT_TYPE_STRUCTURE) then
        return false
    elseif GetEventDamage() == 0 then
        return false
    elseif IsUnitIllusion(GetEventDamageSource()) then
        return false
    elseif IsDamageNotUnitAttack(GetEventDamageSource()) then
        return false
    endif
    return true
endfunction

function Trig_Reisen2Ex_Actions takes nothing returns nothing
    local unit caster = GetEventDamageSource()
    local unit target = GetTriggerUnit()
    local integer level03 = GetUnitAbilityLevel(caster, 'A092')
    local real attackdamage = 5 + level03 * 5 + GetUnitAttack(caster) * (0.02 + 0.02 * level03)
    local real ab03extradam = udg_SK_Reisen203_ExtraDam
    local integer ab03p = 0
    if level03 >= 1 then
        if GetUnitAbilityLevel(caster, 'A0B5') > 0 and GetWidgetLife(target) > 0.405 then
            call UnitPhysicalDamageTarget(caster, target, ab03extradam * 0.25)
            call UnitPhysicalDamageTarget(caster, target, ab03extradam * 0.25)
            call UnitPhysicalDamageTarget(caster, target, ab03extradam * 0.25)
            call UnitPhysicalDamageTarget(caster, target, ab03extradam * 0.25)
            set ab03p = R2I(RMaxBJ(ab03extradam * 0.05, 1))
            call Trig_Reisen203_Fire(GetUnitX(target), GetUnitY(target), GetRandomInt(0, 72), ab03p)
            call UnitRemoveAbility(caster, 'A0B5')
            set udg_SK_Reisen203_ExtraDam = 0
        endif
        call UnitPhysicalDamageArea(caster, GetUnitX(target), GetUnitY(target), 225.0, attackdamage)
    endif
    if udg_SK_Reisen2Ex_Time >= 8.0 then
        set udg_SK_Reisen2Ex_Time = 0.0
        call Trig_Reisen2Ex_Fire(GetUnitX(target), GetUnitY(target), GetRandomInt(0, 90))
        call UnitDelDamageTarget(caster, target, GetHeroLevel(caster) * 5 + 40)
        call UnitHealingTarget(caster, caster, GetHeroLevel(caster) * 4 + 32)
    endif
    if IsUnitType(target, UNIT_TYPE_HERO) and GetUnitAbilityLevel(caster, 'A0BA') >= 1 then
        call UnitBuffTarget(caster, caster, 4.0, 'A0B9', 0)
        call UnitBuffTarget(caster, caster, 4.0, 'A0BA', 'B07G')
    endif
    set caster = null
    set target = null
endfunction

function InitTrig_Reisen2Ex takes nothing returns nothing
endfunction