function sa__Kagerou_w_wSkill_Action takes nothing returns boolean
    local timer t = GetExpiredTimer()
    local timer t1 = null
    local group g = CreateGroup()
    local unit sp = null
    local integer w = LoadInteger(udg_ht, GetHandleId(t), 0)
    set udg_s__Kagerou_w_i[w] = udg_s__Kagerou_w_i[w] + 1
    call SetUnitX(udg_s__Kagerou_w_caster[w], GetUnitX(udg_s__Kagerou_w_caster[w]) + Cos(udg_s__Kagerou_w_a[w]) * udg_Kagerou__Kagerou01_SPEED * 0.02)
    call SetUnitY(udg_s__Kagerou_w_caster[w], GetUnitY(udg_s__Kagerou_w_caster[w]) + Sin(udg_s__Kagerou_w_a[w]) * udg_Kagerou__Kagerou01_SPEED * 0.02)
    if udg_s__Kagerou_w_i[w] > udg_s__Kagerou_w_maxi[w] then
        set t1 = CreateTimer()
        call SaveInteger(udg_ht, GetHandleId(t1), 0, w)
        call TimerStart(t1, 1.5, false, function sc__Kagerou_w_wSkill_AOE_Action)
        call PauseUnit(udg_s__Kagerou_w_caster[w], false)
        call SetUnitInvulnerable(udg_s__Kagerou_w_caster[w], false)
        call FlushChildHashtable(udg_ht, GetHandleId(t))
        call ReleaseTimer(t)
        call DestroyGroup(g)
        call DestroyGroup(udg_s__Kagerou_w_g2[w])
    else
        set t1 = CreateTimer()
        call GroupEnumUnitsInRange(g, GetUnitX(udg_s__Kagerou_w_caster[w]), GetUnitY(udg_s__Kagerou_w_caster[w]), 120, udg_s__Kagerou_w_iff[w])
        set udg_s__Kagerou_w_u[w] = FirstOfGroup(g)
        if udg_s__Kagerou_w_u[w] != null and (not IsUnitType(udg_s__Kagerou_w_u[w], UNIT_TYPE_STRUCTURE) and GetWidgetLife(udg_s__Kagerou_w_u[w]) > 0.405) and IsUnitType(udg_s__Kagerou_w_u[w], UNIT_TYPE_HERO) then
            call PauseUnit(udg_s__Kagerou_w_caster[w], true)
            call SetUnitInvulnerable(udg_s__Kagerou_w_caster[w], true)
            call SetUnitVertexColor(udg_s__Kagerou_w_caster[w], 255, 255, 255, 100)
            call UnitStunTarget(udg_s__Kagerou_w_caster[w], udg_s__Kagerou_w_u[w], 1.5, 0, 0)
            call SaveInteger(udg_ht, GetHandleId(t1), 1, LoadInteger(udg_ht, GetHandleId(t), 0))
            call ReleaseTimer(t)
            set udg_s__Kagerou_w_i[w] = 0
            set udg_s__Kagerou_w_a[w] = Atan2(udg_s__Kagerou_w_oy[w] - GetUnitY(udg_s__Kagerou_w_u[w]), udg_s__Kagerou_w_ox[w] - GetUnitX(udg_s__Kagerou_w_u[w]))
            call UnitAddAbility(udg_s__Kagerou_w_u[w], 'Arav')
            call UnitRemoveAbility(udg_s__Kagerou_w_u[w], 'Arav')
            set udg_s__Kagerou_w_n[w] = 1
            loop
                set sp = CreateUnit(GetOwningPlayer(udg_s__Kagerou_w_caster[w]), 'h01P', GetUnitX(udg_s__Kagerou_w_u[w]) + 200 * Cos(udg_s__Kagerou_w_a[w] + 1.57 * udg_s__Kagerou_w_n[w]), GetUnitY(udg_s__Kagerou_w_u[w]) + 200 * Sin(udg_s__Kagerou_w_a[w] + 1.57 * udg_s__Kagerou_w_n[w]), 0)
                call SetUnitVertexColor(sp, 255, 255, 255, 100)
                call GroupAddUnit(udg_s__Kagerou_w_g2[w], sp)
                call PauseUnit(sp, true)
            exitwhen udg_s__Kagerou_w_n[w] >= 3
                set udg_s__Kagerou_w_n[w] = udg_s__Kagerou_w_n[w] + 1
            endloop
            call TimerStart(t1, 0.02, true, function s__Kagerou_w_wSkill_main)
        else
            call DestroyGroup(g)
        endif
    endif
    set t = null
    set t1 = null
    set g = null
    set sp = null
    return true
endfunction

function sa__Kagerou_w_wSkill_AOE_Action takes nothing returns boolean
    local timer t = GetExpiredTimer()
    local timer t1 = CreateTimer()
    local integer w = LoadInteger(udg_ht, GetHandleId(t), 0)
    call DebugMsg("Kagerou04 Aoe")
    set udg_s__Kagerou_w_EffectUnit[w] = CreateUnit(GetOwningPlayer(udg_s__Kagerou_w_caster[w]), udg_Kagerou__Kagerou02_EFFECT_UNIT_CODE, udg_s__Kagerou_w_ox[w], udg_s__Kagerou_w_oy[w], udg_s__Kagerou_w_a[w] / 3.14 * 180)
    set udg_s__Kagerou_w_AoeStep[w] = 0
    set udg_s__Kagerou_w_AoeDmgGrp[w] = CreateGroup()
    call SaveInteger(udg_ht, GetHandleId(t1), 0, w)
    call TimerStart(t1, 0.02, true, function sc__Kagerou_w_wSkill_AOE_Main)
    call FlushChildHashtable(udg_ht, GetHandleId(t))
    set t = null
    set t1 = null
    return true
endfunction

function sa__Kagerou_w_wSkill_AOE_Main takes nothing returns boolean
    local timer t = GetExpiredTimer()
    local integer w = LoadInteger(udg_ht, GetHandleId(t), 0)
    local group g = CreateGroup()
    local unit v = null
    local real x = udg_s__Kagerou_w_ox[w] + udg_Kagerou__Kagerou01_SPEED * 3 * 0.02 * udg_s__Kagerou_w_AoeStep[w] * Cos(udg_s__Kagerou_w_a[w])
    local real y = udg_s__Kagerou_w_oy[w] + udg_Kagerou__Kagerou01_SPEED * 3 * 0.02 * udg_s__Kagerou_w_AoeStep[w] * Sin(udg_s__Kagerou_w_a[w])
    set udg_s__Kagerou_w_AoeStep[w] = udg_s__Kagerou_w_AoeStep[w] + 1
    call SetUnitX(udg_s__Kagerou_w_EffectUnit[w], x)
    call SetUnitY(udg_s__Kagerou_w_EffectUnit[w], y)
    call GroupEnumUnitsInRange(g, x, y, 333.3, null)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if IsUnitEnemy(v, GetOwningPlayer(udg_s__Kagerou_w_caster[w])) and GetWidgetLife(v) > 0.405 and not IsUnitType(v, UNIT_TYPE_MECHANICAL) and not (GetCustomState(v, 7) != 0) then
            if IsUnitInGroup(v, udg_s__Kagerou_w_AoeDmgGrp[w]) == false then
                call GroupAddUnit(udg_s__Kagerou_w_AoeDmgGrp[w], v)
                call UnitPhysicalDamageTarget(udg_s__Kagerou_w_caster[w], v, udg_s__Kagerou_w_damage[w])
                call Kagerou__Kagerou_r_COUNT(udg_s__Kagerou_w_caster[w], v)
                call UnitInjureTarget(udg_s__Kagerou_w_caster[w], v, 4.0)
            endif
        endif
    endloop
    if udg_s__Kagerou_w_AoeStep[w] > 25 then
        call KillUnit(udg_s__Kagerou_w_EffectUnit[w])
        call DestroyGroup(udg_s__Kagerou_w_AoeDmgGrp[w])
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, GetHandleId(t))
        call s__Kagerou_w_destroy(w)
    endif
    call DestroyGroup(g)
    set g = null
    set v = null
    set t = null
    return true
endfunction

function sa__Kagerou_f_fSkill_Action takes nothing returns boolean
    local timer t = GetExpiredTimer()
    local integer this = LoadInteger(udg_ht, GetHandleId(t), 0)
    local real x = udg_s__Kagerou_f_ox[this] + udg_s__Kagerou_f_speed[this] * 0.02 * udg_s__Kagerou_f_i[this] * Cos(udg_s__Kagerou_f_radian[this])
    local real y = udg_s__Kagerou_f_oy[this] + udg_s__Kagerou_f_speed[this] * 0.02 * udg_s__Kagerou_f_i[this] * Sin(udg_s__Kagerou_f_radian[this])
    local group g = CreateGroup()
    local unit v
    set udg_s__Kagerou_f_i[this] = udg_s__Kagerou_f_i[this] + 1
    call SetUnitX(udg_s__Kagerou_f_EffectUnit[this], x)
    call SetUnitY(udg_s__Kagerou_f_EffectUnit[this], y)
    call GroupEnumUnitsInRange(g, x, y, udg_s__Kagerou_f_HitBox_Size[this], null)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if IsUnitEnemy(v, GetOwningPlayer(udg_s__Kagerou_f_caster[this])) and GetWidgetLife(v) > 0.405 and not IsUnitType(v, UNIT_TYPE_MECHANICAL) and not (GetCustomState(v, 7) != 0) then
            if IsUnitInGroup(v, udg_s__Kagerou_f_dmggrp[this]) == false then
                call GroupAddUnit(udg_s__Kagerou_f_dmggrp[this], v)
                if udg_s__Kagerou_f_isslow[this] then
                    call UnitSlowTarget(udg_s__Kagerou_f_caster[this], v, 2.0, 'A1HT', 'B0A6')
                endif
                call UnitPhysicalDamageTarget(udg_s__Kagerou_f_caster[this], v, udg_s__Kagerou_f_damage[this])
            endif
        endif
    endloop
    if udg_s__Kagerou_f_speed[this] * 0.02 * udg_s__Kagerou_f_i[this] > udg_s__Kagerou_f_range[this] then
        call FlushChildHashtable(udg_ht, GetHandleId(t))
        call ReleaseTimer(t)
        call s__Kagerou_f_destroy(this)
    endif
    call DestroyGroup(g)
    set t = null
    set g = null
    set v = null
    return true
endfunction

function sa__Kagerou_d_dSkill_Action takes nothing returns boolean
    local timer t = GetExpiredTimer()
    local integer this = LoadInteger(udg_ht, GetHandleId(t), 0)
    local unit sp = null
    local integer SkillLevel
    local group g = CreateGroup()
    local unit v = null
    local real nx
    local real ny
    set udg_s__Kagerou_d_i[this] = udg_s__Kagerou_d_i[this] + 1
    set nx = GetUnitX(udg_s__Kagerou_d_caster[this]) + Cos(udg_s__Kagerou_d_a[this]) * udg_Kagerou__Kagerou01_SPEED * 0.02
    set ny = GetUnitY(udg_s__Kagerou_d_caster[this]) + Sin(udg_s__Kagerou_d_a[this]) * udg_Kagerou__Kagerou01_SPEED * 0.02
    if IsTerrainPathable(nx, ny, PATHING_TYPE_FLYABILITY) == false then
        call SetUnitX(udg_s__Kagerou_d_caster[this], nx)
        call SetUnitY(udg_s__Kagerou_d_caster[this], ny)
    endif
    if udg_s__Kagerou_d_i[this] < 13 then
        call SetUnitFlyHeight(udg_s__Kagerou_d_caster[this], GetUnitFlyHeight(udg_s__Kagerou_d_caster[this]) + udg_Kagerou__Kagerou01_FLYRATE * 0.02, 99999)
    else
        call SetUnitFlyHeight(udg_s__Kagerou_d_caster[this], GetUnitFlyHeight(udg_s__Kagerou_d_caster[this]) - udg_Kagerou__Kagerou01_FLYRATE * 0.02, 99999)
    endif
    if udg_s__Kagerou_d_i[this] > 25 then
        set udg_s__Kagerou_d_cx[this] = GetUnitX(udg_s__Kagerou_d_caster[this])
        set udg_s__Kagerou_d_cy[this] = GetUnitY(udg_s__Kagerou_d_caster[this])
        call SetUnitPathing(udg_s__Kagerou_d_caster[this], true)
        call GroupEnumUnitsInRange(g, udg_s__Kagerou_d_cx[this], udg_s__Kagerou_d_cy[this], udg_Kagerou__Kagerou01_AOE, null)
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if IsUnitEnemy(v, GetOwningPlayer(udg_s__Kagerou_d_caster[this])) and GetWidgetLife(v) > 0.405 and not IsUnitType(v, UNIT_TYPE_MECHANICAL) and not (GetCustomState(v, 7) != 0) then
                call UnitPhysicalDamageTarget(udg_s__Kagerou_d_caster[this], v, udg_s__Kagerou_d_damage[this])
            endif
        endloop
        if Kagerou__KagerouEx2_HAS_BUFF(udg_s__Kagerou_d_caster[this]) then
            call Kagerou__KagerouEx2_CLEAR_BUFF(udg_s__Kagerou_d_caster[this])
            set SkillLevel = GetUnitAbilityLevel(udg_s__Kagerou_d_caster[this], udg_Kagerou__Kagerou01)
            call UnitRemoveAbility(udg_s__Kagerou_d_caster[this], udg_Kagerou__Kagerou01)
            call UnitAddAbility(udg_s__Kagerou_d_caster[this], udg_Kagerou__Kagerou01)
            call SetUnitAbilityLevel(udg_s__Kagerou_d_caster[this], udg_Kagerou__Kagerou01, SkillLevel)
        endif
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Undead\\OrbOfDeath\\AnnihilationMissile.mdl", udg_s__Kagerou_d_cx[this], udg_s__Kagerou_d_cy[this]))
        call FlushChildHashtable(udg_ht, GetHandleId(t))
        call ReleaseTimer(t)
        call s__Kagerou_d_destroy(this)
    endif
    call DestroyGroup(g)
    set g = null
    set v = null
    set t = null
    set sp = null
    return true
endfunction

