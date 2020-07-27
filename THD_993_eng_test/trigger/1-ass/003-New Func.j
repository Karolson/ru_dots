function Watch takes string msg returns nothing
    call DisplayTimedTextToPlayer(GetLocalPlayer(), 0, 0, 5, msg)
endfunction

function WatchI takes integer i returns integer
    call Watch(I2S(i))
    return i
endfunction

function WatchR takes real r returns real
    call Watch(R2S(r))
    return r
endfunction

function WatchH takes handle h returns handle
    call Watch(I2S(GetHandleId(h)))
    return h
endfunction

function WatchB takes boolean b returns boolean
    if b then
        call Watch("true")
    else
        call Watch("false")
    endif
    return b
endfunction

function WatchSI takes string s, integer i returns integer
    call Watch(s + "_" + I2S(i))
    return i
endfunction

function DebugSI takes boolean b, string s, integer i returns nothing
    if b then
        call WatchSI(s, i)
    endif
endfunction

function WatchSII takes string s, integer i1, integer i2 returns integer
    call Watch(s + "_" + I2S(i1) + "_" + I2S(i2))
    return i1
endfunction

function DebugSII takes boolean b, string s, integer i1, integer i2 returns nothing
    if b then
        call WatchSII(s, i1, i2)
    endif
endfunction

function WatchSU takes string s, unit u returns unit
    call Watch(s + "_" + GetObjectName(GetUnitTypeId(u)) + "_" + I2S(GetHandleId(u)))
    return u
endfunction

function DebugSU takes boolean b, string s, unit u returns nothing
    if b then
        call WatchSU(s, u)
    endif
endfunction

function WatchEscCode takes code c returns nothing
    local trigger t = CreateTrigger()
    local integer i = 0
    loop
        call TriggerRegisterPlayerEvent(t, Player(i), EVENT_PLAYER_END_CINEMATIC)
    exitwhen i >= 15
        set i = i + 1
    endloop
    call TriggerAddCondition(t, Condition(c))
    set t = null
endfunction

function WatchChatCode takes string msg, boolean exact, code c returns nothing
    local trigger t = CreateTrigger()
    local integer i = 0
    loop
        call TriggerRegisterPlayerChatEvent(t, Player(i), msg, exact)
    exitwhen i >= 15
        set i = i + 1
    endloop
    call TriggerAddCondition(t, Condition(c))
    set t = null
endfunction

function GetTimeString_h_mM_SS_WW takes integer seconds returns string
    local string str
    local integer h = seconds / 3600
    local integer m = seconds / 60 - h * 60
    local integer s = seconds - h * 3600 - m * 60
    if h == 0 then
        set str = I2S(m)
    elseif m < 10 then
        set str = I2S(h) + ":0" + I2S(m)
    else
        set str = I2S(h) + ":" + I2S(m)
    endif
    if s < 10 then
        return str + ":0" + I2S(s)
    else
        return str + ":" + I2S(s)
    endif
endfunction

function DestroyTimer_WW takes timer ti returns nothing
    call DestroyTimer(ti)
endfunction

function FlushTimer_WW takes timer ti returns nothing
    call PauseTimer(ti)
    call FlushChildHashtable(udg_Hashtable, GetHandleId(ti))
    call DestroyTimer(ti)
endfunction

function FlushTrigger takes trigger t returns nothing
    call FlushChildHashtable(udg_Hashtable, GetHandleId(t))
    call DestroyTrigger(t)
endfunction

function GetGameTimeAfterBattleBegin_WW takes nothing returns integer
    return IMaxBJ(udg_GameTime - udg_Game_BattleBeginTime, 0)
endfunction

function GetGameTimeAfterBattleBeginEx_WW takes nothing returns integer
    return udg_GameTime - udg_Game_BattleBeginTime
endfunction

function System_ShareVision_Timeout_WW takes nothing returns nothing
    local timer ti = GetExpiredTimer()
    local integer parentKey = StringHash("VisionShare")
    local integer childKey = LoadInteger(udg_Hashtable, GetHandleId(ti), 1)
    local integer stack = LoadInteger(udg_Hashtable_UnitStatus, parentKey, childKey) - 1
    call SaveInteger(udg_Hashtable_UnitStatus, parentKey, childKey, stack)
    if stack <= 0 then
        call SetPlayerAlliance(LoadPlayerHandle(udg_Hashtable, GetHandleId(ti), 2), LoadPlayerHandle(udg_Hashtable, GetHandleId(ti), 3), ALLIANCE_SHARED_VISION, false)
    endif
    call ReleaseTimer(ti)
    set ti = null
