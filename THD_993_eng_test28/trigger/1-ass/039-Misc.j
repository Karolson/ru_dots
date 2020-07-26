function Invisible_at_night_clear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local group g = CreateGroup()
    local unit v = LoadUnitHandle(udg_ht, task, 0)
    local unit v2
    local player p = GetOwningPlayer(v)
    call GroupEnumUnitsInRange(g, GetUnitX(v), GetUnitY(v), 800, null)
    loop
        set v2 = FirstOfGroup(g)
    exitwhen v2 == null
        call GroupRemoveUnit(g, v2)
        if not IsUnitAlly(v2, p) and IsUnitType(v2, UNIT_TYPE_HERO) then
            call UnitRemoveAbility(v, 'B09F')
            call UnitRemoveAbility(v, 'B09E')
            call ReleaseTimer(t)
            call FlushChildHashtable(udg_ht, task)
        endif
    endloop
    if GetUnitAbilityLevel(v, 'B09E') < 1 then
        call UnitRemoveAbility(v, 'B09F')
        call UnitRemoveAbility(v, 'B09E')
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    call DestroyGroup(g)
    set t = null
    set v = null
    set p = null
endfunction

function Trig_MoonMan takes unit caster returns nothing
    local player p = GetOwningPlayer(caster)
    local unit u = NewDummy(p, GetUnitX(caster), GetUnitY(caster), 0)
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call UnitAddAbility(u, 'A1B7')
    call IssueTargetOrder(u, "invisibility", caster)
    call UnitAddAbility(u, 'A1B8')
    call IssueTargetOrder(u, "bloodlust", caster)
    call UnitRemoveAbility(u, 'A1B8')
    call UnitRemoveAbility(u, 'A1B7')
    call ReleaseDummy(u)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call TimerStart(t, 0.5, true, function Invisible_at_night_clear)
    set t = null
    set u = null
    set p = null
endfunction

function PLY_Sur takes player ply returns nothing
    local string msg
    local integer k = GetPlayerId(ply)
    set udg_GameSurrenderTeamValue[3] = 0
    set udg_GameSurrenderTeamValue[4] = 0
    call ForForce(udg_TeamA, function CountOnlineTeam)
    call ForForce(udg_TeamB, function CountOnlineTeam)
    if udg_GameSurrendingValue[k] == false then
        set msg = udg_PN[GetPlayerId(ply)] + " votes for |cffffffffsurrender|r"
        set udg_GameSurrendingValue[k] = true
        if IsPlayerInForce(ply, udg_TeamA) then
            set udg_GameSurrenderTeamValue[0] = udg_GameSurrenderTeamValue[0] + 1
            set msg = msg + "|cffffffff, Hakurei votes: " + I2S(udg_GameSurrenderTeamValue[0]) + "|r"
            call BroadcastMessage(msg)
            if udg_GameSurrenderTeamValue[0] >= udg_GameSurrenderTeamValue[3] * 0.7 then
                call BroadcastMessage("|cFFFFFFFFHakurei Shrine surrenders!|r")
                call KillUnit(udg_BaseA[0])
            endif
        elseif IsPlayerInForce(ply, udg_TeamB) then
            set udg_GameSurrenderTeamValue[1] = udg_GameSurrenderTeamValue[1] + 1
            set msg = msg + "|cffffffff, Moriya votes: " + I2S(udg_GameSurrenderTeamValue[1]) + "|r"
            call BroadcastMessage(msg)
            if udg_GameSurrenderTeamValue[1] >= udg_GameSurrenderTeamValue[4] * 0.7 then
                call BroadcastMessage("|cFFFFFFFFMoriya Shrine surrenders!|r")
                call KillUnit(udg_BaseB[0])
            endif
        endif
    endif
    set msg = null
endfunction

function InitTrig_Misc takes nothing returns nothing
endfunction