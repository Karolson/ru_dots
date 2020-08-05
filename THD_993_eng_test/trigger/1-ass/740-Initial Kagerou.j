function Kagerou__KagerouEx_NIGHT_BUFF takes unit target returns boolean
    set target = null
    return not (GetFloatGameState(GAME_STATE_TIME_OF_DAY) >= 6 and GetFloatGameState(GAME_STATE_TIME_OF_DAY) < 18)
endfunction

function Kagerou__KagerouEx_HAS_BUFF takes unit target returns boolean
    local boolean ret = false
    if HaveSavedHandle(udg_ht, GetHandleId(target), udg_Kagerou__KagerouEx2_Unit_Hashkey) then
        if IsUnitAliveBJ(LoadUnitHandle(udg_ht, GetHandleId(target), udg_Kagerou__KagerouEx2_Unit_Hashkey)) then
            set ret = true
        endif
    endif
    return ret
endfunction

function Kagerou__KagerouEx2_HAS_BUFF takes unit target returns boolean
    local boolean ret = false
    if GetUnitAbilityLevel(target, udg_Kagerou__KagerouEx2_BUFF_CODE) > 0 then
        set ret = true
    endif
    return ret
endfunction

function Kagerou__KagerouEx2_CLEAR_BUFF takes unit target returns nothing
    call UnitMakeAbilityPermanent(target, false, udg_Kagerou__KagerouEx2_BUFF_CODE)
    call UnitRemoveAbility(target, udg_Kagerou__KagerouEx2_BUFF_CODE)
    call DebugMsg("KagerouEx2_CLEAR_BUFF")
    set target = null
endfunction

function Kagerou__KagerouEx2_Timer_Clear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local unit target = LoadUnitHandle(udg_ht, GetHandleId(t), 0)
    call Kagerou__KagerouEx2_CLEAR_BUFF(target)
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, GetHandleId(t))
    set t = null
    set target = null
endfunction

function Kagerou__KagerouEx2_BUFF takes unit target returns nothing
    local timer t = CreateTimer()
    call DebugMsg("KagerouEx2_BUFF")
    call UnitAddAbility(target, udg_Kagerou__KagerouEx2_BUFF_CODE)
    call UnitMakeAbilityPermanent(target, true, udg_Kagerou__KagerouEx2_BUFF_CODE)
    call SaveUnitHandle(udg_ht, GetHandleId(t), 0, target)
    call TimerStart(t, udg_Kagerou__KagerouEx2_DURATION, false, function Kagerou__KagerouEx2_Timer_Clear)
    set target = null
    set t = null
endfunction

function Kagerou__Kagerou_r_Fade takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local unit target = LoadUnitHandle(udg_ht, GetHandleId(t), 0)
    local integer i = LoadInteger(udg_ht, GetHandleId(t), 1)
    set i = i + 1
    if i * 1.0 > udg_Kagerou__Kagerou03_BUFF_DURATION or IsUnitDead(target) then
        call DebugMsg("Kagerou03_CLEAR_BUFF")
        call UnitMakeAbilityPermanent(target, false, udg_Kagerou__Kagerou03_BUFF_CODE)
        call UnitRemoveAbility(target, udg_Kagerou__Kagerou03_BUFF_CODE)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, GetHandleId(t))
        call RemoveSavedHandle(udg_ht, GetHandleId(target), udg_Kagerou__Kagerou03_Timer_Hashkey)
    endif
    set t = null
    set target = null
endfunction

