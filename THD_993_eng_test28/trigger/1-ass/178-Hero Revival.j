function System_Hero_SetHeroOnRevivalLocation_WW takes unit hero, boolean reviveAtTheSameTime, boolean doEyeCandy returns nothing
    local real x
    local real y
    local integer i
    if IsUnitAlly(hero, udg_PlayerA[0]) then
        set x = GetLocationX(udg_RevivePoint[0])
        set y = GetLocationY(udg_RevivePoint[0])
    elseif IsUnitAlly(hero, udg_PlayerB[0]) then
        set x = GetLocationX(udg_RevivePoint[1])
        set y = GetLocationY(udg_RevivePoint[1])
    else
        set x = 3500.0
        set y = 1500.0
    endif
    if udg_smodestat then
        set i = GetRandomInt(1, 7)
        if udg_GameMode / 100 != 3 then
            if i == 1 then
                set x = GetRectCenterX(gg_rct_RunesTeleport01)
                set y = GetRectCenterY(gg_rct_RunesTeleport01)
            elseif i == 2 then
                set x = GetRectCenterX(gg_rct_RunesTeleport02)
                set y = GetRectCenterY(gg_rct_RunesTeleport02)
            elseif i == 3 then
                set x = GetRectCenterX(gg_rct_RunesTeleport03)
                set y = GetRectCenterY(gg_rct_RunesTeleport03)
            elseif i == 4 then
                set x = GetRectCenterX(gg_rct_RunesTeleport04)
                set y = GetRectCenterY(gg_rct_RunesTeleport04)
            elseif i == 5 then
                set x = GetRectCenterX(gg_rct_RunesTeleport05)
                set y = GetRectCenterY(gg_rct_RunesTeleport05)
            elseif i == 6 then
                set x = GetRectCenterX(gg_rct_RunesTeleport06)
                set y = GetRectCenterY(gg_rct_RunesTeleport06)
            elseif i == 7 then
                set x = GetRectCenterX(gg_rct_RunesTeleport07)
                set y = GetRectCenterY(gg_rct_RunesTeleport07)
            endif
        else
            if i == 1 then
                set x = GetRectCenterX(gg_rct_Rune01_C)
                set y = GetRectCenterY(gg_rct_Rune01_C)
            elseif i == 2 then
                set x = GetRectCenterX(gg_rct_Rune02_C)
                set y = GetRectCenterY(gg_rct_Rune02_C)
            elseif i == 3 then
                set x = GetRectCenterX(gg_rct_Rune03_C)
                set y = GetRectCenterY(gg_rct_Rune03_C)
            elseif i == 4 then
                set x = GetRectCenterX(gg_rct_Rune04_C)
                set y = GetRectCenterY(gg_rct_Rune04_C)
            elseif i == 5 then
                set x = GetRectCenterX(gg_rct_Rune05_C)
                set y = GetRectCenterY(gg_rct_Rune05_C)
            elseif i == 6 then
                set x = GetRectCenterX(gg_rct_Rune06_C)
                set y = GetRectCenterY(gg_rct_Rune06_C)
            elseif i == 7 then
                set x = GetRectCenterX(gg_rct_Rune07_C)
                set y = GetRectCenterY(gg_rct_Rune07_C)
            endif
        endif
    endif
    call SetUnitX(hero, x)
    call SetUnitY(hero, y)
    if reviveAtTheSameTime then
        call ReviveHero(hero, x, y, doEyeCandy)
    endif
endfunction

function Hero_Reset takes unit hero returns nothing
    call ClearAllNegativeBuff(hero, true)
    call SetUnitInvulnerable(hero, false)
    call PauseUnit(hero, false)
    call ShowUnit(hero, true)
    call SetUnitMoveSpeed(hero, GetUnitDefaultMoveSpeed(hero))
    if GetUnitAbilityLevel(hero, 'A1DV') != 0 then
        call SetUnitMoveSpeed(hero, GetUnitDefaultMoveSpeed(hero) + GetUnitAbilityLevel(hero, 'A1DV') * 5 + 15)
    endif
    call SetUnitFlyHeight(hero, GetUnitDefaultFlyHeight(hero), 1000.0)
    call SetUnitVertexColor(hero, 255, 255, 255, 255)
    call SetUnitTimeScale(hero, 1.0)
    call SetUnitUserData(hero, 0)
endfunction

function HeroReviveSTimer_Clear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit h = LoadUnitHandle(udg_Hashtable, task, 0)
    local sound snd = null
    call UnitAddAbility(udg_PlayerReviveHouse[GetPlayerId(GetOwningPlayer(h))], 'Arev')
    call UnitRemoveAbility(h, 'B092')
    set snd = CreateSound("THDots\\music\\"+udg_PlayerCharacterString[GetPlayerId(GetOwningPlayer(h))]+"Reborn0.0mp3",false,false,true,12700,12700,"DefaultEAXON")
    if snd != null then
        call SetSoundVolume(snd, 127)
        call StartSoundForPlayerBJ(GetOwningPlayer(h), snd)
        call KillSoundWhenDone(snd)
        set snd = null
    endif
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_Hashtable, task)
    set t = null
    set h = null
