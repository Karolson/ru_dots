function Trig_Utsuho04_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A07B'
endfunction

function Trig_Utsuho04_Explosion takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local integer level = LoadInteger(udg_ht, task, 0)
    local integer i = LoadInteger(udg_ht, task, 1)
    local player p = LoadPlayerHandle(udg_ht, task, 3)
    local real x = LoadReal(udg_ht, task, 0)
    local real y = LoadReal(udg_ht, task, 1)
    local unit u
    local real damageA = (250 + level * 150 + 0.2 * GetUnitState(caster, UNIT_STATE_MAX_LIFE)) * i / 126
    local real damageB = (250 + level * 150 + 5.0 * GetHeroInt(caster, true)) * i / 126
    set damageA = damageB
    call UnRegisterAreaShow(caster, 'A07B')
    call DebugMsg("Damage:" + R2S(damageA))
    call GroupEnumUnitsInRange(udg_SK_Utsuho04_Group, x, y, 750, null)
    loop
        set u = FirstOfGroup(udg_SK_Utsuho04_Group)
    exitwhen u == null
        call GroupRemoveUnit(udg_SK_Utsuho04_Group, u)
        if IsUnitEnemy(u, p) and IsUnitAlive(u) and IsUnitType(u, UNIT_TYPE_STRUCTURE) == false then
            call UnitMagicDamageTarget(caster, u, damageA, 5)
        endif
    endloop
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    set t = null
    set caster = null
    set p = null
endfunction

function Trig_Utsuho04_SunFallen takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local real i = LoadReal(udg_ht, task, 0)
    local real k = LoadReal(udg_ht, task, 1)
    local real r
    local real a
    local real b
    local real c
    local real d
    if i > 0 then
        set i = i - 80.0
        set r = i / k * 0.5 + 0.5
        set a = 20 * r
        set b = 19 * r
        set c = 18 * r
        set d = 17 * r
        call SetUnitFlyHeight(udg_SK_Utsuho04_Sun[0], i, 0)
        call SetUnitScale(udg_SK_Utsuho04_Sun[0], a, a, a)
        call SaveReal(udg_ht, task, 0, i)
    else
        call RemoveUnit(udg_SK_Utsuho04_Sun[0])
        call RemoveUnit(udg_SK_Utsuho04_Sun[4])
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
endfunction

