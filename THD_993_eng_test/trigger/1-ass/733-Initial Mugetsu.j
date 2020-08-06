function Mugetsu__MugetsuEX_Loop takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local integer cnt = LoadInteger(udg_ht, task, 2)
    local unit u = LoadUnitHandle(udg_ht, task, 1)
    local real si = LoadReal(udg_ht, task, 3)
    if GetUnitAbilityLevel(u, 'A0YP') == 0 then
        if si != 0 then
            call DebugMsg("MoveSpeed Reduce:" + R2S(GetUnitMoveSpeed(u)) + " - " + R2S(si))
            call SetUnitMoveSpeed(u, GetUnitDefaultMoveSpeed(u))
            set si = 0
        endif
        set cnt = 0
        call UnitAddAbility(u, 'A0YP')
    else
        if si == 0 then
            set cnt = cnt + 1
            if cnt >= R2I(udg_Mugetsu__MUGETSUEX_TIME * 10) then
                set si = GetUnitMoveSpeed(u) * udg_Mugetsu__MUGETSUEX_PERCENT
                call DebugMsg("MoveSpeed Addition:" + R2S(GetUnitMoveSpeed(u)) + " + " + R2S(si))
                call SetUnitMoveSpeed(u, GetUnitDefaultMoveSpeed(u) + si)
            endif
        endif
    endif
    call SaveInteger(udg_ht, task, 2, cnt)
    call SaveReal(udg_ht, task, 3, si)
    set t = null
    set u = null
endfunction

function Mugetsu__Mugetsu04_Multi takes unit u returns real
    return 1.0 + udg_Mugetsu__MUGETSU04_MULTI_BASE + (GetUnitAbilityLevel(u, udg_Mugetsu__MUGETSU04) - 1) * udg_Mugetsu__MUGETSU04_MULTI_INC
endfunction

function s__mugetsu03_projectile_create takes unit source, real dmg, real ox, real oy, real tx, real ty, boolean multi returns integer
    local integer m = s__mugetsu03_projectile__allocate()
    set udg_s__mugetsu03_projectile_source[m] = source
    set udg_s__mugetsu03_projectile_p[m] = GetOwningPlayer(udg_s__mugetsu03_projectile_source[m])
    set udg_s__mugetsu03_projectile_projectile[m] = NewSpecialDummy(udg_s__mugetsu03_projectile_p[m], ox, oy, GetUnitFacing(udg_s__mugetsu03_projectile_source[m]))
    set udg_s__mugetsu03_projectile_e[m] = AddSpecialEffectTarget(udg_Mugetsu__MUGETSU03_PROJECTILE_MODEL, udg_s__mugetsu03_projectile_projectile[m], "origin")
    set udg_s__mugetsu03_projectile_dmg[m] = dmg
    set udg_s__mugetsu03_projectile_d[m] = 0.0
    set udg_s__mugetsu03_projectile_cx[m] = ox
    set udg_s__mugetsu03_projectile_cy[m] = oy
    set udg_s__mugetsu03_projectile_tx[m] = tx
    set udg_s__mugetsu03_projectile_ty[m] = ty
    set udg_s__mugetsu03_projectile_control[m] = CreateGroup()
    set udg_s__mugetsu03_projectile_toslow[m] = CreateGroup()
    set udg_s__mugetsu03_projectile_todestroy[m] = false
    set udg_s__mugetsu03_projectile_multi[m] = multi
    return m
endfunction

function s__mugetsu03_projectile_destroy takes integer this returns nothing
    set udg_s__mugetsu03_projectile_p[this] = null
    call DestroyEffect(udg_s__mugetsu03_projectile_e[this])
    set udg_s__mugetsu03_projectile_e[this] = null
    call ReleaseSpecialDummy(udg_s__mugetsu03_projectile_projectile[this])
    set udg_s__mugetsu03_projectile_projectile[this] = null
    set udg_s__mugetsu03_projectile_source[this] = null
    call DestroyGroup(udg_s__mugetsu03_projectile_toslow[this])
    call DestroyGroup(udg_s__mugetsu03_projectile_control[this])
    set udg_s__mugetsu03_projectile_toslow[this] = null
    set udg_s__mugetsu03_projectile_control[this] = null
    set udg_s__mugetsu03_projectile_todestroy[this] = false
    set udg_s__mugetsu03_projectile_multi[this] = false
    call s__mugetsu03_projectile_deallocate(this)
