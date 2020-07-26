function s__fadelightning_destroy takes integer this returns nothing
    call DestroyLightning(udg_s__fadelightning_l[this])
    set udg_s__fadelightning_l[this] = null
    call FlushChildHashtable(udg_ht, GetHandleId(udg_s__fadelightning_t[this]))
    call PauseTimer(udg_s__fadelightning_t[this])
    call DestroyTimer(udg_s__fadelightning_t[this])
    set udg_s__fadelightning_t[this] = null
    call s__fadelightning_deallocate(this)
endfunction

function s__fadelightning_onLoop takes nothing returns nothing
    local integer fl = LoadInteger(udg_ht, GetHandleId(GetExpiredTimer()), 0)
    set udg_s__fadelightning_timeleft[fl] = udg_s__fadelightning_timeleft[fl] - 0.03125
    if udg_s__fadelightning_timeleft[fl] < 0.0 then
        call s__fadelightning_destroy(fl)
    else
        call SetLightningColor(udg_s__fadelightning_l[fl], udg_s__fadelightning_r[fl], udg_s__fadelightning_g[fl], udg_s__fadelightning_b[fl], udg_s__fadelightning_timeleft[fl] / udg_s__fadelightning_fadetime[fl])
    endif
endfunction

function s__fadelightning_create takes lightning l, real fadetime returns integer
    local integer fl
    if l == null or fadetime <= 0.0 then
        return 0
    else
        set fl = s__fadelightning__allocate()
    endif
    set udg_s__fadelightning_l[fl] = l
    set udg_s__fadelightning_fadetime[fl] = fadetime
    set udg_s__fadelightning_timeleft[fl] = fadetime
    set udg_s__fadelightning_r[fl] = GetLightningColorR(l)
    set udg_s__fadelightning_g[fl] = GetLightningColorG(l)
    set udg_s__fadelightning_b[fl] = GetLightningColorB(l)
    set udg_s__fadelightning_t[fl] = CreateTimer()
    call SaveInteger(udg_ht, GetHandleId(udg_s__fadelightning_t[fl]), 0, fl)
    call TimerStart(udg_s__fadelightning_t[fl], 0.03125, true, function s__fadelightning_onLoop)
    return fl
endfunction

function BlackMeiling__BMEX_LightningStrike takes unit source, real x, real y returns nothing
    local real d = GetRandomReal(0.0, 300.0)
    local real a = GetRandomReal(0.0, 6.2832)
    local real length = GetRandomReal(100.0, 300.0)
    local real angle = GetRandomReal(0.0, 6.2832)
    local real ox = x + d * Cos(a)
    local real oy = y + d * Sin(a)
    local real oz = GetPositionZ(ox, oy)
    local real tx = ox + length * Cos(angle)
    local real ty = oy + length * Sin(angle)
    local real tz = GetPositionZ(tx, ty)
    local real px = 0.0
    local real py = 0.0
    local lightning l = AddLightningEx(udg_BlackMeiling__BMEX_LightningFX, true, ox, oy, oz, tx, ty, tz)
    local group g = CreateGroup()
    local group forenum = CreateGroup()
    local unit u = null
    local real r = 50.0
    local real dx = r * Cos(angle)
    local real dy = r * Sin(angle)
    local boolexpr f = udg_FLIFF[GetPlayerId(GetOwningPlayer(source))]
    local real damage = udg_BlackMeiling__BMEX_LightningDamage + udg_BlackMeiling__BMEX_LightningScaleFactor * GetUnitAttack(source)
    loop
    exitwhen r >= length
        set px = ox + dx
        set py = oy + dy
        call GroupEnumUnitsInRange(forenum, px, py, 100.0, f)
        loop
            set u = FirstOfGroup(forenum)
        exitwhen u == null
            call GroupRemoveUnit(forenum, u)
            call GroupAddUnit(g, u)
        endloop
        set r = r + 50.0
    endloop
    loop
        set u = FirstOfGroup(g)
    exitwhen u == null
        call GroupRemoveUnit(g, u)
        call UnitMagicDamageTarget(source, u, damage, 5)
    endloop
    call s__fadelightning_create(l, udg_BlackMeiling__BMEX_LightningFadeTime)
    call GroupClear(g)
    call DestroyGroup(g)
    call GroupClear(forenum)
    call DestroyGroup(forenum)
    set g = null
    set forenum = null
    set f = null
    set l = null