endfunction

function System_ShareVision_WW takes player p, player toPlayer, real timeout returns nothing
    local integer parentKey = StringHash("VisionShare")
    local integer childKey = StringHash("Player" + I2S(GetPlayerId(p)) + "ToPlayer" + I2S(GetPlayerId(toPlayer)))
    local integer stack = LoadInteger(udg_Hashtable_UnitStatus, parentKey, childKey) + 1
    local timer ti
    if IsPlayerAlly(p, toPlayer) then
        return
    endif
    if stack == 1 then
        call SetPlayerAlliance(p, toPlayer, ALLIANCE_SHARED_VISION, true)
    endif
    call SaveInteger(udg_Hashtable_UnitStatus, parentKey, childKey, stack)
    set ti = CreateTimer()
    call SaveInteger(udg_Hashtable, GetHandleId(ti), 1, childKey)
    call SavePlayerHandle(udg_Hashtable, GetHandleId(ti), 2, p)
    call SavePlayerHandle(udg_Hashtable, GetHandleId(ti), 3, toPlayer)
    call TimerStart(ti, timeout, false, function System_ShareVision_Timeout_WW)
    set ti = null
endfunction

function System_ShareVision_U2U_WW takes unit u, unit toUnit, real timeout returns nothing
    call System_ShareVision_WW(GetOwningPlayer(u), GetOwningPlayer(toUnit), timeout)
endfunction

function System_Announce_OriginalAuthor takes nothing returns nothing
    call DisplayTimedTextToPlayer(GetLocalPlayer(), 0, 0, 4, " ")
    call DisplayTimedTextToPlayer(GetLocalPlayer(), 0, 0, 5, "====== Original work ======")
    call DisplayTimedTextToPlayer(GetLocalPlayer(), 0, 0, 6, " - Touhou Project -")
    call DisplayTimedTextToPlayer(GetLocalPlayer(), 0, 0, 7, "Team Shanghai Alice (ZUN)")
    call DisplayTimedTextToPlayer(GetLocalPlayer(), 0, 0, 9, " ")
endfunction

function TriggerRegisterAnyUnitEventFix takes trigger t, playerunitevent whichEvent returns nothing
    local integer i = 0
    loop
        call TriggerRegisterPlayerUnitEvent(t, Player(i), whichEvent, Condition(function Return_True))
    exitwhen i >= 15
        set i = i + 1
    endloop
endfunction

function GroupEnumUnitsInRangeFix takes group g, real x, real y, real radius returns nothing
    call GroupEnumUnitsInRange(g, x, y, radius, Condition(function Return_True))
endfunction

function IsUnitDead_Test takes unit u returns boolean
    return IsUnitType(u, UNIT_TYPE_DEAD) or GetUnitTypeId(u) < 1
endfunction

function CanUnitBlink takes unit u returns boolean
    return udg_BlinkEnableUnit[GetPlayerId(GetOwningPlayer(u))] != null and GetUnitAbilityLevel(u, 'A0V4') <= 0 and GetUnitAbilityLevel(u, 'A0A1') <= 0
endfunction

function AddSpecialEffectTargetLoc takes string modelName, unit u returns effect
    return AddSpecialEffect(modelName, GetUnitX(u), GetUnitY(u))
endfunction

function DummyCastTarget_WW takes unit owner, unit target, real x, real y, real face, integer abilityId, integer level, string order returns nothing
    local unit u = CreateUnit(GetOwningPlayer(owner), 'n001', x, y, face)
    call UnitAddAbility(u, abilityId)
    call SetUnitAbilityLevel(u, abilityId, level)
    call IssueTargetOrder(u, order, target)
    set u = null
endfunction

function DummyCastTargetInstant_WW takes unit owner, unit target, integer abilityId, integer level, string order returns nothing
    call DummyCastTarget_WW(owner, target, GetUnitX(target), GetUnitY(target), GetUnitFacing(target), abilityId, level, order)
endfunction

