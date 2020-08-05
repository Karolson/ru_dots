function s__ReisenNew_projectile_ReisenNewEx takes unit caster, unit target returns nothing
    local real cx = GetUnitX(caster)
    local real cy = GetUnitY(caster)
    local real tx = GetUnitX(target)
    local real ty = GetUnitY(target)
    local real dx = tx - cx
    local real dy = ty - cy
    local real a = Atan2(dy, dx)
    local real dis = SquareRoot(dx * dx + dy * dy)
    local real n
    local real i = udg_ReisenNew___ReisenNewEx_NUMBER
    local unit v
    loop
        set n = GetRandomReal(-3.14, 3.14)
    exitwhen i == 0
        set v = CreateUnit(GetOwningPlayer(caster), udg_ReisenNew___ReisenNewEx_EFFECTUNIT, tx + Cos(a + n) * dis, ty + Sin(a + n) * dis, a + n)
        call UnitAddBonusDmg(v, R2I(GetUnitAttack(caster) * udg_ReisenNew___ReisenNewEx_SCALE))
        call IssueTargetOrder(v, "attack", target)
        call ShowUnit(v, false)
        set i = i - 1
    endloop
    set v = null
endfunction

function s__ReisenNew_projectile_ReisenNew02Main takes unit caster, real x, real y returns nothing
    local unit u
    local real damage = (GetUnitAbilityLevel(caster, udg_ReisenNew___ReisenNew02) - 1) * udg_ReisenNew___ReisenNew02_DAMAGE_INC + udg_ReisenNew___ReisenNew02_DAMAGE_BASE + udg_ReisenNew___ReisenNew02_DAMAGE_SCALE * GetUnitAttack(caster)
    local real stuntime = (GetUnitAbilityLevel(caster, udg_ReisenNew___ReisenNew02) - 1) * udg_ReisenNew___ReisenNew02_STUNTIME_INC + udg_ReisenNew___ReisenNew02_STUNTIME_BASE
    call UnitMagicDamageArea(caster, x, y, udg_ReisenNew___ReisenNew02_AOE, damage, 5)
    call UnitStunArea(caster, stuntime, x, y, udg_ReisenNew___ReisenNew02_AOE, 0, 0)
    set u = CreateUnit(GetOwningPlayer(caster), udg_ReisenNew___ReisenNew02_EFFECT, x, y, 0)
    call UnitApplyTimedLife(u, 'BHwe', 0.5)
    set u = null
endfunction

function s__ReisenNew_projectile_create takes unit caster, real damage returns integer
    local timer t = CreateTimer()
    local integer i = 5
    local integer m = s__ReisenNew_projectile__allocate()
    set udg_s__ReisenNew_projectile_caster[m] = caster
    set udg_s__ReisenNew_projectile_damage[m] = damage
    set udg_s__ReisenNew_projectile_a[m] = (GetUnitFacing(caster) - 30) / 180 * 3.14
    set udg_s__ReisenNew_projectile_cx[m] = GetUnitX(udg_s__ReisenNew_projectile_caster[m])
    set udg_s__ReisenNew_projectile_cy[m] = GetUnitY(udg_s__ReisenNew_projectile_caster[m])
    set udg_s__ReisenNew_projectile_n[m] = 0
    set udg_s__ReisenNew_projectile_g[m] = CreateGroup()
    loop
    exitwhen i == 0
        set udg_s__ReisenNew_projectile_u[m] = CreateUnit(GetOwningPlayer(caster), udg_ReisenNew___ReisenNew04_SHOT, udg_s__ReisenNew_projectile_cx[m] + Cos(udg_s__ReisenNew_projectile_a[m]) * 80, udg_s__ReisenNew_projectile_cy[m] + Sin(udg_s__ReisenNew_projectile_a[m]) * 80, udg_s__ReisenNew_projectile_a[m] * 180 / 3.14)
        call GroupAddUnit(udg_s__ReisenNew_projectile_g[m], udg_s__ReisenNew_projectile_u[m])
        set i = i - 1
        set udg_s__ReisenNew_projectile_a[m] = udg_s__ReisenNew_projectile_a[m] + 0.2617
    endloop
    call SaveInteger(udg_ht, GetHandleId(t), 0, m)
    call TimerStart(t, 0.02, true, function sc__ReisenNew_projectile_startloop)
    set t = null
    return m
endfunction

function s__ReisenNew_projectile_destroy takes integer this returns nothing
    set udg_s__ReisenNew_projectile_caster[this] = null
    set udg_s__ReisenNew_projectile_u[this] = null
    call DestroyGroup(udg_s__ReisenNew_projectile_g[this])
    call s__ReisenNew_projectile_deallocate(this)
endfunction

function s__ReisenNew_projectile_startloop takes nothing returns nothing
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
endfunction

function s__ReisenNew_spell_destroy takes integer this returns nothing
    set udg_s__ReisenNew_spell_caster[this] = null
    set udg_s__ReisenNew_spell_u[this] = null
    call s__ReisenNew_spell_deallocate(this)