function Kagerou__Kagerou_r_COUNT takes unit caster, unit target returns nothing
    local timer t = null
    local integer clvl = GetUnitAbilityLevel(caster, udg_Kagerou__Kagerou03)
    local integer tlvl = GetUnitAbilityLevel(target, udg_Kagerou__Kagerou03_BUFF_CODE)
    return
    if tlvl + 1 >= udg_Kagerou__Kagerou03_HIT_COUNT then
        call UnitMakeAbilityPermanent(target, false, udg_Kagerou__Kagerou03_BUFF_CODE)
        call UnitRemoveAbility(target, udg_Kagerou__Kagerou03_BUFF_CODE)
        call UnitStunTarget(caster, target, (clvl - 1) * udg_Kagerou__Kagerou03_STUNTIME_INC + udg_Kagerou__Kagerou03_STUNTIME_BASE, 0, 0)
        if HaveSavedHandle(udg_ht, GetHandleId(target), udg_Kagerou__Kagerou03_Timer_Hashkey) then
            call DebugMsg("Kagerou03_CLEAR_BUFF")
            set t = LoadTimerHandle(udg_ht, GetHandleId(target), udg_Kagerou__Kagerou03_Timer_Hashkey)
            call ReleaseTimer(t)
            call FlushChildHashtable(udg_ht, GetHandleId(t))
            call RemoveSavedHandle(udg_ht, GetHandleId(target), udg_Kagerou__Kagerou03_Timer_Hashkey)
        endif
    elseif tlvl == 0 then
        call DebugMsg("Kagerou03_BUFF")
        call UnitAddAbility(target, udg_Kagerou__Kagerou03_BUFF_CODE)
        call SetUnitAbilityLevel(target, udg_Kagerou__Kagerou03_BUFF_CODE, 1)
        call UnitMakeAbilityPermanent(target, true, udg_Kagerou__Kagerou03_BUFF_CODE)
        set t = CreateTimer()
        call SaveTimerHandle(udg_ht, GetHandleId(target), udg_Kagerou__Kagerou03_Timer_Hashkey, t)
        call SaveUnitHandle(udg_ht, GetHandleId(t), 0, target)
        call SaveInteger(udg_ht, GetHandleId(t), 1, 0)
        call TimerStart(t, 1.0, true, function Kagerou__Kagerou_r_Fade)
    else
        call SetUnitAbilityLevel(target, udg_Kagerou__Kagerou03_BUFF_CODE, tlvl + 1)
        if HaveSavedHandle(udg_ht, GetHandleId(target), udg_Kagerou__Kagerou03_Timer_Hashkey) then
            call DebugMsg("Kagerou03_RESET_BUFF_TIME")
            set t = LoadTimerHandle(udg_ht, GetHandleId(target), udg_Kagerou__Kagerou03_Timer_Hashkey)
            call SaveInteger(udg_ht, GetHandleId(t), 1, 0)
        else
            call DebugMsg("Kagerou03_BUFF")
            set t = CreateTimer()
            call SaveTimerHandle(udg_ht, GetHandleId(target), udg_Kagerou__Kagerou03_Timer_Hashkey, t)
            call SaveUnitHandle(udg_ht, GetHandleId(t), 0, target)
            call SaveInteger(udg_ht, GetHandleId(t), 1, 0)
            call TimerStart(t, 1.0, true, function Kagerou__Kagerou_r_Fade)
        endif
    endif
    set caster = null
    set target = null
    set t = null
endfunction