function sa__Kulumi02_projectile_Kulumi02Sleep takes nothing returns boolean
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit v
    local group g
    local integer i
    local real dis
    local real a
    local integer m = LoadInteger(udg_ht, GetHandleId(t), 0)
    if udg_s__Kulumi02_projectile_i[m] > 12 then
        call KillUnit(udg_s__Kulumi02_projectile_c[m])
    else
        set udg_s__Kulumi02_projectile_i[m] = udg_s__Kulumi02_projectile_i[m] + 1
    endif
    if GetUnitState(udg_s__Kulumi02_projectile_c[m], UNIT_STATE_MANA) == 1000 then
        call KillUnit(udg_s__Kulumi02_projectile_c[m])
    endif
    if GetWidgetLife(udg_s__Kulumi02_projectile_c[m]) >= 0.405 then
        set i = 0
        loop
        exitwhen i >= 15
            set dis = GetRandomReal(0, udg_Kulumi__Kulumi02_AOE)
            set a = GetRandomInt(0, 360)
            call DestroyEffect(AddSpecialEffect("Objects\\Spawnmodels\\Human\\HumanBlood\\BloodElfSpellThiefBlood.mdl", GetUnitX(udg_s__Kulumi02_projectile_c[m]) + dis * CosBJ(a), GetUnitY(udg_s__Kulumi02_projectile_c[m]) + dis * SinBJ(a)))
            set i = i + 1
        endloop
        set g = CreateGroup()
        call GroupEnumUnitsInRange(g, GetUnitX(udg_s__Kulumi02_projectile_c[m]), GetUnitY(udg_s__Kulumi02_projectile_c[m]), udg_Kulumi__Kulumi02_AOE, udg_s__Kulumi02_projectile_iff[m])
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if udg_NewDebuffSys then
                call UnitDebuffTarget(udg_s__Kulumi02_projectile_c[m], v, 0.5 * 1.0, 2, true, 'A04D', 1, 'B084', "drunkenhaze", 'A05P', "")
            else
                call UnitCurseTarget(udg_s__Kulumi02_projectile_c[m], v, 0.5, 'A11G', "drunkenhaze")
            endif
        endloop
        call DestroyGroup(g)
    else
        call ShowUnit(udg_s__Kulumi02_projectile_u[m], true)
        call SetUnitX(udg_s__Kulumi02_projectile_u[m], udg_s__Kulumi02_projectile_cx[m])
        call SetUnitY(udg_s__Kulumi02_projectile_u[m], udg_s__Kulumi02_projectile_cy[m])
        call SetUnitFacingTimed(udg_s__Kulumi02_projectile_u[m], udg_s__Kulumi02_projectile_cfacing[m], 0)
        call SetUnitAnimation(udg_s__Kulumi02_projectile_u[m], "stand")
        call SetUnitInvulnerable(udg_s__Kulumi02_projectile_u[m], false)
        call PauseUnit(udg_s__Kulumi02_projectile_u[m], false)
        call SelectUnitForPlayerSingle(udg_s__Kulumi02_projectile_u[m], GetOwningPlayer(udg_Kulumi))
        call FlushChildHashtable(udg_ht, task)
        call UnitRemoveAbility(udg_s__Kulumi02_projectile_e[m], 'A17B')
        loop
            set v = FirstOfGroup(udg_s__Kulumi02_projectile_g1[m])
        exitwhen v == null
            call GroupRemoveUnit(udg_s__Kulumi02_projectile_g1[m], v)
            call RemoveUnit(v)
        endloop
        call DestroyGroup(udg_s__Kulumi02_projectile_g1[m])
        set udg_Kulumi_i = 0
        call s__Kulumi02_projectile_destroy(m)
        call ReleaseTimer(t)
    endif
    set t = null
    set v = null
    set g = null
    return true
endfunction

function sa__Futo05_EffectLoop takes nothing returns boolean
    local timer t = GetExpiredTimer()
    local unit caster = LoadUnitHandle(udg_ht, GetHandleId(t), 0)
    local unit effectUnit1 = LoadUnitHandle(udg_ht, GetHandleId(t), 1)
    local unit effectUnit2 = LoadUnitHandle(udg_ht, GetHandleId(t), 2)
    local unit effectUnit3 = LoadUnitHandle(udg_ht, GetHandleId(t), 3)
    local unit effectUnit4 = LoadUnitHandle(udg_ht, GetHandleId(t), 4)
    if GetUnitAbilityLevel(caster, udg_Futo___Futo05_FLAG_ID) == 0 then
        if IsUnitHidden(effectUnit1) == false then
            call DebugMsg("Hide Effect")
            call ShowUnit(effectUnit1, false)
            call ShowUnit(effectUnit2, false)
            call ShowUnit(effectUnit3, false)
            call ShowUnit(effectUnit4, false)
        endif
    else
        if IsUnitHidden(effectUnit1) then
            call DebugMsg("Show Effect")
            call ShowUnit(effectUnit1, true)
            call ShowUnit(effectUnit2, true)
            call ShowUnit(effectUnit3, true)
            call ShowUnit(effectUnit4, true)
            call UnitRemoveAbility(effectUnit1, 'Aloc')
            call UnitRemoveAbility(effectUnit2, 'Aloc')
            call UnitRemoveAbility(effectUnit3, 'Aloc')
            call UnitRemoveAbility(effectUnit4, 'Aloc')
            call UnitAddAbility(effectUnit1, 'Aloc')
            call UnitAddAbility(effectUnit2, 'Aloc')
            call UnitAddAbility(effectUnit3, 'Aloc')
            call UnitAddAbility(effectUnit4, 'Aloc')
        endif
        call SetUnitX(effectUnit1, GetUnitX(caster))
        call SetUnitY(effectUnit1, GetUnitY(caster))
        call SetUnitX(effectUnit2, GetUnitX(caster))
        call SetUnitY(effectUnit2, GetUnitY(caster))
        call SetUnitX(effectUnit3, GetUnitX(caster))
        call SetUnitY(effectUnit3, GetUnitY(caster))
        call SetUnitX(effectUnit4, GetUnitX(caster))
        call SetUnitY(effectUnit4, GetUnitY(caster))
    endif
    set caster = null
    set effectUnit1 = null
    set effectUnit2 = null
    set effectUnit3 = null
    set effectUnit4 = null
    return true
endfunction

function sa__Futo05_trg_attack_func takes nothing returns boolean
    local unit s = GetEventDamageSource()
    local unit d = GetTriggerUnit()
    local unit v
    local boolean yinyang = udg_Futo___FutoEx_Flag
    local real damage
    local group g
    local integer damageUnitCount
    local location loc
    local timer t
    local integer alvl = GetUnitAbilityLevel(s, udg_Futo___Futo05_ID)
    local real getLife
    local real asd
    local real adv
    local real asv
    local real dx
    local real dy
    if GetUnitAbilityLevel(s, udg_Futo___Futo05_FLAG_ID) == 0 or alvl == 0 then
        set s = null
        set d = null
        set udg_f__result_boolean = false
        return true
    elseif IsUnitIllusion(s) then
        set s = null
        set d = null
        set udg_f__result_boolean = false
        return true
    elseif IsUnitAlly(d, GetOwningPlayer(s)) then
        set s = null
        set d = null
        set udg_f__result_boolean = false
        return true
    elseif GetEventDamage() == 0 then
        set s = null
        set d = null
        set udg_f__result_boolean = false
        return true
    elseif IsDamageNotUnitAttack(s) then
        set s = null
        set d = null
        set udg_f__result_boolean = false
        return true
    endif
    call UnitRemoveAbility(s, udg_Futo___Futo05_FLAG_ID)
    set t = CreateTimer()
    call SaveUnitHandle(udg_ht, GetHandleId(t), 0, s)
    call TimerStart(t, udg_Futo___Futo05_PERIOD, false, function sc__Futo05_AddFlag)
    set dx = GetUnitX(d) - GetUnitX(s)
    set dy = GetUnitY(d) - GetUnitY(s)
    set asd = Atan2(dy, dx)
    set damage = udg_Futo___Futo05_DAMAGE_BASE + udg_Futo___Futo05_DAMAGE_SCALC * GetUnitAbilityLevel(s, udg_Futo___Futo05_ID) + GetHeroInt(s, true) * udg_Futo___Futo05_DAMAGE_INT
    if yinyang == false then
        set damageUnitCount = 0
        set loc = GetUnitLoc(d)
        set g = YDWEGetUnitsInRangeOfLocMatchingNull(udg_Futo___Futo05_RANGE * 1.0, loc, null)
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if GetUnitState(v, UNIT_STATE_LIFE) > 0.405 and IsUnitEnemy(v, GetOwningPlayer(s)) and not IsUnitType(v, UNIT_TYPE_MECHANICAL) and v != d then
                set dx = GetUnitX(v) - GetUnitX(d)
                set dy = GetUnitY(v) - GetUnitY(d)
                set adv = Atan2(dy, dx)
                set dx = GetUnitX(v) - GetUnitX(s)
                set dy = GetUnitY(v) - GetUnitY(s)
                set asv = Atan2(dy, dx)
                if RAbsBJ(adv - asd) < udg_Futo___Futo05_SPURTING_ANGLE_A and RAbsBJ(asv - asd) < udg_Futo___Futo05_SPURTING_ANGLE_B then
                    call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Demon\\DemonBoltImpact\\DemonBoltImpact.mdl", v, "origin"))
                    call UnitDelDamageTarget(s, v, damage * udg_Futo___Futo05_DAMAGE_PERCENT_OTHERS_UNIT)
                    call UnitAbsDamageTarget(s, v, damage * udg_Futo___Futo05_DAMAGE_PERCENT_OTHERS_UNIT)
                    call UnitPhysicalDamageTarget(s, v, damage * udg_Futo___Futo05_DAMAGE_PERCENT_OTHERS_UNIT)
                    call UnitMagicDamageTarget(s, v, damage * udg_Futo___Futo05_DAMAGE_PERCENT_OTHERS_UNIT, 1)
                endif
            endif
        endloop
        call DestroyGroup(g)
        set g = null
        call RemoveLocation(loc)
        set loc = null
    else
        call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Human\\ManaFlare\\ManaFlareBoltImpact.mdl", d, "origin"))
        call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Other\\Parasite\\ParasiteTarget.mdl", s, "overhead"))
        set getLife = udg_Futo___Futo05_GET_LIFE_DAMAGE_PERCENT * damage * 4
        call DebugMsg("Futo05 Info:Get Life " + R2S(getLife))
        call SetUnitState(s, UNIT_STATE_LIFE, RMinBJ(GetUnitState(s, UNIT_STATE_MAX_LIFE), GetUnitState(s, UNIT_STATE_LIFE) + getLife))
    endif
    call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Demon\\DemonBoltImpact\\DemonBoltImpact.mdl", d, "origin"))
    call UnitDelDamageTarget(s, d, damage)
    call UnitAbsDamageTarget(s, d, damage)
    call UnitPhysicalDamageTarget(s, d, damage)
    call UnitMagicDamageTarget(s, d, damage, 1)
    call DebugMsg("Futo05 Info:  damage=" + R2S(damage))
    call DebugMsg(R2S(udg_Futo___Futo05_DAMAGE_BASE) + "+" + R2S(udg_Futo___Futo05_DAMAGE_SCALC) + "*" + I2S(GetUnitAbilityLevel(s, udg_Futo___Futo05_ID)) + "+" + I2S(GetHeroInt(s, true)) + "*" + R2S(udg_Futo___Futo05_DAMAGE_INT))
    set s = null
    set d = null
    set v = null
    set udg_f__result_boolean = false
    return true
endfunction

function sa__Futo05_AddFlag takes nothing returns boolean
    local timer t = GetExpiredTimer()
    local unit caster = LoadUnitHandle(udg_ht, GetHandleId(t), 0)
    call RemoveSavedHandle(udg_ht, GetHandleId(t), 0)
    call UnitAddAbility(caster, udg_Futo___Futo05_FLAG_ID)
    return true
endfunction

function sa__Futo05_onDestroy takes nothing returns boolean
    return true
endfunction

function sa__Futo04_ready takes nothing returns boolean
    local timer t = GetExpiredTimer()
    local integer this = LoadInteger(udg_ht, GetHandleId(t), 0)
    if udg_s__Futo04_readyTimercount[this] == 3.0 then
        call SetTextTagColor(udg_s__Futo04_txt[this], 255, 0, 0, 255)
    endif
    call SetTextTagTextBJ(udg_s__Futo04_txt[this], R2SW(udg_s__Futo04_readyTimercount[this], 3, 1), 14.0)
    call SetTextTagPos(udg_s__Futo04_txt[this], GetUnitX(udg_s__Futo04_caster[this]), GetUnitY(udg_s__Futo04_caster[this]), 200.0)
    if IsVisibleToPlayer(GetUnitX(udg_s__Futo04_caster[this]), GetUnitY(udg_s__Futo04_caster[this]), GetLocalPlayer()) == false then
        call SetTextTagVisibility(udg_s__Futo04_txt[this], false)
    else
        call SetTextTagVisibility(udg_s__Futo04_txt[this], true)
    endif
    set udg_s__Futo04_readyTimercount[this] = udg_s__Futo04_readyTimercount[this] + 0.1
    if udg_s__Futo04_readyTimercount[this] > udg_Futo___Futo04_READY_MAX_DURATION or udg_s__Futo04_end[this] then
        if udg_s__Futo04_end[this] == false then
            call SetPlayerAbilityAvailable(GetOwningPlayer(udg_s__Futo04_caster[this]), udg_Futo___Futo04_ID, true)
            call SetPlayerAbilityAvailable(GetOwningPlayer(udg_s__Futo04_caster[this]), udg_Futo___Futo04_CAST_ID, false)
            call sc__Futo04_deallocate(this)
        endif
        call ReleaseTimer(t)
        call RemoveSavedInteger(udg_ht, GetHandleId(t), 0)
        call RemoveSavedInteger(udg_ht, GetHandleId(udg_s__Futo04_caster[this]), GetHandleId(udg_s__Futo04_caster[this]) + udg_Futo___Futo04_HASHTABLE_OFFSET)
    endif
    set t = null
    return true
endfunction

