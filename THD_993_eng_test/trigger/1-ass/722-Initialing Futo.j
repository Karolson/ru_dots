function s__FutoEx_create takes unit caster returns integer
    local integer aID = GetSpellAbilityId()
    set udg_Futo___FutoEx_Flag = not udg_Futo___FutoEx_Flag
    if udg_Futo___FutoEx_Flag then
        call DebugMsg("Yin")
        if GetUnitTypeId(udg_s__FutoEx_FutoExEffectUnit) != 'n058' then
            call IssueImmediateOrder(udg_s__FutoEx_FutoExEffectUnit, "robogoblin")
            call SetUnitFlyHeight(udg_s__FutoEx_FutoExEffectUnit, -50, 100)
        endif
    else
        call DebugMsg("Yang")
        if GetUnitTypeId(udg_s__FutoEx_FutoExEffectUnit) != 'n05C' then
            call IssueImmediateOrder(udg_s__FutoEx_FutoExEffectUnit, "unrobogoblin")
            call SetUnitFlyHeight(udg_s__FutoEx_FutoExEffectUnit, 70, 100)
        endif
    endif
    return 0
endfunction

function s__FutoEx_InitEffect takes unit caster returns nothing
    local timer t
    set udg_s__FutoEx_FutoExEffectUnit = CreateUnit(GetOwningPlayer(caster), 'n058', GetUnitX(caster), GetUnitY(caster), 0)
    set t = CreateTimer()
    call TimerStart(t, 0.01, true, function sc__FutoEx_follwLoop)
endfunction

function s__FutoEx_follwLoop takes nothing returns nothing
    call SetUnitX(udg_s__FutoEx_FutoExEffectUnit, GetUnitX(udg_Futo))
    call SetUnitY(udg_s__FutoEx_FutoExEffectUnit, GetUnitY(udg_Futo))
endfunction

function s__Futo01_create takes unit caster, real x, real y, real damage returns integer
    local integer this = s__Futo01__allocate()
    local timer t = CreateTimer()
    local timer t2 = CreateTimer()
    local unit u
    local group g
    local unit v
    local real vx
    local real vy
    local real vxx
    local real vyy
    local location loc
    local unit dummy
    set udg_s__Futo01_caster[this] = caster
    set udg_s__Futo01_dx[this] = x
    set udg_s__Futo01_dy[this] = y
    set udg_s__Futo01_damage[this] = damage
    set udg_s__Futo01_timercount[this] = 0
    set udg_s__Futo01_alvl[this] = GetUnitAbilityLevel(caster, udg_Futo___Futo01_ID)
    set udg_s__Futo01_radius[this] = udg_Futo___Futo01_RANGE / Sin(45 / bj_RADTODEG)
    set udg_s__Futo01_face[this] = Atan2(y - GetUnitY(caster), x - GetUnitX(caster))
    set udg_s__Futo01_damagedG[this] = CreateGroup()
    set udg_s__Futo01_pushG[this] = CreateGroup()
    set udg_s__Futo01_yinyang[this] = udg_Futo___FutoEx_Flag
    set loc = Location(udg_s__Futo01_dx[this], udg_s__Futo01_dy[this])
    set g = YDWEGetUnitsInRangeOfLocMatchingNull(udg_s__Futo01_radius[this] * 1.0, loc, null)
    call RemoveLocation(loc)
    set loc = null
    set dummy = NewDummy(GetOwningPlayer(caster), x, y, 0.0)
    call UnitAddAbility(dummy, udg_Futo___Futo01_PUSH)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        set vx = GetUnitX(v)
        set vy = GetUnitY(v)
        set vxx = (vx - udg_s__Futo01_dx[this]) * Cos(6.18 - udg_s__Futo01_face[this]) - (vy - udg_s__Futo01_dy[this]) * Sin(6.18 - udg_s__Futo01_face[this])
        set vyy = (vx - udg_s__Futo01_dx[this]) * Sin(6.18 - udg_s__Futo01_face[this]) + (vy - udg_s__Futo01_dy[this]) * Cos(6.18 - udg_s__Futo01_face[this])
        if vxx > -udg_Futo___Futo01_RANGE and vxx < udg_Futo___Futo01_RANGE and vyy > -udg_Futo___Futo01_RANGE and vyy < udg_Futo___Futo01_RANGE then
            if IsUnitEnemy(v, GetOwningPlayer(udg_s__Futo01_caster[this])) and GetWidgetLife(v) > 0.405 and GetUnitDefaultMoveSpeed(v) > 0 and not IsUnitType(v, UNIT_TYPE_MECHANICAL) and not (GetCustomState(v, 7) != 0) then
                call GroupAddUnit(udg_s__Futo01_pushG[this], v)
                call IssueTargetOrder(dummy, udg_Futo___Futo01_PUSH_ORDER, v)
            endif
        endif
    endloop
    call DestroyGroup(g)
    call UnitRemoveAbility(dummy, udg_Futo___Futo01_PUSH)
    call ReleaseDummy(dummy)
    set dummy = null
    call SaveInteger(udg_ht, GetHandleId(t), 0, this)
    call TimerStart(t, udg_Futo___Futo01_RATE, true, function sc__Futo01_timerMainFunc)
    call SaveInteger(udg_ht, GetHandleId(t2), 0, this)
    call TimerStart(t2, udg_Futo___Futo01_RATE, true, function sc__Futo01_timerPushFunc)
    set g = null
    set t = null
    set t2 = null
    set u = null
    return this
