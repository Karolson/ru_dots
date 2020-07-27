function Komachi04_Soul_Cnt takes nothing returns integer
    return 8
endfunction

function Calc_Komachi_Soul_Trans takes unit caster, unit target returns real
    local real lifeper1 = GetUnitState(caster, UNIT_STATE_LIFE) / GetUnitState(caster, UNIT_STATE_MAX_LIFE)
    local real lifeper2 = GetUnitState(target, UNIT_STATE_LIFE) / GetUnitState(target, UNIT_STATE_MAX_LIFE)
    local real lifeper = lifeper1 - lifeper2
    set lifeper = lifeper / 8
    return lifeper
endfunction

function Komachi_Soul_Trans_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit u = LoadUnitHandle(udg_ht, task, 2)
    local unit target = LoadUnitHandle(udg_ht, task, 3)
    local integer level = LoadInteger(udg_ht, task, 1)
    local real ox = GetUnitX(u)
    local real oy = GetUnitY(u)
    local real tx = GetUnitX(target)
    local real ty = GetUnitY(target)
    local real dis = SquareRoot((ty - oy) * (ty - oy) + (tx - ox) * (tx - ox))
    local real anglea = bj_RADTODEG * Atan2(ty - oy, tx - ox)
    local real angle = LoadReal(udg_ht, task, 6)
    local real v = LoadReal(udg_ht, task, 4)
    local real a = LoadReal(udg_ht, task, 5) + 0.0004
    local real ax = v * CosBJ(angle)
    local real ay = v * SinBJ(angle)
    local real angledelta = LoadReal(udg_ht, task, 9)
    local real delta = LoadReal(udg_ht, task, 8)
    local real finlife
    local integer cnt = LoadInteger(udg_ht, task, 7) - 1
    call SaveInteger(udg_ht, task, 7, cnt)
    call SaveReal(udg_ht, task, 5, a)
    if cnt < 0 then
        set a = a * 2
    endif
    if cnt < 0 then
        if cnt < -50 then
            call SetUnitX(u, tx - (dis - 18) * CosBJ(anglea))
            call SetUnitY(u, ty - (dis - 18) * SinBJ(anglea))
        else
            if anglea < 0 then
                set anglea = anglea + 360
            endif
            set ax = ax + a * CosBJ(anglea)
            set ay = ay + a * SinBJ(anglea)
            set angle = bj_RADTODEG * Atan2(ay, ax)
            if angle < 0 then
                set angle = angle + 360
            endif
            set v = SquareRoot(ax * ax + ay * ay)
            call SaveReal(udg_ht, task, 4, v)
            call SaveReal(udg_ht, task, 6, angle)
            if IsTerrainPathable(ox + v * CosBJ(angle), oy + v * SinBJ(angle), PATHING_TYPE_FLYABILITY) == false then
                call SetUnitX(u, ox + v * CosBJ(angle))
                call SetUnitY(u, oy + v * SinBJ(angle))
            endif
        endif
    else
        set delta = delta / RAbsBJ(delta)
        set delta = delta * RAbsBJ(Calc_Komachi_Soul_Trans(caster, target))
        if IsTerrainPathable(GetUnitX(caster) - (150 - cnt) * 1.3 * CosBJ(cnt * 1.4 + angledelta), GetUnitY(caster) - (150 - cnt) * 1.3 * SinBJ(cnt * 1.4 + angledelta), PATHING_TYPE_FLYABILITY) == false then
            call SetUnitX(u, GetUnitX(caster) - (150 - cnt) * 1.3 * CosBJ(cnt * 1.4 + angledelta))
            call SetUnitY(u, GetUnitY(caster) - (150 - cnt) * 1.3 * SinBJ(cnt * 1.4 + angledelta))
        endif
        set u = null
        set t = null
        set caster = null
        set target = null
        return
    endif
    if GetWidgetLife(target) >= 0.405 == false or GetWidgetLife(caster) >= 0.405 == false or GetWidgetLife(u) >= 0.405 == false or u == null or dis >= 3600 then
        call DebugMsg("End")
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    elseif dis < 80 then
        set finlife = GetUnitState(target, UNIT_STATE_MAX_LIFE)
        call CE_Input(caster, target, delta * finlife)
        set finlife = (GetUnitState(target, UNIT_STATE_LIFE) / finlife + delta) * finlife
        if finlife <= 0 then
            if GetUnitAbilityLevel(target, 'A1EC') == 0 then
                call SetUnitInvulnerable(target, false)
                call UnitRemoveBuffs(target, true, true)
                call InstantKill(caster, target)
            else
                call SetUnitLifeBJ(target, 1.0)
            endif
        else
            call SetUnitState(target, UNIT_STATE_LIFE, finlife)
        endif
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set u = null
    set t = null
    set caster = null
    set target = null
