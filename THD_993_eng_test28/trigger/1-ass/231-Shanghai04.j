function Trig_Shanghai04_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0HO'
endfunction

function Trig_Shanghai04_Hit takes nothing returns nothing
    local location target
    local integer task
    local unit v = GetEnteringUnit()
    local unit u
    if GetTriggerEventId() == EVENT_UNIT_ISSUED_POINT_ORDER then
        set task = GetHandleId(GetTriggerUnit())
        set u = LoadUnitHandle(udg_sht, task, 0)
        set target = LoadLocationHandle(udg_sht, task, 1)
        if IsUnitInRange(u, GetTriggerUnit(), 1200.0) then
            call MoveLocation(target, GetOrderPointX(), GetOrderPointY())
        endif
        call IssueImmediateOrder(GetTriggerUnit(), "stop")
    elseif GetTriggerEventId() == EVENT_UNIT_ISSUED_TARGET_ORDER then
        set task = GetHandleId(GetTriggerUnit())
        set u = LoadUnitHandle(udg_sht, task, 0)
        set target = LoadLocationHandle(udg_sht, task, 1)
        if IsUnitInRange(u, GetTriggerUnit(), 1200.0) then
            set v = GetOrderTargetUnit()
            call MoveLocation(target, GetUnitX(v), GetUnitY(v))
        endif
        call IssueImmediateOrder(GetTriggerUnit(), "stop")
    elseif GetWidgetLife(v) > 0.405 then
        set task = GetHandleId(GetTriggeringTrigger())
        set u = LoadUnitHandle(udg_ht, task, 1)
        call SetUnitX(u, GetUnitX(v) - 5.0)
        call SetUnitY(u, GetUnitY(v))
        call UnitStunTarget(u, v, 1.0, 0, 0)
        call UnitPhysicalDamageTarget(u, v, GetUnitAbilityLevel(u, 'A0HP') * 5 + 15 + GetHeroStr(GetCharacterHandle('H01A'), true) * 0.25)
    endif
    set target = null
    set u = null
    set v = null
endfunction