endfunction

function s__Futo01_timerPushFunc takes nothing returns nothing
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
endfunction

function s__Futo01_timerMainFunc takes nothing returns nothing
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
endfunction

function s__Futo01_onDestroy takes integer this returns nothing
    set udg_s__Futo01_caster[this] = null
    call DestroyGroup(udg_s__Futo01_damagedG[this])
    call DestroyGroup(udg_s__Futo01_pushG[this])
    set udg_s__Futo01_damagedG[this] = null
endfunction

function s__Futo01_deallocate takes integer this returns nothing
    if this == null then
        return
    elseif udg_si__Futo01_V[this] != -1 then
        return
    endif
    call s__Futo01_onDestroy(this)
    set udg_si__Futo01_V[this] = udg_si__Futo01_F
    set udg_si__Futo01_F = this
endfunction

function s__Futo02_create takes unit caster returns integer
    local integer this = s__Futo02__allocate()
    local timer t = CreateTimer()
    set udg_s__Futo02_spelloruseitemTrg[this] = null
    set udg_s__Futo02_caster[this] = caster
    set udg_s__Futo02_alvl[this] = GetUnitAbilityLevel(caster, udg_Futo___Futo02_ID)
    set udg_s__Futo02_yinyang[this] = udg_Futo___FutoEx_Flag
    call RegisterAreaShow(caster, udg_Futo___Futo02_ID, udg_Futo___Futo02_RANGE, 5, 0, "Abilities\\Spells\\Undead\\AbsorbMana\\AbsorbManaBirthMissile.mdl", 0.02)
    set udg_s__Futo02_damageOnce[this] = (udg_Futo___Futo02_DAMAGE_BASE + udg_s__Futo02_alvl[this] * udg_Futo___Futo02_DAMAGE_SCALC + udg_Futo___Futo02_DAMAGE_INT * GetHeroInt(caster, true)) / udg_Futo___Futo02_DAMAGE_RATE
    set udg_s__Futo02_counterDamage[this] = udg_Futo___Futo02_COUNTER_DAMAGE_BASE + udg_s__Futo02_alvl[this] * udg_Futo___Futo02_COUNTER_DAMAGE_SCALC + udg_Futo___Futo02_COUNTER_DAMAGE_INT * GetHeroInt(caster, true)
    set udg_s__Futo02_cando[this] = true
    if udg_s__Futo02_yinyang[this] then
        call UnitAddAbility(udg_s__Futo02_caster[this], udg_Futo___Futo02_WEAKEN_DAMAGE_BOOK_ID)
        call SetUnitAbilityLevel(udg_s__Futo02_caster[this], udg_Futo___Futo02_WEAKEN_DAMAGE_ID, udg_s__Futo02_alvl[this])
        call SaveInteger(udg_ht, GetHandleId(t), 0, this)
        call TimerStart(t, udg_Futo___Futo02_DAMAGE_RATE, true, function sc__Futo02_dotLoop)
    else
        set udg_Futo___Futo02_Now = this
        if udg_s__Futo02_spelloruseitemTrg[this] != null then
            call DestroyTrigger(udg_s__Futo02_spelloruseitemTrg[this])
            set udg_s__Futo02_spelloruseitemTrg[this] = null
        endif
        set udg_s__Futo02_spelloruseitemTrg[this] = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(udg_s__Futo02_spelloruseitemTrg[this], EVENT_PLAYER_UNIT_SPELL_CAST)
        call TriggerRegisterAnyUnitEventBJ(udg_s__Futo02_spelloruseitemTrg[this], EVENT_PLAYER_UNIT_USE_ITEM)
        call TriggerAddCondition(udg_s__Futo02_spelloruseitemTrg[this], Condition(function sc__Futo02_trg_spelloruseitem_func))
        call SaveInteger(udg_ht, GetHandleId(t), 0, this)
        call TimerStart(t, udg_Futo___Futo02_DURATION, false, function sc__Futo02_clearTrg)
    endif
    set t = null
    return this
