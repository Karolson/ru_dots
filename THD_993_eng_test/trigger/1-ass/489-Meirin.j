function MeilingPushUnitMain takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer tid = GetHandleId(t)
    local unit u = LoadUnitHandle(udg_Hashtable, tid, 1)
    local integer count = LoadInteger(udg_Hashtable, tid, 2)
    local integer countmax = LoadInteger(udg_Hashtable, tid, 3)
    local real distance = LoadReal(udg_Hashtable, tid, 4)
    local real acc = distance * 2 / 0.5 / 0.5 * 0.03 * 0.03
    local real startspeed = distance * 2 / 0.5 * 0.03
    local real angle = LoadReal(udg_Hashtable, tid, 5)
    local real movedistance = startspeed - acc * count
    local real originx = GetUnitX(u)
    local real originy = GetUnitY(u)
    local real ux = originx + movedistance * Cos(angle)
    local real uy = originy + movedistance * Sin(angle)
    if count > countmax then
        call SetUnitFlag(u, 4, false)
        call SetUnitFlag(u, 3, false)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_Hashtable, tid)
        set u = null
        set t = null
        return
    endif
    call SetUnitXYRepel(u, ux, uy)
    call SaveInteger(udg_Hashtable, tid, 2, count + 1)
    set u = null
    set t = null
endfunction

function MeilingPushUnit takes unit u, real distance, real angle returns nothing
    local timer t
    local integer tid
    if GetCustomState(u, 1) != 0 then
        set t = null
        return
    elseif GetCustomState(u, 5) != 0 then
        set t = null
        return
    elseif GetCustomState(u, 6) != 0 then
        set t = null
        return
    elseif IsUnitType(u, UNIT_TYPE_ANCIENT) then
        set t = null
        return
    endif
    set t = CreateTimer()
    set tid = GetHandleId(t)
    call SetUnitFlag(u, 3, true)
    call TimerStart(t, 0.03, true, function MeilingPushUnitMain)
    call SaveUnitHandle(udg_Hashtable, tid, 1, u)
    call SaveInteger(udg_Hashtable, tid, 2, 0)
    call SaveInteger(udg_Hashtable, tid, 3, 16)
    call SaveReal(udg_Hashtable, tid, 4, distance)
    call SaveReal(udg_Hashtable, tid, 5, angle)
    call SetUnitFlag(u, 4, true)
    set t = null
endfunction

function MeilingSkillsAnimeEnd takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer tid = GetHandleId(t)
    local unit u = LoadUnitHandle(udg_Hashtable, tid, 1)
    call SetUnitAnimation(u, "stand")
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_Hashtable, tid)
    set t = null
    set u = null
endfunction

function MeilingSkillsAnimeStart takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer tid = GetHandleId(t)
    local timer t2 = CreateTimer()
    local integer t2id = GetHandleId(t2)
    local unit u = LoadUnitHandle(udg_Hashtable, tid, 1)
    local string animename = LoadStr(udg_Hashtable, tid, 2)
    local real lasttime = LoadReal(udg_Hashtable, tid, 3)
    call SetUnitAnimation(u, animename)
    call TimerStart(t2, lasttime, false, function MeilingSkillsAnimeEnd)
    call SaveUnitHandle(udg_Hashtable, t2id, 1, u)
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_Hashtable, tid)
    set t = null
    set t2 = null
    set u = null
endfunction

function MeilingSkillsAnime takes unit u, string animename, real lasttime returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call TimerStart(t, 0.01, false, function MeilingSkillsAnimeStart)
    call SaveUnitHandle(udg_Hashtable, task, 1, u)
    call SaveStr(udg_Hashtable, task, 2, animename)
    call SaveReal(udg_Hashtable, task, 3, lasttime)
    set t = null
endfunction

function MeilingSkill4PanCameraRandom takes player whichplayer, real originx, real originy, real range returns nothing
    local real a = GetRandomReal(-1 * range, range)
    local real b = GetRandomReal(-1 * range, range)
    if GetLocalPlayer() == whichplayer then
        call PanCameraToTimed(originx + a, originy + b, 0.2)
    endif
endfunction

function MeilingSkill4ShakeCameraMain takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer tid = GetHandleId(t)
    local player whichplayer = LoadPlayerHandle(udg_Hashtable, tid, 1)
    local integer count = LoadInteger(udg_Hashtable, tid, 2)
    local integer countmax = LoadInteger(udg_Hashtable, tid, 3)
    local real shakepower = LoadReal(udg_Hashtable, tid, 4)
    if count > countmax then
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_Hashtable, tid)
        if GetLocalPlayer() == whichplayer then
            call SetCameraField(CAMERA_FIELD_ROTATION, 90.0, 0.0)
        endif
        set t = null
        set whichplayer = null
        return
    endif
    if GetLocalPlayer() == whichplayer then
        if count / 2 * 2 == count then
            call SetCameraField(CAMERA_FIELD_ROTATION, 90 + (shakepower - shakepower / countmax * count), 0.0)
        else
            call SetCameraField(CAMERA_FIELD_ROTATION, 90 - (shakepower - shakepower / countmax * count), 0.0)
        endif
    endif
    call SaveInteger(udg_Hashtable, tid, 2, count + 1)
    set t = null
    set whichplayer = null
endfunction

function MeilingSkill4ShakeCamera takes player whichplayer, real shakepower, real shaketime returns nothing
    local timer t = CreateTimer()
    local integer tid = GetHandleId(t)
    call TimerStart(t, 0.03, true, function MeilingSkill4ShakeCameraMain)
    call SavePlayerHandle(udg_Hashtable, tid, 1, whichplayer)
    call SaveInteger(udg_Hashtable, tid, 2, 0)
    call SaveInteger(udg_Hashtable, tid, 3, R2I(shaketime / 0.03))
    call SaveReal(udg_Hashtable, tid, 4, shakepower)
    set t = null
endfunction

function MeilingSkill4Shake takes unit caster, real ox, real oy, integer k returns nothing
    local unit h
    local integer i
    set i = 0
    loop
    exitwhen i >= 12
        set h = udg_PlayerHeroes[i]
        if h != null and GetWidgetLife(h) > 0.405 and IsUnitEnemy(h, GetOwningPlayer(caster)) then
            if IsUnitInRangeXY(h, ox, oy, 500.0) then
                if k == 1 then
                    call MeilingSkill4ShakeCamera(GetOwningPlayer(h), 15, 0.7)
                elseif k == 2 then
                    call MeilingSkill4ShakeCamera(GetOwningPlayer(h), 30, 0.7)
                    call MeilingSkill4PanCameraRandom(GetOwningPlayer(h), GetUnitX(h), GetUnitY(h), 1000)
                elseif k == 3 then
                    call MeilingSkill4ShakeCamera(GetOwningPlayer(h), 90, 1.5)
                endif
            endif
        endif
        set i = i + 1
    endloop
    set h = null
endfunction

function InitTrig_Meirin takes nothing returns nothing
endfunction