endfunction

function Mugetsu__Skill01_Clear takes nothing returns nothing
    call PauseTimer(udg_Mugetsu__skill01_timer)
    set udg_Mugetsu__skill01_counter = 0
    call UnitAddBonusDmg(udg_Mugetsu, -udg_Mugetsu__skill01_bonus)
    set udg_Mugetsu__skill01_bonus = 0
endfunction

function Mugetsu__Skill02_Clear takes nothing returns nothing
    call PauseTimer(udg_Mugetsu__skill02_timer)
    set udg_Mugetsu__skill02_counter = 0
    call UnitAddBonusAspd(udg_Mugetsu, -udg_Mugetsu__skill02_bonus)
    set udg_Mugetsu__skill02_bonus = 0
endfunction

function Mugetsu__Skill03_ResetUnitColor takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local unit v = LoadUnitHandle(udg_ht, GetHandleId(t), 0)
    call SetUnitVertexColor(v, 255, 255, 255, 255)
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, GetHandleId(t))
    set v = null
    set t = null
endfunction

function Mugetsu__Skill03_ChangeUnitColor takes unit v, real duration returns nothing
    local timer t = CreateTimer()
    local real time = DebuffDuration(v, duration)
    call SaveUnitHandle(udg_ht, GetHandleId(t), 0, v)
    call SetUnitVertexColor(v, 50, 50, 50, 255)
    call TimerStart(t, time, false, function Mugetsu__Skill03_ResetUnitColor)
    set t = null
endfunction