endfunction

function s__Futo02_dotLoop takes nothing returns nothing
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
endfunction

function s__Futo02_trg_spelloruseitem_func takes nothing returns boolean
    local unit tu = GetTriggerUnit()
    local integer this = udg_Futo___Futo02_Now
    local timer t
    if udg_s__Futo02_cando[this] == false then
        return false
    endif
    if GetWidgetLife(udg_s__Futo02_caster[this]) < 0.405 then
        call UnRegisterAreaShow(udg_s__Futo02_caster[this], udg_Futo___Futo02_ID)
        call DestroyTrigger(GetTriggeringTrigger())
    endif
    if not IsUnitInRange(tu, udg_s__Futo02_caster[this], udg_Futo___Futo02_RANGE) or IsUnitAlly(tu, GetOwningPlayer(udg_s__Futo02_caster[this])) or not IsUnitType(tu, UNIT_TYPE_HERO) or GetCustomState(tu, 7) != 0 then
        return false
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
    return false
endfunction

function s__Futo02_resetCando takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer this = LoadInteger(udg_ht, GetHandleId(t), 0)
    call RemoveSavedInteger(udg_ht, GetHandleId(t), 0)
    set udg_s__Futo02_cando[this] = true
    set t = null
endfunction

function s__Futo02_clearTrg takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer this = LoadInteger(udg_ht, GetHandleId(t), 0)
    call RemoveSavedInteger(udg_ht, GetHandleId(t), 0)
    call UnRegisterAreaShow(udg_s__Futo02_caster[this], udg_Futo___Futo02_ID)
    call DestroyTrigger(udg_s__Futo02_spelloruseitemTrg[this])
    set udg_s__Futo02_spelloruseitemTrg[this] = null
    call sc__Futo02_deallocate(this)
endfunction

function s__Futo02_onDestroy takes integer this returns nothing
    set udg_s__Futo02_caster[this] = null
    if udg_s__Futo02_spelloruseitemTrg[this] != null then
        call DestroyTrigger(udg_s__Futo02_spelloruseitemTrg[this])
        set udg_s__Futo02_spelloruseitemTrg[this] = null
    endif
endfunction

function s__Futo02_deallocate takes integer this returns nothing
    if this == null then
        return
    elseif udg_si__Futo02_V[this] != -1 then
        return
    endif
    call s__Futo02_onDestroy(this)
    set udg_si__Futo02_V[this] = udg_si__Futo02_F
    set udg_si__Futo02_F = this
endfunction