endfunction

function BlackMeiling__BMEX_LightningSimpleStrikeExact takes unit source, real x, real y returns nothing
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\Monsoon\\MonsoonBoltTarget.mdl", x, y))
    call UnitMagicDamageArea(source, x, y, 220, udg_BlackMeiling__BMEX_LightningDamage + udg_BlackMeiling__BMEX_LightningScaleFactor * GetUnitAttack(source), 6)
endfunction

function BlackMeiling__BMEX_LightningSimpleStrikeRandom takes unit source, real x, real y returns nothing
    local real d = GetRandomReal(0.0, 300.0)
    local real a = GetRandomReal(0.0, 6.2832)
    local real tx = x + d * Cos(a)
    local real ty = y + d * Sin(a)
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\Monsoon\\MonsoonBoltTarget.mdl", tx, ty))
    call UnitMagicDamageArea(source, tx, ty, 220, udg_BlackMeiling__BMEX_LightningDamage + udg_BlackMeiling__BMEX_LightningScaleFactor * GetUnitAttack(source), 6)
endfunction

function s__flytotarget_destroy takes integer this returns nothing
    set udg_s__flytotarget_source[this] = null
    set udg_s__flytotarget_target[this] = null
    call FlushChildHashtable(udg_ht, GetHandleId(udg_s__flytotarget_t[this]))
    call PauseTimer(udg_s__flytotarget_t[this])
    call DestroyTimer(udg_s__flytotarget_t[this])
    set udg_s__flytotarget_t[this] = null
    call s__flytotarget_deallocate(this)
endfunction

function s__flytotarget_delaydestroy takes nothing returns nothing
    local integer f = LoadInteger(udg_ht, GetHandleId(GetExpiredTimer()), 0)
    call RemoveSavedBoolean(udg_ht, StringHash("BM01_Hit"), GetHandleId(udg_s__flytotarget_target[f]))
    call s__flytotarget_destroy(f)
endfunction

function s__flytotarget_onLoop takes nothing returns nothing
    local integer f = LoadInteger(udg_ht, GetHandleId(GetExpiredTimer()), 0)
    local real tx = GetUnitX(udg_s__flytotarget_target[f])
    local real ty = GetUnitY(udg_s__flytotarget_target[f])
    local real cx = GetUnitX(udg_s__flytotarget_source[f])
    local real cy = GetUnitY(udg_s__flytotarget_source[f])
    local real a = 0.0
    if IsUnitInRange(udg_s__flytotarget_source[f], udg_s__flytotarget_target[f], udg_s__flytotarget_d[f]) then
        call PauseUnit(udg_s__flytotarget_source[f], false)
        call SetUnitAnimation(udg_s__flytotarget_source[f], "stand")
        call SetUnitFlag(udg_s__flytotarget_source[f], 5, false)
        call UnitPhysicalDamageTarget(udg_s__flytotarget_source[f], udg_s__flytotarget_target[f], udg_BlackMeiling__BM01_BaseDamage + (GetUnitAbilityLevel(udg_s__flytotarget_source[f], udg_BlackMeiling__BM01_Skill) - 1) * udg_BlackMeiling__BM02_PerLvlDamage + udg_BlackMeiling__BM01_DamageScaleFactor * GetUnitAttack(udg_s__flytotarget_source[f]))
        call Knockback(udg_s__flytotarget_source[f], udg_s__flytotarget_target[f], udg_BlackMeiling__BM01_KnockbackDistance, udg_BlackMeiling__BM01_KnockbackSpeed, Atan2(GetUnitY(udg_s__flytotarget_target[f]) - GetUnitY(udg_s__flytotarget_source[f]), GetUnitX(udg_s__flytotarget_target[f]) - GetUnitX(udg_s__flytotarget_source[f])), "Abilities\\Weapons\\AncientProtectorMissile\\AncientProtectorMissile.mdl", true, false, false, true)
        call SaveBoolean(udg_ht, StringHash("BM01_Hit"), GetHandleId(udg_s__flytotarget_target[f]), true)
        call PauseTimer(udg_s__flytotarget_t[f])
        call TimerStart(udg_s__flytotarget_t[f], udg_BlackMeiling__BM01_KnockbackDistance / udg_BlackMeiling__BM01_KnockbackSpeed, false, function s__flytotarget_delaydestroy)
    elseif not IsUnitInRange(udg_s__flytotarget_source[f], udg_s__flytotarget_target[f], 1500.0) then
        call PauseUnit(udg_s__flytotarget_source[f], false)
        call SetUnitAnimation(udg_s__flytotarget_source[f], "stand")
        call SetUnitFlag(udg_s__flytotarget_source[f], 5, false)
        call s__flytotarget_destroy(f)
    else
        set a = Atan2(ty - cy, tx - cx)
        set cx = cx + udg_s__flytotarget_d[f] * Cos(a)
        set cy = cy + udg_s__flytotarget_d[f] * Sin(a)
        call SetUnitX(udg_s__flytotarget_source[f], cx)
        call SetUnitY(udg_s__flytotarget_source[f], cy)
    endif