endfunction

function s__ReisenNew_spell_create takes unit caster, real x, real y, real damage returns integer
    local timer t = CreateTimer()
    local integer s = s__ReisenNew_spell__allocate()
    set udg_s__ReisenNew_spell_caster[s] = caster
    set udg_s__ReisenNew_spell_cx[s] = GetUnitX(caster)
    set udg_s__ReisenNew_spell_cy[s] = GetUnitY(caster)
    set udg_s__ReisenNew_spell_tx[s] = x
    set udg_s__ReisenNew_spell_ty[s] = y
    set udg_s__ReisenNew_spell_damage[s] = damage
    set udg_s__ReisenNew_spell_i[s] = 0
    set udg_s__ReisenNew_spell_a[s] = Atan2(udg_s__ReisenNew_spell_cy[s] - udg_s__ReisenNew_spell_ty[s], udg_s__ReisenNew_spell_cx[s] - udg_s__ReisenNew_spell_tx[s])
    set udg_s__ReisenNew_spell_u[s] = CreateUnit(GetOwningPlayer(caster), udg_ReisenNew___ReisenNew04_SHOT, udg_s__ReisenNew_spell_cx[s], udg_s__ReisenNew_spell_cy[s], udg_s__ReisenNew_spell_a[s] * 180 / 3.14)
    call SaveInteger(udg_ht, GetHandleId(t), 0, s)
    call SetUnitFacing(caster, (udg_s__ReisenNew_spell_a[s] + 3.14) / 3.14 * 180)
    call TimerStart(t, 0.02, true, function sc__ReisenNew_spell_skill01loop)
    set t = null
    return s
endfunction

function s__ReisenNew_spell_skill01loop takes nothing returns nothing
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
endfunction

function s__ReisenNew_laser_create takes unit caster, real x, real y, real damage returns integer
    local timer t = CreateTimer()
    local integer b = s__ReisenNew_laser__allocate()
    set udg_s__ReisenNew_laser_caster[b] = caster
    set udg_s__ReisenNew_laser_cx[b] = GetUnitX(caster)
    set udg_s__ReisenNew_laser_cy[b] = GetUnitY(caster)
    set udg_s__ReisenNew_laser_tx[b] = x
    set udg_s__ReisenNew_laser_ty[b] = y
    set udg_s__ReisenNew_laser_a[b] = Atan2(udg_s__ReisenNew_laser_ty[b] - udg_s__ReisenNew_laser_cy[b], udg_s__ReisenNew_laser_tx[b] - udg_s__ReisenNew_laser_cx[b]) - 1.046
    set udg_s__ReisenNew_laser_dx[b] = udg_s__ReisenNew_laser_tx[b] - udg_s__ReisenNew_laser_cx[b]
    set udg_s__ReisenNew_laser_dy[b] = udg_s__ReisenNew_laser_ty[b] - udg_s__ReisenNew_laser_cy[b]
    set udg_s__ReisenNew_laser_dis[b] = SquareRoot(udg_s__ReisenNew_laser_dx[b] * udg_s__ReisenNew_laser_dx[b] + udg_s__ReisenNew_laser_dy[b] * udg_s__ReisenNew_laser_dy[b])
    set udg_s__ReisenNew_laser_i[b] = 0
    set udg_s__ReisenNew_laser_damage[b] = damage
    set udg_s__ReisenNew_laser_g[b] = CreateGroup()
    set udg_s__ReisenNew_laser_u[b] = CreateUnit(GetOwningPlayer(caster), udg_ReisenNew___ReisenNew03_EFFECTUNIT, udg_s__ReisenNew_laser_cx[b] + Cos(udg_s__ReisenNew_laser_a[b]) * udg_s__ReisenNew_laser_dis[b], udg_s__ReisenNew_laser_cy[b] + Sin(udg_s__ReisenNew_laser_a[b]) * udg_s__ReisenNew_laser_dis[b], 0)
    call SaveInteger(udg_ht, GetHandleId(t), 0, b)
    call TimerStart(t, 0.02, true, function sc__ReisenNew_laser_laserloop)
    set t = null
    return b
endfunction

function s__ReisenNew_laser_destroy takes integer this returns nothing
    set udg_s__ReisenNew_laser_caster[this] = null
    set udg_s__ReisenNew_laser_u[this] = null
    call DestroyGroup(udg_s__ReisenNew_laser_g[this])
    call s__ReisenNew_laser_deallocate(this)
endfunction