function sa__Futo04_cast takes nothing returns boolean
    local timer t = GetExpiredTimer()
    local integer this = LoadInteger(udg_ht, GetHandleId(t), 0)
    local group g
    local unit v
    local real distanceX
    local real distanceY
    local integer slowAbiliLvl
    if udg_s__Futo04_slowpercent[this] < udg_Futo___Futo04_SLOW_MIN_BASE + udg_Futo___Futo04_SLOW_MIN_SCALC then
        set slowAbiliLvl = 0
    elseif udg_s__Futo04_slowpercent[this] > udg_Futo___Futo04_SLOW_MAX_BASE + 4 * udg_Futo___Futo04_SLOW_MAX_SCALC then
        set slowAbiliLvl = 5
    else
        set slowAbiliLvl = R2I(udg_s__Futo04_slowpercent[this]) / 5 - 5
    endif
    if udg_s__Futo04_movetimes[this] > 0 then
        set udg_s__Futo04_movetimes[this] = udg_s__Futo04_movetimes[this] - 1
        call SetUnitX(udg_s__Futo04_effectU[this], GetUnitX(udg_s__Futo04_effectU[this]) + Cos(udg_s__Futo04_radian[this]) * udg_s__Futo04_speed[this])
        call SetUnitY(udg_s__Futo04_effectU[this], GetUnitY(udg_s__Futo04_effectU[this]) + Sin(udg_s__Futo04_radian[this]) * udg_s__Futo04_speed[this])
    else
        set g = YDWEGetUnitsInRangeOfLocMatchingNull(udg_Futo___Futo04_RANGE * 1.0, GetUnitLoc(udg_s__Futo04_effectU[this]), null)
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if IsUnitEnemy(v, GetOwningPlayer(udg_s__Futo04_caster[this])) and GetWidgetLife(v) > 0.405 and not IsUnitType(v, UNIT_TYPE_MECHANICAL) and not (GetCustomState(v, 7) != 0) then
                set distanceX = GetUnitX(udg_s__Futo04_effectU[this]) - GetUnitX(v)
                set distanceY = GetUnitY(udg_s__Futo04_effectU[this]) - GetUnitY(v)
                if udg_s__Futo04_yinyang[this] then
                    if udg_NewDebuffSys then
                        call UnitSlowTargetMspd(udg_s__Futo04_caster[this], v, udg_s__Futo04_slowpercent[this], 3, 3, 0)
                    else
                        call sc__Futo04_SlowTarget(this, v, slowAbiliLvl)
                    endif
                    call UnitMagicDamageTarget(udg_s__Futo04_caster[this], v, udg_s__Futo04_damage[this], 1)
                else
                    call UnitMagicDamageTarget(udg_s__Futo04_caster[this], v, udg_s__Futo04_damage[this] + udg_s__Futo04_damageadd[this], 1)
                endif
            endif
        endloop
        call DestroyGroup(g)
        call DestroyEffect(AddSpecialEffectLoc("Abilities\\Spells\\Human\\Thunderclap\\ThunderClapCaster.mdl", GetUnitLoc(udg_s__Futo04_effectU[this])))
        call RemoveSavedInteger(udg_ht, GetHandleId(t), 0)
        call ReleaseTimer(t)
        call sc__Futo04_deallocate(this)
    endif
    set t = null
    set g = null
    set v = null
    return true
endfunction

function sa__Futo04_SlowTarget takes nothing returns boolean
    call s__Futo04_SlowTarget(udg_f__arg_this, udg_f__arg_unit1, udg_f__arg_integer1)
    return true
endfunction

function sa__Futo04_onDestroy takes nothing returns boolean
    local integer this = udg_f__arg_this
    if udg_s__Futo04_effectU[this] != null then
        call KillUnit(udg_s__Futo04_effectU[this])
        set udg_s__Futo04_effectU[this] = null
    endif
    if udg_s__Futo04_txt[this] != null then
        call DestroyTextTag(udg_s__Futo04_txt[this])
        set udg_s__Futo04_txt[this] = null
    endif
    return true
endfunction

function sa__Futo03_ClearProtect takes nothing returns boolean
    local timer t = GetExpiredTimer()
    local unit u = LoadUnitHandle(udg_ht, GetHandleId(t), 0)
    call UnitRemoveAbility(u, 'A0UG')
    call UnitRemoveAbility(u, 'B09S')
    call DebugMsg("Clear Protect")
    call RemoveSavedReal(udg_ht, StringHash("Futo03_Protect"), GetHandleId(u))
    call RemoveSavedHandle(udg_ht, StringHash("Futo03_Protect_Timer"), GetHandleId(u))
    call RemoveSavedHandle(udg_ht, GetHandleId(t), 0)
    call ReleaseTimer(t)
    set t = null
    set u = null
    return true
endfunction

function sa__Futo03_flyup takes nothing returns boolean
    local timer t = GetExpiredTimer()
    local integer this = LoadInteger(udg_ht, GetHandleId(t), 0)
    local group g
    local unit v
    local location loc
    call SetUnitFlyHeight(udg_s__Futo03_ship[this], udg_s__Futo03_flyupTimercount[this] * 100, 100)
    if udg_s__Futo03_yinyang[this] == false then
        call s__Futo03_protectHero(this)
    endif
    set udg_s__Futo03_flyupTimercount[this] = udg_s__Futo03_flyupTimercount[this] + 0.1
    if udg_s__Futo03_flyupTimercount[this] > udg_Futo___Futo03_FLYUP_DURATION or udg_s__Futo03_setLoc[this] then
        set loc = GetUnitLoc(udg_s__Futo03_ship[this])
        if udg_s__Futo03_setLoc[this] then
            call DebugMsg("Set destination")
            if udg_s__Futo03_yinyang[this] then
                set udg_s__Futo03_byship[this] = CreateGroup()
                set g = YDWEGetUnitsInRangeOfLocMatchingNull(udg_Futo___Futo03_RANGE * 1.0, loc, null)
                loop
                    set v = FirstOfGroup(g)
                exitwhen v == null
                    call GroupRemoveUnit(g, v)
                    if IsUnitAlly(v, GetOwningPlayer(udg_s__Futo03_caster[this])) and IsUnitType(v, UNIT_TYPE_HERO) then
                        call IssueImmediateOrder(v, "stop")
                        call SetUnitInvulnerable(v, true)
                        call ShowUnit(v, false)
                        call SetUnitFlag(v, 1, true)
                        call GroupAddUnit(udg_s__Futo03_byship[this], v)
                    endif
                endloop
                call DestroyGroup(g)
            endif
            call SetUnitFlyHeight(udg_s__Futo03_ship[this], 0, 300 / udg_s__Futo03_flyupTimercount[this])
        endif
        call DebugMsg(R2S(udg_s__Futo03_flyupTimercount[this]))
        call SetPlayerAbilityAvailable(GetOwningPlayer(udg_s__Futo03_caster[this]), udg_Futo___Futo03_ID, true)
        call UnitRemoveAbility(udg_s__Futo03_caster[this], udg_Futo___Futo03_SETLOC_ID)
        set udg_s__Futo03_radian[this] = Atan2(GetLocationY(udg_s__Futo03_des[this]) - GetUnitY(udg_s__Futo03_ship[this]), GetLocationX(udg_s__Futo03_des[this]) - GetUnitX(udg_s__Futo03_ship[this]))
        set udg_s__Futo03_speed[this] = DistanceBetweenPoints(loc, udg_s__Futo03_des[this]) / udg_Futo___Futo03_MOVE_DURATION * 0.01
        call RemoveSavedInteger(udg_ht, GetHandleId(t), 0)
        call ReleaseTimer(t)
        set t = CreateTimer()
        call SaveInteger(udg_ht, GetHandleId(t), 0, this)
        call TimerStart(t, 0.01, true, function sc__Futo03_move)
        set udg_Futo___Futo03_i = 0
        call UnRegisterAreaShow(udg_s__Futo03_ship[this], udg_Futo___Futo03_ID)
        call RemoveLocation(loc)
        set loc = null
    endif
    set t = null
    set g = null
    set v = null
    return true
endfunction

function sa__Futo03_move takes nothing returns boolean
    local timer t = GetExpiredTimer()
    local integer this = LoadInteger(udg_ht, GetHandleId(t), 0)
    local unit v
    local real movex = GetLocationX(udg_s__Futo03_des[this]) - GetLocationX(udg_s__Futo03_src[this])
    local real movey = GetLocationY(udg_s__Futo03_des[this]) - GetLocationY(udg_s__Futo03_src[this])
    local real x
    local real y
    local real ox
    local real oy
    local real px
    local real py
    local real dx
    local real dy
    local real a
    local real d
    local boolean theDes = false
    local location shipLoc = GetUnitLoc(udg_s__Futo03_ship[this])
    if udg_s__Futo03_yinyang[this] == false then
        call s__Futo03_protectHero(this)
    endif
    if DistanceBetweenPoints(shipLoc, udg_s__Futo03_des[this]) < udg_s__Futo03_speed[this] then
        set theDes = true
        call DebugMsg("Futo03 Info:The destination!")
    else
        call SetUnitX(udg_s__Futo03_ship[this], GetUnitX(udg_s__Futo03_ship[this]) + Cos(udg_s__Futo03_radian[this]) * udg_s__Futo03_speed[this])
        call SetUnitY(udg_s__Futo03_ship[this], GetUnitY(udg_s__Futo03_ship[this]) + Sin(udg_s__Futo03_radian[this]) * udg_s__Futo03_speed[this])
    endif
    set udg_s__Futo03_moveTimercount[this] = udg_s__Futo03_moveTimercount[this] + 0.01
    if theDes or udg_s__Futo03_moveTimercount[this] > udg_Futo___Futo03_MOVE_DURATION then
        set ox = GetUnitX(udg_s__Futo03_ship[this])
        set oy = GetUnitY(udg_s__Futo03_ship[this])
        if udg_s__Futo03_yinyang[this] then
            loop
                set v = FirstOfGroup(udg_s__Futo03_byship[this])
            exitwhen v == null
                call GroupRemoveUnit(udg_s__Futo03_byship[this], v)
                call SetUnitInvulnerable(v, false)
                call ShowUnit(v, true)
                call SetUnitFlag(v, 1, false)
                set x = GetUnitX(v) + movex
                set y = GetUnitY(v) + movey
                set dx = x - ox
                set dy = y - oy
                set a = Atan2(dy, dx)
                set d = SquareRoot(dx * dx + dy * dy)
                set px = ox + d * Cos(a)
                set py = oy + d * Sin(a)
                call Trig_BlinkPlaceRealer(px, py, d, a)
                set x = udg_SK_BlinkPlace_x
                set y = udg_SK_BlinkPlace_y
                call SetUnitX(v, x)
                call SetUnitY(v, y)
                call SelectUnitForPlayerSingle(v, GetOwningPlayer(v))
            endloop
        endif
        call ReleaseTimer(t)
        call RemoveSavedInteger(udg_ht, GetHandleId(t), 0)
        call sc__Futo03_deallocate(this)
    endif
    call RemoveLocation(shipLoc)
    set shipLoc = null
    set t = null
    set v = null
    return true
endfunction

function sa__Futo03_onDestroy takes nothing returns boolean
    local integer this = udg_f__arg_this
    call RemoveLocation(udg_s__Futo03_des[this])
    set udg_s__Futo03_des[this] = null
    call RemoveLocation(udg_s__Futo03_src[this])
    set udg_s__Futo03_src[this] = null
    call KillUnit(udg_s__Futo03_ship[this])
    set udg_s__Futo03_ship[this] = null
    if udg_s__Futo03_byship[this] != null then
        call DestroyGroup(udg_s__Futo03_byship[this])
        set udg_s__Futo03_byship[this] = null
    endif
    return true
endfunction

function sa__Futo02_dotLoop takes nothing returns boolean
    local timer t = GetExpiredTimer()
    local integer this = LoadInteger(udg_ht, GetHandleId(t), 0)
    local group g = YDWEGetUnitsInRangeOfLocMatchingNull(udg_Futo___Futo02_RANGE * 1.0, GetUnitLoc(udg_s__Futo02_caster[this]), null)
    local unit v
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if IsUnitEnemy(v, GetOwningPlayer(udg_s__Futo02_caster[this])) and GetWidgetLife(v) > 0.405 and not IsUnitType(v, UNIT_TYPE_MECHANICAL) and not (GetCustomState(v, 7) != 0) then
            call UnitMagicDamageTarget(udg_s__Futo02_caster[this], v, udg_s__Futo02_damageOnce[this], 1)
        endif
    endloop
    set udg_s__Futo02_dotTimercount[this] = udg_s__Futo02_dotTimercount[this] + udg_Futo___Futo02_DAMAGE_RATE
    if udg_s__Futo02_dotTimercount[this] > udg_Futo___Futo02_DURATION then
        call UnitRemoveAbility(udg_s__Futo02_caster[this], udg_Futo___Futo02_WEAKEN_DAMAGE_BOOK_ID)
        call RemoveSavedInteger(udg_ht, GetHandleId(t), 0)
        call ReleaseTimer(t)
        call UnRegisterAreaShow(udg_s__Futo02_caster[this], udg_Futo___Futo02_ID)
        call sc__Futo02_deallocate(this)
    endif
    call DestroyGroup(g)
    set t = null
    set g = null
    set v = null
    return true
endfunction

function sa__Futo02_trg_spelloruseitem_func takes nothing returns boolean
    local unit tu = GetTriggerUnit()
    local integer this = udg_Futo___Futo02_Now
    local timer t
    if udg_s__Futo02_cando[this] == false then
        set udg_f__result_boolean = false
        return true
    endif
    if GetWidgetLife(udg_s__Futo02_caster[this]) < 0.405 then
        call UnRegisterAreaShow(udg_s__Futo02_caster[this], udg_Futo___Futo02_ID)
        call DestroyTrigger(GetTriggeringTrigger())
    endif
    if not IsUnitInRange(tu, udg_s__Futo02_caster[this], udg_Futo___Futo02_RANGE) or IsUnitAlly(tu, GetOwningPlayer(udg_s__Futo02_caster[this])) or not IsUnitType(tu, UNIT_TYPE_HERO) or GetCustomState(tu, 7) != 0 then
        set udg_f__result_boolean = false
        return true
    endif
    set udg_s__Futo02_cando[this] = false
    call UnitMagicDamageTarget(udg_s__Futo02_caster[this], tu, udg_s__Futo02_counterDamage[this], 1)
    call UnitStunTarget(udg_s__Futo02_caster[this], tu, udg_Futo___Futo02_COUNTER_STUN_DURATION, 0, 0)
    call TimedLightning(AddLightningEx("MBUR", false, GetUnitX(udg_s__Futo02_caster[this]), GetUnitY(udg_s__Futo02_caster[this]), 200, GetUnitX(tu), GetUnitY(tu), 100), 0.4)
    set t = CreateTimer()
    call SaveInteger(udg_ht, GetHandleId(t), 0, this)
    call TimerStart(t, udg_Futo___Futo02_PERIOD, false, function sc__Futo02_resetCando)
    set t = null
    set tu = null
    set udg_f__result_boolean = false
    return true
endfunction

function sa__Futo02_resetCando takes nothing returns boolean
    local timer t = GetExpiredTimer()
    local integer this = LoadInteger(udg_ht, GetHandleId(t), 0)
    call RemoveSavedInteger(udg_ht, GetHandleId(t), 0)
    set udg_s__Futo02_cando[this] = true
    set t = null
    return true