endfunction

function s__flytotarget_create takes unit source, unit target returns integer
    local integer f = s__flytotarget__allocate()
    set udg_s__flytotarget_source[f] = source
    set udg_s__flytotarget_target[f] = target
    set udg_s__flytotarget_d[f] = udg_BlackMeiling__BM01_Speed * 0.03125
    set udg_s__flytotarget_t[f] = CreateTimer()
    call SetUnitAnimation(source, udg_BlackMeiling__BM01_Animation)
    call SetUnitFlag(source, 5, true)
    call PauseUnit(source, true)
    call SaveInteger(udg_ht, GetHandleId(udg_s__flytotarget_t[f]), 0, f)
    call TimerStart(udg_s__flytotarget_t[f], 0.03125, true, function s__flytotarget_onLoop)
    return f
endfunction

function s__launchunits_destroy takes integer this returns nothing
    local unit u
    loop
        set u = FirstOfGroup(udg_s__launchunits_g[this])
    exitwhen u == null
    call SetUnitFlyHeight(u, 0, 0.0)
        call GroupRemoveUnit(udg_s__launchunits_g[this], u)
        call PauseUnit(u, false)
    endloop
    call PauseTimer(udg_s__launchunits_t[this])
    call DestroyTimer(udg_s__launchunits_t[this])
    set udg_s__launchunits_source[this] = null
    set udg_s__launchunits_t[this] = null
    call DestroyGroup(udg_s__launchunits_g[this])
    set udg_s__launchunits_g[this] = null
    call s__launchunits_deallocate(this)
endfunction

function s__launchunits_onLoopGroupCallback takes nothing returns nothing
    local integer l = LoadInteger(udg_ht, GetHandleId(GetExpiredTimer()), 0)
    call SetUnitFlyHeight(GetEnumUnit(), udg_s__launchunits_h[l], 0.0)
endfunction

function s__launchunits_onLoop takes nothing returns nothing
    local integer l = LoadInteger(udg_ht, GetHandleId(GetExpiredTimer()), 0)
    set udg_s__launchunits_timeleft[l] = udg_s__launchunits_timeleft[l] + 0.03125
    set udg_s__launchunits_h[l] = udg_s__launchunits_k[l] * udg_s__launchunits_timeleft[l] * (udg_BlackMeiling__BM02_FlyTime - udg_s__launchunits_timeleft[l])
    if udg_s__launchunits_timeleft[l] < udg_BlackMeiling__BM02_FlyTime then
        call ForGroup(udg_s__launchunits_g[l], function s__launchunits_onLoopGroupCallback)
    else
        call s__launchunits_destroy(l)
    endif
endfunction

