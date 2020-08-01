function Check_MugetsuEX takes nothing returns boolean
    local integer i
    local unit u
    local boolean b
    set i = 0
    if udg_SK_MugetsuEX == false then
        set u = null
        return false
    endif
    loop
    exitwhen i > 11
        set u = udg_PlayerHeroes[i]
        if u != null then
            set b = IsUnitAlly(u, udg_SK_MugetsuEXP)
            if b == false then
                if GetWidgetLife(u) > 0.405 then
                    set u = null
                    return false
                endif
            endif
        endif
        set i = i + 1
    endloop
    set u = null
    return true
endfunction

function MugetsuEX_Effect_End takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local timerdialog w = LoadTimerDialogHandle(udg_ht, task, 2)
    call TimerDialogDisplay(w, false)
    call DestroyTimerDialog(w)
    set udg_MugetsuEx_InEffect = false
    call BroadcastMessage("Dream rune 'The ending of the dream'")
    call ReleaseTimer(t)
    call DestroyTimerDialog(w)
    call FlushChildHashtable(udg_ht, task)
endfunction

function MugetsuEX_Effect takes nothing returns nothing
    local timer t
    local timerdialog w
    local integer task
    if Check_MugetsuEX() and udg_MugetsuEx_InEffect == false then
        set udg_MugetsuEx_InEffect = true
        call BroadcastMessage("Dream rune 'End of Dream' takes effect")
        set t = CreateTimer()
        set task = GetHandleId(t)
        set w = CreateTimerDialog(t)
        call TimerDialogSetTitle(w, "Dream rune 'Final Countdown'")
        call TimerDialogDisplay(w, true)
        call SaveTimerHandle(udg_ht, task, 1, t)
        call SaveTimerDialogHandle(udg_ht, task, 2, w)
        call TimerStart(t, 600, false, function MugetsuEX_Effect_End)
        set w = null
        set t = null
    endif
endfunction

function Trig_Hero_Event_Conditions takes nothing returns boolean
    return IsUnitType(GetTriggerUnit(), UNIT_TYPE_HERO)
endfunction

function HeroRevive_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local integer cost = LoadInteger(udg_Hashtable, task, 0)
    local integer i = LoadInteger(udg_Hashtable, task, 1)
    local unit h = LoadUnitHandle(udg_Hashtable, task, 0)
    if udg_smodestat and GetPlayerSlotState(GetOwningPlayer(h)) == PLAYER_SLOT_STATE_LEFT then
        call FlushTimer_WW(t)
        set t = null
        set h = null
        return
    endif
    if IsUnitDead(h) == false then
        call FlushTimer_WW(t)
    elseif cost > 0 then
        call SaveInteger(udg_Hashtable, task, 0, cost - 1)
        call SaveInteger(udg_Hashtable, task, 1, i + 1)
        if IsUnitOwnedByPlayer(h, GetLocalPlayer()) then
            set udg_TimeStringReviveTimer = "Revive in " + I2S(cost) + " sec || "
        endif
        call MultiboardSetTitleText(udg_GIB, udg_TimeStringReviveTimer + udg_TimeStringAfterBattleBegin)
        call GIB_SetPlayerField(GetOwningPlayer(h), 5, "	" + I2S(cost))
        if i == 4 then
            call System_Hero_SetHeroOnRevivalLocation_WW(h, false, false)
        endif
    else
        call SaveBoolean(udg_Hashtable_UnitStatus, GetHandleId(h), StringHash("IsNormalRevival"), true)
        call System_Hero_SetHeroOnRevivalLocation_WW(h, true, true)
        call FlushTimer_WW(t)
    endif
    set t = null
    set h = null
endfunction

function HeroRevive_FirstTimeUpdate takes nothing returns nothing
    call HeroRevive_Main()
    call PauseTimer(GetExpiredTimer())
    call TimerStart(GetExpiredTimer(), 1, true, function HeroRevive_Main)
endfunction