endfunction

function sa__Futo02_clearTrg takes nothing returns boolean
    local timer t = GetExpiredTimer()
    local integer this = LoadInteger(udg_ht, GetHandleId(t), 0)
    call RemoveSavedInteger(udg_ht, GetHandleId(t), 0)
    call UnRegisterAreaShow(udg_s__Futo02_caster[this], udg_Futo___Futo02_ID)
    call DestroyTrigger(udg_s__Futo02_spelloruseitemTrg[this])
    set udg_s__Futo02_spelloruseitemTrg[this] = null
    call sc__Futo02_deallocate(this)
    return true
endfunction

function sa__Futo02_onDestroy takes nothing returns boolean
    local integer this = udg_f__arg_this
    set udg_s__Futo02_caster[this] = null
    if udg_s__Futo02_spelloruseitemTrg[this] != null then
        call DestroyTrigger(udg_s__Futo02_spelloruseitemTrg[this])
        set udg_s__Futo02_spelloruseitemTrg[this] = null
    endif
    return true
endfunction

function sa__Futo01_timerPushFunc takes nothing returns boolean
    local timer t = GetExpiredTimer()
    local integer this = LoadInteger(udg_ht, GetHandleId(t), 0)
    local real YinYangFlag
    local unit v
    local real vx
    local real vy
    local real vxx
    local real vyy
    local group g = CreateGroup()
    call GroupAddGroup(udg_s__Futo01_pushG[this], g)
    if udg_s__Futo01_yinyang[this] then
        set YinYangFlag = -1
    else
        set YinYangFlag = 1
    endif
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if GetWidgetLife(v) > 0.405 and GetUnitAbilityLevel(v, udg_Futo___Futo01_PUSH_BUFF) > 0 then
            set vx = GetUnitX(v)
            set vy = GetUnitY(v)
            set vxx = (vx - udg_s__Futo01_dx[this]) * Cos(6.18 - udg_s__Futo01_face[this]) - (vy - udg_s__Futo01_dy[this]) * Sin(6.18 - udg_s__Futo01_face[this])
            set vyy = (vx - udg_s__Futo01_dx[this]) * Sin(6.18 - udg_s__Futo01_face[this]) + (vy - udg_s__Futo01_dy[this]) * Cos(6.18 - udg_s__Futo01_face[this])
            if IsTerrainPathable(vx, vy, PATHING_TYPE_WALKABILITY) == false then
                call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Undead\\CarrionSwarm\\CarrionSwarmDamage.mdl", vx, vy))
                if YinYangFlag * vxx < 0 then
                    if RAbsBJ(vxx) > udg_Futo___Futo01_MOVE_ONCE then
                        call SetUnitX(v, vx - Cos(udg_s__Futo01_face[this]) * udg_Futo___Futo01_MOVE_ONCE)
                        call SetUnitY(v, vy - Sin(udg_s__Futo01_face[this]) * udg_Futo___Futo01_MOVE_ONCE)
                    endif
                else
                    call SetUnitX(v, vx + Cos(udg_s__Futo01_face[this]) * udg_Futo___Futo01_MOVE_ONCE)
                    call SetUnitY(v, vy + Sin(udg_s__Futo01_face[this]) * udg_Futo___Futo01_MOVE_ONCE)
                endif
            endif
        else
            call GroupRemoveUnit(udg_s__Futo01_pushG[this], v)
        endif
    endloop
    call DestroyGroup(g)
    set g = null
    if udg_s__Futo01_timercount[this] > udg_Futo___Futo01_PUSH_DURATION then
        call ReleaseTimer(t)
        call RemoveSavedInteger(udg_ht, GetHandleId(t), 0)
        call DestroyGroup(udg_s__Futo01_pushG[this])
        set udg_s__Futo01_pushG[this] = null
    endif
    return true
endfunction

function sa__Futo01_timerMainFunc takes nothing returns boolean
    local timer t = GetExpiredTimer()
    local integer this = LoadInteger(udg_ht, GetHandleId(t), 0)
    local group g
    local unit v
    local real vx
    local real vy
    local real vxx
    local real vyy
    local location loc
    local unit dummy
    if udg_Futo___FutoEx_Flag then
        call DestroyEffect(AddSpecialEffect("BatAppear.mdx", udg_s__Futo01_dx[this] + ModuloReal(udg_s__Futo01_timercount[this], 1) * udg_Futo___Futo01_RANGE * Cos(udg_s__Futo01_face[this] + 1.57), udg_s__Futo01_dy[this] + ModuloReal(udg_s__Futo01_timercount[this], 1) * udg_Futo___Futo01_RANGE * Sin(udg_s__Futo01_face[this] + 1.57)))
        call DestroyEffect(AddSpecialEffect("BatAppear.mdx", udg_s__Futo01_dx[this] + ModuloReal(udg_s__Futo01_timercount[this], 1) * udg_Futo___Futo01_RANGE * Cos(udg_s__Futo01_face[this] + 4.71), udg_s__Futo01_dy[this] + ModuloReal(udg_s__Futo01_timercount[this], 1) * udg_Futo___Futo01_RANGE * Sin(udg_s__Futo01_face[this] + 4.71)))
    else
        call DestroyEffect(AddSpecialEffect("BatAppear.mdx", udg_s__Futo01_dx[this] + (1.0 - ModuloReal(udg_s__Futo01_timercount[this], 1)) * udg_Futo___Futo01_RANGE * Cos(udg_s__Futo01_face[this] + 1.57), udg_s__Futo01_dy[this] + (1.0 - ModuloReal(udg_s__Futo01_timercount[this], 1)) * udg_Futo___Futo01_RANGE * Sin(udg_s__Futo01_face[this] + 1.57)))
        call DestroyEffect(AddSpecialEffect("BatAppear.mdx", udg_s__Futo01_dx[this] + (1.0 - ModuloReal(udg_s__Futo01_timercount[this], 1)) * udg_Futo___Futo01_RANGE * Cos(udg_s__Futo01_face[this] + 4.71), udg_s__Futo01_dy[this] + (1.0 - ModuloReal(udg_s__Futo01_timercount[this], 1)) * udg_Futo___Futo01_RANGE * Sin(udg_s__Futo01_face[this] + 4.71)))
    endif
    set loc = Location(udg_s__Futo01_dx[this], udg_s__Futo01_dy[this])
    set g = YDWEGetUnitsInRangeOfLocMatchingNull(udg_s__Futo01_radius[this] * 1.0, loc, null)
    call RemoveLocation(loc)
    set loc = null
    set dummy = NewDummy(GetOwningPlayer(udg_s__Futo01_caster[this]), udg_s__Futo01_dx[this], udg_s__Futo01_dy[this], 0.0)
    call UnitAddAbility(dummy, udg_Futo___Futo01_ENSNARE)
    call SetUnitAbilityLevel(dummy, udg_Futo___Futo01_ENSNARE, udg_s__Futo01_alvl[this])
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        set vx = GetUnitX(v)
        set vy = GetUnitY(v)
        set vxx = (vx - udg_s__Futo01_dx[this]) * Cos(6.18 - udg_s__Futo01_face[this]) - (vy - udg_s__Futo01_dy[this]) * Sin(6.18 - udg_s__Futo01_face[this])
        set vyy = (vx - udg_s__Futo01_dx[this]) * Sin(6.18 - udg_s__Futo01_face[this]) + (vy - udg_s__Futo01_dy[this]) * Cos(6.18 - udg_s__Futo01_face[this])
        if vxx > -udg_Futo___Futo01_RANGE and vxx < udg_Futo___Futo01_RANGE and vyy > -udg_Futo___Futo01_RANGE and vyy < udg_Futo___Futo01_RANGE then
            if IsUnitEnemy(v, GetOwningPlayer(udg_s__Futo01_caster[this])) and GetWidgetLife(v) > 0.405 and not IsUnitType(v, UNIT_TYPE_MECHANICAL) and not (GetCustomState(v, 7) != 0) then
                if RAbsBJ(vxx) <= udg_Futo___Futo01_DOOR_RANGE and IsUnitInGroup(v, udg_s__Futo01_damagedG[this]) == false then
                    call IssueTargetOrder(dummy, udg_Futo___Futo01_ENSNARE_ORDER, v)
                    call RestrictTarget(udg_s__Futo01_caster[this], v, DebuffDuration(v, udg_Futo___Futo01_ENSNARE_DURATION_BASE + udg_Futo___Futo01_ENSNARE_DURATION_SCALC * udg_s__Futo01_alvl[this]))
                    call UnitMagicDamageTarget(udg_s__Futo01_caster[this], v, udg_s__Futo01_damage[this], 1)
                    call GroupAddUnit(udg_s__Futo01_damagedG[this], v)
                endif
            endif
        endif
    endloop
    call DestroyGroup(g)
    call UnitRemoveAbility(dummy, udg_Futo___Futo01_ENSNARE)
    call RemoveUnit(dummy)
    set dummy = null
    set udg_s__Futo01_timercount[this] = udg_s__Futo01_timercount[this] + udg_Futo___Futo01_RATE
    if udg_s__Futo01_timercount[this] > udg_Futo___Futo01_DURATION then
        call ReleaseTimer(t)
        call RemoveSavedInteger(udg_ht, GetHandleId(t), 0)
        call sc__Futo01_deallocate(this)
    endif
    set t = null
    set v = null
    set g = null
    return true
endfunction

function sa__Futo01_onDestroy takes nothing returns boolean
    local integer this = udg_f__arg_this
    set udg_s__Futo01_caster[this] = null
    call DestroyGroup(udg_s__Futo01_damagedG[this])
    call DestroyGroup(udg_s__Futo01_pushG[this])
    set udg_s__Futo01_damagedG[this] = null
    return true
endfunction

function sa__FutoEx_follwLoop takes nothing returns boolean
    call SetUnitX(udg_s__FutoEx_FutoExEffectUnit, GetUnitX(udg_Futo))
    call SetUnitY(udg_s__FutoEx_FutoExEffectUnit, GetUnitY(udg_Futo))
    return true
endfunction

function sa__Flandre2_04_onClear takes nothing returns boolean
    local timer t = GetExpiredTimer()
    local unit caster = LoadUnitHandle(udg_sht, GetHandleId(t), 0)
    local integer playerId = StringHash("Player" + I2S(GetPlayerId(GetOwningPlayer(caster))))
    local effect e1 = LoadEffectHandle(udg_sht, playerId, StringHash("Flandre2_04Effect01"))
    local effect e2 = LoadEffectHandle(udg_sht, playerId, StringHash("Flandre2_04Effect02"))
    local group g
    local unit tmpunit
    call DebugMsg("Clear Skill04")
    call DestroyEffect(e1)
    call DestroyEffect(e2)
    call RemoveSavedInteger(udg_sht, playerId, StringHash("Flandre2_04"))
    call RemoveSavedInteger(udg_sht, playerId, StringHash("Flandre2_04level"))
    call RemoveSavedInteger(udg_sht, playerId, StringHash("Flandre2_04caster"))
    call RemoveSavedHandle(udg_sht, playerId, StringHash("Flandre2_04Timer"))
    call RemoveSavedHandle(udg_sht, playerId, StringHash("Flandre2_04Effect01"))
    call RemoveSavedHandle(udg_sht, playerId, StringHash("Flandre2_04Effect02"))
    call RemoveSavedHandle(udg_sht, GetHandleId(t), 0)
    set udg_s__Flandre2_04_AttackTrgUse = udg_s__Flandre2_04_AttackTrgUse - 1
    if udg_s__Flandre2_04_AttackTrgUse <= 0 then
        call DisableTrigger(udg_s__Flandre2_04_trgAttack)
    endif
    call ReleaseTimer(t)
    set t = null
    set e1 = null
    set e2 = null
    set caster = null
    set g = null
    set tmpunit = null
    return true
endfunction

function sa__Flandre2_04_onClearTargetDebuff takes nothing returns boolean
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit target = LoadUnitHandle(udg_sht, task, 1)
    call DebugMsg("Clear Target Debuff")
    call UnitRemoveAbility(target, udg_Flandre2__FLANDRE2_04_DEBUFF)
    call ReleaseTimer(t)
    call RemoveSavedHandle(udg_sht, task, 0)
    call RemoveSavedHandle(udg_sht, task, 1)
    call RemoveSavedHandle(udg_sht, GetHandleId(target), StringHash("Flandre2_04TargetTimer"))
    call FlushChildHashtable(udg_sht, task)
    set udg_s__Flandre2_04_DeathTrgUse = udg_s__Flandre2_04_DeathTrgUse - 1
    if udg_s__Flandre2_04_DeathTrgUse <= 0 then
        call DisableTrigger(udg_s__Flandre2_04_trgDeath)
    endif
    set t = null
    set target = null
    return true
endfunction

function sa__Flandre2_02_onSlow takes nothing returns boolean
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_sht, task, 0)
    local unit target = LoadUnitHandle(udg_sht, task, 1)
    local integer lvl = LoadInteger(udg_sht, task, 2)
    local real duration = LoadReal(udg_sht, task, 3) - 0.1
    local unit dummy = LoadUnitHandle(udg_sht, task, 4)
    local real dx = GetUnitX(caster) - GetUnitX(target)
    local real dy = GetUnitY(caster) - GetUnitY(target)
    local real dis = SquareRoot(dx * dx + dy * dy)
    local integer id
    call SaveReal(udg_sht, task, 3, duration)
    set id = 'A1EL'
    if dis <= udg_Flandre2__FLANDRE2_02_DOUBLE_SLOW_RANGE and GetUnitAbilityLevel(target, id) > 0 then
        call DebugMsg("DOUBLE SLOW")
        call IssueTargetOrder(dummy, "slow", target)
    endif
    if duration <= 0.0 or IsUnitDeadBJ(target) or GetUnitAbilityLevel(target, id) == 0 then
        call RemoveSavedHandle(udg_sht, task, 0)
        call RemoveSavedHandle(udg_sht, task, 1)
        call RemoveSavedInteger(udg_sht, task, 2)
        call RemoveSavedReal(udg_sht, task, 3)
        call RemoveSavedHandle(udg_sht, task, 4)
        call UnitRemoveAbility(dummy, 'A1EM')
        call ReleaseDummy(dummy)
        call ReleaseTimer(t)
    endif
    set t = null
    set caster = null
    set target = null
    set dummy = null
    return true
endfunction