function s__launchunits_toLaunch takes nothing returns nothing
    local integer l = LoadInteger(udg_ht, GetHandleId(GetExpiredTimer()), 0)
    local boolexpr f = udg_FLIFF[GetPlayerId(GetOwningPlayer(udg_s__launchunits_source[l]))]
    local group control = CreateGroup()
    local unit u
    local boolean toRefresh = false
    local integer lvl
    call PauseTimer(udg_s__launchunits_t[l])
    call DestroyEffect(udg_s__launchunits_e[l])
    set udg_s__launchunits_e[l] = null
    set udg_s__launchunits_g[l] = CreateGroup()
    call UnitMagicDamageArea(udg_s__launchunits_source[l], udg_s__launchunits_x[l], udg_s__launchunits_y[l], udg_BlackMeiling__BM02_Radius, udg_BlackMeiling__BM02_BaseDamage + (GetUnitAbilityLevel(udg_s__launchunits_source[l], udg_BlackMeiling__BM02_Skill) - 1) * udg_BlackMeiling__BM02_PerLvlDamage + udg_BlackMeiling__BM02_DamageScaleFactor * GetHeroInt(udg_s__launchunits_source[l], true), 5)
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Orc\\WarStomp\\WarStompCaster.mdl", udg_s__launchunits_x[l], udg_s__launchunits_y[l]))
    call GroupEnumUnitsInRange(control, udg_s__launchunits_x[l], udg_s__launchunits_y[l], udg_BlackMeiling__BM02_Radius, f)
    loop
        set u = FirstOfGroup(control)
    exitwhen u == null
        call GroupRemoveUnit(control, u)
        if IsUnitAliveBJ(u) then
           call GroupAddUnit(udg_s__launchunits_g[l], u)
           call EnableHeight(u)
           call PauseUnit(u, true)
           if LoadBoolean(udg_ht, StringHash("BM01_Hit"), GetHandleId(u)) then
            set toRefresh = true
        endif
    endif
    endloop
    if toRefresh then
        set lvl = GetUnitAbilityLevel(udg_s__launchunits_source[l], udg_BlackMeiling__BM01_Skill)
        call UnitRemoveAbility(udg_s__launchunits_source[l], udg_BlackMeiling__BM01_Skill)
        call UnitAddAbility(udg_s__launchunits_source[l], udg_BlackMeiling__BM01_Skill)
        call SetUnitAbilityLevel(udg_s__launchunits_source[l], udg_BlackMeiling__BM01_Skill, lvl)
        call UnitMakeAbilityPermanent(udg_s__launchunits_source[l], true, udg_BlackMeiling__BM01_Skill)
    endif
    if FirstOfGroup(udg_s__launchunits_g[l]) != null then
        set udg_s__launchunits_timeleft[l] = 0.0
        set udg_s__launchunits_k[l] = 4 * udg_BlackMeiling__BM02_LaunchMaxHeight / (udg_BlackMeiling__BM02_FlyTime * udg_BlackMeiling__BM02_FlyTime)
        set udg_s__launchunits_h[l] = 0.0
        call TimerStart(udg_s__launchunits_t[l], 0.03125, true, function s__launchunits_onLoop)
    else
        call s__launchunits_destroy(l)
    endif
    call DestroyGroup(control)
    set control = null
    set f = null
endfunction

function s__launchunits_create takes unit source, real x, real y returns integer
    local integer l = s__launchunits__allocate()
    set udg_s__launchunits_source[l] = source
    set udg_s__launchunits_e[l] = AddSpecialEffect(udg_BlackMeiling__BM02_Effect, x, y)
    set udg_s__launchunits_t[l] = CreateTimer()
    set udg_s__launchunits_x[l] = x
    set udg_s__launchunits_y[l] = y
    call SaveInteger(udg_ht, GetHandleId(udg_s__launchunits_t[l]), 0, l)
    call TimerStart(udg_s__launchunits_t[l], udg_BlackMeiling__BM02_Delay, false, function s__launchunits_toLaunch)
    return l
endfunction