function s__ReisenNew_laser_laserdamage takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local unit v
    local real damage = 0
    local integer b = LoadInteger(udg_ht, GetHandleId(t), 0)
    loop
        set v = FirstOfGroup(udg_s__ReisenNew_laser_g[b])
    exitwhen v == null
        set damage = UnitMagicDamageTarget(udg_s__ReisenNew_laser_caster[b], v, udg_s__ReisenNew_laser_damage[b], 5)
        if GetUnitAbilityLevel(udg_s__ReisenNew_laser_caster[b], udg_ReisenNew___ReisenNew02_BUFF) > 0 then
            call s__ReisenNew_projectile_ReisenNew02Main(udg_s__ReisenNew_laser_caster[b], GetUnitX(v), GetUnitY(v))
        endif
        if GetWidgetLife(v) > 0.405 and damage > 1.0 then
            call s__ReisenNew_projectile_ReisenNewEx(udg_s__ReisenNew_laser_caster[b], v)
        endif
        call AddTimedEffectToUnit(v, 1.0, "Objects\\Spawnmodels\\Human\\HumanBlood\\HumanBloodPeasant.mdl", "origin")
        call GroupRemoveUnit(udg_s__ReisenNew_laser_g[b], v)
    endloop
    call FlushChildHashtable(udg_ht, GetHandleId(t))
    call s__ReisenNew_laser_destroy(b)
    call ReleaseTimer(t)
    set t = null
endfunction

function s__ReisenNew_laser_laserloop takes nothing returns nothing
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
endfunction

function ReisenNew___Skill takes nothing returns boolean
    local unit caster = GetTriggerUnit()
    local integer id = GetSpellAbilityId()
    local integer lvl = GetUnitAbilityLevel(caster, id)
    local location loc = GetSpellTargetLoc()
    local real x = GetLocationX(loc)
    local real y = GetLocationY(loc)
    local real damage
    call DebugMsg("skill open")
    if id == udg_ReisenNew___ReisenNew01 then
        call AbilityCoolDownResetion(caster, id, udg_ReisenNew___ReisenNew01_CD_BASE - (lvl - 1) * udg_ReisenNew___ReisenNew01_CD_DECREASE)
        set damage = (lvl - 1) * udg_ReisenNew___ReisenNew01_DAMAGE_INC + udg_ReisenNew___ReisenNew01_DAMAGE_BASE + GetUnitAttack(caster) * udg_ReisenNew___ReisenNew01_DAMAGE_SCALE
        call s__ReisenNew_spell_create(caster, x, y, damage)
        call DebugMsg("01 skill open")
    elseif id == udg_ReisenNew___ReisenNew02 then
    elseif id == udg_ReisenNew___ReisenNew03 then
        call AbilityCoolDownResetion(caster, id, udg_ReisenNew___ReisenNew03_CD_BASE - (lvl - 1) * udg_ReisenNew___ReisenNew03_CD_DECREASE)
        set damage = (lvl - 1) * udg_ReisenNew___ReisenNew03_DAMAGE_INC + udg_ReisenNew___ReisenNew03_DAMAGE_BASE + GetUnitAttack(caster) * udg_ReisenNew___ReisenNew03_DAMAGE_SCALE
        call s__ReisenNew_laser_create(caster, x, y, damage)
        call DebugMsg("03 skill open")
    elseif id == udg_ReisenNew___ReisenNew04 then
        call AbilityCoolDownResetion(caster, id, udg_ReisenNew___ReisenNew04_CD_BASE - (lvl - 1) * udg_ReisenNew___ReisenNew04_CD_DECREASE)
        set damage = (lvl - 1) * udg_ReisenNew___ReisenNew04_DAMAGE_INC + udg_ReisenNew___ReisenNew04_DAMAGE_BASE + GetUnitAttack(caster) * udg_ReisenNew___ReisenNew04_DAMAGE_SCALE
        call s__ReisenNew_projectile_create(caster, damage)
        call DebugMsg("04 skill open")
    endif
    call RemoveLocation(loc)
    set caster = null
    set loc = null
    return false
endfunction

function ReisenNew_Init takes nothing returns nothing
    local trigger t = CreateTrigger()
    call TriggerAddCondition(t, Condition(function ReisenNew___Skill))
    call TriggerRegisterUnitEvent(t, udg_ReisenNew, EVENT_UNIT_SPELL_EFFECT)
    call SetHeroLifeIncreaseValue(udg_ReisenNew, 6)
    call SetHeroManaIncreaseValue(udg_ReisenNew, 1)
    call SetHeroManaBaseRegenValue(udg_ReisenNew, 0.4)
    set t = null
endfunction

function Trig_Initial_ReisenNew_Actions takes nothing returns nothing
    set udg_ReisenNew = GetCharacterHandle(udg_ReisenNew_CODE)
    call FirstAbilityInit('A12H')
    call FirstAbilityInit('A12I')
    call FirstAbilityInit('A12J')
    call FirstAbilityInit('A12K')
    call ReisenNew_Init()
endfunction

function InitTrig_Initial_ReisenNew takes nothing returns nothing
    set gg_trg_Initial_ReisenNew = CreateTrigger()
    call TriggerAddAction(gg_trg_Initial_ReisenNew, function Trig_Initial_ReisenNew_Actions)
endfunction