endfunction

function Komachi_Soul_Trans takes unit caster, unit eu, unit target, real deltalife, real angledelta returns nothing
    local timer t
    local integer task
    local unit u
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real tx = GetUnitX(target)
    local real ty = GetUnitY(target)
    local real a = GetRandomInt(0, 360)
    set t = CreateTimer()
    set task = GetHandleId(t)
    set u = eu
    call SetUnitPathing(u, false)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveInteger(udg_ht, task, 1, GetRandomInt(1, 12))
    call SaveUnitHandle(udg_ht, task, 2, u)
    call SaveUnitHandle(udg_ht, task, 3, target)
    call SaveReal(udg_ht, task, 4, 15)
    call SaveReal(udg_ht, task, 5, 0.55)
    call SaveReal(udg_ht, task, 6, GetRandomInt(0, 360))
    call SaveInteger(udg_ht, task, 7, 150)
    call SaveReal(udg_ht, task, 8, deltalife)
    call SaveReal(udg_ht, task, 9, angledelta)
    call UnitAddMaxLife(u, R2I(RAbsBJ(GetUnitState(target, UNIT_STATE_MAX_LIFE) * deltalife)))
    call TimerStart(t, 0.02, true, function Komachi_Soul_Trans_Main)
endfunction

function Komachi_Soul_Follow_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit u = LoadUnitHandle(udg_ht, task, 2)
    local unit target = LoadUnitHandle(udg_ht, task, 3)
    local integer level = LoadInteger(udg_ht, task, 1)
    local real ox = GetUnitX(u)
    local real oy = GetUnitY(u)
    local real tx = GetUnitX(target)
    local real ty = GetUnitY(target)
    local real dis = SquareRoot((ty - oy) * (ty - oy) + (tx - ox) * (tx - ox))
    local real anglea = bj_RADTODEG * Atan2(ty - oy, tx - ox)
    local real angle = LoadReal(udg_ht, task, 6)
    local real v = LoadReal(udg_ht, task, 4) - 0.064
    local real a = LoadReal(udg_ht, task, 5) + 0.001
    local real ax = v * CosBJ(angle)
    local real ay = v * SinBJ(angle)
    local integer cnt = LoadInteger(udg_ht, task, 7) - 1
    local integer countdown = LoadInteger(udg_ht, task, 8) - 1
    call SaveInteger(udg_ht, task, 8, countdown)
    call SaveReal(udg_ht, task, 5, a)
    if cnt < 0 then
        set a = a * 2
    endif
    if anglea < 0 then
        set anglea = anglea + 360
    endif
    set ax = ax + a * CosBJ(anglea)
    set ay = ay + a * SinBJ(anglea)
    set angle = bj_RADTODEG * Atan2(ay, ax)
    if angle < 0 then
        set angle = angle + 360
    endif
    set v = SquareRoot(ax * ax + ay * ay)
    call SaveReal(udg_ht, task, 4, v)
    call SaveReal(udg_ht, task, 6, angle)
    if IsTerrainPathable(ox + v * CosBJ(angle), oy + v * SinBJ(angle), PATHING_TYPE_FLYABILITY) == false then
        call SetUnitX(u, ox + v * CosBJ(angle))
        call SetUnitY(u, oy + v * SinBJ(angle))
    endif
    if countdown <= 0 then
        call KillUnit(u)
        call RemoveUnit(u)
    endif
    if GetWidgetLife(target) >= 0.405 == false or GetWidgetLife(u) >= 0.405 == false or dis >= 3600 then
        call DebugMsg("End")
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set u = null
    set t = null
    set caster = null
    set target = null
endfunction

function Komachi_Soul_Follow takes unit caster, unit target returns nothing
    local timer t
    local integer task
    local unit u
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real tx = GetUnitX(target)
    local real ty = GetUnitY(target)
    local real a = GetRandomInt(0, 360)
    set t = CreateTimer()
    set task = GetHandleId(t)
    set u = caster
    call SetUnitPathing(u, false)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveInteger(udg_ht, task, 1, GetRandomInt(1, 12))
    call SaveUnitHandle(udg_ht, task, 2, u)
    call SaveUnitHandle(udg_ht, task, 3, target)
    call SaveReal(udg_ht, task, 4, 15)
    call SaveReal(udg_ht, task, 5, 0.7)
    call SaveReal(udg_ht, task, 6, GetRandomInt(0, 360))
    call SaveInteger(udg_ht, task, 7, 15)
    call SaveInteger(udg_ht, task, 8, 2000)
    call TimerStart(t, 0.02, true, function Komachi_Soul_Follow_Main)