function s__Futo03_create takes unit caster, real x, real y returns integer
    local integer this
    local timer t
    local real ox
    local real oy
    local real px
    local real py
    local real dx
    local real dy
    local real a
    local real d
    if GetSpellAbilityId() == udg_Futo___Futo03_ID then
        call DebugMsg("Futo03 skill start")
        set this = s__Futo03__allocate()
        call SaveInteger(udg_ht, GetHandleId(caster), GetHandleId(caster) + udg_Futo___Futo03_HASHTABLE_OFFSET, this)
        set x = GetUnitX(caster)
        set y = GetUnitY(caster)
        set udg_s__Futo03_flyupTimercount[this] = 0
        set udg_s__Futo03_moveTimercount[this] = 0
        set udg_s__Futo03_setLoc[this] = false
        set udg_s__Futo03_caster[this] = caster
        set udg_s__Futo03_yinyang[this] = udg_Futo___FutoEx_Flag
        set udg_s__Futo03_alvl[this] = GetUnitAbilityLevel(caster, udg_Futo___Futo03_ID)
        set udg_s__Futo03_des[this] = Location(x, y)
        set udg_s__Futo03_src[this] = Location(x, y)
        set udg_s__Futo03_ship[this] = CreateUnit(GetOwningPlayer(caster), udg_Futo___Futo03_SHIP_ID, x, y, 0)
        if udg_s__Futo03_yinyang[this] == false then
            set udg_s__Futo03_byship[this] = CreateGroup()
            set udg_s__Futo03_protectValue[this] = udg_Futo___Futo03_PROTECT_BASE + udg_Futo___Futo03_PROTECT_SCALC * udg_s__Futo03_alvl[this] + GetHeroInt(udg_s__Futo03_caster[this], true) * udg_Futo___Futo03_PROTECT_INT
            call DebugMsg("Futo03 Info: Protect Life " + R2S(udg_s__Futo03_protectValue[this]))
        endif
        call RegisterAreaShow(udg_s__Futo03_ship[this], udg_Futo___Futo03_ID, udg_Futo___Futo03_RANGE, 5, 0, "Abilities\\Weapons\\SeaElementalMissile\\SeaElementalMissile.mdl", 0.02)
        set t = CreateTimer()
        call SaveInteger(udg_ht, GetHandleId(t), 0, this)
        call TimerStart(t, 0.1, true, function sc__Futo03_flyup)
        call SetPlayerAbilityAvailable(GetOwningPlayer(caster), udg_Futo___Futo03_ID, false)
        call UnitAddAbility(caster, udg_Futo___Futo03_SETLOC_ID)
    else
        if HaveSavedInteger(udg_ht, GetHandleId(caster), GetHandleId(caster) + udg_Futo___Futo03_HASHTABLE_OFFSET) == false then
            call SetPlayerAbilityAvailable(GetOwningPlayer(caster), udg_Futo___Futo03_ID, true)
            call UnitRemoveAbility(caster, udg_Futo___Futo03_SETLOC_ID)
            return 0
        endif
        set this = LoadInteger(udg_ht, GetHandleId(caster), GetHandleId(caster) + udg_Futo___Futo03_HASHTABLE_OFFSET)
        call RemoveSavedInteger(udg_ht, GetHandleId(udg_s__Futo03_caster[this]), GetHandleId(udg_s__Futo03_caster[this]) + udg_Futo___Futo03_HASHTABLE_OFFSET)
        call DebugMsg("Futo03 skill Set location")
        set ox = GetUnitX(caster)
        set oy = GetUnitY(caster)
        set dx = x - ox
        set dy = y - oy
        set a = Atan2(dy, dx)
        set d = SquareRoot(dx * dx + dy * dy)
        set px = ox + d * Cos(a)
        set py = oy + d * Sin(a)
        call Trig_BlinkPlaceRealer(px, py, d, a)
        set x = udg_SK_BlinkPlace_x
        set y = udg_SK_BlinkPlace_y
        call RemoveLocation(udg_s__Futo03_des[this])
        set udg_s__Futo03_des[this] = Location(x, y)
        call SetUnitFacing(udg_s__Futo03_ship[this], AngleBetweenPoints(udg_s__Futo03_src[this], udg_s__Futo03_des[this]))
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Human\\Blizzard\\BlizzardTarget.mdl", x, y))
        set udg_s__Futo03_setLoc[this] = true
    endif
    return this
endfunction

function s__Futo03_protectHero takes integer this returns nothing
    local group g = CreateGroup()
    local unit v
    local timer t
    local location loc = GetUnitLoc(udg_s__Futo03_ship[this])
    set g = YDWEGetUnitsInRangeOfLocMatchingNull(udg_Futo___Futo03_RANGE * 1.0, loc, null)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if IsUnitAlly(v, GetOwningPlayer(udg_s__Futo03_caster[this])) and IsUnitType(v, UNIT_TYPE_HERO) and not IsUnitInGroup(v, udg_s__Futo03_byship[this]) then
            set t = CreateTimer()
            call SaveUnitHandle(udg_ht, GetHandleId(t), 0, v)
            call UnitAddAbility(v, 'A0UG')
            call UnitAddAbility(v, 'B09S')
            call TimerStart(t, udg_Futo___Futo03_PROTECT_DURATION, false, function sc__Futo03_ClearProtect)
            call SaveReal(udg_ht, StringHash("Futo03_Protect"), GetHandleId(v), udg_s__Futo03_protectValue[this])
            call SaveTimerHandle(udg_ht, StringHash("Futo03_Protect_Timer"), GetHandleId(v), t)
            call GroupAddUnit(udg_s__Futo03_byship[this], v)
            call DebugMsg("Protect udg_Hero")
        endif
    endloop
    call DestroyGroup(g)
    call RemoveLocation(loc)
    set loc = null
    set g = null
    set v = null