function s__celestialcage_destroy takes integer this returns nothing
    call RemoveDestructable(udg_s__celestialcage_d1[this])
    call RemoveDestructable(udg_s__celestialcage_d2[this])
    call RemoveDestructable(udg_s__celestialcage_d3[this])
    call RemoveDestructable(udg_s__celestialcage_d4[this])
    set udg_s__celestialcage_d1[this] = null
    set udg_s__celestialcage_d2[this] = null
    set udg_s__celestialcage_d3[this] = null
    set udg_s__celestialcage_d4[this] = null
    call DestroyEffect(udg_s__celestialcage_le[this])
    call DestroyEffect(udg_s__celestialcage_re[this])
    set udg_s__celestialcage_le[this] = null
    set udg_s__celestialcage_re[this] = null
    call RemoveSavedInteger(udg_ht, GetHandleId(udg_s__celestialcage_t[this]), 0)
    call PauseTimer(udg_s__celestialcage_t[this])
    call DestroyTimer(udg_s__celestialcage_t[this])
    set udg_s__celestialcage_t[this] = null
    set udg_s__celestialcage_source[this] = null
    set udg_s__celestialcage_target[this] = null
    call s__celestialcage_deallocate(this)
endfunction

function s__celestialcage_onLoop takes nothing returns nothing
    local integer cc = LoadInteger(udg_ht, GetHandleId(GetExpiredTimer()), 0)
    set udg_s__celestialcage_timeleft[cc] = udg_s__celestialcage_timeleft[cc] - 0.2
    if udg_s__celestialcage_timeleft[cc] >= 0.0 then
        if IsUnitInRangeXY(udg_s__celestialcage_target[cc], udg_s__celestialcage_lx[cc], udg_s__celestialcage_ly[cc], udg_BlackMeiling__BM03_DamageRadius) then
            call UnitStunTarget(udg_s__celestialcage_source[cc], udg_s__celestialcage_target[cc], udg_BlackMeiling__BM03_BaseStunDuration + (GetUnitAbilityLevel(udg_s__celestialcage_source[cc], udg_BlackMeiling__BM03_Skill) - 1) * udg_BlackMeiling__BM03_PerLvlStunDuration, 0, 0)
            call s__celestialcage_destroy(cc)
        elseif IsUnitInRangeXY(udg_s__celestialcage_target[cc], udg_s__celestialcage_rx[cc], udg_s__celestialcage_ry[cc], udg_BlackMeiling__BM03_DamageRadius) then
            call UnitMagicDamageTarget(udg_s__celestialcage_source[cc], udg_s__celestialcage_target[cc], udg_BlackMeiling__BM03_BaseDamage + (GetUnitAbilityLevel(udg_s__celestialcage_source[cc], udg_BlackMeiling__BM03_Skill) - 1) * udg_BlackMeiling__BM03_PerLvlDamage + udg_BlackMeiling__BM03_DamageScaleFactor * GetHeroInt(udg_s__celestialcage_source[cc], true), 5)
            call s__celestialcage_destroy(cc)
        endif
    else
        call s__celestialcage_destroy(cc)
    endif
endfunction