function sa__Flandre2_01_countIllusion takes nothing returns boolean
    local timer t = GetExpiredTimer()
    local timer t2
    local unit caster = LoadUnitHandle(udg_sht, GetHandleId(t), 0)
    local group g = CreateGroup()
    local unit tmpunit
    local integer id = GetUnitTypeId(caster)
    call GroupEnumUnitsOfPlayer(g, GetOwningPlayer(caster), null)
    loop
        set tmpunit = FirstOfGroup(g)
    exitwhen tmpunit == null
        call GroupRemoveUnit(g, tmpunit)
        if GetUnitTypeId(tmpunit) == id and IsUnitIllusion(tmpunit) then
            call GroupAddUnit(udg_s__Flandre2_01_IllusionGroup, tmpunit)
            set t2 = CreateTimer()
            call SaveUnitHandle(udg_sht, GetHandleId(t2), 0, tmpunit)
            call TimerStart(t2, 10.5, false, function sc__Flandre2_01_RemoveIllusionFromGroup)
        endif
    endloop
    call DestroyGroup(g)
    call RemoveSavedHandle(udg_sht, GetHandleId(t), 0)
    call ReleaseTimer(t)
    set t = null
    set t2 = null
    set caster = null
    set g = null
    set tmpunit = null
    return true
endfunction

function sa__Flandre2_01_RemoveIllusionFromGroup takes nothing returns boolean
    local timer t = GetExpiredTimer()
    local unit v = LoadUnitHandle(udg_sht, GetHandleId(t), 0)
    call GroupRemoveUnit(udg_s__Flandre2_01_IllusionGroup, v)
    call RemoveSavedHandle(udg_sht, GetHandleId(t), 0)
    call ReleaseTimer(t)
    set t = null
    set v = null
    return true
endfunction

function sa__ReisenNew_laser_laserloop takes nothing returns boolean
    local timer t = GetExpiredTimer()
    local group g2 = CreateGroup()
    local unit v
    local integer b = LoadInteger(udg_ht, GetHandleId(t), 0)
    local real n
    local real distance
    local lightning e = LoadLightningHandle(udg_ht, GetHandleId(t), 0)
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(udg_s__ReisenNew_laser_caster[b]))]
    if udg_s__ReisenNew_laser_i[b] < 30 then
        call DestroyLightning(e)
        set e = AddLightningEx("TCLE", true, udg_s__ReisenNew_laser_cx[b], udg_s__ReisenNew_laser_cy[b], 100, GetUnitX(udg_s__ReisenNew_laser_u[b]), GetUnitY(udg_s__ReisenNew_laser_u[b]), 0)
        call SetUnitX(udg_s__ReisenNew_laser_u[b], udg_s__ReisenNew_laser_cx[b] + Cos(udg_s__ReisenNew_laser_a[b] + udg_s__ReisenNew_laser_i[b] * 0.07) * udg_s__ReisenNew_laser_dis[b])
        call SetUnitY(udg_s__ReisenNew_laser_u[b], udg_s__ReisenNew_laser_cy[b] + Sin(udg_s__ReisenNew_laser_a[b] + udg_s__ReisenNew_laser_i[b] * 0.07) * udg_s__ReisenNew_laser_dis[b])
        call SaveLightningHandle(udg_ht, GetHandleId(t), 0, e)
        set n = udg_s__ReisenNew_laser_dis[b] * 0.1
        set distance = n
        loop
        exitwhen distance > udg_s__ReisenNew_laser_dis[b]
            call GroupEnumUnitsInRange(g2, udg_s__ReisenNew_laser_cx[b] + Cos(udg_s__ReisenNew_laser_a[b] + udg_s__ReisenNew_laser_i[b] * 0.07) * distance, udg_s__ReisenNew_laser_cy[b] + Sin(udg_s__ReisenNew_laser_a[b] + udg_s__ReisenNew_laser_i[b] * 0.07) * distance, n, iff)
            loop
                set v = FirstOfGroup(g2)
            exitwhen v == null
                if not IsUnitType(v, UNIT_TYPE_STRUCTURE) and GetWidgetLife(v) > 0.405 then
                    call GroupAddUnit(udg_s__ReisenNew_laser_g[b], v)
                endif
                call GroupRemoveUnit(g2, v)
            endloop
            set distance = distance + n * 2
        endloop
    else
        call TimerStart(t, 1, false, function s__ReisenNew_laser_laserdamage)
        call DestroyLightning(e)
        call KillUnit(udg_s__ReisenNew_laser_u[b])
    endif
    set udg_s__ReisenNew_laser_i[b] = udg_s__ReisenNew_laser_i[b] + 1
    call DestroyGroup(g2)
    set t = null
    return true
endfunction

function sa__ReisenNew_spell_skill01loop takes nothing returns boolean
    local timer t = GetExpiredTimer()
    local unit v = null
    local unit u
    local real damage = 0
    local group g = CreateGroup()
    local integer s = LoadInteger(udg_ht, GetHandleId(t), 0)
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(udg_s__ReisenNew_spell_caster[s]))]
    call SetUnitX(udg_s__ReisenNew_spell_caster[s], GetUnitX(udg_s__ReisenNew_spell_caster[s]) + Cos(udg_s__ReisenNew_spell_a[s]) * udg_ReisenNew___ReisenNew01_BACK_SPEED * 0.02)
    call SetUnitY(udg_s__ReisenNew_spell_caster[s], GetUnitY(udg_s__ReisenNew_spell_caster[s]) + Sin(udg_s__ReisenNew_spell_a[s]) * udg_ReisenNew___ReisenNew01_BACK_SPEED * 0.02)
    call SetUnitX(udg_s__ReisenNew_spell_u[s], GetUnitX(udg_s__ReisenNew_spell_u[s]) + Cos(udg_s__ReisenNew_spell_a[s] - 3.14) * udg_ReisenNew___ReisenNew01_SHOT_SPEED * 0.02)
    call SetUnitY(udg_s__ReisenNew_spell_u[s], GetUnitY(udg_s__ReisenNew_spell_u[s]) + Sin(udg_s__ReisenNew_spell_a[s] - 3.14) * udg_ReisenNew___ReisenNew01_SHOT_SPEED * 0.02)
    call GroupEnumUnitsInRange(g, GetUnitX(udg_s__ReisenNew_spell_u[s]), GetUnitY(udg_s__ReisenNew_spell_u[s]), 80, iff)
    loop
        set u = FirstOfGroup(g)
    exitwhen u == null
        if not IsUnitType(u, UNIT_TYPE_STRUCTURE) and GetWidgetLife(u) > 0.405 then
            set v = u
        endif
        call GroupRemoveUnit(g, u)
    endloop
    if v != null then
        set damage = UnitMagicDamageTarget(udg_s__ReisenNew_spell_caster[s], v, udg_s__ReisenNew_spell_damage[s], 5)
        if GetUnitAbilityLevel(udg_s__ReisenNew_spell_caster[s], udg_ReisenNew___ReisenNew02_BUFF) > 0 and GetWidgetLife(v) > 0.405 and damage > 1 then
            call s__ReisenNew_projectile_ReisenNew02Main(udg_s__ReisenNew_spell_caster[s], GetUnitX(v), GetUnitY(v))
        endif
        call s__ReisenNew_projectile_ReisenNewEx(udg_s__ReisenNew_spell_caster[s], v)
        call KillUnit(udg_s__ReisenNew_spell_u[s])
        call FlushChildHashtable(udg_ht, GetHandleId(t))
        call ReleaseTimer(t)
        call s__ReisenNew_spell_destroy(s)
    elseif udg_s__ReisenNew_spell_i[s] > 40 then
        call KillUnit(udg_s__ReisenNew_spell_u[s])
        call FlushChildHashtable(udg_ht, GetHandleId(t))
        call ReleaseTimer(t)
        call s__ReisenNew_spell_destroy(s)
    endif
    set udg_s__ReisenNew_spell_i[s] = udg_s__ReisenNew_spell_i[s] + 1
    call DestroyGroup(g)
    set v = null
    set t = null
    set g = null
    return true
endfunction

function sa__ReisenNew_projectile_startloop takes nothing returns boolean
    local timer t = GetExpiredTimer()
    local unit u
    local unit v
    local real a
    local real damage
    local real damagedecrease
    local group g2 = CreateGroup()
    local group g3 = CreateGroup()
    local integer m = LoadInteger(udg_ht, GetHandleId(t), 0)
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(udg_s__ReisenNew_projectile_caster[m]))]
    if udg_s__ReisenNew_projectile_n[m] <= 25 then
        loop
            set u = FirstOfGroup(udg_s__ReisenNew_projectile_g[m])
            set a = GetUnitFacing(u) / 180 * 3.14
        exitwhen u == null
            call SetUnitX(u, GetUnitX(u) + Cos(a) * (udg_ReisenNew___ReisenNew04_SLOW_SPEED - udg_s__ReisenNew_projectile_n[m] * udg_ReisenNew___ReisenNew04_SLOW_ACCESS))
            call SetUnitY(u, GetUnitY(u) + Sin(a) * (udg_ReisenNew___ReisenNew04_SLOW_SPEED - udg_s__ReisenNew_projectile_n[m] * udg_ReisenNew___ReisenNew04_SLOW_ACCESS))
            call GroupEnumUnitsInRange(g2, GetUnitX(u), GetUnitY(u), 100, iff)
            loop
                set v = FirstOfGroup(g2)
            exitwhen v == null
                if not IsUnitType(v, UNIT_TYPE_STRUCTURE) and GetWidgetLife(v) > 0.405 then
                    set damagedecrease = SquareRoot((GetUnitX(v) - udg_s__ReisenNew_projectile_cx[m]) * (GetUnitX(v) - udg_s__ReisenNew_projectile_cx[m]) + (GetUnitY(v) - udg_s__ReisenNew_projectile_cy[m]) * (GetUnitY(v) - udg_s__ReisenNew_projectile_cy[m])) / 500
                    if damagedecrease >= 1 then
                        set damagedecrease = 1
                    elseif damagedecrease <= 0.5 then
                        set damagedecrease = 0.5
                    endif
                    set udg_s__ReisenNew_projectile_damage[m] = udg_s__ReisenNew_projectile_damage[m] * damagedecrease
                    set damage = UnitMagicDamageTarget(udg_s__ReisenNew_projectile_caster[m], v, udg_s__ReisenNew_projectile_damage[m], 5)
                    if GetUnitAbilityLevel(udg_s__ReisenNew_projectile_caster[m], udg_ReisenNew___ReisenNew02_BUFF) > 0 and not IsUnitInRange(v, udg_s__ReisenNew_projectile_caster[m], 200) and GetWidgetLife(v) > 0.405 and damage > 1 then
                        call s__ReisenNew_projectile_ReisenNew02Main(udg_s__ReisenNew_projectile_caster[m], GetUnitX(v), GetUnitY(v))
                    endif
                    call s__ReisenNew_projectile_ReisenNewEx(udg_s__ReisenNew_projectile_caster[m], v)
                    call KillUnit(u)
                endif
                call GroupRemoveUnit(g2, v)
            endloop
            if GetWidgetLife(u) > 0.405 then
                call GroupAddUnit(g3, u)
            endif
            call GroupRemoveUnit(udg_s__ReisenNew_projectile_g[m], u)
        endloop
        loop
            set u = FirstOfGroup(g3)
        exitwhen u == null
            call GroupRemoveUnit(g3, u)
            call GroupAddUnit(udg_s__ReisenNew_projectile_g[m], u)
        endloop
    else
        loop
            set u = FirstOfGroup(udg_s__ReisenNew_projectile_g[m])
            set a = GetUnitFacing(u) / 180 * 3.14
        exitwhen u == null
            call SetUnitX(u, GetUnitX(u) + Cos(a) * ((udg_s__ReisenNew_projectile_n[m] - 25) * udg_ReisenNew___ReisenNew04_ACCESS_ACCESS))
            call SetUnitY(u, GetUnitY(u) + Sin(a) * ((udg_s__ReisenNew_projectile_n[m] - 25) * udg_ReisenNew___ReisenNew04_ACCESS_ACCESS))
            call GroupEnumUnitsInRange(g2, GetUnitX(u), GetUnitY(u), 100, iff)
            loop
                set v = FirstOfGroup(g2)
            exitwhen v == null
                if not IsUnitType(v, UNIT_TYPE_STRUCTURE) and GetWidgetLife(v) > 0.405 then
                    set damagedecrease = SquareRoot((GetUnitX(v) - udg_s__ReisenNew_projectile_cx[m]) * (GetUnitX(v) - udg_s__ReisenNew_projectile_cx[m]) + (GetUnitY(v) - udg_s__ReisenNew_projectile_cy[m]) * (GetUnitY(v) - udg_s__ReisenNew_projectile_cy[m])) / 500
                    if damagedecrease >= 1 then
                        set damagedecrease = 1
                    elseif damagedecrease <= 0.5 then
                        set damagedecrease = 0.5
                    endif
                    set udg_s__ReisenNew_projectile_damage[m] = udg_s__ReisenNew_projectile_damage[m] * damagedecrease
                    set damage = UnitMagicDamageTarget(udg_s__ReisenNew_projectile_caster[m], v, udg_s__ReisenNew_projectile_damage[m], 5)
                    if GetUnitAbilityLevel(udg_s__ReisenNew_projectile_caster[m], udg_ReisenNew___ReisenNew02_BUFF) > 0 and not IsUnitInRange(v, udg_s__ReisenNew_projectile_caster[m], 200) and GetWidgetLife(v) > 0.405 and damage > 1 then
                        call s__ReisenNew_projectile_ReisenNew02Main(udg_s__ReisenNew_projectile_caster[m], GetUnitX(v), GetUnitY(v))
                    endif
                    call s__ReisenNew_projectile_ReisenNewEx(udg_s__ReisenNew_projectile_caster[m], v)
                    call KillUnit(u)
                endif
                call GroupRemoveUnit(g2, v)
            endloop
            if GetWidgetLife(u) > 0.405 then
                call GroupAddUnit(g3, u)
            endif
            call GroupRemoveUnit(udg_s__ReisenNew_projectile_g[m], u)
        endloop
        loop
            set u = FirstOfGroup(g3)
        exitwhen u == null
            call GroupRemoveUnit(g3, u)
            call GroupAddUnit(udg_s__ReisenNew_projectile_g[m], u)
        endloop
    endif
    if udg_s__ReisenNew_projectile_n[m] > 50 then
        loop
            set u = FirstOfGroup(udg_s__ReisenNew_projectile_g[m])
        exitwhen u == null
            call GroupRemoveUnit(udg_s__ReisenNew_projectile_g[m], u)
            call KillUnit(u)
        endloop
        call FlushChildHashtable(udg_ht, GetHandleId(t))
        call ReleaseTimer(t)
        call s__ReisenNew_projectile_destroy(m)
    endif
    set udg_s__ReisenNew_projectile_n[m] = udg_s__ReisenNew_projectile_n[m] + 1
    call DestroyGroup(g2)
    call DestroyGroup(g3)
    set u = null
    set t = null
    return true