function Kagerou__KagerouEx_Loop takes nothing returns nothing
    local integer task = GetHandleId(GetExpiredTimer())
    local integer count = LoadInteger(udg_ht, task, 0)
    local unit caster = LoadUnitHandle(udg_ht, task, 1)
    local group g = CreateGroup()
    local unit v = null
    local boolean HasAlly = false
    local unit Requires = null
    call GroupEnumUnitsInRange(g, GetUnitX(caster), GetUnitY(caster), udg_Kagerou__KagerouEx_CHECK_RANGE, null)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if HasAlly == false and v != caster and IsUnitAlly(v, GetOwningPlayer(caster)) and GetWidgetLife(v) > 0.405 and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false and GetUnitAbilityLevel(v, 'A0IL') > 0 == false then
            set HasAlly = true
        endif
    endloop
    if HasAlly == false then
        set count = count + 1
        if count * 0.5 >= udg_Kagerou__KagerouEx_CHECK_TIME then
            call DebugMsg("udg_Kagerou Alone")
            if HaveSavedHandle(udg_ht, GetHandleId(caster), udg_Kagerou__KagerouEx2_Unit_Hashkey) then
                set Requires = LoadUnitHandle(udg_ht, GetHandleId(caster), udg_Kagerou__KagerouEx2_Unit_Hashkey)
                call KillUnit(Requires)
            endif
            set Requires = CreateUnit(GetOwningPlayer(caster), 'e040', -5344.0, -3968.0, 0)
            call SaveUnitHandle(udg_ht, GetHandleId(caster), udg_Kagerou__KagerouEx2_Unit_Hashkey, Requires)
            call UnitAddAbility(udg_Kagerou, udg_Kagerou__KagerouExBuff)
            call UnitMakeAbilityPermanent(udg_Kagerou, true, udg_Kagerou__KagerouExBuff)
        endif
    else
        set count = 0
        if HaveSavedHandle(udg_ht, GetHandleId(caster), udg_Kagerou__KagerouEx2_Unit_Hashkey) then
            call DebugMsg("udg_Kagerou Out Alone")
            set Requires = LoadUnitHandle(udg_ht, GetHandleId(caster), udg_Kagerou__KagerouEx2_Unit_Hashkey)
            call KillUnit(Requires)
            call RemoveSavedHandle(udg_ht, GetHandleId(caster), udg_Kagerou__KagerouEx2_Unit_Hashkey)
            call UnitRemoveAbility(udg_Kagerou, udg_Kagerou__KagerouExBuff)
        endif
    endif
    call SaveInteger(udg_ht, task, 0, count)
    call DestroyGroup(g)
    set g = null
    set v = null
    set caster = null
    set Requires = null
endfunction

function s__Kagerou_d_create takes unit caster, real damage, real angle returns integer
    local timer t = CreateTimer()
    local integer d = s__Kagerou_d__allocate()
    set udg_s__Kagerou_d_caster[d] = caster
    set udg_s__Kagerou_d_damage[d] = damage
    set udg_s__Kagerou_d_cx[d] = GetUnitX(caster)
    set udg_s__Kagerou_d_cy[d] = GetUnitY(caster)
    set udg_s__Kagerou_d_a[d] = angle
    set udg_s__Kagerou_d_i[d] = 0
    call SaveInteger(udg_ht, GetHandleId(t), 0, d)
    call SetUnitPathing(caster, false)
    call UnitAddAbility(caster, 'Arav')
    call UnitRemoveAbility(caster, 'Arav')
    call TimerStart(t, 0.02, true, function sc__Kagerou_d_dSkill_Action)
    set t = null
    return d
endfunction

function s__Kagerou_d_destroy takes integer this returns nothing
    set udg_s__Kagerou_d_caster[this] = null
    call s__Kagerou_d_deallocate(this)
endfunction

function s__Kagerou_d_dSkill_Action takes nothing returns nothing
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
                if Kagerou__KagerouEx_NIGHT_BUFF(udg_s__Kagerou_d_caster[this]) then
                    call UnitPhysicalDamageTarget(udg_s__Kagerou_d_caster[this], v, udg_s__Kagerou_d_damage[this])
                else
                    call UnitMagicDamageTarget(udg_s__Kagerou_d_caster[this], v, udg_s__Kagerou_d_damage[this], 1)
                endif
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
endfunction