function Mugetsu__Skill03_Loop takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local real dx
    local real dy
    local real a
    local real multiplier = 1.0
    local unit v = null
    local integer m = LoadInteger(udg_ht, task, 0)
    if udg_s__mugetsu03_projectile_multi[m] then
        call SetUnitScale(udg_s__mugetsu03_projectile_projectile[m], RMinBJ(1.0 + udg_Mugetsu__MUGETSU04_MULTI_BASE + (GetUnitAbilityLevel(udg_s__mugetsu03_projectile_source[m], udg_Mugetsu__MUGETSU04) - 1) * udg_Mugetsu__MUGETSU04_MULTI_INC + 1, 2.0), RMinBJ(2.0, 1.0 + udg_Mugetsu__MUGETSU04_MULTI_BASE + (GetUnitAbilityLevel(udg_s__mugetsu03_projectile_source[m], udg_Mugetsu__MUGETSU04) - 1) * udg_Mugetsu__MUGETSU04_MULTI_INC + 1), RMinBJ(2.0, 1.0 + udg_Mugetsu__MUGETSU04_MULTI_BASE + (GetUnitAbilityLevel(udg_s__mugetsu03_projectile_source[m], udg_Mugetsu__MUGETSU04) - 1) * udg_Mugetsu__MUGETSU04_MULTI_INC + 1))
        set multiplier = multiplier * (1.0 + udg_Mugetsu__MUGETSU04_MULTI_BASE + (GetUnitAbilityLevel(udg_s__mugetsu03_projectile_source[m], udg_Mugetsu__MUGETSU04) - 1) * udg_Mugetsu__MUGETSU04_MULTI_INC)
    else
        call SetUnitScale(udg_s__mugetsu03_projectile_projectile[m], 1, 1, 1)
    endif
    if udg_s__mugetsu03_projectile_todestroy[m] then
        call s__mugetsu03_projectile_destroy(m)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    else
        set a = Atan2(udg_s__mugetsu03_projectile_ty[m] - udg_s__mugetsu03_projectile_cy[m], udg_s__mugetsu03_projectile_tx[m] - udg_s__mugetsu03_projectile_cx[m])
        set dx = udg_Mugetsu__MUGETSU03_SPEED * Cos(a) * 0.03125
        set dy = udg_Mugetsu__MUGETSU03_SPEED * Sin(a) * 0.03125
        set udg_s__mugetsu03_projectile_cx[m] = udg_s__mugetsu03_projectile_cx[m] + dx
        set udg_s__mugetsu03_projectile_cy[m] = udg_s__mugetsu03_projectile_cy[m] + dy
        if IsTerrainPathable(udg_s__mugetsu03_projectile_cx[m], udg_s__mugetsu03_projectile_cy[m], PATHING_TYPE_FLYABILITY) == false then
            call SetUnitX(udg_s__mugetsu03_projectile_projectile[m], udg_s__mugetsu03_projectile_cx[m])
            call SetUnitY(udg_s__mugetsu03_projectile_projectile[m], udg_s__mugetsu03_projectile_cy[m])
        else
            set udg_s__mugetsu03_projectile_todestroy[m] = true
        endif
        call GroupEnumUnitsInRange(udg_s__mugetsu03_projectile_toslow[m], udg_s__mugetsu03_projectile_cx[m], udg_s__mugetsu03_projectile_cy[m], RMinBJ(udg_Mugetsu__MUGETSU03_HITBOX_SIZE * multiplier, 300), null)
        loop
            set v = FirstOfGroup(udg_s__mugetsu03_projectile_toslow[m])
        exitwhen v == null
            call GroupRemoveUnit(udg_s__mugetsu03_projectile_toslow[m], v)
            if not IsUnitInGroup(v, udg_s__mugetsu03_projectile_control[m]) and IsUnitEnemy(v, udg_s__mugetsu03_projectile_p[m]) and GetUnitAbilityLevel(v, 'Avul') == 0 then
                call GroupAddUnit(udg_s__mugetsu03_projectile_control[m], v)
                if GetUnitAbilityLevel(v, udg_Mugetsu__MUGETSU03_STONE_SKILL) == 0 then
                    if IsUnitType(v, UNIT_TYPE_HERO) then
                        call UnitMagicDamageTarget(udg_s__mugetsu03_projectile_source[m], v, udg_s__mugetsu03_projectile_dmg[m], 5)
                    else
                        call UnitMagicDamageTarget(udg_s__mugetsu03_projectile_source[m], v, udg_s__mugetsu03_projectile_dmg[m] * 0.15, 5)
                    endif
                else
                    if IsUnitType(v, UNIT_TYPE_HERO) then
                        call UnitMagicDamageTarget(udg_s__mugetsu03_projectile_source[m], v, udg_s__mugetsu03_projectile_dmg[m], 5)
                    else
                        call UnitMagicDamageTarget(udg_s__mugetsu03_projectile_source[m], v, udg_s__mugetsu03_projectile_dmg[m] * 0.15, 5)
                    endif
                endif
                if GetUnitAbilityLevel(v, udg_Mugetsu__MUGETSU03_SLOW_SKILL) != 0 then
                    call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\ChimaeraLightningMissile\\ChimaeraLightningMissile.mdl", GetUnitX(v), GetUnitY(v)))
                    call UnitRemoveAbility(v, udg_Mugetsu__MUGETSU03_SLOW_SKILL)
                    call UnitRemoveAbility(v, udg_Mugetsu__MUGETSU03_SLOW_DEBUFF)
                    call UnitStunTarget(udg_Mugetsu, v, udg_Mugetsu__MUGETSU03_STONE_DURATION * ((multiplier - 1) * 0.07 + 1), 0, 0)
                    call UnitSlowTarget(udg_Mugetsu, v, udg_Mugetsu__MUGETSU03_STONE_DURATION * ((multiplier - 1) * 0.07 + 1), udg_Mugetsu__MUGETSU03_STONE_SKILL, 0)
                    call Mugetsu__Skill03_ChangeUnitColor(v, udg_Mugetsu__MUGETSU03_STONE_DURATION * ((multiplier - 1) * 0.07 + 1))
                else
                    if GetUnitAbilityLevel(v, udg_Mugetsu__MUGETSU03_STONE_SKILL) == 0 then
                        call UnitSlowTarget(udg_s__mugetsu03_projectile_source[m], v, udg_Mugetsu__MUGETSU03_SLOW_DURATION * ((multiplier - 1) * 0.04 + 1), udg_Mugetsu__MUGETSU03_SLOW_SKILL, udg_Mugetsu__MUGETSU03_SLOW_DEBUFF)
                    endif
                endif
            endif
        endloop
        if IsUnitInRangeXY(udg_s__mugetsu03_projectile_projectile[m], udg_s__mugetsu03_projectile_tx[m], udg_s__mugetsu03_projectile_ty[m], udg_Mugetsu__MUGETSU03_SPEED * 0.5) then
            set udg_s__mugetsu03_projectile_todestroy[m] = true
        endif
    endif
    set v = null
    set t = null