endfunction

function sa__YoumuNew_w_wSkill_Action takes nothing returns boolean
    local timer t = GetExpiredTimer()
    local timer t1 = CreateTimer()
    local group g = CreateGroup()
    local unit sp = null
    local integer w = LoadInteger(udg_ht, GetHandleId(t), 0)
    set udg_s__YoumuNew_w_i[w] = udg_s__YoumuNew_w_i[w] + 1
    call SetUnitX(udg_s__YoumuNew_w_caster[w], GetUnitX(udg_s__YoumuNew_w_caster[w]) + Cos(udg_s__YoumuNew_w_a[w]) * udg_YoumuNew__YoumuNew01_SPEED * 0.02)
    call SetUnitY(udg_s__YoumuNew_w_caster[w], GetUnitY(udg_s__YoumuNew_w_caster[w]) + Sin(udg_s__YoumuNew_w_a[w]) * udg_YoumuNew__YoumuNew01_SPEED * 0.02)
    if udg_s__YoumuNew_w_i[w] > 25 then
        call PauseUnit(udg_s__YoumuNew_w_caster[w], false)
        call SetUnitInvulnerable(udg_s__YoumuNew_w_caster[w], false)
        call FlushChildHashtable(udg_ht, GetHandleId(t))
        call ReleaseTimer(t)
        call ReleaseTimer(t1)
        call DestroyGroup(g)
        call DestroyGroup(udg_s__YoumuNew_w_g2[w])
        call s__YoumuNew_w_destroy(w)
    else
        call GroupEnumUnitsInRange(g, GetUnitX(udg_s__YoumuNew_w_caster[w]), GetUnitY(udg_s__YoumuNew_w_caster[w]), 120, udg_s__YoumuNew_w_iff[w])
        set udg_s__YoumuNew_w_u[w] = FirstOfGroup(g)
        if udg_s__YoumuNew_w_u[w] != null and (not IsUnitType(udg_s__YoumuNew_w_u[w], UNIT_TYPE_STRUCTURE) and GetWidgetLife(udg_s__YoumuNew_w_u[w]) > 0.405) and IsUnitType(udg_s__YoumuNew_w_u[w], UNIT_TYPE_HERO) then
            call PauseUnit(udg_s__YoumuNew_w_caster[w], true)
            call SetUnitInvulnerable(udg_s__YoumuNew_w_caster[w], true)
            call SetUnitVertexColor(udg_s__YoumuNew_w_caster[w], 255, 255, 255, 100)
            call UnitStunTarget(udg_s__YoumuNew_w_caster[w], udg_s__YoumuNew_w_u[w], 1.5, 0, 0)
            call SaveInteger(udg_ht, GetHandleId(t1), 1, LoadInteger(udg_ht, GetHandleId(t), 0))
            call ReleaseTimer(t)
            set udg_s__YoumuNew_w_i[w] = 0
            set udg_s__YoumuNew_w_a[w] = Atan2(udg_s__YoumuNew_w_cy[w] - GetUnitY(udg_s__YoumuNew_w_u[w]), udg_s__YoumuNew_w_cx[w] - GetUnitX(udg_s__YoumuNew_w_u[w]))
            call UnitAddAbility(udg_s__YoumuNew_w_u[w], 'Arav')
            call UnitRemoveAbility(udg_s__YoumuNew_w_u[w], 'Arav')
            set udg_s__YoumuNew_w_n[w] = (1) - 1
            loop
set udg_s__YoumuNew_w_n[w] = udg_s__YoumuNew_w_n[w] + 1
exitwhen udg_s__YoumuNew_w_n[w] > (3)
set sp = CreateUnit(GetOwningPlayer(udg_s__YoumuNew_w_caster[w]), 'n057', GetUnitX(udg_s__YoumuNew_w_u[w]) + 200 * Cos(udg_s__YoumuNew_w_a[w] + 1.57 * udg_s__YoumuNew_w_n[w]), GetUnitY(udg_s__YoumuNew_w_u[w]) + 200 * Sin(udg_s__YoumuNew_w_a[w] + 1.57 * udg_s__YoumuNew_w_n[w]), 0)
call SetUnitVertexColor(sp, 255, 255, 255, 100)
call GroupAddUnit(udg_s__YoumuNew_w_g2[w], sp)
call PauseUnit(sp, true)
endloop
            call TimerStart(t1, 0.02, true, function s__YoumuNew_w_wSkill_main)
        else
            call DestroyGroup(g)
            call ReleaseTimer(t1)
        endif
    endif
    set t = null
    set t1 = null
    set g = null
    set sp = null
    return true
endfunction

function sa__YoumuNew_d_dSkill_Action takes nothing returns boolean
    local timer t = GetExpiredTimer()
    local unit sp = null
    local integer d = LoadInteger(udg_ht, GetHandleId(t), 0)
    local real damage03 = (udg_YoumuNew__YoumuNew03_DAMAGE_BASE + udg_YoumuNew__YoumuNew03_DAMAGE_INCREASE * (GetUnitAbilityLevel(udg_s__YoumuNew_d_caster[d], udg_YoumuNew__YoumuNew03) - 1)) / 100
    set udg_s__YoumuNew_d_i[d] = udg_s__YoumuNew_d_i[d] + 1
    call SetUnitX(udg_s__YoumuNew_d_caster[d], GetUnitX(udg_s__YoumuNew_d_caster[d]) + Cos(udg_s__YoumuNew_d_a[d]) * udg_YoumuNew__YoumuNew01_SPEED * 0.02)
    call SetUnitY(udg_s__YoumuNew_d_caster[d], GetUnitY(udg_s__YoumuNew_d_caster[d]) + Sin(udg_s__YoumuNew_d_a[d]) * udg_YoumuNew__YoumuNew01_SPEED * 0.02)
    if udg_s__YoumuNew_d_i[d] < 13 then
        call SetUnitFlyHeight(udg_s__YoumuNew_d_caster[d], GetUnitFlyHeight(udg_s__YoumuNew_d_caster[d]) + udg_YoumuNew__YoumuNew01_FLYRATE * 0.02, 99999)
    else
        call SetUnitFlyHeight(udg_s__YoumuNew_d_caster[d], GetUnitFlyHeight(udg_s__YoumuNew_d_caster[d]) - udg_YoumuNew__YoumuNew01_FLYRATE * 0.02, 99999)
    endif
    if udg_s__YoumuNew_d_i[d] > 25 then
        set udg_s__YoumuNew_d_cx[d] = GetUnitX(udg_s__YoumuNew_d_caster[d])
        set udg_s__YoumuNew_d_cy[d] = GetUnitY(udg_s__YoumuNew_d_caster[d])
        call SetUnitPathing(udg_s__YoumuNew_d_caster[d], true)
        if udg_SK_YoumuNewEx[udg_s__YoumuNew_d_p[d]] == 0 then
            call UnitPhysicalDamageArea(udg_s__YoumuNew_d_caster[d], udg_s__YoumuNew_d_cx[d], udg_s__YoumuNew_d_cy[d], udg_YoumuNew__YoumuNew01_AOE, udg_s__YoumuNew_d_damage[d])
            if GetRandomReal(0, 100) < udg_YoumuNew__YoumuNew03_PROB_BASE + udg_YoumuNew__YoumuNew03_PROB_INCREASE * (GetUnitAbilityLevel(udg_s__YoumuNew_d_caster[d], udg_YoumuNew__YoumuNew03) - 1) then
                set sp = CreateUnit(GetOwningPlayer(udg_s__YoumuNew_d_caster[d]), 'n057', udg_s__YoumuNew_d_cx[d], udg_s__YoumuNew_d_cy[d], GetUnitFacing(udg_s__YoumuNew_d_caster[d]))
                call SetUnitAnimation(sp, "spell five alternate")
                call UnitMagicDamageArea(udg_s__YoumuNew_d_caster[d], udg_s__YoumuNew_d_cx[d], udg_s__YoumuNew_d_cy[d], udg_YoumuNew__YoumuNew01_AOE, udg_s__YoumuNew_d_damage[d] * damage03, 5)
            endif
            call FlushChildHashtable(udg_ht, GetHandleId(t))
            call ReleaseTimer(t)
            call s__YoumuNew_d_destroy(d)
        elseif udg_SK_YoumuNewEx[udg_s__YoumuNew_d_p[d]] == 1 then
            call UnitMagicDamageArea(udg_s__YoumuNew_d_caster[d], udg_s__YoumuNew_d_cx[d], udg_s__YoumuNew_d_cy[d], udg_YoumuNew__YoumuNew01_AOE, udg_s__YoumuNew_d_damage[d], 5)
            if GetRandomReal(0, 100) < udg_YoumuNew__YoumuNew03_PROB_BASE + udg_YoumuNew__YoumuNew03_PROB_INCREASE * (GetUnitAbilityLevel(udg_s__YoumuNew_d_caster[d], udg_YoumuNew__YoumuNew03) - 1) then
                set sp = CreateUnit(GetOwningPlayer(udg_s__YoumuNew_d_caster[d]), 'n057', udg_s__YoumuNew_d_cx[d], udg_s__YoumuNew_d_cy[d], GetUnitFacing(udg_s__YoumuNew_d_caster[d]))
                call SetUnitAnimation(sp, "spell five alternate")
                call UnitPhysicalDamageArea(udg_s__YoumuNew_d_caster[d], udg_s__YoumuNew_d_cx[d], udg_s__YoumuNew_d_cy[d], udg_YoumuNew__YoumuNew01_AOE, udg_s__YoumuNew_d_damage[d] * damage03)
            endif
            call FlushChildHashtable(udg_ht, GetHandleId(t))
            call ReleaseTimer(t)
            call s__YoumuNew_d_destroy(d)
        elseif udg_SK_YoumuNewEx[udg_s__YoumuNew_d_p[d]] == 2 then
            call UnitPhysicalDamageArea(udg_s__YoumuNew_d_caster[d], udg_s__YoumuNew_d_cx[d], udg_s__YoumuNew_d_cy[d], udg_YoumuNew__YoumuNew01_AOE, udg_s__YoumuNew_d_damage[d] * damage03)
            call UnitMagicDamageArea(udg_s__YoumuNew_d_caster[d], udg_s__YoumuNew_d_cx[d], udg_s__YoumuNew_d_cy[d], udg_YoumuNew__YoumuNew01_AOE, udg_s__YoumuNew_d_damage[d] * damage03, 5)
            call s__YoumuNew_d_create(udg_s__YoumuNew_d_caster[d], udg_s__YoumuNew_d_damage[d], udg_s__YoumuNew_d_p[d])
            if udg_SK_YoumuNewExLast[udg_s__YoumuNew_d_p[d]] == 0 then
                call CastSpell(udg_YoumuNew, "Lou Guan Jian")
                call AddUnitAnimationProperties(udg_s__YoumuNew_d_caster[d], "alternate", false)
                call AddUnitAnimationProperties(udg_s__YoumuNew_d_caster[d], "defend upgrade first", true)
            elseif udg_SK_YoumuNewExLast[udg_s__YoumuNew_d_p[d]] == 1 then
                call CastSpell(udg_s__YoumuNew_d_caster[d], "Lou Guan Jian")
                call AddUnitAnimationProperties(udg_s__YoumuNew_d_caster[d], "alternate", false)
                call AddUnitAnimationProperties(udg_s__YoumuNew_d_caster[d], "upgrade first", true)
            endif
            set udg_SK_YoumuNewEx[udg_s__YoumuNew_d_p[d]] = udg_SK_YoumuNewExLast[udg_s__YoumuNew_d_p[d]]
        endif
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Undead\\OrbOfDeath\\AnnihilationMissile.mdl", udg_s__YoumuNew_d_cx[d], udg_s__YoumuNew_d_cy[d]))
    endif
    set t = null
    set sp = null
    return true
endfunction

function sa__ReimuMother_ULT06_dSkill_Action takes nothing returns boolean
    local timer t = GetExpiredTimer()
    local group g = CreateGroup()
    local unit v
    local unit v1 = null
    local real a = GetRandomReal(-3.14, 3.14)
    local real dis = 600
    local integer d = LoadInteger(udg_ht, GetHandleId(t), 0)
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(udg_s__ReimuMother_ULT06_caster[d]))]
    call GroupEnumUnitsInRange(g, udg_s__ReimuMother_ULT06_cx[d], udg_s__ReimuMother_ULT06_cy[d], 500, iff)
    call DebugMsg("06 Group on")
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        if not IsUnitType(v, UNIT_TYPE_STRUCTURE) and GetWidgetLife(v) > 0.405 and GetUnitAbilityLevel(v, 'A0IL') > 0 == false then
            set v1 = v
        endif
        call GroupRemoveUnit(g, v)
    endloop
    if udg_s__ReimuMother_ULT06_i[d] < udg_ReimuMother__ReimuMotherULT06_COUNT and v1 != null then
        set udg_s__ReimuMother_ULT06_i[d] = udg_s__ReimuMother_ULT06_i[d] + 1
        call SetUnitX(udg_s__ReimuMother_ULT06_caster[d], GetUnitX(v1) + Cos(a) * 300)
        call SetUnitY(udg_s__ReimuMother_ULT06_caster[d], GetUnitY(v1) + Sin(a) * 300)
        call SetUnitFacing(udg_s__ReimuMother_ULT06_caster[d], a * 180 / 3.14)
        call SetUnitAnimation(udg_s__ReimuMother_ULT06_caster[d], "attack")
        loop
        exitwhen dis < 60
            call AddTimedEffectToPoint(GetUnitX(udg_s__ReimuMother_ULT06_caster[d]) - dis * Cos(a), GetUnitY(udg_s__ReimuMother_ULT06_caster[d]) - dis * Sin(a), 1, "ball_red.mdx")
            set dis = dis - 60
        endloop
        call UnitPhysicalDamageTarget(udg_s__ReimuMother_ULT06_caster[d], v1, udg_s__ReimuMother_ULT06_damage[d])
    else
        call PauseUnit(udg_s__ReimuMother_ULT06_caster[d], false)
        call SetUnitInvulnerable(udg_s__ReimuMother_ULT06_caster[d], false)
        call SetUnitVertexColor(udg_s__ReimuMother_ULT06_caster[d], 255, 255, 255, 255)
        call FlushChildHashtable(udg_ht, GetHandleId(t))
        call ReleaseTimer(t)
        call s__ReimuMother_ULT06_destroy(d)
    endif
    call DestroyGroup(g)
    set t = null
    set v = null
    set v1 = null
    return true
