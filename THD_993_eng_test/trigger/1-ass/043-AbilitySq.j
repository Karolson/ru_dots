function UnRegisterAreaShow takes unit u, integer iAbility returns nothing
    local timer t = null
    local integer task
    local integer i
    local integer iEffectCount
    local unit v
    local effect e
    set t = LoadTimerHandle(udg_Hashtable_CastSq, GetHandleId(u), iAbility)
    if t != null then
        set task = GetHandleId(t)
        set iEffectCount = LoadInteger(udg_ht, task, 2)
        set i = 0
        loop
        exitwhen i >= iEffectCount
            set v = LoadUnitHandle(udg_ht, task, 20 + i)
            set e = LoadEffectHandle(udg_ht, task, 0 - i)
            call DestroyEffect(e)
            call ReleaseSpecialDummy(v)
            set i = i + 1
        endloop
        call FlushChildHashtable(udg_ht, task)
        call PauseTimer(t)
        call DestroyTimer(t)
        call SaveTimerHandle(udg_Hashtable_CastSq, GetHandleId(u), iAbility, null)
        call DebugMsg("AreaShow Removed Successfully")
    else
        call DebugMsg("AreaShow Not Exist")
        set t = null
        set v = null
        set e = null
        return
    endif
    set v = null
    set t = null
    set e = null
endfunction

function AreaShowXY_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit u = LoadUnitHandle(udg_ht, task, 4)
    local real rRange = LoadReal(udg_ht, task, 3)
    local integer iType = LoadInteger(udg_ht, task, 5)
    local integer iEffectCount = LoadInteger(udg_ht, task, 2)
    local integer cnt = LoadInteger(udg_ht, task, 1) + 1
    local string sEffect
    local unit v
    local integer i
    local real ox = LoadReal(udg_ht, task, 8)
    local real oy = LoadReal(udg_ht, task, 9)
    local real tx
    local real ty
    call SaveInteger(udg_ht, task, 1, cnt)
    if GetWidgetLife(u) >= 0.405 == false then
        call DebugMsg("UnitDead,UnRegisterAreaShow")
        call UnRegisterAreaShow(u, LoadInteger(udg_ht, task, 7))
        set v = null
        set t = null
        set u = null
        return
    endif
    if iType == 0 then
        set i = 0
        loop
        exitwhen i >= iEffectCount
            set v = LoadUnitHandle(udg_ht, task, 20 + i)
            set tx = ox + rRange * CosBJ(cnt * 4 + 360 / iEffectCount * i)
            set ty = oy + rRange * SinBJ(cnt * 4 + 360 / iEffectCount * i)
            if IsTerrainPathable(tx, ty, PATHING_TYPE_FLYABILITY) == false then
                call SetUnitX(v, tx)
                call SetUnitY(v, ty)
            endif
            set i = i + 1
        endloop
    else
        set sEffect = LoadStr(udg_ht, task, 6)
        set i = 0
        loop
        exitwhen i >= iEffectCount
            set tx = ox + rRange * CosBJ(cnt * 4 + 360 / iEffectCount * i)
            set ty = oy + rRange * SinBJ(cnt * 4 + 360 / iEffectCount * i)
            call DestroyEffect(AddSpecialEffect(sEffect, tx, ty))
            set i = i + 1
        endloop
    endif
    set v = null
    set t = null
    set u = null
endfunction