function s__celestialcage_create takes unit source, unit target returns integer
    local integer cc = s__celestialcage__allocate()
    local real tx = GetUnitX(target)
    local real ty = GetUnitY(target)
    local real a = Atan2(ty - GetUnitY(source), tx - GetUnitX(source))
    local real a1 = a + 1.5708
    local real a2 = a - 1.5708
    local real ca = Cos(a)
    local real sa = Sin(a)
    local real ca1 = Cos(a1)
    local real ca2 = Cos(a2)
    local real sa1 = Sin(a1)
    local real sa2 = Sin(a2)
    local real x1 = tx + 64.0 * (ca + ca1)
    local real y1 = ty + 64.0 * (sa + sa1)
    local real x2 = tx + 64.0 * (ca + ca2)
    local real y2 = ty + 64.0 * (sa + sa2)
    local real x3 = tx + 64.0 * (ca1 - ca)
    local real y3 = ty + 64.0 * (sa1 - sa)
    local real x4 = tx + 64.0 * (ca2 - ca)
    local real y4 = ty + 64.0 * (sa2 - sa)
    local real lx = tx + 128.0 * ca1
    local real ly = ty + 128.0 * sa1
    local real rx = tx + 128.0 * ca2
    local real ry = ty + 128.0 * sa2
    set a = a1 * bj_RADTODEG
    set udg_s__celestialcage_source[cc] = source
    set udg_s__celestialcage_target[cc] = target
    set udg_s__celestialcage_d1[cc] = CreateDestructable(udg_BlackMeiling__BM03_Destructable, x1, y1, a, 0.7, 0)
    set udg_s__celestialcage_d2[cc] = CreateDestructable(udg_BlackMeiling__BM03_Destructable, x2, y2, a, 0.7, 0)
    set udg_s__celestialcage_d3[cc] = CreateDestructable(udg_BlackMeiling__BM03_Destructable, x3, y3, a, 0.7, 0)
    set udg_s__celestialcage_d4[cc] = CreateDestructable(udg_BlackMeiling__BM03_Destructable, x4, y4, a, 0.7, 0)
    set udg_s__celestialcage_le[cc] = AddSpecialEffect(udg_BlackMeiling__BM03_EffectLeft, lx, ly)
    set udg_s__celestialcage_re[cc] = AddSpecialEffect(udg_BlackMeiling__BM03_EffectRight, rx, ry)
    set udg_s__celestialcage_lx[cc] = lx
    set udg_s__celestialcage_ly[cc] = ly
    set udg_s__celestialcage_rx[cc] = rx
    set udg_s__celestialcage_ry[cc] = ry
    set udg_s__celestialcage_timeleft[cc] = udg_BlackMeiling__BM03_Duration
    set udg_s__celestialcage_t[cc] = CreateTimer()
    call SaveInteger(udg_ht, GetHandleId(udg_s__celestialcage_t[cc]), 0, cc)
    call TimerStart(udg_s__celestialcage_t[cc], 0.2, true, function s__celestialcage_onLoop)
    return cc
endfunction

function s__darklightningstorm_destroy takes integer this returns nothing
    call DestroyEffect(udg_s__darklightningstorm_e[this])
    set udg_s__darklightningstorm_e[this] = null
    call RemoveSavedInteger(udg_ht, GetHandleId(udg_s__darklightningstorm_t[this]), 0)
    call PauseTimer(udg_s__darklightningstorm_t[this])
    call DestroyTimer(udg_s__darklightningstorm_t[this])
    set udg_s__darklightningstorm_t[this] = null
    set udg_s__darklightningstorm_source[this] = null
    call s__darklightningstorm_deallocate(this)
endfunction

function s__darklightningstorm_onLoop takes nothing returns nothing
    local integer dls = LoadInteger(udg_ht, GetHandleId(GetExpiredTimer()), 0)
    local real r
    local real a
    set udg_s__darklightningstorm_strikenum[dls] = udg_s__darklightningstorm_strikenum[dls] - 1
    if udg_s__darklightningstorm_strikenum[dls] > 0 then
        set r = GetRandomReal(0.0, 0.5 * udg_BlackMeiling__BM04_StormDiameter)
        set a = GetRandomReal(0.0, 6.2832)
        call BlackMeiling__BMEX_LightningSimpleStrikeExact(udg_s__darklightningstorm_source[dls], udg_s__darklightningstorm_x[dls] + r * Cos(a), udg_s__darklightningstorm_y[dls] + r * Sin(a))
    else
        call s__darklightningstorm_destroy(dls)
    endif
endfunction

function s__darklightningstorm_create takes unit source, real duration, integer strikenum returns integer
    local integer dls = s__darklightningstorm__allocate()
    local real x = GetUnitX(source)
    local real y = GetUnitY(source)
    local real r = GetRandomReal(0.0, 0.5 * udg_BlackMeiling__BM04_StormDiameter)
    local real a = GetRandomReal(0.0, 6.2832)
    set udg_s__darklightningstorm_source[dls] = source
    set udg_s__darklightningstorm_x[dls] = x
    set udg_s__darklightningstorm_y[dls] = y
    set udg_s__darklightningstorm_e[dls] = AddSpecialEffect(udg_BlackMeiling__BM04_DarknessEffect, x, y)
    set udg_s__darklightningstorm_strikenum[dls] = strikenum
    call BlackMeiling__BMEX_LightningSimpleStrikeExact(source, x + r * Cos(a), y + r * Sin(a))
    set udg_s__darklightningstorm_t[dls] = CreateTimer()
    call SaveInteger(udg_ht, GetHandleId(udg_s__darklightningstorm_t[dls]), 0, dls)
    call TimerStart(udg_s__darklightningstorm_t[dls], duration / strikenum, true, function s__darklightningstorm_onLoop)
    return dls