endfunction

function sa__ReimuMother_ULT05_ULT05_Action takes nothing returns boolean
    local timer t = GetExpiredTimer()
    local real i
    local group g
    local integer w = LoadInteger(udg_ht, GetHandleId(t), 0)
    if udg_s__ReimuMother_ULT05_i[w] < 25 then
        set i = 1
    else
        set i = -1
    endif
    if udg_s__ReimuMother_ULT05_i[w] <= 50 then
        call UnitAddAbility(udg_s__ReimuMother_ULT05_caster[w], 'Arav')
        call UnitRemoveAbility(udg_s__ReimuMother_ULT05_caster[w], 'Arav')
        call SetUnitFlyHeight(udg_s__ReimuMother_ULT05_caster[w], GetUnitFlyHeight(udg_s__ReimuMother_ULT05_caster[w]) + udg_ReimuMother__ReimuMotherULT05_FLYRATE * 0.02 * i, 99999)
        set udg_s__ReimuMother_ULT05_i[w] = udg_s__ReimuMother_ULT05_i[w] + 1
    else
        call SetUnitFlyHeight(udg_s__ReimuMother_ULT05_caster[w], udg_s__ReimuMother_ULT05_h[w], 99999)
        call PauseUnit(udg_s__ReimuMother_ULT05_caster[w], false)
        call SetUnitInvulnerable(udg_s__ReimuMother_ULT05_caster[w], false)
        call SetUnitPathing(udg_s__ReimuMother_ULT05_caster[w], true)
        call CreateUnit(GetOwningPlayer(udg_s__ReimuMother_ULT05_caster[w]), 'e03T', GetUnitX(udg_s__ReimuMother_ULT05_caster[w]), GetUnitY(udg_s__ReimuMother_ULT05_caster[w]), 0)
        call UnitMagicDamageArea(udg_s__ReimuMother_ULT05_caster[w], udg_s__ReimuMother_ULT05_cx[w], udg_s__ReimuMother_ULT05_cy[w], udg_ReimuMother__ReimuMotherULT05_AOE, udg_s__ReimuMother_ULT05_damage[w], 5)
        call UnitStunArea(udg_s__ReimuMother_ULT05_caster[w], udg_ReimuMother__ReimuMotherAll_StunTime + (GetUnitAbilityLevel(udg_s__ReimuMother_ULT05_caster[w], 'A1CC') - 1) * udg_ReimuMother__ReimuMotherAll_StunTime_INC * 2, udg_s__ReimuMother_ULT05_cx[w], udg_s__ReimuMother_ULT05_cy[w], udg_ReimuMother__ReimuMotherULT05_AOE, 0, 0)
        call FlushChildHashtable(udg_ht, GetHandleId(t))
        call ReleaseTimer(t)
        call s__ReimuMother_ULT05_destroy(w)
    endif
    call DestroyGroup(g)
    set t = null
    return true
endfunction

function sa__ReimuMother_ULT03_Clear takes nothing returns boolean
    local timer t = GetExpiredTimer()
    local integer u3 = LoadInteger(udg_ht, GetHandleId(t), 0)
    call UnitAddBonusDmg(udg_s__ReimuMother_ULT03_caster[u3], -R2I(udg_s__ReimuMother_ULT03_i[u3] * udg_ReimuMother__ReimuMother_ULT03_DAMAGESCALE))
    call FlushChildHashtable(udg_ht, GetHandleId(t))
    call ReleaseTimer(t)
    call s__ReimuMother_ULT03_destroy(u3)
    set t = null
    return true
endfunction

function sa__ReimuMother_ULT02_startloop takes nothing returns boolean
    local timer t = GetExpiredTimer()
    local unit u
    local unit v
    local real a
    local group g2 = CreateGroup()
    local group g3 = CreateGroup()
    local integer m = LoadInteger(udg_ht, GetHandleId(t), 0)
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(udg_s__ReimuMother_ULT02_caster[m]))]
    if udg_s__ReimuMother_ULT02_n[m] <= 25 then
        loop
            set u = FirstOfGroup(udg_s__ReimuMother_ULT02_g[m])
            set a = GetUnitFacing(u) / 180 * 3.14
        exitwhen u == null
            call SetUnitX(u, GetUnitX(u) + Cos(a) * udg_ReimuMother__ReimuMother_ULT02_SPEED * 0.02)
            call SetUnitY(u, GetUnitY(u) + Sin(a) * udg_ReimuMother__ReimuMother_ULT02_SPEED * 0.02)
            call GroupEnumUnitsInRange(g2, GetUnitX(u), GetUnitY(u), 100, iff)
            loop
                set v = FirstOfGroup(g2)
            exitwhen v == null
                if not IsUnitType(v, UNIT_TYPE_STRUCTURE) and GetWidgetLife(v) > 0.405 then
                    call UnitMagicDamageTarget(udg_s__ReimuMother_ULT02_caster[m], v, udg_s__ReimuMother_ULT02_damage[m], 5)
                    call KillUnit(u)
                endif
                call GroupRemoveUnit(g2, v)
            endloop
            if GetWidgetLife(u) > 0.405 then
                call GroupAddUnit(g3, u)
            endif
            call GroupRemoveUnit(udg_s__ReimuMother_ULT02_g[m], u)
        endloop
        loop
            set u = FirstOfGroup(g3)
        exitwhen u == null
            call GroupRemoveUnit(g3, u)
            call GroupAddUnit(udg_s__ReimuMother_ULT02_g[m], u)
        endloop
    else
        loop
            set u = FirstOfGroup(udg_s__ReimuMother_ULT02_g[m])
        exitwhen u == null
            call GroupRemoveUnit(udg_s__ReimuMother_ULT02_g[m], u)
            call KillUnit(u)
        endloop
        call FlushChildHashtable(udg_ht, GetHandleId(t))
        call ReleaseTimer(t)
        call s__ReimuMother_ULT02_destroy(m)
    endif
    set udg_s__ReimuMother_ULT02_n[m] = udg_s__ReimuMother_ULT02_n[m] + 1
    call DestroyGroup(g2)
    call DestroyGroup(g3)
    set u = null
    set t = null
    return true
endfunction

function sa__ReimuMother_ULT01_ULT01_loop takes nothing returns boolean
    local timer t = GetExpiredTimer()
    local unit v
    local group g = CreateGroup()
    local integer u1 = LoadInteger(udg_ht, GetHandleId(t), 0)
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(udg_s__ReimuMother_ULT01_caster[u1]))]
    set udg_s__ReimuMother_ULT01_i[u1] = udg_s__ReimuMother_ULT01_i[u1] + 1
    if udg_s__ReimuMother_ULT01_i[u1] <= 25 then
        call GroupEnumUnitsInRange(g, GetUnitX(udg_s__ReimuMother_ULT01_caster[u1]), GetUnitY(udg_s__ReimuMother_ULT01_caster[u1]), udg_ReimuMother__ReimuMother_ULT01_WIDTH, iff)
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if not IsUnitType(v, UNIT_TYPE_STRUCTURE) and GetWidgetLife(v) > 0.405 then
                call GroupAddUnit(udg_s__ReimuMother_ULT01_g[u1], v)
            endif
        endloop
        call AddTimedEffectToPoint(GetUnitX(udg_s__ReimuMother_ULT01_caster[u1]), GetUnitY(udg_s__ReimuMother_ULT01_caster[u1]), 0.02, "Abilities\\Spells\\Orc\\Shockwave\\ShockwaveMissile.mdl")
        call SetUnitX(udg_s__ReimuMother_ULT01_caster[u1], GetUnitX(udg_s__ReimuMother_ULT01_caster[u1]) + Cos(udg_s__ReimuMother_ULT01_a[u1]) * udg_ReimuMother__ReimuMother_ULT01_SPEED * 0.02)
        call SetUnitY(udg_s__ReimuMother_ULT01_caster[u1], GetUnitY(udg_s__ReimuMother_ULT01_caster[u1]) + Sin(udg_s__ReimuMother_ULT01_a[u1]) * udg_ReimuMother__ReimuMother_ULT01_SPEED * 0.02)
    elseif udg_s__ReimuMother_ULT01_i[u1] <= 50 then
        call SetUnitFacing(udg_s__ReimuMother_ULT01_caster[u1], udg_s__ReimuMother_ULT01_a[u1] * 180 / 3.14 + 180)
        call GroupEnumUnitsInRange(g, GetUnitX(udg_s__ReimuMother_ULT01_caster[u1]), GetUnitY(udg_s__ReimuMother_ULT01_caster[u1]), udg_ReimuMother__ReimuMother_ULT01_WIDTH, iff)
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if not IsUnitType(v, UNIT_TYPE_STRUCTURE) and GetWidgetLife(v) > 0.405 then
                call GroupAddUnit(udg_s__ReimuMother_ULT01_g[u1], v)
            endif
        endloop
        call AddTimedEffectToPoint(GetUnitX(udg_s__ReimuMother_ULT01_caster[u1]), GetUnitY(udg_s__ReimuMother_ULT01_caster[u1]), 0.02, "Abilities\\Spells\\Orc\\Shockwave\\ShockwaveMissile.mdl")
        call SetUnitX(udg_s__ReimuMother_ULT01_caster[u1], GetUnitX(udg_s__ReimuMother_ULT01_caster[u1]) - Cos(udg_s__ReimuMother_ULT01_a[u1]) * udg_ReimuMother__ReimuMother_ULT01_SPEED * 0.02)
        call SetUnitY(udg_s__ReimuMother_ULT01_caster[u1], GetUnitY(udg_s__ReimuMother_ULT01_caster[u1]) - Sin(udg_s__ReimuMother_ULT01_a[u1]) * udg_ReimuMother__ReimuMother_ULT01_SPEED * 0.02)
    else
        loop
            set v = FirstOfGroup(udg_s__ReimuMother_ULT01_g[u1])
        exitwhen v == null
            call UnitPhysicalDamageTarget(udg_s__ReimuMother_ULT01_caster[u1], v, udg_s__ReimuMother_ULT01_damage[u1])
            call GroupRemoveUnit(udg_s__ReimuMother_ULT01_g[u1], v)
        endloop
        call PauseUnit(udg_s__ReimuMother_ULT01_caster[u1], false)
        call SetUnitInvulnerable(udg_s__ReimuMother_ULT01_caster[u1], false)
        call SetUnitPathing(udg_s__ReimuMother_ULT01_caster[u1], true)
        call FlushChildHashtable(udg_ht, GetHandleId(t))
        call ReleaseTimer(t)
        call s__ReimuMother_ULT01_destroy(u1)
    endif
    call DestroyGroup(g)
    set t = null
    return true
endfunction

function sa__ReimuMother_w_wSkill_Action takes nothing returns boolean
    local timer t = GetExpiredTimer()
    local unit v
    local real i
    local group g = CreateGroup()
    local integer w = LoadInteger(udg_ht, GetHandleId(t), 0)
    if udg_s__ReimuMother_w_i[w] < 13 then
        set i = 1
    else
        set i = -1
    endif
    call GroupAddGroup(udg_s__ReimuMother_w_g[w], g)
    if udg_s__ReimuMother_w_i[w] <= 25 then
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            if not IsUnitType(v, UNIT_TYPE_STRUCTURE) and GetWidgetLife(v) > 0.405 then
                call UnitAddAbility(v, 'Arav')
                call UnitRemoveAbility(v, 'Arav')
                call SetUnitFlyHeight(v, GetUnitFlyHeight(v) + udg_ReimuMother__ReimuMother04_FLYRATE * 0.02 * i, 99999)
            endif
            call GroupRemoveUnit(g, v)
        endloop
        set udg_s__ReimuMother_w_i[w] = udg_s__ReimuMother_w_i[w] + 1
    else
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call SetUnitFlyHeight(v, udg_s__ReimuMother_w_h[w], 99999)
            call GroupRemoveUnit(g, v)
        endloop
        call FlushChildHashtable(udg_ht, GetHandleId(t))
        call ReleaseTimer(t)
        call s__ReimuMother_w_destroy(w)
    endif
    call DestroyGroup(g)
    set t = null
    return true
endfunction

function sa__ReimuMother_r_rSkill_Action takes nothing returns boolean
    local timer t = GetExpiredTimer()
    local integer r = LoadInteger(udg_ht, GetHandleId(t), 0)
    set udg_s__ReimuMother_r_i[r] = udg_s__ReimuMother_r_i[r] + 1
    call SetUnitX(udg_s__ReimuMother_r_caster[r], GetUnitX(udg_s__ReimuMother_r_caster[r]) + Cos(udg_s__ReimuMother_r_a[r]) * udg_ReimuMother__ReimuMother03_SPEED * 0.02)
    call SetUnitY(udg_s__ReimuMother_r_caster[r], GetUnitY(udg_s__ReimuMother_r_caster[r]) + Sin(udg_s__ReimuMother_r_a[r]) * udg_ReimuMother__ReimuMother03_SPEED * 0.02)
    if udg_s__ReimuMother_r_i[r] > 25 then
        set udg_s__ReimuMother_r_cx[r] = GetUnitX(udg_s__ReimuMother_r_caster[r]) + udg_ReimuMother__ReimuMotherAll_AOE * Cos(udg_s__ReimuMother_r_a[r])
        set udg_s__ReimuMother_r_cy[r] = GetUnitY(udg_s__ReimuMother_r_caster[r]) + udg_ReimuMother__ReimuMotherAll_AOE * Sin(udg_s__ReimuMother_r_a[r])
        call UnitPhysicalDamageArea(udg_s__ReimuMother_r_caster[r], udg_s__ReimuMother_r_cx[r], udg_s__ReimuMother_r_cy[r], udg_ReimuMother__ReimuMotherAll_AOE, udg_s__ReimuMother_r_damage[r])
        call UnitStunArea(udg_s__ReimuMother_r_caster[r], udg_ReimuMother__ReimuMotherAll_StunTime + GetUnitAbilityLevel(udg_s__ReimuMother_r_caster[r], 'A1CC') * udg_ReimuMother__ReimuMotherAll_StunTime_INC, udg_s__ReimuMother_r_cx[r], udg_s__ReimuMother_r_cy[r], udg_ReimuMother__ReimuMotherAll_AOE, 0, 0)
        call FlushChildHashtable(udg_ht, GetHandleId(t))
        call ReleaseTimer(t)
        call s__ReimuMother_r_destroy(r)
    endif
    set t = null
    return true