endfunction

function s__Futo03_ClearProtect takes nothing returns nothing
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
endfunction

function s__Futo03_flyup takes nothing returns nothing
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
endfunction

function s__Futo03_move takes nothing returns nothing
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
endfunction

function s__Futo03_onDestroy takes integer this returns nothing
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
endfunction

function s__Futo03_deallocate takes integer this returns nothing
    if this == null then
        return
    elseif udg_si__Futo03_V[this] != -1 then
        return
    endif
    call s__Futo03_onDestroy(this)
    set udg_si__Futo03_V[this] = udg_si__Futo03_F
    set udg_si__Futo03_F = this
endfunction

function s__Futo04_create takes unit caster, real x, real y returns integer
    local integer this
    local timer t
    local real maxslow
    local real minslow
    local real distance
    if GetSpellAbilityId() == udg_Futo___Futo04_ID then
        call DebugMsg("Futo04 skill start")
        set this = s__Futo04__allocate()
        call SaveInteger(udg_ht, GetHandleId(caster), GetHandleId(caster) + udg_Futo___Futo04_HASHTABLE_OFFSET, this)
        set udg_s__Futo04_end[this] = false
        set udg_s__Futo04_readyTimercount[this] = 0
        set udg_s__Futo04_caster[this] = caster
        set udg_s__Futo04_txt[this] = CreateTextTag()
        if not IsUnitAlly(udg_s__Futo04_caster[this], GetLocalPlayer()) then
            call SetTextTagVisibility(udg_s__Futo04_txt[this], false)
        endif
        set t = CreateTimer()
        call SaveInteger(udg_ht, GetHandleId(t), 0, this)
        call TimerStart(t, 0.1, true, function sc__Futo04_ready)
        call SetPlayerAbilityAvailable(GetOwningPlayer(caster), udg_Futo___Futo04_ID, false)
        if GetUnitAbilityLevel(caster, udg_Futo___Futo04_CAST_ID) < 1 then
            call UnitAddAbility(caster, udg_Futo___Futo04_CAST_ID)
        else
            call SetPlayerAbilityAvailable(GetOwningPlayer(caster), udg_Futo___Futo04_CAST_ID, true)
        endif
    else
        call SetPlayerAbilityAvailable(GetOwningPlayer(caster), udg_Futo___Futo04_ID, true)
        call SetPlayerAbilityAvailable(GetOwningPlayer(caster), udg_Futo___Futo04_CAST_ID, false)
        if HaveSavedInteger(udg_ht, GetHandleId(caster), GetHandleId(caster) + udg_Futo___Futo04_HASHTABLE_OFFSET) == false then
            return this
        endif
        call DebugMsg("Futo04 skill acction")
        set this = LoadInteger(udg_ht, GetHandleId(caster), GetHandleId(caster) + udg_Futo___Futo04_HASHTABLE_OFFSET)
        call RemoveSavedInteger(udg_ht, GetHandleId(caster), GetHandleId(caster) + udg_Futo___Futo04_HASHTABLE_OFFSET)
        set udg_s__Futo04_end[this] = true
        if udg_s__Futo04_txt[this] != null then
            call DestroyTextTag(udg_s__Futo04_txt[this])
            set udg_s__Futo04_txt[this] = null
        endif
        set udg_s__Futo04_caster[this] = caster
        set udg_s__Futo04_alvl[this] = GetUnitAbilityLevel(caster, udg_Futo___Futo04_ID)
        set udg_s__Futo04_radian[this] = Atan2(y - GetUnitY(caster), x - GetUnitX(caster))
        set udg_s__Futo04_effectU[this] = CreateUnit(GetOwningPlayer(caster), udg_Futo___Futo04_EFFECT_UNIT_ID, GetUnitX(caster), GetUnitY(caster), bj_RADTODEG * udg_s__Futo04_radian[this])
        set udg_s__Futo04_dx[this] = x
        set udg_s__Futo04_dy[this] = y
        set udg_s__Futo04_yinyang[this] = udg_Futo___FutoEx_Flag
        set udg_s__Futo04_damage[this] = udg_Futo___Futo04_DAMAGE_BASE + udg_Futo___Futo04_DAMAGE_SCALC * udg_s__Futo04_alvl[this] + GetHeroInt(caster, true) * udg_Futo___Futo04_DAMAGE_INT
        set udg_s__Futo04_damage[this] = udg_s__Futo04_damage[this] + udg_s__Futo04_damage[this] * RMinBJ(udg_s__Futo04_readyTimercount[this], udg_Futo___Futo04_VALID_MAX_DURATION) * udg_Futo___Futo04_DAMAGE_DURATION_ADD
        if udg_s__Futo04_yinyang[this] then
            set maxslow = udg_Futo___Futo04_SLOW_MAX_BASE + udg_Futo___Futo04_SLOW_MAX_SCALC * udg_s__Futo04_alvl[this]
            set minslow = udg_Futo___Futo04_SLOW_MIN_BASE + udg_Futo___Futo04_SLOW_MIN_SCALC * udg_s__Futo04_alvl[this]
            set udg_s__Futo04_slowpercent[this] = R2I((maxslow - minslow) * RMinBJ(udg_s__Futo04_readyTimercount[this], udg_Futo___Futo04_VALID_MAX_DURATION) / udg_Futo___Futo04_VALID_MAX_DURATION + minslow) / 5 * 5
            call DebugMsg("Futo04 Info: slow percent is " + I2S(udg_s__Futo04_slowpercent[this]))
        else
            set udg_s__Futo04_damageadd[this] = udg_Futo___Futo04_DAMAGE_ADD_BASE + udg_Futo___Futo04_DAMAGE_ADD_SCALC * udg_s__Futo04_alvl[this]
            set udg_s__Futo04_damageadd[this] = udg_s__Futo04_damageadd[this] + udg_s__Futo04_damageadd[this] * RMinBJ(udg_s__Futo04_readyTimercount[this], udg_Futo___Futo04_VALID_MAX_DURATION) * udg_Futo___Futo04_DAMAGE_DURATION_ADD
        endif
        call DebugMsg("Futo04 Info: read time=" + R2S(udg_s__Futo04_readyTimercount[this]))
        call DebugMsg("Futo04 Info: damage=" + R2S(udg_s__Futo04_damage[this]) + ",damageadd=" + R2S(udg_s__Futo04_damageadd[this]))
        set udg_s__Futo04_speed[this] = udg_Futo___Futo04_SPEED + udg_Futo___Futo04_SPEED * (RMinBJ(udg_s__Futo04_readyTimercount[this], udg_Futo___Futo04_VALID_MAX_DURATION) / udg_Futo___Futo04_VALID_MAX_DURATION)
        set t = CreateTimer()
        set distance = DistanceBetweenPoints(Location(x, y), GetUnitLoc(caster))
        if distance > 700 then
            set udg_s__Futo04_damage[this] = udg_s__Futo04_damage[this] * 0.5
            set udg_s__Futo04_damageadd[this] = udg_s__Futo04_damageadd[this] * 0.5
        endif
        set udg_s__Futo04_movetimes[this] = R2I(distance / udg_s__Futo04_speed[this])
        call SaveInteger(udg_ht, GetHandleId(t), 0, this)
        call TimerStart(t, 0.01, true, function sc__Futo04_cast)
    endif
    set t = null
    return this