function s__Kagerou_f_create takes unit caster, real damage, real ox, real oy, real tx, real ty returns integer
    local timer t = CreateTimer()
    local integer this = s__Kagerou_f__allocate()
    set udg_s__Kagerou_f_caster[this] = caster
    set udg_s__Kagerou_f_damage[this] = damage
    set udg_s__Kagerou_f_radian[this] = Atan2(ty - oy, tx - ox)
    set udg_s__Kagerou_f_ox[this] = ox
    set udg_s__Kagerou_f_oy[this] = oy
    set udg_s__Kagerou_f_tx[this] = tx
    set udg_s__Kagerou_f_ty[this] = ty
    set udg_s__Kagerou_f_i[this] = 0
    set udg_s__Kagerou_f_dmggrp[this] = CreateGroup()
    set udg_s__Kagerou_f_EffectUnit[this] = CreateUnit(GetOwningPlayer(caster), udg_Kagerou__Kagerou02_EFFECT_UNIT_CODE, ox, oy, udg_s__Kagerou_f_radian[this] / 3.14 * 180)
    if Kagerou__KagerouEx2_HAS_BUFF(udg_s__Kagerou_f_caster[this]) then
        call Kagerou__KagerouEx2_CLEAR_BUFF(udg_s__Kagerou_f_caster[this])
        set udg_s__Kagerou_f_speed[this] = udg_Kagerou__Kagerou02_SPEED_EX
        set udg_s__Kagerou_f_range[this] = udg_Kagerou__Kagerou02_RANGE_EX
        set udg_s__Kagerou_f_HitBox_Size[this] = udg_Kagerou__Kagerou02_HITBOX_SIZE_EX
        set udg_s__Kagerou_f_isslow[this] = true
    else
        set udg_s__Kagerou_f_speed[this] = udg_Kagerou__Kagerou02_SPEED
        set udg_s__Kagerou_f_range[this] = udg_Kagerou__Kagerou02_RANGE
        set udg_s__Kagerou_f_HitBox_Size[this] = udg_Kagerou__Kagerou02_HITBOX_SIZE
        set udg_s__Kagerou_f_isslow[this] = false
    endif
    call SaveInteger(udg_ht, GetHandleId(t), 0, this)
    call TimerStart(t, 0.02, true, function sc__Kagerou_f_fSkill_Action)
    set t = null
    return this
endfunction

function s__Kagerou_f_destroy takes integer this returns nothing
    call KillUnit(udg_s__Kagerou_f_EffectUnit[this])
    call DestroyGroup(udg_s__Kagerou_f_dmggrp[this])
    set udg_s__Kagerou_f_caster[this] = null
    set udg_s__Kagerou_f_EffectUnit[this] = null
    set udg_s__Kagerou_f_dmggrp[this] = null
    call s__Kagerou_f_deallocate(this)
endfunction

function s__Kagerou_f_fSkill_Action takes nothing returns nothing
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
                if Kagerou__KagerouEx_NIGHT_BUFF(udg_s__Kagerou_f_caster[this]) then
                    call UnitPhysicalDamageTarget(udg_s__Kagerou_f_caster[this], v, udg_s__Kagerou_f_damage[this])
                else
                    call UnitMagicDamageTarget(udg_s__Kagerou_f_caster[this], v, udg_s__Kagerou_f_damage[this], 1)
                endif
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
endfunction

function s__Kagerou_w_create takes unit caster, real damage, real ox, real oy, real tx, real ty returns integer
    local timer t = CreateTimer()
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    local integer w = s__Kagerou_w__allocate()
    set udg_s__Kagerou_w_caster[w] = caster
    set udg_s__Kagerou_w_damage[w] = damage
    set udg_s__Kagerou_w_ox[w] = ox
    set udg_s__Kagerou_w_oy[w] = oy
    set udg_s__Kagerou_w_tx[w] = tx
    set udg_s__Kagerou_w_ty[w] = ty
    set udg_s__Kagerou_w_a[w] = Atan2(ty - oy, tx - ox)
    set udg_s__Kagerou_w_i[w] = 0
    set udg_s__Kagerou_w_iff[w] = iff
    set udg_s__Kagerou_w_n[w] = 1
    set udg_s__Kagerou_w_g2[w] = CreateGroup()
    set udg_s__Kagerou_w_maxi[w] = 25
    if Kagerou__KagerouEx2_HAS_BUFF(caster) then
        call Kagerou__KagerouEx2_CLEAR_BUFF(caster)
        set udg_s__Kagerou_w_maxi[w] = 50
    endif
    call SaveInteger(udg_ht, GetHandleId(t), 0, w)
    call UnitAddAbility(caster, 'Arav')
    call UnitRemoveAbility(caster, 'Arav')
    call TimerStart(t, 0.01, true, function sc__Kagerou_w_wSkill_Action)
    set t = null
    return w