function InitPlayerColorRGB takes nothing returns nothing
    set udg_PlayerColorR[0] = 255
    set udg_PlayerColorG[0] = 3
    set udg_PlayerColorB[0] = 3
    set udg_PlayerColorR[1] = 0
    set udg_PlayerColorG[1] = 66
    set udg_PlayerColorB[1] = 255
    set udg_PlayerColorR[2] = 48
    set udg_PlayerColorG[2] = 230
    set udg_PlayerColorB[2] = 185
    set udg_PlayerColorR[3] = 50
    set udg_PlayerColorG[3] = 0
    set udg_PlayerColorB[3] = 129
    set udg_PlayerColorR[4] = 255
    set udg_PlayerColorG[4] = 252
    set udg_PlayerColorB[4] = 1
    set udg_PlayerColorR[5] = 255
    set udg_PlayerColorG[5] = 50
    set udg_PlayerColorB[5] = 0
    set udg_PlayerColorR[6] = 32
    set udg_PlayerColorG[6] = 192
    set udg_PlayerColorB[6] = 0
    set udg_PlayerColorR[7] = 220
    set udg_PlayerColorG[7] = 50
    set udg_PlayerColorB[7] = 50
    set udg_PlayerColorR[8] = 50
    set udg_PlayerColorG[8] = 50
    set udg_PlayerColorB[8] = 50
    set udg_PlayerColorR[9] = 75
    set udg_PlayerColorG[9] = 150
    set udg_PlayerColorB[9] = 190
    set udg_PlayerColorR[10] = 16
    set udg_PlayerColorG[10] = 60
    set udg_PlayerColorB[10] = 18
    set udg_PlayerColorR[11] = 68
    set udg_PlayerColorG[11] = 42
    set udg_PlayerColorB[11] = 4
    set udg_PlayerColorR[12] = 255
    set udg_PlayerColorG[12] = 255
    set udg_PlayerColorB[12] = 255
    set udg_PlayerColorR[13] = 255
    set udg_PlayerColorG[13] = 255
    set udg_PlayerColorB[13] = 255
    set udg_PlayerColorR[14] = 255
    set udg_PlayerColorG[14] = 255
    set udg_PlayerColorB[14] = 255
    set udg_PlayerColorR[15] = 255
    set udg_PlayerColorG[15] = 255
    set udg_PlayerColorB[15] = 255
endfunction

function PlayerPingMinimap_WW takes player p, real x, real y, real duration, boolean extraEffects returns nothing
    if p == Player(0) then
        call PingMinimapEx(x, y, duration, 255, 255, 255, extraEffects)
    else
        call PingMinimapEx(x, y, duration, udg_PlayerColorR[GetPlayerId(p)], udg_PlayerColorG[GetPlayerId(p)], udg_PlayerColorB[GetPlayerId(p)], extraEffects)
    endif
endfunction

function GetUnitBase takes unit u returns unit
    if IsUnitAlly(gg_unit_n023_0006, GetOwningPlayer(u)) then
        return gg_unit_n023_0006
    endif
    if IsUnitAlly(gg_unit_n03O_0079, GetOwningPlayer(u)) then
        return gg_unit_n03O_0079
    endif
    call BJDebugMsg("Secondary bug! GetUnitBase . Neutral Unit?")
    return null
endfunction

function LocalErrorMessage takes unit u, string message returns nothing
    local sound snd = CreateSoundFromLabel("InterfaceError", false, false, false, 10, 10)
    if GetLocalPlayer() == GetOwningPlayer(u) then
        call DisplayTimedTextToPlayer(GetOwningPlayer(u), 0, 0, 5.0, "|cffffcc00" + message + "|r")
        call StartSound(snd)
    endif
    call KillSoundWhenDone(snd)
    set snd = null
endfunction

function AddItemCharges takes item it, integer delta returns nothing
    call SetItemCharges(it, GetItemCharges(it) + delta)
endfunction

function GetStatus takes unit u, string childKey returns boolean
    return LoadBoolean(udg_Hashtable_UnitStatus, GetHandleId(u), StringHash(childKey))
endfunction

function SetStatus takes unit u, string childKey returns nothing
    call SaveBoolean(udg_Hashtable_UnitStatus, GetHandleId(u), StringHash(childKey), true)
endfunction

function DelStatus takes unit u, string childKey returns nothing
    call SaveBoolean(udg_Hashtable_UnitStatus, GetHandleId(u), StringHash(childKey), false)
endfunction

function IssueStopOrderEx takes unit u returns nothing
    call PauseUnit(u, true)
    call PauseUnit(u, false)
endfunction

function InitTrig_New_Func takes nothing returns nothing
endfunction