function Trig_Utsuho04_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local timer t2
    local integer task2
    local player p = LoadPlayerHandle(udg_ht, task, 3)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local real x = LoadReal(udg_ht, task, 0)
    local real y = LoadReal(udg_ht, task, 1)
    local integer level = LoadInteger(udg_ht, task, 0)
    local integer i = LoadInteger(udg_ht, task, 1)
    local unit u
    local unit v
    local real px
    local real py
    local real a
    local real sunheight
    local real gravpower
    local real gravmindist
    if i < 126 and GetUnitCurrentOrder(caster) == OrderId("cyclone") then
        call SaveInteger(udg_ht, task, 1, i + 1)
        if i < 48 then
            set sunheight = i * 1.25
            call SetUnitFlyHeight(udg_SK_Utsuho04_Sun[0], sunheight, 0)
        endif
        set gravpower = (110 + level * 30) * i * 0.0008
        set gravmindist = 80.0 + gravpower
        call GroupEnumUnitsInRange(udg_SK_Utsuho04_Group, x, y, 750, null)
        loop
            set v = FirstOfGroup(udg_SK_Utsuho04_Group)
        exitwhen v == null
            call GroupRemoveUnit(udg_SK_Utsuho04_Group, v)
            if GetWidgetLife(v) > 0.405 and IsUnitEnemy(v, p) then
                if not IsUnitInRangeXY(v, x, y, gravmindist) and not IsUnitType(v, UNIT_TYPE_MECHANICAL) and GetUnitDefaultMoveSpeed(v) > 0 and not (GetCustomState(v, 7) != 0) then
                    set a = Atan2(GetUnitY(v) - y, GetUnitX(v) - x)
                    set px = GetUnitX(v) - gravpower * Cos(a)
                    set py = GetUnitY(v) - gravpower * Sin(a)
                    if not IsTerrainPathable(px, py, PATHING_TYPE_WALKABILITY) then
                        call SetUnitX(v, px)
                        call SetUnitY(v, py)
                    endif
                endif
            endif
        endloop
    else
        call DestroyEffect(LoadEffectHandle(udg_ht, task, 1))
        call DestroyEffect(LoadEffectHandle(udg_ht, task, 2))
        set u = CreateUnit(GetOwningPlayer(caster), 'n01H', x, y, 0)
        call UnitApplyTimedLife(u, 'BTLF', 15.0)
        call SetUnitTimeScale(u, 3.0)
        call SetUnitVertexColor(u, 255, 255, 255, R2I(255 * i / 126))
        set u = CreateUnit(GetOwningPlayer(caster), 'n01I', x, y, 0)
        call UnitApplyTimedLife(u, 'BTLF', 15.0)
        call SetUnitTimeScale(u, 0.2)
        call SetUnitVertexColor(u, 255, 255, 255, R2I(255 * i / 126))
        call SaveInteger(udg_ht, task, 1, i)
        call PauseTimer(t)
        call TimerStart(t, 0.27, false, function Trig_Utsuho04_Explosion)
        set t2 = CreateTimer()
        set task2 = GetHandleId(t2)
        set a = i * 6.25
        if a <= 300 then
            call SaveReal(udg_ht, task2, 0, a)
            call SaveReal(udg_ht, task2, 1, a)
        else
            call SaveReal(udg_ht, task2, 0, 300.0)
            call SaveReal(udg_ht, task2, 1, 300.0)
        endif
        call TimerStart(t2, 0.05, true, function Trig_Utsuho04_SunFallen)
    endif
    set t = null
    set t2 = null
    set caster = null
    set p = null
    set u = null
    set v = null
endfunction

function Trig_Utsuho04_Actions takes nothing returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A07B')
    local real x = GetSpellTargetX()
    local real y = GetSpellTargetY()
    local unit u
    local effect e1 = AddSpecialEffect("AuraNuke.mdl", x, y)
    local effect e2 = AddSpecialEffect("SelfbuffFX.mdx", x, y)
    call AbilityCoolDownResetion(caster, 'A07B', 150 * Trig_UtsuhoCD(caster))
    call VE_Spellcast(caster)
    call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|cFFFFCC00================|r")
    call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|cFFFFCC00    CAUTION!    |r")
    call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|cFFFFCC00================|r")
    call PingMinimapEx(x, y, 6.0, 255, 255, 238, true)
    set udg_SK_Utsuho04_Sun[0] = CreateUnit(GetOwningPlayer(caster), 'h01L', x, y, 0)
    call SetUnitScale(udg_SK_Utsuho04_Sun[0], 20, 20, 20)
    set udg_SK_Utsuho04_Sun[4] = CreateUnit(GetOwningPlayer(caster), 'h01M', x, y, 0)
    call RegisterAreaShowXY(caster, 'A07B', x, y, 750, 6, 0, "Abilities\\Weapons\\SerpentWardMissile\\SerpentWardMissile.mdl", 0.02)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveEffectHandle(udg_ht, task, 1, e1)
    call SaveEffectHandle(udg_ht, task, 2, e2)
    call SavePlayerHandle(udg_ht, task, 3, GetOwningPlayer(caster))
    call SaveInteger(udg_ht, task, 0, level)
    call SaveInteger(udg_ht, task, 1, 0)
    call SaveInteger(udg_ht, task, 2, 8)
    call SaveReal(udg_ht, task, 0, x)
    call SaveReal(udg_ht, task, 1, y)
    call TimerStart(t, 0.05, true, function Trig_Utsuho04_Main)
    set t = null
    set caster = null
    set u = null
    set e1 = null
    set e2 = null
endfunction

function InitTrig_Utsuho04 takes nothing returns nothing
endfunction