endfunction

function s__Kagerou_w_destroy takes integer this returns nothing
    set udg_s__Kagerou_w_EffectUnit[this] = null
    set udg_s__Kagerou_w_caster[this] = null
    set udg_s__Kagerou_w_u[this] = null
    call s__Kagerou_w_deallocate(this)
endfunction

function s__Kagerou_w_wSkill_Spell_Move takes nothing returns nothing
    local integer w = udg_Kagerou_int
    if udg_s__Kagerou_w_n[w] < 3 then
        set udg_s__Kagerou_w_n[w] = udg_s__Kagerou_w_n[w] + 1
    else
        set udg_s__Kagerou_w_n[w] = 1
    endif
    call SetUnitX(GetEnumUnit(), GetUnitX(udg_s__Kagerou_w_u[w]) + 50 * Cos(udg_s__Kagerou_w_a[w] + 0.2 * udg_s__Kagerou_w_i[w] + 1.57 * udg_s__Kagerou_w_n[w]))
    call SetUnitY(GetEnumUnit(), GetUnitY(udg_s__Kagerou_w_u[w]) + 50 * Sin(udg_s__Kagerou_w_a[w] + 0.2 * udg_s__Kagerou_w_i[w] + 1.57 * udg_s__Kagerou_w_n[w]))
    call SetUnitFacing(GetEnumUnit(), (udg_s__Kagerou_w_a[w] + 0.2 * udg_s__Kagerou_w_i[w] + 0.785 * udg_s__Kagerou_w_n[w]) / 3.14 * 180 + 90)
    call DebugMsg("udg_Kagerou struct2:" + I2S(w))
endfunction

function s__Kagerou_w_wSkill_main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer w = LoadInteger(udg_ht, GetHandleId(t), 1)
    set udg_s__Kagerou_w_n[w] = 1
    set udg_s__Kagerou_w_i[w] = udg_s__Kagerou_w_i[w] + 1
    call SetUnitX(udg_s__Kagerou_w_caster[w], GetUnitX(udg_s__Kagerou_w_u[w]) + 50 * Cos(udg_s__Kagerou_w_a[w] + 0.2 * udg_s__Kagerou_w_i[w]))
    call SetUnitY(udg_s__Kagerou_w_caster[w], GetUnitY(udg_s__Kagerou_w_u[w]) + 50 * Sin(udg_s__Kagerou_w_a[w] + 0.2 * udg_s__Kagerou_w_i[w]))
    call SetUnitFacing(udg_s__Kagerou_w_caster[w], (udg_s__Kagerou_w_a[w] + 0.2 * udg_s__Kagerou_w_i[w]) / 3.14 * 180 + 90)
    set udg_Kagerou_int = LoadInteger(udg_ht, GetHandleId(t), 1)
    call DebugMsg("udg_Kagerou struct1:" + I2S(w))
    call ForGroup(udg_s__Kagerou_w_g2[w], function s__Kagerou_w_wSkill_Spell_Move)
    if udg_s__Kagerou_w_i[w] < 30 then
        call SetUnitFlyHeight(udg_s__Kagerou_w_u[w], GetUnitFlyHeight(udg_s__Kagerou_w_u[w]) + udg_Kagerou__Kagerou01_FLYRATE * 0.02, 99999)
    else
        call SetUnitFlyHeight(udg_s__Kagerou_w_u[w], GetUnitFlyHeight(udg_s__Kagerou_w_u[w]) - udg_Kagerou__Kagerou01_FLYRATE * 0.02, 99999)
    endif
    if udg_s__Kagerou_w_i[w] == 50 then
        call SetUnitAnimation(CreateUnit(GetOwningPlayer(udg_s__Kagerou_w_caster[w]), 'h02P', GetUnitX(udg_s__Kagerou_w_u[w]), GetUnitY(udg_s__Kagerou_w_u[w]), 0), "Birth")
    endif
    if udg_s__Kagerou_w_i[w] / 10 * 10 == udg_s__Kagerou_w_i[w] then
        if Kagerou__KagerouEx_NIGHT_BUFF(udg_s__Kagerou_w_caster[w]) then
            call UnitPhysicalDamageTarget(udg_s__Kagerou_w_caster[w], udg_s__Kagerou_w_u[w], udg_s__Kagerou_w_damage[w] / 6)
        else
            call UnitMagicDamageTarget(udg_s__Kagerou_w_caster[w], udg_s__Kagerou_w_u[w], udg_s__Kagerou_w_damage[w] / 6, 5)
        endif
    endif
    if udg_s__Kagerou_w_i[w] > 60 then
        call SetUnitX(udg_s__Kagerou_w_caster[w], GetUnitX(udg_s__Kagerou_w_u[w]))
        call SetUnitY(udg_s__Kagerou_w_caster[w], GetUnitY(udg_s__Kagerou_w_u[w]))
        call PauseUnit(udg_s__Kagerou_w_caster[w], false)
        call SetUnitInvulnerable(udg_s__Kagerou_w_caster[w], false)
        call SetUnitVertexColor(udg_s__Kagerou_w_caster[w], 255, 255, 255, 255)
        call AbilityCoolDownResetion(udg_s__Kagerou_w_caster[w], udg_Kagerou__KagerouEx2, 0)
        call FlushChildHashtable(udg_ht, GetHandleId(t))
        call ReleaseTimer(t)
        call DestroyGroup(udg_s__Kagerou_w_g2[w])
        call s__Kagerou_w_destroy(w)
    endif