function Trig_Hero_Event_Actions takes nothing returns nothing
    local unit killer = GetKillingUnit()
    local unit dead = GetPlayerCharacter(GetOwningPlayer(GetTriggerUnit()))
    local player winner = GetOwningPlayer(killer)
    local player loser = GetOwningPlayer(dead)
    local real cost = udg_ReviveTime[0] + udg_ReviveTime[1] * GetHeroLevel(dead)
    local boolean refresh = false
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local integer i = 0
    local integer tmp
    if udg_GameMode / 100 == 3 then
        if udg_GameTime > 30 * 60 then
            set cost = cost + (udg_GameTime / 60 - 30) * 1.0
        endif
    else
        if udg_GameTime > 45 * 60 then
            set cost = cost + (udg_GameTime / 60 - 45) * 1.0
        endif
    endif
    set i = 0
    if GetUnitTypeId(killer) == 'E011' then
        call TSU_DestroyEffect(1.0, AddSpecialEffect("Koishi04.mdl", GetUnitX(dead), GetUnitY(dead)))
    else
        call CreateUnit(loser, 'n01J', GetUnitX(dead), GetUnitY(dead), 270.0)
    endif
    if GetUnitAbilityLevel(GetPlayerCharacter(loser), 'A0MS') != 0 then
        set refresh = true
    else
        set refresh = AnnounceHeroBonus(killer, dead)
    endif
    set cost = cost + udg_HeroRevivePenalty[GetPlayerId(loser)]
    if udg_smodestat then
        set cost = 5
    endif
    call MugetsuEX_Effect()
    if udg_GameMode / 100 != 3 then
        if GetUnitTypeId(dead) == 'E01A' then
            set cost = cost - 15
            if cost < 5 then
                set cost = 5
            endif
        elseif GetUnitTypeId(dead) == 'E01B' then
            set cost = cost * 0.75
        elseif GetUnitAbilityLevel(dead, 'A11F') >= 1 then
            set cost = cost - 15
        endif
    endif
    if udg_GameModeIsTurbo then
        set cost = cost * 0.85
    endif
    if udg_GameMode / 100 == 3 then
        set cost = cost * 0.75
    else
        if YDWEUnitHasItemOfTypeBJNull(dead, 'I07J') then
            set cost = cost * 0.75
        endif
        if YDWEUnitHasItemOfTypeBJNull(dead, 'I08Q') then
            set cost = cost * 0.75
            call UnitBuffTarget(dead, dead, 240 + cost, 'A196', 0)
        endif
        if YDWEUnitHasItemOfTypeBJNull(dead, 'I00C') then
            set cost = cost * 0.75
        endif
    endif
    if cost < 5 then
        set cost = 5
    endif
    call DebugMsg("Revive Time Penalty " + R2S(udg_HeroRevivePenalty[GetPlayerId(loser)]))
    if IsUnitAlly(dead, GetLocalPlayer()) then
        if udg_SE_Stat[GetPlayerId(GetLocalPlayer())] then
            call StartSound(udg_SE_MISS)
        endif
    else
        if udg_SE_Stat[GetPlayerId(GetLocalPlayer())] then
            call StartSound(udg_SE_Kill)
        endif
    endif
    call GIB_SetPlayerField(loser, 3, I2S(udg_FlagDeath[GetPlayerId(loser)]))
    if refresh then
        call GIB_SetPlayerField(winner, 2, I2S(udg_FlagKill[GetPlayerId(winner)]))
        if IsPlayerInForce(winner, udg_TeamA) or winner == udg_PlayerA[0] then
            call GIB_SetPlayerField(udg_PlayerA[0], 2, "|cffffcc00" + I2S(udg_FlagKill[5]) + "|r")
        elseif IsPlayerInForce(winner, udg_TeamB) or winner == udg_PlayerB[0] then
            call GIB_SetPlayerField(udg_PlayerB[0], 2, "|cffffcc00" + I2S(udg_FlagKill[11]) + "|r")
        endif
    endif
    call SaveUnitHandle(udg_Hashtable, task, 0, dead)
    if cost == I2R(R2I(cost)) then
        call SaveInteger(udg_Hashtable, task, 0, R2I(cost))
        call SaveInteger(udg_Hashtable, task, 1, 1)
    else
        call SaveInteger(udg_Hashtable, task, 0, R2I(cost) + 1)
        call SaveInteger(udg_Hashtable, task, 1, 0)
    endif
    call TimerStart(t, cost - I2R(R2I(cost)), false, function HeroRevive_FirstTimeUpdate)
    if udg_GameMode / 100 == 2 then
        if IsPlayerInForce(loser, udg_TeamB) then
            set udg_GIB_PlayerScoreForSolo[0] = udg_GIB_PlayerScoreForSolo[0] + 1
            call BroadcastMessage("|cFFFF0000Hakurei has scored 1 point||r, current score: " + I2S(udg_GIB_PlayerScoreForSolo[0]) + "(Hakurei) " + I2S(udg_GIB_PlayerScoreForSolo[1]) + "(Moriya)")
        else
            set udg_GIB_PlayerScoreForSolo[1] = udg_GIB_PlayerScoreForSolo[1] + 1
            call BroadcastMessage("|cFF00FF00Moriya has scored 1 point||r, current score: " + I2S(udg_GIB_PlayerScoreForSolo[0]) + "(Hakurei) " + I2S(udg_GIB_PlayerScoreForSolo[1]) + "(Moriya)")
        endif
        call Trig_SoloMode_CountingWinLose()
    endif
    if GetUnitAbilityLevel(dead, 'A1A4') != 0 then
        set tmp = GetRandomInt(1, 6)
        if tmp == 1 then
            call BroadcastMessageFriend("Ally: " + udg_PN[GetPlayerId(GetOwningPlayer(dead))] + " Hey, care about QwQ", loser)
        elseif tmp == 2 then
            call BroadcastMessageFriend("Ally: " + udg_PN[GetPlayerId(GetOwningPlayer(dead))] + " I feel like I can kill TvT", loser)
        elseif tmp == 3 then
            call BroadcastMessageFriend("Ally: " + udg_PN[GetPlayerId(GetOwningPlayer(dead))] + " R.I.P.", loser)
        elseif tmp == 4 then
            call BroadcastMessageFriend("Ally: " + udg_PN[GetPlayerId(GetOwningPlayer(dead))] + " Sorry this teammate has QAQ", loser)
        elseif tmp == 5 then
            call BroadcastMessageFriend("Ally: " + udg_PN[GetPlayerId(GetOwningPlayer(dead))] + " Although it has failed now, the victory still belongs to us!", loser)
        elseif tmp == 6 then
            call BroadcastMessageFriend("Ally: " + udg_PN[GetPlayerId(GetOwningPlayer(dead))] + " Don't be discouraged, we'll fight the opposite wave again in a moment!", loser)
        endif
    endif
    set loser = null
    set winner = null
    set killer = null
    set dead = null
    set t = null
endfunction

function InitTrig_Hero_Event takes nothing returns nothing
    set gg_trg_Hero_Event = CreateTrigger()
    call TriggerAddCondition(gg_trg_Hero_Event, Condition(function Trig_Hero_Event_Conditions))
    call TriggerAddAction(gg_trg_Hero_Event, function Trig_Hero_Event_Actions)
endfunction