endfunction

function s__Futo04_ready takes nothing returns nothing
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
endfunction

function s__Futo04_cast takes nothing returns nothing
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
endfunction

function s__Futo04_SlowTarget takes integer this, unit target, integer slowAbiliLvl returns nothing
    local integer slowAbiliId
    call DebugMsg("Slow slowAbiliLvl is" + I2S(slowAbiliLvl + 1))
    if slowAbiliLvl == 0 then
        set slowAbiliId = 'A1DM'
    elseif slowAbiliLvl == 1 then
        set slowAbiliId = 'A1DN'
    elseif slowAbiliLvl == 2 then
        set slowAbiliId = 'A1DO'
    elseif slowAbiliLvl == 3 then
        set slowAbiliId = 'A1DP'
    elseif slowAbiliLvl == 4 then
        set slowAbiliId = 'A1DQ'
    elseif slowAbiliLvl == 5 then
        set slowAbiliId = 'A1DR'
    elseif slowAbiliLvl == 6 then
        set slowAbiliId = 'A1DS'
    elseif slowAbiliLvl == 7 then
        set slowAbiliId = 'A1DT'
    else
        set slowAbiliId = 'A1DU'
    endif
    call UnitSlowTarget(udg_s__Futo04_caster[this], target, 2, slowAbiliId, 'B06I')