endfunction

function s__Kagerou_w_wSkill_Action takes nothing returns nothing
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
                set sp = CreateUnit(GetOwningPlayer(udg_s__Kagerou_w_caster[w]), udg_Kagerou__Kagerou02_EFFECT_UNIT_CODE, GetUnitX(udg_s__Kagerou_w_u[w]) + 200 * Cos(udg_s__Kagerou_w_a[w] + 1.57 * udg_s__Kagerou_w_n[w]), GetUnitY(udg_s__Kagerou_w_u[w]) + 200 * Sin(udg_s__Kagerou_w_a[w] + 1.57 * udg_s__Kagerou_w_n[w]), 0)
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
endfunction

function s__Kagerou_w_wSkill_AOE_Action takes nothing returns nothing
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
endfunction

function s__Kagerou_w_wSkill_AOE_Main takes nothing returns nothing
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
                if Kagerou__KagerouEx_NIGHT_BUFF(udg_s__Kagerou_w_caster[w]) then
                    call UnitPhysicalDamageTarget(udg_s__Kagerou_w_caster[w], v, udg_s__Kagerou_w_damage[w])
                else
                    call UnitMagicDamageTarget(udg_s__Kagerou_w_caster[w], v, udg_s__Kagerou_w_damage[w], 1)
                endif
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
endfunction

function Kagerou__Kagerou_r_Damage_Conditions takes nothing returns boolean
    if GetUnitAbilityLevel(GetEventDamageSource(), udg_Kagerou__Kagerou03) == 0 and GetUnitAbilityLevel(GetEventDamageSource(), udg_Kagerou__Kagerou02) == 0 then
        return false
    endif
    if IsUnitAlly(GetTriggerUnit(), GetOwningPlayer(GetEventDamageSource())) then
        return false
    endif
    if IsUnitType(GetTriggerUnit(), UNIT_TYPE_STRUCTURE) then
        return false
    endif
    if IsUnitIllusion(GetEventDamageSource()) then
        return false
    endif
    if GetEventDamage() == 0 then
        return false
    endif
    if IsDamageNotUnitAttack(GetEventDamageSource()) then
        return false
    endif
    return true