endfunction

function Mugetsu__Skill0304 takes nothing returns nothing
    local timer t2 = GetExpiredTimer()
    local timer t
    local real a
    local integer m
    local integer task = GetHandleId(t2)
    local integer cnt = LoadInteger(udg_ht, task, 1) - 1
    local integer lvl = LoadInteger(udg_ht, task, 2)
    local unit u = LoadUnitHandle(udg_ht, task, 3)
    local real multiplier = 1.0 + udg_Mugetsu__MUGETSU04_MULTI_BASE + (GetUnitAbilityLevel(u, udg_Mugetsu__MUGETSU04) - 1) * udg_Mugetsu__MUGETSU04_MULTI_INC
    local real ox = LoadReal(udg_ht, task, 4)
    local real oy = LoadReal(udg_ht, task, 5)
    call DebugMsg("Mugetsu0304_Loop")
    call SaveInteger(udg_ht, task, 1, cnt)
    set lvl = GetUnitAbilityLevel(u, udg_Mugetsu__MUGETSU03)
    set a = LoadReal(udg_ht, task, 6)
    set m = s__mugetsu03_projectile_create(u, udg_Mugetsu__MUGETSU03_DMG_BASE + (lvl - 1) * udg_Mugetsu__MUGETSU03_DMG_INC + udg_Mugetsu__MUGETSU03_DMG_SCALE * GetHeroInt(u, true), ox, oy, ox + (udg_Mugetsu__MUGETSU03_RANGE + udg_Mugetsu__MUGETSU03_SPEED * 0.5) * Cos(a), oy + (udg_Mugetsu__MUGETSU03_RANGE + udg_Mugetsu__MUGETSU03_SPEED * 0.5) * Sin(a), true)
    set t = CreateTimer()
    call SaveInteger(udg_ht, GetHandleId(t), 0, m)
    call TimerStart(t, 0.03125, true, function Mugetsu__Skill03_Loop)
    if cnt == 0 then
        call PauseTimer(t2)
        call ReleaseTimer(t2)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t2 = null
    set t = null
endfunction

