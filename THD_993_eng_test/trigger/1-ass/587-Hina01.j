function Trig_HinaEx_Actions takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 1)
    local integer i = LoadInteger(udg_ht, task, 2)
    if caster == null then
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
        set t = null
        set caster = null
        return
    endif
    if LoadInteger(udg_Hashtable_Slow, GetHandleId(caster), 'A070' * -10) == 0 then
        set i = i + 1
        if i == 16 then
            set udg_SK_HinaEx_Count = GetUnitState(caster, UNIT_STATE_MAX_LIFE) * 0.1
            call UnitBuffTarget(caster, caster, 99999.0, 'A070', 'B07B')
            call SaveReal(udg_Hashtable_Slow, GetHandleId(caster), 'A070' * -10, GetUnitState(caster, UNIT_STATE_MAX_LIFE) * 0.1)
            call SaveUnitHandle(udg_Hashtable_Slow, GetHandleId(caster), 'A070' * -10, caster)
            set i = 0
        endif
        call SaveInteger(udg_ht, task, 2, i)
    endif
    set caster = null
    set t = null
endfunction

function HINA01 takes nothing returns integer
    return 'A0E4'
endfunction

function Trig_Hina01_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local real ox = GetUnitX(target)
    local real oy = GetUnitY(target)
    local real px
    local real py
    local real a
    local real d
    local integer level = GetUnitAbilityLevel(caster, 'A0E4')
    local integer i
    local integer n
    call AbilityCoolDownResetion(caster, 'A0E4', 12)
    set udg_SK_Hina01_Unit = target
    set i = 1
    set n = 1
    loop
        set a = GetRandomReal(0.0, 6.28318)
        set d = GetRandomReal(80.0, 320.0)
        set px = ox + d * Cos(a)
        set py = oy + d * Sin(a)
        set udg_SK_Hina01_Item[i] = CreateUnit(GetOwningPlayer(caster), 'n02T', px, py, a * 57.29578)
        call UnitAddMaxLife(udg_SK_Hina01_Item[i], 75 * level)
        call UnitApplyTimedLife(udg_SK_Hina01_Item[i], 'BTLF', 6.0)
        set i = i + 1
    exitwhen i > n
    endloop
    set caster = null
    set target = null
endfunction

function Trig_Hina01_Main_New takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit u = LoadUnitHandle(udg_ht, task, 1)
    local unit v
    local group g = CreateGroup()
    local group dg = LoadGroupHandle(udg_ht, task, 12)
    local integer level = LoadInteger(udg_ht, task, 2)
    local integer i = LoadInteger(udg_ht, task, 3)
    local real ox = GetUnitX(u)
    local real oy = GetUnitY(u)
    local real px
    local real py
    local real a = LoadReal(udg_ht, task, 4)
    local real d = LoadReal(udg_ht, task, 5)
    local real ax = LoadReal(udg_ht, task, 6)
    local real ay = LoadReal(udg_ht, task, 7)
    local real bx = LoadReal(udg_ht, task, 8)
    local real by = LoadReal(udg_ht, task, 9)
    local real i2 = LoadReal(udg_ht, task, 10)
    local real cnt = LoadReal(udg_ht, task, 11)
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    if i >= 0 then
        set px = ox + d * Cos(a)
        set py = oy + d * Sin(a)
        if IsTerrainPathable(px, py, PATHING_TYPE_FLYABILITY) == false then
            if i / 2 * 2 == i then
                call SaveUnitHandle(udg_ht, task, 13 + R2I(cnt), CreateUnit(GetOwningPlayer(caster), 'e039', px, py, bj_RADTODEG * a))
                call SaveReal(udg_ht, task, 11, cnt + 1)
            endif
            call SetUnitX(u, px)
            call SetUnitY(u, py)
            call SaveInteger(udg_ht, task, 3, i - 1)
            call SaveReal(udg_ht, task, 8, px)
            call SaveReal(udg_ht, task, 9, py)
        else
            call SaveInteger(udg_ht, task, 3, 0)
        endif
        if i == 0 then
            call SaveReal(udg_ht, task, 10, 150)
            set i2 = 150
            call SaveInteger(udg_ht, task, 3, -999)
        endif
    endif
    if i2 > 0 then
        call SaveReal(udg_ht, task, 10, i2 - 1)
        call DebugMsg("bx:" + R2S(bx) + "by:" + R2S(by))
        call GroupEnumUnitsInLine(g, bx, by, ox, oy, 500, iff)
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if IsUnitInGroup(v, dg) == false then
                call GroupAddUnit(dg, v)
                call UnitMagicDamageTarget(caster, v, level * 60 + 1.0 * GetHeroInt(caster, true), 1)
            endif
            call UnitSlowTarget(caster, v, 0.5, 'A0IB' + level, 'B086')
        endloop
        call DestroyGroup(g)
    else
        set i = 0
        loop
        exitwhen i == cnt
            call KillUnit(LoadUnitHandle(udg_ht, task, i + 13))
            set i = i + 1
        endloop
        call DestroyGroup(dg)
        call KillUnit(u)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set u = null
    set v = null
    set iff = null
endfunction

function Trig_Hina01_Actions_New takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit u
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real tx = GetSpellTargetX()
    local real ty = GetSpellTargetY()
    local real a = Atan2(ty - oy, tx - ox)
    local integer level = GetUnitAbilityLevel(caster, 'A0E4')
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call AbilityCoolDownResetion(caster, 'A0E4', 15.5 - 1.5 * level)
    set u = CreateUnit(GetOwningPlayer(caster), 'e039', ox, oy, bj_RADTODEG * a)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, u)
    call SaveInteger(udg_ht, task, 2, level)
    call SaveInteger(udg_ht, task, 3, 36)
    call SaveReal(udg_ht, task, 4, a)
    call SaveReal(udg_ht, task, 5, 25.0)
    call SaveReal(udg_ht, task, 6, ox)
    call SaveReal(udg_ht, task, 7, oy)
    call SaveReal(udg_ht, task, 8, ox)
    call SaveReal(udg_ht, task, 9, oy)
    call SaveReal(udg_ht, task, 10, 99999)
    call SaveReal(udg_ht, task, 11, 0)
    call SaveGroupHandle(udg_ht, task, 12, CreateGroup())
    call TimerStart(t, 0.02, true, function Trig_Hina01_Main_New)
    set caster = null
    set u = null
    set t = null
endfunction

function Trig_Hina01_Conditions takes nothing returns boolean
    if GetSpellAbilityId() == 'A0E4' then
        call Trig_Hina01_Actions()
    endif
    return false
endfunction

function InitTrig_Hina01 takes nothing returns nothing
endfunction