endfunction

function Kagerou__Kagerou_r_Damage_Actions takes nothing returns nothing
    local unit caster = GetEventDamageSource()
    local unit target = GetTriggerUnit()
    local real level = GetUnitAbilityLevel(caster, udg_Kagerou__Kagerou03)
    local real damage
    if GetUnitAbilityLevel(caster, udg_Kagerou__Kagerou02) != 0 then
        if Kagerou__KagerouEx_HAS_BUFF(caster) then
            set damage = (level - 1) * udg_Kagerou__Kagerou03_DAMAGE_INC_EX + udg_Kagerou__Kagerou03_DAMAGE_BASE_EX
        else
            set damage = (level - 1) * udg_Kagerou__Kagerou03_DAMAGE_INC + udg_Kagerou__Kagerou03_DAMAGE_BASE
        endif
        call UnitPhysicalDamageTarget(caster, target, damage)
    endif
    if GetUnitAbilityLevel(caster, udg_Kagerou__Kagerou03) != 0 then
        if GetRandomInt(0, 100) < 5 + level * 5 or GetUnitAbilityLevel(caster, 'A1I6') != 0 then
            call UnitStunTarget(caster, target, 1.0, 0, 0)
            if GetUnitTypeId(caster) == 'O01D' then
                call UnitHealingTarget(caster, caster, 100)
            endif
            call UnitRemoveAbility(caster, 'A1I6')
        endif
    endif
    set caster = null
    set target = null
endfunction

function Kagerou_Kagerou_AddAbility takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 1)
    call UnitAddAbility(caster, udg_Kagerou__KagerouEx2)
    call UnitMakeAbilityPermanent(caster, true, udg_Kagerou__KagerouEx2)
    call PauseTimer(t)
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    set t = null
    set caster = null
endfunction

function Kagerou__Skill takes nothing returns boolean
    local unit caster = GetTriggerUnit()
    local unit u = null
    local unit sp
    local integer id = GetSpellAbilityId()
    local integer lvl = GetUnitAbilityLevel(caster, id)
    local integer p = GetPlayerId(GetOwningPlayer(caster))
    local location loc = GetSpellTargetLoc()
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real tx = GetLocationX(loc)
    local real ty = GetLocationY(loc)
    local real damage
    local timer t = null
    local integer task
    local group g = CreateGroup()
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    call DebugMsg("skill open")
    if id == udg_Kagerou__KagerouEx2 then
        call Kagerou__KagerouEx2_BUFF(caster)
    elseif id == udg_Kagerou__Kagerou01 then
        call AbilityCoolDownResetion(caster, id, udg_Kagerou__Kagerou01_CD_BASE - (lvl - 1) * udg_Kagerou__Kagerou01_CD_DECREASE)
        set damage = (lvl - 1) * udg_Kagerou__Kagerou01_DAMAGE_INC + udg_Kagerou__Kagerou01_DAMAGE_BASE + GetUnitAttack(caster) * udg_Kagerou__Kagerou01_DAMAGE_SCALE
        call s__Kagerou_d_create(caster, damage, Atan2(ty - oy, tx - ox))
        call DebugMsg("01 skill open")
    elseif id == udg_Kagerou__Kagerou02 then
        call AbilityCoolDownResetion(caster, id, udg_Kagerou__Kagerou02_CD_BASE - (lvl - 1) * udg_Kagerou__Kagerou02_CD_DECREASE)
        set damage = (lvl - 1) * udg_Kagerou__Kagerou02_DAMAGE_INC + udg_Kagerou__Kagerou02_DAMAGE_BASE + GetUnitAttack(caster) * udg_Kagerou__Kagerou02_DAMAGE_SCALE
        call s__Kagerou_f_create(caster, damage, ox, oy, tx, ty)
        call DebugMsg("02 skill open")
    elseif id == udg_Kagerou__Kagerou03 then
        call UnitAddAbility(caster, udg_Kagerou__KagerouEx2)
        call UnitMakeAbilityPermanent(caster, true, udg_Kagerou__KagerouEx2)
        call UnitAddAbility(caster, 'A1I6')
        call UnitMakeAbilityPermanent(caster, true, 'A1I6')
        set t = CreateTimer()
        set task = GetHandleId(t)
        call SaveUnitHandle(udg_ht, task, 1, caster)
        call TimerStart(t, 15.1, false, function Kagerou_Kagerou_AddAbility)
        if Kagerou__KagerouEx2_HAS_BUFF(caster) then
            call Kagerou__KagerouEx2_CLEAR_BUFF(caster)
            call UnitHealingTarget(caster, caster, 200 + GetUnitState(caster, UNIT_STATE_MAX_LIFE) * 0.03 * lvl)
        endif
    elseif id == udg_Kagerou__Kagerou04 then
        call AbilityCoolDownResetion(caster, id, udg_Kagerou__Kagerou04_CD_BASE - (lvl - 1) * udg_Kagerou__Kagerou04_CD_DECREASE)
        set damage = (lvl - 1) * udg_Kagerou__Kagerou04_DAMAGE_INC + udg_Kagerou__Kagerou04_DAMAGE_BASE + GetUnitAttack(caster) * udg_Kagerou__Kagerou04_DAMAGE_SCALE
        call s__Kagerou_w_create(caster, damage, ox, oy, tx, ty)
        call DebugMsg("04 skill open")
    endif
    call RemoveLocation(loc)
    call DestroyGroup(g)
    set t = null
    set caster = null
    set loc = null
    set u = null
    set g = null
    set sp = null
    return false