function Mugetsu__Skill takes nothing returns boolean
    local unit u = GetTriggerUnit()
    local player p = GetOwningPlayer(u)
    local unit v = null
    local unit w = null
    local timer t = null
    local unit tar
    local integer id = GetSpellAbilityId()
    local integer lvl = GetUnitAbilityLevel(u, id)
    local real ox
    local real oy
    local real tx
    local real ty
    local real a
    local real dmg
    local boolean m04 = false
    local real multiplier = 1.0
    local integer m
    if id == udg_Mugetsu__MUGETSU04 then
        call AbilityCoolDownResetion(u, id, udg_Mugetsu__MUGETSU04_UCD_BASE - (lvl - 1) * udg_Mugetsu__MUGETSU04_UCD_DECREASE)
        set m04 = true
        set multiplier = multiplier * (1.0 + udg_Mugetsu__MUGETSU04_MULTI_BASE + (GetUnitAbilityLevel(u, udg_Mugetsu__MUGETSU04) - 1) * udg_Mugetsu__MUGETSU04_MULTI_INC)
        call VE_Spellcast(u)
    endif
    if m04 and udg_Mugetsu__MUGETSU04_LASTSPELL == udg_Mugetsu__MUGETSU04 then
        call AbilityCoolDownResetion(u, id, 0.1)
        call SetUnitState(u, UNIT_STATE_MANA, GetUnitState(u, UNIT_STATE_MANA) + 550)
    endif
    if (id == udg_Mugetsu__MUGETSU01 and (GetUnitAbilityLevel(u, 'A0V4') == 0 and GetUnitAbilityLevel(u, 'A0A1') == 0)) or (m04 and udg_Mugetsu__MUGETSU04_LASTSPELL == udg_Mugetsu__MUGETSU01) then
        set udg_Mugetsu__MUGETSU04_LASTSPELL = id
        set lvl = GetUnitAbilityLevel(u, udg_Mugetsu__MUGETSU01)
        if m04 == false then
            call AbilityCoolDownResetion(u, id, udg_Mugetsu__MUGETSU01_CD_BASE - (lvl - 1) * udg_Mugetsu__MUGETSU01_CD_DECREASE)
        endif
        set ox = GetUnitX(u)
        set oy = GetUnitY(u)
        set a = GetUnitFacing(u) * bj_DEGTORAD
        set tx = ox + udg_Mugetsu__MUGETSU01_RANGE * Cos(a)
        set ty = oy + udg_Mugetsu__MUGETSU01_RANGE * Sin(a)
        call Trig_BlinkPlaceRealer(tx, ty, udg_Mugetsu__MUGETSU01_RANGE, a)
        set tx = udg_SK_BlinkPlace_x
        set ty = udg_SK_BlinkPlace_y
        call SetUnitX(u, tx)
        call SetUnitY(u, ty)
        call DestroyEffect(AddSpecialEffect("mugetsu1.mdx", ox, oy))
        call DestroyEffect(AddSpecialEffect("mugetsu1.mdx", tx, ty))
        set dmg = (udg_Mugetsu__MUGETSU01_DMG_BASE + (lvl - 1) * udg_Mugetsu__MUGETSU01_DMG_INC + udg_Mugetsu__MUGETSU01_DMG_SCALE * GetHeroInt(u, true)) * multiplier
        call GroupEnumUnitsInRange(udg_Mugetsu__dmggroup, ox, oy, udg_Mugetsu__MUGETSU01_AOE, null)
        loop
            set v = FirstOfGroup(udg_Mugetsu__dmggroup)
        exitwhen v == null
            call GroupRemoveUnit(udg_Mugetsu__dmggroup, v)
            if not IsUnitInGroup(v, udg_Mugetsu__tmpgroup) and IsUnitEnemy(v, p) and not IsUnitType(v, UNIT_TYPE_STRUCTURE) then
                call GroupAddUnit(udg_Mugetsu__tmpgroup, v)
                call UnitMagicDamageTarget(u, v, dmg, 5)
                set tar = v
            endif
        endloop
        call GroupEnumUnitsInRange(udg_Mugetsu__dmggroup, tx, ty, udg_Mugetsu__MUGETSU01_AOE, null)
        loop
            set v = FirstOfGroup(udg_Mugetsu__dmggroup)
        exitwhen v == null
            call GroupRemoveUnit(udg_Mugetsu__dmggroup, v)
            if not IsUnitInGroup(v, udg_Mugetsu__tmpgroup) and IsUnitEnemy(v, p) and not IsUnitType(v, UNIT_TYPE_STRUCTURE) then
                call GroupAddUnit(udg_Mugetsu__tmpgroup, v)
                call UnitMagicDamageTarget(u, v, dmg, 5)
                set tar = v
            endif
        endloop
        call GroupClear(udg_Mugetsu__tmpgroup)
        if udg_Mugetsu__skill01_counter < 5 or m04 then
            set udg_Mugetsu__skill01_counter = udg_Mugetsu__skill01_counter + 1
            call UnitAddBonusDmg(udg_Mugetsu, -udg_Mugetsu__skill01_bonus)
            set udg_Mugetsu__skill01_bonus = R2I((udg_Mugetsu__MUGETSU01_BONUS_DMG_BASE + (lvl - 1) * udg_Mugetsu__MUGETSU01_BONUS_DMG_INC) * multiplier)
            call DebugMsg("ExtraAttack:" + I2S(udg_Mugetsu__skill01_bonus))
            call DebugMsg("OriginAttack:" + I2S(udg_Mugetsu__MUGETSU01_BONUS_DMG_BASE + (lvl - 1) * udg_Mugetsu__MUGETSU01_BONUS_DMG_INC))
            call DebugMsg("Multiplier:" + R2S(multiplier))
            call UnitAddBonusDmg(u, R2I((udg_Mugetsu__MUGETSU01_BONUS_DMG_BASE + (lvl - 1) * udg_Mugetsu__MUGETSU01_BONUS_DMG_INC) * multiplier))
            call TimerStart(udg_Mugetsu__skill01_timer, udg_Mugetsu__MUGETSU01_BONUS_DURATION * multiplier, false, function Mugetsu__Skill01_Clear)
        endif
        call DebugMsg("Time:" + R2S(udg_Mugetsu__MUGETSU01_BONUS_DURATION * multiplier))
    elseif (id == udg_Mugetsu__MUGETSU02 and (GetUnitAbilityLevel(u, 'A0V4') == 0 and GetUnitAbilityLevel(u, 'A0A1') == 0)) or (m04 and udg_Mugetsu__MUGETSU04_LASTSPELL == udg_Mugetsu__MUGETSU02) then
        set udg_Mugetsu__MUGETSU04_LASTSPELL = id
        set lvl = GetUnitAbilityLevel(u, udg_Mugetsu__MUGETSU02)
        if m04 == false then
            call AbilityCoolDownResetion(u, id, udg_Mugetsu__MUGETSU02_CD_BASE - (lvl - 1) * udg_Mugetsu__MUGETSU02_CD_DECREASE)
        endif
        set ox = GetUnitX(u)
        set oy = GetUnitY(u)
        set a = (GetUnitFacing(u) - 180.0) * bj_DEGTORAD
        if m04 == false then
            set tx = ox + udg_Mugetsu__MUGETSU01_RANGE * Cos(a)
            set ty = oy + udg_Mugetsu__MUGETSU01_RANGE * Sin(a)
            call Trig_BlinkPlaceRealer(tx, ty, udg_Mugetsu__MUGETSU02_RANGE, a)
        else
            call Trig_BlinkPlaceRealer(GetSpellTargetX(), GetSpellTargetY(), udg_Mugetsu__MUGETSU02_RANGE * multiplier, a)
        endif
        set tx = udg_SK_BlinkPlace_x
        set ty = udg_SK_BlinkPlace_y
        call SetUnitX(u, tx)
        call SetUnitY(u, ty)
        call DestroyEffect(AddSpecialEffect("mugetsu1.mdx", ox, oy))
        call DestroyEffect(AddSpecialEffect("mugetsu1.mdx", tx, ty))
        set dmg = (udg_Mugetsu__MUGETSU02_DMG_BASE + (lvl - 1) * udg_Mugetsu__MUGETSU02_DMG_INC + udg_Mugetsu__MUGETSU02_DMG_SCALE * GetHeroInt(u, true)) * multiplier
        call GroupEnumUnitsInRange(udg_Mugetsu__dmggroup, ox, oy, udg_Mugetsu__MUGETSU02_AOE, null)
        loop
            set v = FirstOfGroup(udg_Mugetsu__dmggroup)
        exitwhen v == null
            call GroupRemoveUnit(udg_Mugetsu__dmggroup, v)
            if not IsUnitInGroup(v, udg_Mugetsu__tmpgroup) and IsUnitEnemy(v, p) and not IsUnitType(v, UNIT_TYPE_STRUCTURE) then
                call GroupAddUnit(udg_Mugetsu__tmpgroup, v)
                call UnitMagicDamageTarget(u, v, dmg, 5)
                set tar = v
            endif
        endloop
        call GroupEnumUnitsInRange(udg_Mugetsu__dmggroup, tx, ty, udg_Mugetsu__MUGETSU02_AOE, null)
        loop
            set v = FirstOfGroup(udg_Mugetsu__dmggroup)
        exitwhen v == null
            call GroupRemoveUnit(udg_Mugetsu__dmggroup, v)
            if not IsUnitInGroup(v, udg_Mugetsu__tmpgroup) and IsUnitEnemy(v, p) and not IsUnitType(v, UNIT_TYPE_STRUCTURE) then
                call GroupAddUnit(udg_Mugetsu__tmpgroup, v)
                call UnitMagicDamageTarget(u, v, dmg, 5)
                set tar = v
            endif
        endloop
        call GroupClear(udg_Mugetsu__tmpgroup)
        if udg_Mugetsu__skill02_counter < 5 or m04 then
            set udg_Mugetsu__skill02_counter = udg_Mugetsu__skill02_counter + 1
            call UnitAddBonusAspd(udg_Mugetsu, -udg_Mugetsu__skill02_bonus)
            set udg_Mugetsu__skill02_bonus = R2I((udg_Mugetsu__MUGETSU02_BONUS_ASPD_BASE + (lvl - 1) * udg_Mugetsu__MUGETSU02_BONUS_ASPD_INC) * multiplier)
            call UnitAddBonusAspd(u, R2I((udg_Mugetsu__MUGETSU02_BONUS_ASPD_BASE + (lvl - 1) * udg_Mugetsu__MUGETSU02_BONUS_ASPD_INC) * multiplier))
            call DebugMsg("ExtraAttack:" + I2S(udg_Mugetsu__skill01_bonus))
            call TimerStart(udg_Mugetsu__skill02_timer, udg_Mugetsu__MUGETSU02_BONUS_DURATION * multiplier, false, function Mugetsu__Skill02_Clear)
        endif
        call DebugMsg("Time:" + R2S(udg_Mugetsu__MUGETSU02_BONUS_DURATION * multiplier))
    elseif id == udg_Mugetsu__MUGETSU03 or (m04 and udg_Mugetsu__MUGETSU04_LASTSPELL == udg_Mugetsu__MUGETSU03) then
        set lvl = GetUnitAbilityLevel(u, udg_Mugetsu__MUGETSU03)
        if m04 == false then
            call AbilityCoolDownResetion(u, id, udg_Mugetsu__MUGETSU03_CD_BASE - (lvl - 1) * udg_Mugetsu__MUGETSU03_CD_DECREASE)
        endif
        set tx = GetSpellTargetX()
        set ty = GetSpellTargetY()
        set ox = GetUnitX(u)
        set oy = GetUnitY(u)
        set a = Atan2(ty - oy, tx - ox)
        if m04 then
            set t = CreateTimer()
            call DebugMsg("Mugetsu0304Start")
            call SaveInteger(udg_ht, GetHandleId(t), 1, GetUnitAbilityLevel(u, udg_Mugetsu__MUGETSU04))
            call SaveInteger(udg_ht, GetHandleId(t), 2, lvl)
            call SaveUnitHandle(udg_ht, GetHandleId(t), 3, u)
            call SaveReal(udg_ht, GetHandleId(t), 4, ox)
            call SaveReal(udg_ht, GetHandleId(t), 5, oy)
            call SaveReal(udg_ht, GetHandleId(t), 6, a)
            call TimerStart(t, 0.2, true, function Mugetsu__Skill0304)
        endif
        set udg_Mugetsu__MUGETSU04_LASTSPELL = id
        call SetUnitFacing(u, a)
        set m = s__mugetsu03_projectile_create(u, udg_Mugetsu__MUGETSU03_DMG_BASE + (lvl - 1) * udg_Mugetsu__MUGETSU03_DMG_INC + udg_Mugetsu__MUGETSU03_DMG_SCALE * GetHeroInt(u, true), GetUnitX(u), GetUnitY(u), GetUnitX(u) + (udg_Mugetsu__MUGETSU03_RANGE + udg_Mugetsu__MUGETSU03_SPEED * 0.5) * Cos(a), GetUnitY(u) + (udg_Mugetsu__MUGETSU03_RANGE + udg_Mugetsu__MUGETSU03_SPEED * 0.5) * Sin(a), m04)
        set t = CreateTimer()
        call SaveInteger(udg_ht, GetHandleId(t), 0, m)
        call TimerStart(t, 0.03125, true, function Mugetsu__Skill03_Loop)
    endif
    set t = null
    set u = null
    set v = null
    set w = null
    set p = null
    return false
