function HINA02 takes nothing returns integer
    return 'A0DZ'
endfunction

function Trig_Hina02_Lightning takes unit u1, unit u2 returns nothing
    local real x1
    local real y1
    local real z1
    local real x2
    local real y2
    local real z2
    local lightning e
    if u1 != null and u2 != null then
        set x1 = GetUnitX(u1)
        set y1 = GetUnitY(u1)
        set z1 = 50.0 + GetPositionZ(x1, y1)
        set x2 = GetUnitX(u2)
        set y2 = GetUnitY(u2)
        set z2 = 50.0 + GetPositionZ(x2, y2)
        set e = AddLightningEx("MBUR", false, x1, y1, z1, x2, y2, z2)
        call TSU_DestroyLightning(0.25, e)
    endif
    set e = null
endfunction

function Trig_Hina02_Damage takes nothing returns nothing
    local trigger trg = GetTriggeringTrigger()
    local integer task = GetHandleId(trg)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit u = GetTriggerUnit()
    local unit v = GetEnumUnit()
    local integer level = LoadInteger(udg_ht, task, 0)
    local real damage = level * 0.07 * GetEventDamage()
    local real HP = GetWidgetLife(v)
    set damage = RMinBJ(damage, GetWidgetLife(u))
    if HP > 1.0 and v != u then
        if HP < damage then
            set damage = damage - HP - 1.0
        endif
        call SetUnitOwner(udg_SK_HinaUnit01, GetOwningPlayer(caster), true)
        call UnitAbsDamageTarget(udg_SK_HinaUnit01, v, damage)
    endif
    set trg = null
    set caster = null
    set u = null
    set v = null
endfunction

function Trig_Hina02_Main takes nothing returns nothing
    local trigger trg = GetTriggeringTrigger()
    local integer task = GetHandleId(trg)
    local group g = LoadGroupHandle(udg_ht, task, 2)
    if GetTriggerEventId() != EVENT_UNIT_DAMAGED then
        call FlushChildHashtable(udg_ht, task)
        call DestroyGroup(g)
        call DestroyTrigger(trg)
    elseif udg_A_DamagingUnit != udg_SK_HinaUnit01 then
        call DisableTrigger(trg)
        call ForGroup(g, function Trig_Hina02_Damage)
        call EnableTrigger(trg)
    endif
    set trg = null
    set g = null
endfunction

function Trig_Hina02_Filter takes nothing returns boolean
    local unit u = GetFilterUnit()
    local unit v = GetSpellTargetUnit()
    local unit w = GetTriggerUnit()
    if GetUnitAbilityLevel(u, 'Aloc') != 0 then
        set u = null
        set v = null
        set w = null
        return false
    elseif IsUnitType(u, UNIT_TYPE_STRUCTURE) then
        set u = null
        set v = null
        set w = null
        return false
    elseif GetWidgetLife(u) < 0.405 then
        set u = null
        set v = null
        set w = null
        return false
    elseif IsUnitAlly(u, GetOwningPlayer(w)) then
        set u = null
        set v = null
        set w = null
        return false
    elseif not IsUnitVisible(u, GetOwningPlayer(w)) then
        set u = null
        set v = null
        set w = null
        return false
    elseif u != v then
        set u = null
        set v = null
        set w = null
        return true
    endif
    set u = null
    set v = null
    set w = null
    return false
endfunction