endfunction

function s__Futo04_onDestroy takes integer this returns nothing
    if udg_s__Futo04_effectU[this] != null then
        call KillUnit(udg_s__Futo04_effectU[this])
        set udg_s__Futo04_effectU[this] = null
    endif
    if udg_s__Futo04_txt[this] != null then
        call DestroyTextTag(udg_s__Futo04_txt[this])
        set udg_s__Futo04_txt[this] = null
    endif
endfunction

function s__Futo04_deallocate takes integer this returns nothing
    if this == null then
        return
    elseif udg_si__Futo04_V[this] != -1 then
        return
    endif
    call s__Futo04_onDestroy(this)
    set udg_si__Futo04_V[this] = udg_si__Futo04_F
    set udg_si__Futo04_F = this
endfunction

function s__Futo05_create takes unit caster returns integer
    local timer t
    if udg_s__Futo05_trg_attack == null then
        set udg_s__Futo05_trg_attack = CreateTrigger()
        call TriggerAddCondition(udg_s__Futo05_trg_attack, Condition(function sc__Futo05_trg_attack_func))
        call RegisterAnyUnitDamage(udg_s__Futo05_trg_attack)
    endif
    if GetUnitAbilityLevel(caster, udg_Futo___Futo05_FLAG_ID) == 0 and GetUnitAbilityLevel(caster, udg_Futo___Futo05_ID) == 1 then
        call UnitAddAbility(caster, udg_Futo___Futo05_FLAG_ID)
        set t = CreateTimer()
        call SaveUnitHandle(udg_ht, GetHandleId(t), 0, caster)
        call SaveUnitHandle(udg_ht, GetHandleId(t), 1, CreateUnit(GetOwningPlayer(caster), 'n05D', GetUnitX(caster), GetUnitY(caster), 0.0))
        call SaveUnitHandle(udg_ht, GetHandleId(t), 2, CreateUnit(GetOwningPlayer(caster), 'n05D', GetUnitX(caster), GetUnitY(caster), 90.0))
        call SaveUnitHandle(udg_ht, GetHandleId(t), 3, CreateUnit(GetOwningPlayer(caster), 'n05D', GetUnitX(caster), GetUnitY(caster), 180.0))
        call SaveUnitHandle(udg_ht, GetHandleId(t), 4, CreateUnit(GetOwningPlayer(caster), 'n05D', GetUnitX(caster), GetUnitY(caster), 270.0))
        call TimerStart(t, 0.01, true, function sc__Futo05_EffectLoop)
    endif
    set t = null
    return 0
endfunction

function s__Futo05_EffectLoop takes nothing returns nothing
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
endfunction

function s__Futo05_trg_attack_func takes nothing returns boolean
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
        return false
    elseif IsUnitIllusion(s) then
        set s = null
        set d = null
        return false
    elseif IsUnitAlly(d, GetOwningPlayer(s)) then
        set s = null
        set d = null
        return false
    elseif GetEventDamage() == 0 then
        set s = null
        set d = null
        return false
    elseif IsDamageNotUnitAttack(s) then
        set s = null
        set d = null
        return false
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
    return false
endfunction

function s__Futo05_AddFlag takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local unit caster = LoadUnitHandle(udg_ht, GetHandleId(t), 0)
    call RemoveSavedHandle(udg_ht, GetHandleId(t), 0)
    call UnitAddAbility(caster, udg_Futo___Futo05_FLAG_ID)
endfunction

function s__Futo05_onDestroy takes integer this returns nothing
endfunction

function s__Futo05_deallocate takes integer this returns nothing
    if this == null then
        return
    elseif udg_si__Futo05_V[this] != -1 then
        return
    endif
    call s__Futo05_onDestroy(this)
    set udg_si__Futo05_V[this] = udg_si__Futo05_F
    set udg_si__Futo05_F = this
endfunction