endfunction

function Komachi_SoulMove_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local integer i = LoadInteger(udg_ht, task, 2) - 1
    local real angle = LoadReal(udg_ht, task, 1)
    local real velo = LoadReal(udg_ht, task, 3)
    local real oi = LoadInteger(udg_ht, task, 4)
    local real perc = 0.5 + i / oi / 2
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local real nx = GetUnitX(caster) + velo * Sin(perc * 3.1415926) * Cos(angle)
    local real ny = GetUnitY(caster) + velo * Sin(perc * 3.1415926) * Sin(angle)
    call SaveInteger(udg_ht, task, 2, i)
    if GetWidgetLife(caster) > 0.405 and i > 0 then
        call SetUnitX(caster, nx)
        call SetUnitY(caster, ny)
    else
        call PauseTimer(t)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
endfunction

function Komachi_SoulMove takes unit u, real v, real angle, real movetime returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call SaveUnitHandle(udg_ht, task, 0, u)
    call SaveReal(udg_ht, task, 1, angle)
    call SaveInteger(udg_ht, task, 2, R2I(movetime / 0.02))
    call SaveReal(udg_ht, task, 3, v * 3.1415926 / 50 / 2)
    call SaveInteger(udg_ht, task, 4, R2I(movetime / 0.02))
    call TimerStart(t, 0.02, true, function Komachi_SoulMove_Main)
    call DebugMsg("Soul Move Register")
    set t = null
endfunction

function Komachi_Soul_Duration takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit target = LoadUnitHandle(udg_ht, task, 1)
    local integer cnt = LoadInteger(udg_ht, task, 2) - 1
    local group g = LoadGroupHandle(udg_ht, GetHandleId(caster), 66)
    call SaveInteger(udg_ht, task, 2, cnt)
    if cnt <= 0 then
        call GroupRemoveUnit(g, target)
        call KillUnit(target)
        call RemoveUnit(target)
        call PauseTimer(t)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set target = null
    set g = null
endfunction

function Komachi_Soul takes unit caster, unit target, integer style returns unit
    local real x = GetUnitX(target)
    local real y = GetUnitY(target)
    local unit soul
    local timer t
    local integer task
    local group g
    local real duration
    if GetUnitAbilityLevel(caster, 'A0JK') == 0 and GetUnitAbilityLevel(caster, 'A1ED') == 0 then
        return null
    endif
    set g = LoadGroupHandle(udg_ht, GetHandleId(caster), 66)
    if g == null then
        set g = CreateGroup()
        call SaveGroupHandle(udg_ht, GetHandleId(caster), 66, g)
        call DebugMsg("GroupNotExist,CreateNew(KomachiN)")
    endif
    if style == 1 or style == 3 then
        set soul = CreateUnit(GetOwningPlayer(caster), 'n01G', x, y, 0.0)
    elseif style == 2 then
        set soul = CreateUnit(GetOwningPlayer(caster), 'n056', x, y, 0.0)
    elseif style == 4 then
        set soul = CreateUnit(GetOwningPlayer(caster), 'n05E', GetUnitX(caster), GetUnitY(caster), 0.0)
    elseif style == 5 then
        set soul = CreateUnit(GetOwningPlayer(caster), 'n05G', GetUnitX(caster), GetUnitY(caster), 0.0)
    elseif style == 6 then
        set soul = CreateUnit(GetOwningPlayer(caster), 'n05H', x, y, 0.0)
    endif
    call UnitRemoveAbility(soul, 'Amov')
    if style == 1 then
        set duration = 15
        call Komachi_SoulMove(soul, 75, GetRandomReal(0, 3.1415926 * 2), 2.0)
    elseif style == 2 then
        set duration = 15
        call Komachi_SoulMove(soul, 125, GetRandomReal(0, 3.1415926 * 2), 1.0)
    elseif style == 3 then
        set duration = 3
        call Komachi_SoulMove(soul, 400, GetRandomReal(0, 3.1415926 * 2), 3.0)
    elseif style == 4 then
        set duration = 40
        call Komachi_Soul_Follow(soul, target)
    elseif style == 5 then
        set duration = 60
    elseif style == 6 then
        set duration = 60
    endif
    set t = CreateTimer()
    set task = GetHandleId(t)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, soul)
    call SaveInteger(udg_ht, task, 2, R2I(duration / 0.2))
    call SaveInteger(udg_ht, task, 3, R2I(duration / 0.2))
    call TimerStart(t, 0.2, false, function Komachi_Soul_Duration)
    if style != 3 then
        call GroupAddUnit(g, soul)
    endif
    set g = null
    set t = null
    return soul