function Trig_Hina02_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local filterfunc f = Filter(function Trig_Hina02_Filter)
    local group g = CreateGroup()
    local group m = CreateGroup()
    local unit array v
    local unit u
    local integer level = GetUnitAbilityLevel(caster, 'A0DZ')
    local trigger trg = CreateTrigger()
    local integer task = GetHandleId(trg)
    local integer i
    local string StringFX = "Abilities\\Spells\\Undead\\Curse\\CurseTarget.mdl"
    call AbilityCoolDownResetion(caster, 'A0DZ', 25)
    call GroupEnumUnitsInRange(m, GetUnitX(target), GetUnitY(target), 500.0, f)
    set v[0] = caster
    set v[1] = target
    set i = 1
    set u = v[1]
    loop
        call Trig_Hina02_Lightning(v[i - 1], u)
        call UnitInjureTarget(caster, u, 6.0)
        call TSU_AddSpecialEffectTarget(StringFX, u, "overhead", 20.0)
        call UnitAbsDamageTarget(caster, u, 25 + level * 25)
        call TriggerRegisterUnitEvent(trg, u, EVENT_UNIT_DAMAGED)
        call GroupAddUnit(g, u)
        set i = i + 1
    exitwhen i > 5
        set u = FirstOfGroup(m)
    exitwhen u == null
        call GroupRemoveUnit(m, u)
        set v[i] = u
    endloop
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, target)
    call SaveGroupHandle(udg_ht, task, 2, g)
    call SaveInteger(udg_ht, task, 0, level)
    call TriggerRegisterTimerEvent(trg, 15.0, false)
    call TriggerAddAction(trg, function Trig_Hina02_Main)
    call DestroyGroup(m)
    call DestroyFilter(f)
    set caster = null
    set target = null
    set trg = null
    set g = null
    set m = null
    set f = null
    set v[0] = null
    set v[1] = null
    set v[2] = null
    set v[3] = null
    set v[4] = null
    set v[5] = null
endfunction

function Trig_Hina02_EffectApply_New takes nothing returns nothing
    local unit source = udg_PS_Source
    local player p = GetOwningPlayer(source)
    local unit target = udg_PS_Target
    local integer level
    call KillUnit(source)
    call DebugMsg("Step5")
    if IsUnitAlly(target, p) then
        set level = GetUnitAbilityLevel(target, 'A0DZ')
        call UnitRemoveAbility(target, 'A0DZ')
        call UnitAddAbility(target, 'A0DZ')
        call SetUnitAbilityLevel(target, 'A0DZ', level)
        call UnitGainMana(target, 30.0)
    else
        set source = GetPlayerCharacter(p)
        set level = GetUnitAbilityLevel(source, 'A0DZ')
        call UnitMagicDamageTarget(source, target, (30 * level + GetHeroInt(source, true) * 0.4) * 2.0, 2)
        call UnitStunTarget(source, target, (0.5 + level * 0.1) * 2.0, 0, 0)
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Undead\\DeathandDecay\\DeathandDecayDamage.mdl", GetUnitX(target), GetUnitY(target)))
    endif
    set p = null
    set source = null
    set target = null
endfunction

function Trig_Hina02_EffectMain_New takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local player p = LoadPlayerHandle(udg_ht, task, 1)
    local real x = LoadReal(udg_ht, task, 2)
    local real y = LoadReal(udg_ht, task, 3)
    local unit eu = LoadUnitHandle(udg_ht, task, 4)
    local unit v
    local group g = LoadGroupHandle(udg_ht, task, 5)
    local real timeleft = LoadReal(udg_ht, task, 5)
    local boolean b = false
    call GroupEnumUnitsInRange(g, x, y, 150.0, null)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if IsUnitType(v, UNIT_TYPE_HERO) then
            call DebugMsg("Step4")
            if (IsUnitAlly(v, p) and GetUnitAbilityLevel(v, 'A0DZ') != 0) or IsUnitEnemy(v, p) then
                call LaunchProjectileToUnit("Abilities\\Weapons\\AvengerMissile\\AvengerMissile.mdl", 1.5, eu, 900, v, "Trig_Hina02_EffectApply_New")
                set b = true
            endif
        endif
    exitwhen b
    endloop
    set timeleft = timeleft - 0.04
    if timeleft <= 0.0 or b then
        if not b then
            call KillUnit(eu)
        endif
        call ReleaseTimer(t)
        call DestroyGroup(g)
        call FlushChildHashtable(udg_ht, task)
    else
        call SaveReal(udg_ht, task, 5, timeleft)
    endif
    set eu = null
    set t = null
    set p = null
    set v = null
    set g = null
endfunction

function Trig_Hina02_Effect_New takes nothing returns nothing
    local player p = udg_PS_Source_Player
    local real x = udg_PS_CurrentX
    local real y = udg_PS_CurrentY
    local unit u
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local group g = CreateGroup()
    call DebugMsg("Step3")
    call SavePlayerHandle(udg_ht, task, 1, p)
    call SaveReal(udg_ht, task, 2, x)
    call SaveReal(udg_ht, task, 3, y)
    call SaveUnitHandle(udg_ht, task, 4, CreateUnit(p, 'e03A', x, y, 0))
    call SaveGroupHandle(udg_ht, task, 5, g)
    call SaveReal(udg_ht, task, 5, 10.0)
    call TimerStart(t, 0.04, true, function Trig_Hina02_EffectMain_New)
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Undead\\DeathandDecay\\DeathandDecayDamage.mdl", x, y))
    set u = null
    set t = null
    set g = null
    set p = null