function RegisterAreaShowXY takes unit u, integer iAbility, real x, real y, real rRange, integer iEffectCount, integer iType, string sEffect, real rInterval returns nothing
    local timer t = null
    local integer task
    local integer i
    local unit eu
    local effect e
    set t = LoadTimerHandle(udg_Hashtable_CastSq, GetHandleId(u), iAbility)
    if iType < 0 or iType > 1 or iEffectCount <= 0 or rRange <= 0 then
        call DebugMsg("Invaild Type Input(AreaEffect System)")
        set t = null
        return
    endif
    if t == null then
        set t = CreateTimer()
        call SaveTimerHandle(udg_Hashtable_CastSq, GetHandleId(u), iAbility, t)
        call DebugMsg("New AreaEffect Created")
    else
        call UnRegisterAreaShow(u, iAbility)
        set t = CreateTimer()
        call SaveTimerHandle(udg_Hashtable_CastSq, GetHandleId(u), iAbility, t)
        call DebugMsg("Old AreaEffect Overrided")
    endif
    set task = GetHandleId(t)
    call SaveInteger(udg_ht, task, 1, 0)
    call SaveInteger(udg_ht, task, 2, iEffectCount)
    call SaveReal(udg_ht, task, 3, rRange)
    call SaveInteger(udg_ht, task, 5, iType)
    call SaveInteger(udg_ht, task, 7, iAbility)
    call SaveReal(udg_ht, task, 8, x)
    call SaveReal(udg_ht, task, 9, y)
    call SaveUnitHandle(udg_ht, task, 4, u)
    if iType == 0 then
        set i = 0
        loop
        exitwhen i >= iEffectCount
            set eu = NewSpecialDummy(GetOwningPlayer(u), GetUnitX(u), GetUnitY(u), 0)
            set e = AddSpecialEffectTarget(sEffect, eu, "origin")
            call SetUnitScale(eu, 1, 1, 1)
            call SaveUnitHandle(udg_ht, task, 20 + i, eu)
            call SaveEffectHandle(udg_ht, task, 0 - i, e)
            set i = i + 1
        endloop
        call DebugMsg("DummyUnitCreated")
    else
        call SaveStr(udg_ht, task, 6, sEffect)
        call DebugMsg("Effect StringSaved")
    endif
    call TimerStart(t, rInterval, true, function AreaShowXY_Main)
    call DebugMsg("Effect Created")
    set t = null
    set u = null
    set e = null
endfunction

function AreaShow_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit u = LoadUnitHandle(udg_ht, task, 4)
    local real rRange = LoadReal(udg_ht, task, 3)
    local integer iType = LoadInteger(udg_ht, task, 5)
    local integer iEffectCount = LoadInteger(udg_ht, task, 2)
    local integer cnt = LoadInteger(udg_ht, task, 1) + 1
    local string sEffect
    local unit v
    local integer i
    local real ox = GetUnitX(u)
    local real oy = GetUnitY(u)
    local real tx
    local real ty
    call SaveInteger(udg_ht, task, 1, cnt)
    if GetWidgetLife(u) >= 0.405 == false then
        call DebugMsg("UnitDead,UnRegisterAreaShow")
        call UnRegisterAreaShow(u, LoadInteger(udg_ht, task, 7))
        set v = null
        set t = null
        set u = null
        return
    endif
    if iType == 0 then
        set i = 0
        loop
        exitwhen i >= iEffectCount
            set v = LoadUnitHandle(udg_ht, task, 20 + i)
            set tx = ox + rRange * CosBJ(cnt * 4 + 360 / iEffectCount * i)
            set ty = oy + rRange * SinBJ(cnt * 4 + 360 / iEffectCount * i)
            if IsTerrainPathable(tx, ty, PATHING_TYPE_FLYABILITY) == false then
                call SetUnitX(v, tx)
                call SetUnitY(v, ty)
            endif
            set i = i + 1
        endloop
    else
        set sEffect = LoadStr(udg_ht, task, 6)
        set i = 0
        loop
        exitwhen i >= iEffectCount
            set tx = ox + rRange * CosBJ(cnt * 4 + 360 / iEffectCount * i)
            set ty = oy + rRange * SinBJ(cnt * 4 + 360 / iEffectCount * i)
            call DestroyEffect(AddSpecialEffect(sEffect, tx, ty))
            set i = i + 1
        endloop
    endif
    set v = null
    set t = null
    set u = null
endfunction