endfunction

function HeroReviveSTimer_Set takes nothing returns nothing
    local timer ti = GetExpiredTimer()
    local unit hero = LoadUnitHandle(udg_Hashtable, GetHandleId(ti), 0)
    local integer cd = 180 + IMaxBJ(udg_GameTime - udg_Game_BattleBeginTime, 0) / 10
    call UnitRemoveAbility(udg_PlayerReviveHouse[GetPlayerId(GetOwningPlayer(hero))], 'Arev')
    call PauseTimer(ti)
    call TimerStart(ti, cd, false, function HeroReviveSTimer_Clear)
    call BroadcastMessage(udg_PlayerColors[GetPlayerId(GetOwningPlayer(hero))] + GetHeroProperName(hero) + "|r has used buyback. Next buyback: |cffffcc00  " + GetTimeString_h_mM_SS_WW(IAbsBJ(udg_GameTime - udg_Game_BattleBeginTime + cd)) + "|r")
    set ti = null
    set hero = null
endfunction

function SetPlayerBuyBackCooldown_WW takes unit hero returns nothing
    local timer ti = CreateTimer()
    call SaveUnitHandle(udg_Hashtable, GetHandleId(ti), 0, hero)
    call TimerStart(ti, 0, false, function HeroReviveSTimer_Set)
    set ti = null
endfunction

function Trig_Hero_Revival_Conditions takes nothing returns boolean
    local unit hero = GetTriggerUnit()
    call GIB_SetPlayerField(GetOwningPlayer(hero), 5, "    -")
    if IsUnitOwnedByPlayer(hero, GetLocalPlayer()) then
        set udg_TimeStringReviveTimer = ""
        call MultiboardSetTitleText(udg_GIB, udg_TimeStringReviveTimer + udg_TimeStringAfterBattleBegin)
    endif
    if LoadBoolean(udg_Hashtable_UnitStatus, GetHandleId(hero), StringHash("IsAkyuExRevival")) then
        call DebugMsg("AkyuEx Revival")
        call SaveBoolean(udg_Hashtable_UnitStatus, GetHandleId(hero), StringHash("IsAkyuExRevival"), false)
    else
        if LoadBoolean(udg_Hashtable_UnitStatus, GetHandleId(hero), StringHash("IsNormalRevival")) then
            call DebugMsg("Normal Revival")
            call SaveBoolean(udg_Hashtable_UnitStatus, GetHandleId(hero), StringHash("IsNormalRevival"), false)
        else
            call DebugMsg("Buyback")
            call SetPlayerBuyBackCooldown_WW(hero)
        endif
        call System_Hero_SetHeroOnRevivalLocation_WW(hero, false, false)
        call SetUnitState(hero, UNIT_STATE_MANA, GetUnitState(hero, UNIT_STATE_MAX_MANA))
    endif
    if udg_SK_Akyu_Ghost != null and not IsUnitHidden(udg_SK_Akyu_Ghost) then
        call ShowUnit(udg_SK_Akyu_Ghost, false)
    endif
    call Hero_Reset(hero)
    call SetCameraPositionForPlayer(GetOwningPlayer(hero), GetUnitX(hero), GetUnitY(hero))
    if GetOwningPlayer(hero) == GetLocalPlayer() then
        call ClearSelection()
        call SelectUnit(hero, true)
    endif
    if udg_CameraState[GetPlayerId(GetOwningPlayer(hero))] == 1 then
        call CameraAdd(hero)
    endif
    if LoadReal(udg_ht, GetHandleId(GetOwningPlayer(hero)), StringHash("AREASHOW")) != 0 then
        call RegisterAreaShowPlayer(GetOwningPlayer(hero), hero, 'UTSB', LoadReal(udg_ht, GetHandleId(GetOwningPlayer(hero)), StringHash("AREASHOW")), R2I(LoadReal(udg_ht, GetHandleId(GetOwningPlayer(hero)), StringHash("AREASHOW")) * 3.1415 / 150) + 1, 0, "EnergyHands.mdl", 0.02)
    endif
    set hero = null
    return false
endfunction

function InitTrig_Hero_Revival takes nothing returns nothing
    set gg_trg_Hero_Revival = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Hero_Revival, EVENT_PLAYER_HERO_REVIVE_FINISH)
    call TriggerAddCondition(gg_trg_Hero_Revival, Condition(function Trig_Hero_Revival_Conditions))
endfunction