endfunction

function Trig_Hina02_Main_New takes nothing returns nothing
    local unit source = udg_PS_Source
    local player p = udg_PS_Source_Player
    local group g = udg_PS_OnHit_Group
    local real x = udg_PS_CurrentX
    local real y = udg_PS_CurrentY
    local unit u = FirstOfGroup(g)
    local real tx
    local real ty
    local real ox = GetUnitX(source)
    local real oy = GetUnitY(source)
    local real a
    local integer level = GetUnitAbilityLevel(source, 'A0DZ')
    if udg_Hina02_Hit then
        set udg_Hina02_Hit = false
        set source = null
        set g = null
        set u = null
        return
    endif
    if u != null then
        if IsUnitEnemy(u, GetOwningPlayer(source)) and not IsUnitType(u, UNIT_TYPE_STRUCTURE) then
            call UnitMagicDamageTarget(source, u, 30 * level + GetHeroInt(source, true) * 0.4, 2)
            call UnitStunTarget(source, u, 0.5 + level * 0.1, 0, 0)
            set tx = GetUnitX(u)
            set ty = GetUnitY(u)
            set a = Atan2(ty - oy, tx - ox)
            call DebugMsg("Step2")
            set udg_Hina02_Hit = true
            call LaunchProjectileFromPointToPoint("Abilities\\Weapons\\AvengerMissile\\AvengerMissile.mdl", 2.5, p, tx, ty, x + 300 * Cos(a), y + 300 * Sin(a), 900, 70, "", "Trig_Hina02_Effect_New", false, false, false)
            call LaunchProjectileFromPointToPoint("Abilities\\Spells\\Other\\BreathOfFire\\BreathOfFireDamage.mdl", 2.5, p, tx, ty, x + 300 * Cos(a), y + 300 * Sin(a), 900, 70, "", "", false, false, false)
        endif
    else
        set a = Atan2(y - oy, x - ox)
        call DebugMsg("Step2")
        call LaunchProjectileFromPointToPoint("Abilities\\Weapons\\AvengerMissile\\AvengerMissile.mdl", 2.5, p, x, y, x + 300 * Cos(a), y + 300 * Sin(a), 900, 70, "", "Trig_Hina02_Effect_New", false, false, false)
        call LaunchProjectileFromPointToPoint("Abilities\\Spells\\Other\\BreathOfFire\\BreathOfFireDamage.mdl", 2.5, p, x, y, x + 300 * Cos(a), y + 300 * Sin(a), 900, 70, "", "", false, false, false)
    endif
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Undead\\DeathandDecay\\DeathandDecayDamage.mdl", tx, ty))
    set u = null
    set source = null
    set g = null
    set p = null
endfunction

function Trig_Hina02_Actions_New takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local real tx = GetSpellTargetX()
    local real ty = GetSpellTargetY()
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real a = Atan2(ty - oy, tx - ox)
    local real dis = 900
    call AbilityCoolDownResetion(caster, 'A0DZ', 13 - GetUnitAbilityLevel(caster, 'A0DZ'))
    call DebugMsg("Step1")
    call LaunchProjectileFromUnitToPoint("Abilities\\Weapons\\AvengerMissile\\AvengerMissile.mdl", 2, caster, ox + dis * Cos(a), oy + dis * Sin(a), 1200.0, 75.0, "Trig_Hina02_Main_New", "Trig_Hina02_Main_New", false, true, true)
    call LaunchProjectileFromUnitToPoint("Abilities\\Spells\\Other\\BreathOfFire\\BreathOfFireDamage.mdl", 2, caster, ox + dis * Cos(a), oy + dis * Sin(a), 1200.0, 75.0, "", "", false, true, true)
    set caster = null
endfunction

function Trig_Hina02_Conditions takes nothing returns boolean
    call DebugMsg("Check")
    if GetSpellAbilityId() == 'A0DZ' then
        call DebugMsg("CheckTrue")
        call Trig_Hina02_Actions()
    endif
    return false
endfunction

function InitTrig_Hina02 takes nothing returns nothing
endfunction