function RegisterAreaShowPlayer takes player p, unit u, integer iAbility, real rRange, integer iEffectCount, integer iType, string sEffect, real rInterval returns nothing
    local timer t = null
    local integer task
    local integer i
    local unit eu
    local effect e
    set t = LoadTimerHandle(udg_Hashtable_CastSq, GetHandleId(u), iAbility)
    if iType < 0 or iType > 1 or iEffectCount <= 0 or rRange <= 0 then
        call DebugMsg("Invaild Type Input(AreaEffect System)")
        return
    endif
    if t == null then
        set t = CreateTimer()
        call SaveTimerHandle(udg_Hashtable_CastSq, GetHandleId(u), iAbility, t)
        call DebugMsg("New AreaEffect Created")
    else
        call UnRegisterAreaShow(u, iAbility)
        set t = CreateTimer()
        call SaveTimerHandle(udg_Hashtable_CastSq, GetHandleId(u), iAbility, t)
        call DebugMsg("Old AreaEffect Overrided")
    endif
    set task = GetHandleId(t)
    call SaveInteger(udg_ht, task, 1, 0)
    call SaveInteger(udg_ht, task, 2, iEffectCount)
    call SaveReal(udg_ht, task, 3, rRange)
    call SaveInteger(udg_ht, task, 5, iType)
    call SaveInteger(udg_ht, task, 7, iAbility)
    call SaveUnitHandle(udg_ht, task, 4, u)
    call SaveReal(udg_ht, GetHandleId(p), StringHash("AREASHOW"), rRange)
    if iType == 0 then
        set i = 0
        loop
        exitwhen i >= iEffectCount
            set eu = NewSpecialDummy(GetOwningPlayer(u), GetUnitX(u), GetUnitY(u), 0)
            set e = AddSpecialEffectTarget(sEffect, eu, "origin")
            call SetUnitScale(eu, 1, 1, 1)
            call SaveUnitHandle(udg_ht, task, 20 + i, eu)
            call SaveEffectHandle(udg_ht, task, 0 - i, e)
            if p != GetLocalPlayer() then
                call ShowUnit(eu, false)
            endif
            set i = i + 1
        endloop
        call DebugMsg("DummyUnitCreated")
    else
        call SaveStr(udg_ht, task, 6, sEffect)
        call DebugMsg("Effect StringSaved")
    endif
    call TimerStart(t, rInterval, true, function AreaShow_Main)
    call DebugMsg("Effect Created")
    set t = null
    set u = null
    set e = null
endfunction

function RegisterAreaShow takes unit u, integer iAbility, real rRange, integer iEffectCount, integer iType, string sEffect, real rInterval returns nothing
    local timer t = null
    local integer task
    local integer i
    local unit eu
    local effect e
    set t = LoadTimerHandle(udg_Hashtable_CastSq, GetHandleId(u), iAbility)
    if iType < 0 or iType > 1 or iEffectCount <= 0 or rRange <= 0 then
        call DebugMsg("Invaild Type Input(AreaEffect System)")
        return
    endif
    if t == null then
        set t = CreateTimer()
        call SaveTimerHandle(udg_Hashtable_CastSq, GetHandleId(u), iAbility, t)
        call DebugMsg("New AreaEffect Created")
    else
        call UnRegisterAreaShow(u, iAbility)
        set t = CreateTimer()
        call SaveTimerHandle(udg_Hashtable_CastSq, GetHandleId(u), iAbility, t)
        call DebugMsg("Old AreaEffect Overrided")
    endif
    set task = GetHandleId(t)
    call SaveInteger(udg_ht, task, 1, 0)
    call SaveInteger(udg_ht, task, 2, iEffectCount)
    call SaveReal(udg_ht, task, 3, rRange)
    call SaveInteger(udg_ht, task, 5, iType)
    call SaveInteger(udg_ht, task, 7, iAbility)
    call SaveUnitHandle(udg_ht, task, 4, u)
    if iType == 0 then
        set i = 0
        loop
        exitwhen i >= iEffectCount
            set eu = NewSpecialDummy(GetOwningPlayer(u), GetUnitX(u), GetUnitY(u), 0)
            set e = AddSpecialEffectTarget(sEffect, eu, "origin")
            call SetUnitScale(eu, 1, 1, 1)
            call SaveUnitHandle(udg_ht, task, 20 + i, eu)
            call SaveEffectHandle(udg_ht, task, 0 - i, e)
            set i = i + 1
        endloop
        call DebugMsg("DummyUnitCreated")
    else
        call SaveStr(udg_ht, task, 6, sEffect)
        call DebugMsg("Effect StringSaved")
    endif
    call TimerStart(t, rInterval, true, function AreaShow_Main)
    call DebugMsg("Effect Created")
    set t = null
    set u = null
    set e = null
endfunction