endfunction

function Mugetsu__Skill04_Add takes nothing returns nothing
    call UnitAddBonusDmg(udg_Mugetsu, udg_Mugetsu__MUGETSU04_BONUS_DMG)
    call UnitAddBonusInt(udg_Mugetsu, udg_Mugetsu__MUGETSU04_BONUS_INT)
endfunction

function Mugetsu__Skill04 takes nothing returns boolean
    local integer id = GetLearnedSkill()
    local integer lvl = GetLearnedSkillLevel()
    if id == udg_Mugetsu__MUGETSU04 then
        call UnitAddBonusDmg(udg_Mugetsu, udg_Mugetsu__MUGETSU04_BONUS_DMG)
        call UnitAddBonusInt(udg_Mugetsu, udg_Mugetsu__MUGETSU04_BONUS_INT)
        call TimerStart(udg_Mugetsu__skill04_timer, udg_Mugetsu__MUGETSU04_CD_BASE - (lvl - 1) * udg_Mugetsu__MUGETSU04_CD_DECREASE, true, function Mugetsu__Skill04_Add)
    endif
    return false
endfunction

function Mugetsu__DmgDisplay takes nothing returns boolean
    local integer lvl = GetUnitAbilityLevel(udg_Mugetsu, udg_Mugetsu__MUGETSU01)
    if lvl > 0 then
        call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "|c00ffff00Dream Sign 'Dream Above' damage: |r" + R2S(udg_Mugetsu__MUGETSU01_DMG_BASE + (lvl - 1) * udg_Mugetsu__MUGETSU01_DMG_INC + udg_Mugetsu__MUGETSU01_DMG_SCALE * GetHeroInt(udg_Mugetsu, true)))
    endif
    return false