function Trig_Shanghai04_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit u = LoadUnitHandle(udg_ht, task, 1)
    local unit h = LoadUnitHandle(udg_sht, GetHandleId(caster), 0)
    local location target = LoadLocationHandle(udg_sht, GetHandleId(caster), 1)
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real tx = GetLocationX(target)
    local real ty = GetLocationY(target)
    local real dx = tx - ox
    local real dy = ty - oy
    local real px
    local real py
    local real a = LoadReal(udg_ht, task, 0)
    local real e
    local real s = 3.0
    local integer i = LoadInteger(udg_ht, task, 1)
    local integer n = LoadInteger(udg_ht, task, 2)
    local trigger trg
    local triggeraction tga
    if i > 0 and IsUnitType(caster, UNIT_TYPE_DEAD) == false then
        call SetUnitLifePercentBJ(u, 100.0)
        call SaveInteger(udg_ht, task, 1, i - 1)
        if SquareRoot(dy * dy + dx * dx) <= 150.0 then
            set tx = ox + 3000.0 * CosBJ(a)
            set ty = oy + 3000.0 * SinBJ(a)
            call MoveLocation(target, tx, ty)
        endif
        if not IsUnitInRange(h, caster, 1100.0) then
            set tx = GetUnitX(h)
            set ty = GetUnitY(h)
            set e = bj_RADTODEG * Atan2(oy - ty, ox - tx)
            if YawError(a, e) <= 0.0 then
                set e = e + 144.0
            else
                set e = e - 144.0
            endif
            set tx = tx + 1200.0 * CosBJ(e)
            set ty = ty + 1200.0 * SinBJ(e)
            call MoveLocation(target, tx, ty)
            set s = 4.0
            if not IsUnitInRange(h, caster, 2400.0) then
                call SaveInteger(udg_ht, task, 1, 0)
            endif
        else
            set s = 3.0
        endif
        set e = YawError(a, bj_RADTODEG * Atan2(ty - oy, tx - ox))
        if e >= 0.0 then
            set e = RMinBJ(e, s)
        else
            set e = RMaxBJ(e, -s)
        endif
        set a = a + e
        if a < 0.0 then
            set a = a + 360.0
        elseif a >= 360.0 then
            set a = a - 360.0
        endif
        call SaveReal(udg_ht, task, 0, a)
        call IssueImmediateOrder(caster, "stop")
        call SetUnitAnimation(caster, "spell channel")
        call SetUnitFacing(caster, a)
        set px = ox + 16.0 * CosBJ(a)
        set py = oy + 16.0 * SinBJ(a)
        if IsTerrainPathable(px, py, PATHING_TYPE_FLYABILITY) == false then
            call SetUnitX(caster, px)
            call SetUnitY(caster, py)
            call SetUnitX(u, px)
            call SetUnitY(u, py)
        endif
        set i = 2
        loop
        exitwhen i > n
            set h = udg_SK_ShanghaiJSA[13 - i]
            set u = udg_SK_ShanghaiJSA[12 - i]
            set tx = GetUnitX(h)
            set ty = GetUnitY(h)
            set ox = GetUnitX(u)
            set oy = GetUnitY(u)
            set dx = tx - ox
            set dy = ty - oy
            set a = Atan2(dy, dx)
            set e = RMinBJ(30.0, SquareRoot(dy * dy + dx * dx) / 5.0)
            set px = ox + e * Cos(a)
            set py = oy + e * Sin(a)
            call SetUnitFacing(u, bj_RADTODEG * a)
            call SetUnitX(u, px)
            call SetUnitY(u, py)
            set i = i + 1
        endloop
    else
        call RemoveUnit(u)
        call DestroyEffect(LoadEffectHandle(udg_ht, task, 2))
        set trg = LoadTriggerHandle(udg_ht, task, 3)
        set tga = LoadTriggerActionHandle(udg_ht, task, 4)
        call FlushChildHashtable(udg_ht, GetHandleId(trg))
        call TriggerRemoveAction(trg, tga)
        call DestroyTrigger(trg)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
        call RemoveLocation(target)
        set i = 1
        loop
        exitwhen i > n
            set u = udg_SK_ShanghaiJSA[12 - i]
            set udg_SK_ShanghaiJSA[12 - i] = null
            if u != caster then
                call PauseUnit(u, false)
                call DestroyEffect(LoadEffectHandle(udg_sht, GetHandleId(u), 1))
            endif
            call UnitRemoveAbility(u, 'A0HR')
            call SetUnitAnimation(u, "stand")
            call IssueImmediateOrder(u, "stop")
            call SetUnitPathing(u, true)
            call SetUnitInvulnerable(u, false)
            call SetUnitFlag(u, 5, false)
            set i = i + 1
        endloop
        call EnableTrigger(gg_trg_Shanghai04)
    endif
    set t = null
    set caster = null
    set target = null
    set u = null
    set h = null
    set trg = null
    set tga = null
endfunction

function Trig_Shanghai04_Shanghai takes nothing returns boolean
    if GetUnitTypeId(GetFilterUnit()) != 'h01C' then
        return false
    endif
    if IsUnitIllusion(GetFilterUnit()) then
        return false
    endif
    return not IsUnitDead(GetFilterUnit())
endfunction