function Trig_AbilitySq_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer timertask = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, timertask, 1)
    local integer task = GetHandleId(caster)
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local integer i = LoadInteger(udg_ht, timertask, 2)
    local integer turner = LoadInteger(udg_Hashtable_CastSq, task, 0)
    local integer abid = LoadInteger(udg_Hashtable_CastSq_Id, task, 0 + i * 10)
    local real BaseRange = LoadReal(udg_Hashtable_CastSq_Id, task, 2 + i * 10)
    local real IncRange = LoadReal(udg_Hashtable_CastSq_Id, task, 3 + i * 10)
    local integer R = LoadInteger(udg_Hashtable_CastSq_Id, task, 5 + i * 10)
    local integer G = LoadInteger(udg_Hashtable_CastSq_Id, task, 6 + i * 10)
    local integer B = LoadInteger(udg_Hashtable_CastSq_Id, task, 7 + i * 10)
    local unit u = LoadUnitHandle(udg_Hashtable_CastSq_Id, task, 8 + i * 10)
    local real S = (BaseRange + IncRange * GetUnitAbilityLevel(caster, abid)) / 414
    call SetUnitXY(u, ox, oy)
    call SetUnitScale(u, S, S, S)
    if turner == 0 then
        call RemoveUnit(u)
        call SaveUnitHandle(udg_Hashtable_CastSq_Id, task, 8 + i * 10, null)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, timertask)
    endif
    set t = null
    set caster = null
    set u = null
endfunction

function Trig_AbilitySq_Actions takes nothing returns nothing
    local unit caster = GetPlayerCharacter(GetTriggerPlayer())
    local integer task = GetHandleId(caster)
    local timer t
    local integer timertask
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local unit u
    local integer abid
    local integer i = 0
    local integer HasCastRange
    local integer CircleType
    local integer UType
    local real BaseRange
    local real IncRange
    local real S
    local integer R
    local integer G
    local integer B
    if HaveSavedInteger(udg_Hashtable_CastSq, task, 0) then
        if LoadInteger(udg_Hashtable_CastSq, task, 0) == 0 then
            call SaveInteger(udg_Hashtable_CastSq, task, 0, 1)
        else
            set caster = null
            set t = null
            return
        endif
    else
        call SaveInteger(udg_Hashtable_CastSq, task, 0, 1)
    endif
    set i = 0
    loop
    exitwhen HaveSavedInteger(udg_Hashtable_CastSq_Id, task, 0 + i * 10) == false
        set abid = LoadInteger(udg_Hashtable_CastSq_Id, task, 0 + i * 10)
        set HasCastRange = LoadInteger(udg_Hashtable_CastSq_Id, task, 1 + i * 10)
        if HasCastRange >= 1 then
            set BaseRange = LoadReal(udg_Hashtable_CastSq_Id, task, 2 + i * 10)
            set IncRange = LoadReal(udg_Hashtable_CastSq_Id, task, 3 + i * 10)
            if LoadUnitHandle(udg_Hashtable_CastSq_Id, task, 8 + i * 10) == null then
                set CircleType = LoadInteger(udg_Hashtable_CastSq_Id, task, 4 + i * 10)
                if CircleType == 0 then
                    set UType = 'n042'
                endif
                set u = CreateUnit(GetOwningPlayer(caster), UType, ox, oy, 0)
                call SaveUnitHandle(udg_Hashtable_CastSq_Id, task, 8 + i * 10, u)
                set S = (BaseRange + IncRange * GetUnitAbilityLevel(caster, abid)) / 414
                call SetUnitScale(u, S, S, S)
                set R = LoadInteger(udg_Hashtable_CastSq_Id, task, 5 + i * 10)
                set G = LoadInteger(udg_Hashtable_CastSq_Id, task, 6 + i * 10)
                set B = LoadInteger(udg_Hashtable_CastSq_Id, task, 7 + i * 10)
                call SetUnitVertexColor(u, R, G, B, 0)
                if GetOwningPlayer(caster) == GetLocalPlayer() then
                    call SetUnitVertexColor(u, R, G, B, 155)
                endif
                set t = CreateTimer()
                set timertask = GetHandleId(t)
                call SaveTimerHandle(udg_ht, timertask, 0, t)
                call SaveUnitHandle(udg_ht, timertask, 1, caster)
                call SaveInteger(udg_ht, timertask, 2, i)
                call TimerStart(t, 0.02, true, function Trig_AbilitySq_Main)
            endif
        endif
        set i = i + 1
    endloop
    set caster = null
    set u = null
    set t = null
endfunction

function InitTrig_AbilitySq takes nothing returns nothing
    set gg_trg_AbilitySq = CreateTrigger()
    call TriggerAddAction(gg_trg_AbilitySq, function Trig_AbilitySq_Actions)
endfunction