endfunction

function KOMACHIEX takes nothing returns integer
    return 'A0CL'
endfunction

function KOMACHIEX_EFFECT takes nothing returns string
    return "war3mapImported\\komachi_1.mdx"
endfunction

function KOMACHIEX_DELAY takes nothing returns real
    return 0.6
endfunction

function KOMACHIEX_DEBUFF takes nothing returns integer
    return 'A0FH'
endfunction

function KOMACHIEX_DEBUFF_EFFECT takes nothing returns integer
    return 'B07J'
endfunction

function KOMACHIEX_AOE takes nothing returns real
    return 150.0
endfunction

function KOMACHIEX_DAMAGE takes integer level returns real
    return 60.0 + 12.0 * level
endfunction

function KOMACHIEX_DEBUFF_DURATION takes nothing returns real
    return 2.0
endfunction

function KOMACHIEX_REBUFF_INTERVAL takes nothing returns real
    return 8.0
endfunction

function KomachiEx_Damage takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit u = LoadUnitHandle(udg_sht, task, 0)
    local effect e = LoadEffectHandle(udg_sht, task, 1)
    local group g = CreateGroup()
    local player p = GetOwningPlayer(u)
    local real damage = 60.0 + 12.0 * GetHeroLevel(u)
    local unit v
    call DestroyEffect(e)
    call GroupEnumUnitsInRange(g, LoadReal(udg_sht, task, 0), LoadReal(udg_sht, task, 1), 150.0, null)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if IsUnitEnemy(v, p) and GetWidgetLife(v) > 0.405 and not IsUnitType(v, UNIT_TYPE_STRUCTURE) and GetUnitAbilityLevel(v, 'Aloc') <= 0 and GetUnitAbilityLevel(v, 'Avul') <= 0 then
            if udg_NewDebuffSys then
                call UnitSlowTargetMspd(u, v, 80, 2.0, 3, 0)
            else
                call UnitSlowTarget(u, v, 2.0, 'A0FH', 'B07J')
            endif
            call Komachi_Soul(u, v, 1)
            call Komachi_Soul(u, v, 1)
            call UnitMagicDamageTarget(u, v, damage, 5)
        endif
    endloop
    call DestroyGroup(g)
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_sht, task)
    set t = null
    set u = null
    set e = null
    set g = null
    set p = null
    set v = null
endfunction

function KomachiEx_ReBuff takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_sht, task, 0)
    call SaveBoolean(udg_sht, StringHash("KomachiEx"), GetHandleId(caster), true)
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_sht, task)
    set t = null
    set caster = null
endfunction

function KomachiEx_Conditions takes nothing returns boolean
    local unit u = GetAttacker()
    local unit v
    local effect e
    local timer t
    local integer task
    if GetUnitAbilityLevel(u, 'A0CL') > 0 and LoadBoolean(udg_sht, StringHash("KomachiEx"), GetHandleId(u)) then
        set v = GetTriggerUnit()
        call SaveBoolean(udg_sht, StringHash("KomachiEx"), GetHandleId(u), false)
        set e = AddSpecialEffect("war3mapImported\\komachi_1.mdx", GetUnitX(v), GetUnitY(v))
        call SaveEffectHandle(udg_sht, StringHash("KomachiEx"), GetHandleId(u), e)
        set t = CreateTimer()
        set task = GetHandleId(t)
        call SaveUnitHandle(udg_sht, task, 0, u)
        call SaveEffectHandle(udg_sht, task, 1, e)
        call SaveReal(udg_sht, task, 0, GetUnitX(v))
        call SaveReal(udg_sht, task, 1, GetUnitY(v))
        call TimerStart(t, 0.6, false, function KomachiEx_Damage)
        set t = CreateTimer()
        set task = GetHandleId(t)
        call SaveUnitHandle(udg_sht, task, 0, u)
        call TimerStart(t, 8.0, false, function KomachiEx_ReBuff)
    endif
    set e = null
    set t = null
    set u = null
    set v = null
    return false
endfunction

function InitTrig_KomachiEx takes nothing returns nothing
endfunction