endfunction

function Mugetsu_Init takes nothing returns nothing
    local trigger t = CreateTrigger()
    local timer tim = CreateTimer()
    set udg_Mugetsu__skill01_timer = CreateTimer()
    set udg_Mugetsu__skill02_timer = CreateTimer()
    set udg_Mugetsu__skill04_timer = CreateTimer()
    set udg_Mugetsu__dmggroup = CreateGroup()
    set udg_Mugetsu__tmpgroup = CreateGroup()
    call SaveUnitHandle(udg_ht, GetHandleId(tim), 1, udg_Mugetsu)
    call SaveInteger(udg_ht, GetHandleId(tim), 2, 0)
    call SaveReal(udg_ht, GetHandleId(tim), 3, 0)
    call TimerStart(tim, 0.1, true, function Mugetsu__MugetsuEX_Loop)
    set tim = null
    set udg_SK_MugetsuEX = true
    set udg_SK_MugetsuEXP = GetOwningPlayer(udg_Mugetsu)
    call TriggerAddCondition(t, Condition(function Mugetsu__Skill))
    call TriggerRegisterUnitEvent(t, udg_Mugetsu, EVENT_UNIT_SPELL_EFFECT)
    set t = CreateTrigger()
    call TriggerAddCondition(t, Condition(function Mugetsu__Skill04))
    call TriggerRegisterUnitEvent(t, udg_Mugetsu, EVENT_UNIT_HERO_SKILL)
    set t = CreateTrigger()
    call TriggerAddCondition(t, Condition(function Mugetsu__DmgDisplay))
    call TriggerRegisterPlayerEvent(t, GetOwningPlayer(udg_Mugetsu), EVENT_PLAYER_END_CINEMATIC)
    call SetHeroLifeIncreaseValue(udg_Mugetsu, 32)
    call SetHeroManaIncreaseValue(udg_Mugetsu, 1)
    set t = null
endfunction

function Trig_Initial_Mugetsu_Actions takes nothing returns nothing
    set udg_Mugetsu = GetCharacterHandle(udg_MUGETSU_CODE)
    call FirstAbilityInit('A188')
    call FirstAbilityInit('A0YP')
    call FirstAbilityInit('A0V4')
    call Mugetsu_Init()
endfunction

function InitTrig_Initial_Mugetsu takes nothing returns nothing
    set gg_trg_Initial_Mugetsu = CreateTrigger()
    call TriggerAddAction(gg_trg_Initial_Mugetsu, function Trig_Initial_Mugetsu_Actions)
endfunction