endfunction

function sa__ReimuMother_f_fSkill_Action takes nothing returns boolean
    local timer t = GetExpiredTimer()
    local unit v
    local real vx
    local real vy
    local real a
    local integer f = LoadInteger(udg_ht, GetHandleId(t), 0)
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(udg_s__ReimuMother_f_caster[f]))]
    call GroupEnumUnitsInRange(udg_s__ReimuMother_f_g[f], udg_s__ReimuMother_f_cx[f], udg_s__ReimuMother_f_cy[f], udg_ReimuMother__ReimuMotherAll_AOE, iff)
    loop
        set v = FirstOfGroup(udg_s__ReimuMother_f_g[f])
    exitwhen v == null
        if not IsUnitType(v, UNIT_TYPE_STRUCTURE) and IsUnitType(v, UNIT_TYPE_ANCIENT) == false and GetWidgetLife(v) > 0.405 then
            set vx = GetUnitX(v)
            set vy = GetUnitY(v)
            set a = Atan2(vy - udg_s__ReimuMother_f_cy[f], vx - udg_s__ReimuMother_f_cx[f])
            call SetUnitX(v, GetUnitX(v) + Cos(a) * udg_ReimuMother__ReimuMother02_SPEED * 0.02)
            call SetUnitY(v, GetUnitY(v) + Sin(a) * udg_ReimuMother__ReimuMother02_SPEED * 0.02)
        endif
        call GroupRemoveUnit(udg_s__ReimuMother_f_g[f], v)
    endloop
    set udg_s__ReimuMother_f_i[f] = udg_s__ReimuMother_f_i[f] + 1
    if udg_s__ReimuMother_f_i[f] > 25 then
        call FlushChildHashtable(udg_ht, GetHandleId(t))
        call ReleaseTimer(t)
        call DestroyGroup(udg_s__ReimuMother_f_g[f])
        call s__ReimuMother_f_destroy(f)
    endif
    set t = null
    return true
endfunction

function sa__ReimuMother_d_dSkill_Action takes nothing returns boolean
    local timer t = GetExpiredTimer()
    local group g = CreateGroup()
    local unit v
    local integer d = LoadInteger(udg_ht, GetHandleId(t), 0)
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(udg_s__ReimuMother_d_caster[d]))]
    call GroupEnumUnitsInRange(g, udg_s__ReimuMother_d_cx[d], udg_s__ReimuMother_d_cy[d], udg_ReimuMother__ReimuMotherAll_AOE, iff)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        if not IsUnitType(v, UNIT_TYPE_STRUCTURE) and GetWidgetLife(v) > 0.405 then
            call UnitPhysicalDamageTarget(udg_s__ReimuMother_d_caster[d], v, udg_s__ReimuMother_d_damage[d])
        endif
        call GroupRemoveUnit(g, v)
    endloop
    call UnitStunArea(udg_s__ReimuMother_d_caster[d], udg_ReimuMother__ReimuMotherAll_StunTime + (GetUnitAbilityLevel(udg_s__ReimuMother_d_caster[d], 'A1CC') - 1) * udg_ReimuMother__ReimuMotherAll_StunTime_INC, udg_s__ReimuMother_d_cx[d], udg_s__ReimuMother_d_cy[d], udg_ReimuMother__ReimuMotherAll_AOE, 0, 0)
    call FlushChildHashtable(udg_ht, GetHandleId(t))
    call ReleaseTimer(t)
    call DestroyGroup(g)
    call s__ReimuMother_d_destroy(d)
    set t = null
    return true
endfunction

function sa__ReimuMother_e_eSkill_loop takes nothing returns boolean
    local timer t = GetExpiredTimer()
    local integer e = LoadInteger(udg_ht, GetHandleId(t), 0)
    call SetUnitX(udg_s__ReimuMother_e_caster[e], GetUnitX(udg_s__ReimuMother_e_caster[e]) + Cos(udg_s__ReimuMother_e_a[e]) * udg_ReimuMother__ReimuMotherEx_SPEED * 0.02)
    call SetUnitY(udg_s__ReimuMother_e_caster[e], GetUnitY(udg_s__ReimuMother_e_caster[e]) + Sin(udg_s__ReimuMother_e_a[e]) * udg_ReimuMother__ReimuMotherEx_SPEED * 0.02)
    set udg_s__ReimuMother_e_i[e] = udg_s__ReimuMother_e_i[e] + 1
    if udg_s__ReimuMother_e_i[e] > 13 then
        call FlushChildHashtable(udg_ht, GetHandleId(t))
        call ReleaseTimer(t)
        call s__ReimuMother_e_destroy(e)
    endif
    set t = null
    return true
endfunction

function InitTrig_govno takes nothing returns nothing
    set udg_st__Kagerou_w_wSkill_Action = CreateTrigger()
    call TriggerAddCondition(udg_st__Kagerou_w_wSkill_Action, Condition(function sa__Kagerou_w_wSkill_Action))
    set udg_st__Kagerou_w_wSkill_AOE_Action = CreateTrigger()
    call TriggerAddCondition(udg_st__Kagerou_w_wSkill_AOE_Action, Condition(function sa__Kagerou_w_wSkill_AOE_Action))
    set udg_st__Kagerou_w_wSkill_AOE_Main = CreateTrigger()
    call TriggerAddCondition(udg_st__Kagerou_w_wSkill_AOE_Main, Condition(function sa__Kagerou_w_wSkill_AOE_Main))
    set udg_st__Kagerou_f_fSkill_Action = CreateTrigger()
    call TriggerAddCondition(udg_st__Kagerou_f_fSkill_Action, Condition(function sa__Kagerou_f_fSkill_Action))
    set udg_st__Kagerou_d_dSkill_Action = CreateTrigger()
    call TriggerAddCondition(udg_st__Kagerou_d_dSkill_Action, Condition(function sa__Kagerou_d_dSkill_Action))
    set udg_st__Kulumi02_projectile_Kulumi02Sleep = CreateTrigger()
    call TriggerAddCondition(udg_st__Kulumi02_projectile_Kulumi02Sleep, Condition(function sa__Kulumi02_projectile_Kulumi02Sleep))
    set udg_st__Futo05_EffectLoop = CreateTrigger()
    call TriggerAddCondition(udg_st__Futo05_EffectLoop, Condition(function sa__Futo05_EffectLoop))
    set udg_st__Futo05_trg_attack_func = CreateTrigger()
    call TriggerAddCondition(udg_st__Futo05_trg_attack_func, Condition(function sa__Futo05_trg_attack_func))
    set udg_st__Futo05_AddFlag = CreateTrigger()
    call TriggerAddCondition(udg_st__Futo05_AddFlag, Condition(function sa__Futo05_AddFlag))
    set udg_st__Futo05_onDestroy = CreateTrigger()
    call TriggerAddCondition(udg_st__Futo05_onDestroy, Condition(function sa__Futo05_onDestroy))
    set udg_st__Futo04_ready = CreateTrigger()
    call TriggerAddCondition(udg_st__Futo04_ready, Condition(function sa__Futo04_ready))
    set udg_st__Futo04_cast = CreateTrigger()
    call TriggerAddCondition(udg_st__Futo04_cast, Condition(function sa__Futo04_cast))
    set udg_st__Futo04_SlowTarget = CreateTrigger()
    call TriggerAddCondition(udg_st__Futo04_SlowTarget, Condition(function sa__Futo04_SlowTarget))
    set udg_st__Futo04_onDestroy = CreateTrigger()
    call TriggerAddCondition(udg_st__Futo04_onDestroy, Condition(function sa__Futo04_onDestroy))
    set udg_st__Futo03_ClearProtect = CreateTrigger()
    call TriggerAddCondition(udg_st__Futo03_ClearProtect, Condition(function sa__Futo03_ClearProtect))
    set udg_st__Futo03_flyup = CreateTrigger()
    call TriggerAddCondition(udg_st__Futo03_flyup, Condition(function sa__Futo03_flyup))
    set udg_st__Futo03_move = CreateTrigger()
    call TriggerAddCondition(udg_st__Futo03_move, Condition(function sa__Futo03_move))
    set udg_st__Futo03_onDestroy = CreateTrigger()
    call TriggerAddCondition(udg_st__Futo03_onDestroy, Condition(function sa__Futo03_onDestroy))
    set udg_st__Futo02_dotLoop = CreateTrigger()
    call TriggerAddCondition(udg_st__Futo02_dotLoop, Condition(function sa__Futo02_dotLoop))
    set udg_st__Futo02_trg_spelloruseitem_func = CreateTrigger()
    call TriggerAddCondition(udg_st__Futo02_trg_spelloruseitem_func, Condition(function sa__Futo02_trg_spelloruseitem_func))
    set udg_st__Futo02_resetCando = CreateTrigger()
    call TriggerAddCondition(udg_st__Futo02_resetCando, Condition(function sa__Futo02_resetCando))
    set udg_st__Futo02_clearTrg = CreateTrigger()
    call TriggerAddCondition(udg_st__Futo02_clearTrg, Condition(function sa__Futo02_clearTrg))
    set udg_st__Futo02_onDestroy = CreateTrigger()
    call TriggerAddCondition(udg_st__Futo02_onDestroy, Condition(function sa__Futo02_onDestroy))
    set udg_st__Futo01_timerPushFunc = CreateTrigger()
    call TriggerAddCondition(udg_st__Futo01_timerPushFunc, Condition(function sa__Futo01_timerPushFunc))
    set udg_st__Futo01_timerMainFunc = CreateTrigger()
    call TriggerAddCondition(udg_st__Futo01_timerMainFunc, Condition(function sa__Futo01_timerMainFunc))
    set udg_st__Futo01_onDestroy = CreateTrigger()
    call TriggerAddCondition(udg_st__Futo01_onDestroy, Condition(function sa__Futo01_onDestroy))
    set udg_st__FutoEx_follwLoop = CreateTrigger()
    call TriggerAddCondition(udg_st__FutoEx_follwLoop, Condition(function sa__FutoEx_follwLoop))
    set udg_st__Flandre2_04_onClear = CreateTrigger()
    call TriggerAddCondition(udg_st__Flandre2_04_onClear, Condition(function sa__Flandre2_04_onClear))
    set udg_st__Flandre2_04_onClearTargetDebuff = CreateTrigger()
    call TriggerAddCondition(udg_st__Flandre2_04_onClearTargetDebuff, Condition(function sa__Flandre2_04_onClearTargetDebuff))
    set udg_st__Flandre2_02_onSlow = CreateTrigger()
    call TriggerAddCondition(udg_st__Flandre2_02_onSlow, Condition(function sa__Flandre2_02_onSlow))
    set udg_st__Flandre2_01_countIllusion = CreateTrigger()
    call TriggerAddCondition(udg_st__Flandre2_01_countIllusion, Condition(function sa__Flandre2_01_countIllusion))
    set udg_st__Flandre2_01_RemoveIllusionFromGroup = CreateTrigger()
    call TriggerAddCondition(udg_st__Flandre2_01_RemoveIllusionFromGroup, Condition(function sa__Flandre2_01_RemoveIllusionFromGroup))
    set udg_st__ReisenNew_laser_laserloop = CreateTrigger()
    call TriggerAddCondition(udg_st__ReisenNew_laser_laserloop, Condition(function sa__ReisenNew_laser_laserloop))
    set udg_st__ReisenNew_spell_skill01loop = CreateTrigger()
    call TriggerAddCondition(udg_st__ReisenNew_spell_skill01loop, Condition(function sa__ReisenNew_spell_skill01loop))
    set udg_st__ReisenNew_projectile_startloop = CreateTrigger()
    call TriggerAddCondition(udg_st__ReisenNew_projectile_startloop, Condition(function sa__ReisenNew_projectile_startloop))
    set udg_st__YoumuNew_w_wSkill_Action = CreateTrigger()
    call TriggerAddCondition(udg_st__YoumuNew_w_wSkill_Action, Condition(function sa__YoumuNew_w_wSkill_Action))
    set udg_st__YoumuNew_d_dSkill_Action = CreateTrigger()
    call TriggerAddCondition(udg_st__YoumuNew_d_dSkill_Action, Condition(function sa__YoumuNew_d_dSkill_Action))
    set udg_st__ReimuMother_ULT06_dSkill_Action = CreateTrigger()
    call TriggerAddCondition(udg_st__ReimuMother_ULT06_dSkill_Action, Condition(function sa__ReimuMother_ULT06_dSkill_Action))
    set udg_st__ReimuMother_ULT05_ULT05_Action = CreateTrigger()
    call TriggerAddCondition(udg_st__ReimuMother_ULT05_ULT05_Action, Condition(function sa__ReimuMother_ULT05_ULT05_Action))
    set udg_st__ReimuMother_ULT03_Clear = CreateTrigger()
    call TriggerAddCondition(udg_st__ReimuMother_ULT03_Clear, Condition(function sa__ReimuMother_ULT03_Clear))
    set udg_st__ReimuMother_ULT02_startloop = CreateTrigger()
    call TriggerAddCondition(udg_st__ReimuMother_ULT02_startloop, Condition(function sa__ReimuMother_ULT02_startloop))
    set udg_st__ReimuMother_ULT01_ULT01_loop = CreateTrigger()
    call TriggerAddCondition(udg_st__ReimuMother_ULT01_ULT01_loop, Condition(function sa__ReimuMother_ULT01_ULT01_loop))
    set udg_st__ReimuMother_w_wSkill_Action = CreateTrigger()
    call TriggerAddCondition(udg_st__ReimuMother_w_wSkill_Action, Condition(function sa__ReimuMother_w_wSkill_Action))
    set udg_st__ReimuMother_r_rSkill_Action = CreateTrigger()
    call TriggerAddCondition(udg_st__ReimuMother_r_rSkill_Action, Condition(function sa__ReimuMother_r_rSkill_Action))
    set udg_st__ReimuMother_f_fSkill_Action = CreateTrigger()
    call TriggerAddCondition(udg_st__ReimuMother_f_fSkill_Action, Condition(function sa__ReimuMother_f_fSkill_Action))
    set udg_st__ReimuMother_d_dSkill_Action = CreateTrigger()
    call TriggerAddCondition(udg_st__ReimuMother_d_dSkill_Action, Condition(function sa__ReimuMother_d_dSkill_Action))
    set udg_st__ReimuMother_e_eSkill_loop = CreateTrigger()
    call TriggerAddCondition(udg_st__ReimuMother_e_eSkill_loop, Condition(function sa__ReimuMother_e_eSkill_loop))
    call ExecuteFunc("Record__Init")
endfunction