function Futo___Skill takes nothing returns boolean
    local unit caster = GetTriggerUnit()
    local integer id = GetSpellAbilityId()
    local integer lvl = GetUnitAbilityLevel(caster, id)
    local location loc = GetSpellTargetLoc()
    local real x = GetLocationX(loc)
    local real y = GetLocationY(loc)
    local real damage
    call DebugMsg("skill open")
    if id == udg_Futo___FutoEx_ID then
        call s__FutoEx_create(caster)
        call DebugMsg("Ex skill open")
    elseif id == udg_Futo___Futo01_ID then
        call AbilityCoolDownResetion(caster, id, udg_Futo___Futo01_CD_BASE - (lvl - 1) * udg_Futo___Futo01_CD_DECREASE)
        set damage = udg_Futo___Futo01_DAMAGE_BASE + udg_Futo___Futo01_DAMAGE_SCALC * GetUnitAbilityLevel(caster, udg_Futo___Futo01_ID) + udg_Futo___Futo01_DAMAGE_INT * GetHeroInt(caster, true)
        call s__Futo01_create(caster, x, y, damage)
        call DebugMsg("01 skill open")
    elseif id == udg_Futo___Futo02_ID then
        call AbilityCoolDownResetion(caster, id, udg_Futo___Futo02_CD_BASE - (lvl - 1) * udg_Futo___Futo02_CD_DECREASE)
        call s__Futo02_create(caster)
        call DebugMsg("02 skill open")
    elseif id == udg_Futo___Futo03_ID or id == udg_Futo___Futo03_SETLOC_ID then
        call AbilityCoolDownResetion(caster, id, udg_Futo___Futo03_CD_BASE - (lvl - 1) * udg_Futo___Futo03_CD_DECREASE)
        call s__Futo03_create(caster, x, y)
        call DebugMsg("03 skill open")
    elseif id == udg_Futo___Futo04_ID or id == udg_Futo___Futo04_CAST_ID then
        call s__Futo04_create(caster, x, y)
    endif
    call RemoveLocation(loc)
    set caster = null
    set loc = null
    return false
endfunction

function Futo___Learn takes nothing returns boolean
    local unit caster = GetTriggerUnit()
    call DebugMsg("Learn Skill")
    if GetLearnedSkill() == udg_Futo___Futo05_ID then
        call DebugMsg("05 skill learned")
        call s__Futo05_create(caster)
    endif
    return false
endfunction

function Futo_Init takes nothing returns nothing
    local trigger SkillTrg = CreateTrigger()
    local trigger learnTrg = CreateTrigger()
    call DebugMsg("Register Trigger!")
    call TriggerAddCondition(SkillTrg, Condition(function Futo___Skill))
    call TriggerRegisterUnitEvent(SkillTrg, udg_Futo, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(learnTrg, Condition(function Futo___Learn))
    call TriggerRegisterUnitEvent(learnTrg, udg_Futo, EVENT_UNIT_HERO_SKILL)
    call SetHeroLifeIncreaseValue(udg_Futo, 53)
    call SetHeroManaIncreaseValue(udg_Futo, 5)
    call SetHeroManaBaseRegenValue(udg_Futo, 0.4)
    call s__FutoEx_InitEffect(udg_Futo)
    call SetPlayerAbilityAvailable(GetOwningPlayer(udg_Futo), udg_Futo___Futo05_FLAG_ID, false)
    call SetPlayerAbilityAvailable(GetOwningPlayer(udg_Futo), udg_Futo___Futo02_WEAKEN_DAMAGE_BOOK_ID, false)
    set SkillTrg = null
    set learnTrg = null
endfunction

function Trig_Initialing_Futo_Actions takes nothing returns nothing
    set udg_Futo = GetCharacterHandle(udg_Futo_CODE)
    call FirstAbilityInit('A0UG')
    call FirstAbilityInit('A1DM')
    call FirstAbilityInit('A1DN')
    call FirstAbilityInit('A1DO')
    call FirstAbilityInit('A1DP')
    call FirstAbilityInit('A1DQ')
    call FirstAbilityInit('A1DR')
    call FirstAbilityInit('A1DS')
    call FirstAbilityInit('A1DT')
    call FirstAbilityInit('A1DU')
    call Futo_Init()
endfunction

function InitTrig_Initialing_Futo takes nothing returns nothing
    set gg_trg_Initialing_Futo = CreateTrigger()
    call TriggerAddAction(gg_trg_Initialing_Futo, function Trig_Initialing_Futo_Actions)
endfunction