function Trig_Shanghai04_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit h = LoadUnitHandle(udg_sht, GetHandleId(caster), 0)
    local real mana = GetUnitState(h, UNIT_STATE_MANA)
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real tx = GetSpellTargetX()
    local real ty = GetSpellTargetY()
    local real a = bj_RADTODEG * Atan2(ty - oy, tx - ox)
    local location target = GetSpellTargetLoc()
    local integer level = GetUnitAbilityLevel(caster, 'A0HQ')
    local timer t = CreateTimer()
    local integer task
    local unit u
    local effect e
    local group g = CreateGroup()
    local boolexpr f = Filter(function Trig_Shanghai04_Shanghai)
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    local trigger trg = CreateTrigger()
    local triggeraction tga
    local integer n
    local integer i
    call DisableTrigger(gg_trg_Shanghai04)
    set n = 1
    set udg_SK_ShanghaiJSA[12 - n] = caster
    call TriggerRegisterUnitEvent(trg, caster, EVENT_UNIT_ISSUED_POINT_ORDER)
    call TriggerRegisterUnitEvent(trg, caster, EVENT_UNIT_ISSUED_TARGET_ORDER)
    call GroupEnumUnitsInRange(g, GetUnitX(h), GetUnitY(h), 1200.0, f)
    call GroupRemoveUnit(g, caster)
    loop
        set u = FirstOfGroup(g)
    exitwhen u == null
        call GroupRemoveUnit(g, u)
        if GetUnitAbilityLevel(u, 'A0HW') == 0 then
            set n = n + 1
            set udg_SK_ShanghaiJSA[12 - n] = u
        endif
    exitwhen n >= 12
    endloop
    call DestroyBoolExpr(f)
    call DestroyGroup(g)
    if n >= 6 then
        if GetUnitAbilityLevel(h, 'A0HU') == 0 then
            call UnitAddAbility(h, 'A0HU')
        endif
        call IssueImmediateOrder(h, "starfall")
        set tga = TriggerAddAction(trg, function Trig_Shanghai04_Hit)
        set u = CreateUnit(GetOwningPlayer(caster), 'o000', ox, oy, 0.0)
        call UnitAddAbility(u, 'A0HP')
        call SetUnitAbilityLevel(u, 'A0HP', level)
        call DebugMsg("level:" + I2S(level))
        set task = GetHandleId(trg)
        call SaveUnitHandle(udg_ht, task, 0, caster)
        call SaveUnitHandle(udg_ht, task, 1, u)
        set task = GetHandleId(t)
        set e = AddSpecialEffectTarget("Abilities\\Spells\\Orc\\Shockwave\\ShockwaveMissile.mdl", caster, "origin")
        call SaveUnitHandle(udg_ht, task, 0, caster)
        call SaveUnitHandle(udg_ht, task, 1, u)
        call SaveEffectHandle(udg_ht, task, 2, e)
        call SaveTriggerHandle(udg_ht, task, 3, trg)
        call SaveTriggerActionHandle(udg_ht, task, 4, tga)
        call SaveInteger(udg_ht, task, 0, level)
        call SaveInteger(udg_ht, task, 1, 600)
        call SaveInteger(udg_ht, task, 2, n)
        call SaveReal(udg_ht, task, 0, a)
        call TimerStart(t, 0.02, true, function Trig_Shanghai04_Main)
        call SaveLocationHandle(udg_sht, GetHandleId(caster), 1, target)
        call SetUnitFacing(caster, a)
        call UnitAddAbility(caster, 'A0HR')
        call UnitMakeAbilityPermanent(caster, true, 'A0HR')
        call SetUnitPathing(caster, false)
        call SetUnitFlag(caster, 5, true)
        call SetUnitInvulnerable(caster, true)
        call TriggerRegisterUnitInRange(trg, caster, 90.0, iff)
        set i = 2
        loop
        exitwhen i > n
            set u = udg_SK_ShanghaiJSA[12 - i]
            call UnitAddAbility(u, 'A0HR')
            call UnitMakeAbilityPermanent(u, true, 'A0HR')
            call SetUnitPathing(u, false)
            call SetUnitFlag(u, 5, true)
            call SetUnitInvulnerable(u, true)
            call TriggerRegisterUnitInRange(trg, u, 90.0, iff)
            call PauseUnit(u, true)
            set e = AddSpecialEffectTarget("Abilities\\Spells\\Orc\\Shockwave\\ShockwaveMissile.mdl", u, "origin")
            call SaveEffectHandle(udg_sht, GetHandleId(u), 1, e)
            call SetUnitAnimation(u, "spell channel")
            set i = i + 1
        endloop
    else
        call DisplayTextToPlayer(GetOwningPlayer(caster), 0.0, 0.0, "|cffff1100The current number of Shanghai dolls is not enough to launch 'Doll of War'!|r")
        call ReleaseTimer(t)
        call DestroyTrigger(trg)
        call RemoveLocation(target)
        call EnableTrigger(gg_trg_Shanghai04)
    endif
    set caster = null
    set target = null
    set h = null
    set t = null
    set u = null
    set e = null
    set f = null
    set g = null
    set iff = null
    set trg = null
    set tga = null
endfunction

function InitTrig_Shanghai04 takes nothing returns nothing
endfunction