endfunction

function Kagerou_Init takes nothing returns nothing
    local trigger t = CreateTrigger()
    local timer exTimer = CreateTimer()
    call DebugMsg("Initial Kagerou1")
    call TriggerAddCondition(t, Condition(function Kagerou__Skill))
    call TriggerRegisterUnitEvent(t, udg_Kagerou, EVENT_UNIT_SPELL_EFFECT)
    call DebugMsg("Initial Kagerou2")
    call UnitAddAbility(udg_Kagerou, udg_Kagerou__KagerouEx2)
    call UnitMakeAbilityPermanent(udg_Kagerou, true, udg_Kagerou__KagerouEx2)
    call SaveInteger(udg_ht, GetHandleId(exTimer), 0, 0)
    call SaveUnitHandle(udg_ht, GetHandleId(exTimer), 1, udg_Kagerou)
    call TimerStart(exTimer, 0.5, true, function Kagerou__KagerouEx_Loop)
    call DebugMsg("Initial Kagerou3")
    set t = CreateTrigger()
    call RegisterAnyUnitDamage(t)
    call TriggerAddCondition(t, Condition(function Kagerou__Kagerou_r_Damage_Conditions))
    call TriggerAddAction(t, function Kagerou__Kagerou_r_Damage_Actions)
    call SetHeroLifeIncreaseValue(udg_Kagerou, 28)
    call SetHeroManaIncreaseValue(udg_Kagerou, 8)
    call SetHeroManaBaseRegenValue(udg_Kagerou, 0.7)
    call DebugMsg("Initial Kagerou4")
    set t = null
endfunction

function Trig_Initial_Kagerou_Actions takes nothing returns nothing
    set udg_Kagerou = GetCharacterHandle(udg_Kagerou_CODE)
    call FirstAbilityInit('A0IL')
    call FirstAbilityInit('Arav')
    call FirstAbilityInit('A1HT')
    call FirstAbilityInit('A1I6')
    call DebugMsg("Initial Kagerou0")
    call Kagerou_Init()
endfunction

function InitTrig_Initial_Kagerou takes nothing returns nothing
    set gg_trg_Initial_Kagerou = CreateTrigger()
    call TriggerAddAction(gg_trg_Initial_Kagerou, function Trig_Initial_Kagerou_Actions)
endfunction