endfunction

function BlackMeiling__onCast takes nothing returns boolean
    local unit caster = GetTriggerUnit()
    local integer abid = GetSpellAbilityId()
    local integer lvl = GetUnitAbilityLevel(caster, abid)
    if abid == udg_BlackMeiling__BM01_Skill then
        call AbilityCoolDownResetion(caster, abid, 6.0)
        call BlackMeiling__BMEX_LightningSimpleStrikeRandom(caster, GetUnitX(GetSpellTargetUnit()), GetUnitY(GetSpellTargetUnit()))
        call s__flytotarget_create(caster, GetSpellTargetUnit())
    elseif abid == udg_BlackMeiling__BM02_Skill then
        call AbilityCoolDownResetion(caster, abid, 10.0)
        call BlackMeiling__BMEX_LightningSimpleStrikeRandom(caster, GetSpellTargetX(), GetSpellTargetY())
        call s__launchunits_create(caster, GetSpellTargetX(), GetSpellTargetY())
    elseif abid == udg_BlackMeiling__BM03_Skill then
        call AbilityCoolDownResetion(caster, abid, 15.0)
        call BlackMeiling__BMEX_LightningSimpleStrikeRandom(caster, GetUnitX(GetSpellTargetUnit()), GetUnitY(GetSpellTargetUnit()))
        call s__celestialcage_create(caster, GetSpellTargetUnit())
    elseif abid == udg_BlackMeiling__BM04_Skill then
        call AbilityCoolDownResetion(caster, abid, 130.0 - lvl * 10.0)
        call BlackMeiling__BMEX_LightningSimpleStrikeRandom(caster, GetUnitX(caster), GetUnitY(caster))
        call s__darklightningstorm_create(caster, udg_BlackMeiling__BM04_BaseDuration + (lvl - 1) * udg_BlackMeiling__BM04_PerLvlDuration, udg_BlackMeiling__BM04_BaseStrikeNumber + (lvl - 1) * udg_BlackMeiling__BM04_PerLvlStrikeNumber)
    endif
    set caster = null
    return false
endfunction

function BlackMeiling__onDamage takes nothing returns boolean
    local unit source = GetEventDamageSource()
    local integer count
    local integer task
    if GetUnitAbilityLevel(source, udg_BlackMeiling__BMEX_Skill) > 0 and GetEventDamage() > 0.0 then
        set task = GetHandleId(source)
        set count = LoadInteger(udg_ht, StringHash("BMEX_Count"), task)
        if count < 6 then
            call SaveInteger(udg_ht, StringHash("BMEX_Count"), task, count + 1)
        elseif count == 6 then
            call SaveInteger(udg_ht, StringHash("BMEX_Count"), task, 0)
            call BlackMeiling__BMEX_LightningSimpleStrikeRandom(source, GetUnitX(GetTriggerUnit()), GetUnitY(GetTriggerUnit()))
        endif
    endif
    set source = null
    return false
endfunction

function BlackMeiling_Init takes nothing returns nothing
    local trigger t = CreateTrigger()
    local unit u = GetCharacterHandle(udg_BlackMeiling__BlackMeilingType)
    call TriggerRegisterUnitEvent(t, u, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(t, Condition(function BlackMeiling__onCast))
    call SaveInteger(udg_ht, StringHash("BMEX_Count"), GetHandleId(u), 0)
    set t = CreateTrigger()
    call RegisterAnyUnitDamage(t)
    call TriggerAddCondition(t, Condition(function BlackMeiling__onDamage))
    set t = null
    set u = null
endfunction

function Trig_Initial_Black_Meiling_Actions takes nothing returns nothing
    call BlackMeiling_Init()
endfunction

function InitTrig_Initial_Black_Meiling takes nothing returns nothing
    set gg_trg_Initial_Black_Meiling = CreateTrigger()
    call TriggerAddAction(gg_trg_Initial_Black_Meiling, function Trig_Initial_Black_Meiling_Actions)
endfunction