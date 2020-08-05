function Trig_FunctionedWin takes nothing returns nothing
    local integer i
    local integer n
    local integer high = 0
    local unit u
    local integer rid
    set i = 0
    loop
    exitwhen i > 12
        set u = udg_PlayerHeroes[i]
        if u != null then
            set rid = GetPlayerId(GetOwningPlayer(u))
            if udg_smode_jc[rid] > high then
                set n = i
                set high = udg_smode_jc[rid]
            endif
        endif
        set i = i + 1
    endloop
    set i = n
    set u = udg_PlayerHeroes[i]
    call YDWEPauseAllUnitsBJNull(true)
    call FogEnable(false)
    call SetCameraTargetController(u, 0, 0, false)
    call DisplayTimedTextToForce(GetPlayersAll(), 60.0, udg_PN[GetPlayerId(GetOwningPlayer(u))] + " is the last winner of ginseng!")
    set u = null
endfunction

function JieCao_RandomWarp takes unit caster returns nothing
    local integer t = GetRandomInt(1, 7)
    if udg_GameMode / 100 != 3 then
        if t == 1 then
            call SetUnitX(caster, GetRectCenterX(gg_rct_RunesTeleport01))
            call SetUnitY(caster, GetRectCenterY(gg_rct_RunesTeleport01))
        elseif t == 2 then
            call SetUnitX(caster, GetRectCenterX(gg_rct_RunesTeleport02))
            call SetUnitY(caster, GetRectCenterY(gg_rct_RunesTeleport02))
        elseif t == 3 then
            call SetUnitX(caster, GetRectCenterX(gg_rct_RunesTeleport03))
            call SetUnitY(caster, GetRectCenterY(gg_rct_RunesTeleport03))
        elseif t == 4 then
            call SetUnitX(caster, GetRectCenterX(gg_rct_RunesTeleport04))
            call SetUnitY(caster, GetRectCenterY(gg_rct_RunesTeleport04))
        elseif t == 5 then
            call SetUnitX(caster, GetRectCenterX(gg_rct_RunesTeleport05))
            call SetUnitY(caster, GetRectCenterY(gg_rct_RunesTeleport05))
        elseif t == 6 then
            call SetUnitX(caster, GetRectCenterX(gg_rct_RunesTeleport06))
            call SetUnitY(caster, GetRectCenterY(gg_rct_RunesTeleport06))
        elseif t == 7 then
            call SetUnitX(caster, GetRectCenterX(gg_rct_RunesTeleport07))
            call SetUnitY(caster, GetRectCenterY(gg_rct_RunesTeleport07))
        endif
    else
        if t == 1 then
            call SetUnitX(caster, GetRectCenterX(gg_rct_Rune01_C))
            call SetUnitY(caster, GetRectCenterY(gg_rct_Rune01_C))
        elseif t == 2 then
            call SetUnitX(caster, GetRectCenterX(gg_rct_Rune02_C))
            call SetUnitY(caster, GetRectCenterY(gg_rct_Rune02_C))
        elseif t == 3 then
            call SetUnitX(caster, GetRectCenterX(gg_rct_Rune03_C))
            call SetUnitY(caster, GetRectCenterY(gg_rct_Rune03_C))
        elseif t == 4 then
            call SetUnitX(caster, GetRectCenterX(gg_rct_Rune04_C))
            call SetUnitY(caster, GetRectCenterY(gg_rct_Rune04_C))
        elseif t == 5 then
            call SetUnitX(caster, GetRectCenterX(gg_rct_Rune05_C))
            call SetUnitY(caster, GetRectCenterY(gg_rct_Rune05_C))
        elseif t == 6 then
            call SetUnitX(caster, GetRectCenterX(gg_rct_Rune06_C))
            call SetUnitY(caster, GetRectCenterY(gg_rct_Rune06_C))
        elseif t == 7 then
            call SetUnitX(caster, GetRectCenterX(gg_rct_Rune07_C))
            call SetUnitY(caster, GetRectCenterY(gg_rct_Rune07_C))
        endif
    endif
endfunction

function Trig_JieCao takes nothing returns nothing
    local unit u
    local integer i
    local integer level
    local integer rid
    set i = 0
    if R2I((udg_GameTime + 10) / 120) * 120 == udg_GameTime + 10 then
        call BroadcastMessage("After 10 seconds girls will be randomly teleported all over the map")
    endif
    if R2I(udg_GameTime / 120) * 120 == udg_GameTime then
        call BroadcastMessage("Random teleports have been activated")
    endif
    loop
        set u = udg_PlayerHeroes[i]
        if u != null then
            set rid = GetPlayerId(GetOwningPlayer(u))
            if GetPlayerSlotState(GetOwningPlayer(u)) == PLAYER_SLOT_STATE_LEFT and udg_smode_jc[rid] > 0 then
                set udg_smode_jc[rid] = udg_smode_jc[rid] - 75
            endif
            set udg_smode_jc[rid] = udg_smode_jc[rid] + 4
            if udg_GameTime >= udg_smode_EndTime then
                call Trig_FunctionedWin()
                call PauseTimer(GetExpiredTimer())
            endif
            if R2I(udg_GameTime / 120) * 120 == udg_GameTime then
                call JieCao_RandomWarp(u)
            endif
            if udg_smode_jc[rid] > 3200 then
                call PauseTimer(GetExpiredTimer())
                call YDWEPauseAllUnitsBJNull(true)
                call FogEnable(false)
                call SetCameraTargetController(u, 0, 0, false)
                call DisplayTimedTextToForce(GetPlayersAll(), 60.0, udg_PN[GetPlayerId(GetOwningPlayer(u))] + " is the last winner of ginseng!")
            endif
            if udg_GameMode / 100 == 3 then
                call AddHeroXP(u, 130, true)
            endif
            set level = 1
            if udg_smode_jc[rid] < 500 then
                set level = 1
            elseif udg_smode_jc[rid] < 1000 then
                set level = 2
            elseif udg_smode_jc[rid] < 2000 then
                set level = 3
            elseif udg_smode_jc[rid] < 2500 then
                set level = 4
            else
                set level = 5
            endif
            if u == udg_smode_jcu then
                if GetUnitAbilityLevel(u, 'A1AQ') == 0 then
                    call UnitAddAbility(u, 'A1AQ')
                    call UnitMakeAbilityPermanent(u, true, 'A08U')
                endif
                set level = level + 1
                set udg_smode_jc[rid] = udg_smode_jc[rid] + 4
                call PingMinimap(GetUnitX(udg_smode_jcu), GetUnitY(udg_smode_jcu), 2.0)
            else
                if GetUnitAbilityLevel(u, 'A1AQ') != 0 then
                    call UnitRemoveAbility(u, 'A1AQ')
                endif
            endif
            call GIB_SetPlayerField(GetOwningPlayer(u), 4, I2S(udg_smode_jc[rid]))
            call GIB_SetPlayerField(GetOwningPlayer(u), 3, I2S(level))
            call SetUnitMoveSpeed(u, 522.0 - 50 * level)
        endif
        set i = i + 1
    exitwhen i >= 12
    endloop
    set u = null
endfunction

function Trig_SModeInit_Actions takes nothing returns nothing
    set udg_smodestat = true
endfunction

function Trig_SModeInit takes nothing returns nothing
    local timer et = GetExpiredTimer()
    local integer j
    local integer i = 1
    local integer t
    local unit u
    local unit caster
    local string s
    call ReleaseTimer(et)
    set et = null
    set udg_smodestat = true
    call DebugMsg("FirstPartTestOK")
    if GetLocalPlayer() == udg_PlayerA[0] or GetLocalPlayer() == udg_PlayerB[0] then
    endif
    call DestroyTrigger(gg_trg_Victory)
    call DestroyTrigger(gg_trg_Share)
    call DestroyTrigger(GetTriggeringTrigger())
    call DestroyTrigger(gg_trg_Tower_Break_A)
    call DestroyTrigger(gg_trg_Tower_Break_A_Patch)
    call DestroyTrigger(gg_trg_Tower_Break_B)
    call DestroyTrigger(gg_trg_Tower_Break_B_Patch)
    call KillUnit(gg_unit_n023_0006)
    call KillUnit(gg_unit_n03O_0079)
    call CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE), 'nfoh', 5574.0, -10195.0, bj_UNIT_FACING)
    call CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE), 'nfoh', 9299.9, -14824.0, bj_UNIT_FACING)
    call CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE), 'nmoo', 12193.0, -11092.0, bj_UNIT_FACING)
    call CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE), 'nmoo', 1294.0, -7865.0, bj_UNIT_FACING)
    call CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE), 'nfoh', 17156.9, -6358.0, bj_UNIT_FACING)
    call CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE), 'nfoh', 17163.0, -13868.0, bj_UNIT_FACING)
    call CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE), 'nmoo', 18593, -5852.0, bj_UNIT_FACING)
    call CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE), 'nmoo', 15620.0, -14576.0, bj_UNIT_FACING)
    call KillUnit(gg_unit_n050_0161)
    call KillUnit(gg_unit_n04Y_0159)
    call DebugMsg("FirstPartTestOK")
    loop
    exitwhen i >= 13
        call KillUnit(udg_BaseA[i])
        call KillUnit(udg_BaseB[i])
        set j = 1
        loop
        exitwhen j >= 16
            if j != i then
                call SetPlayerAllianceStateBJ(ConvertedPlayer(i), ConvertedPlayer(j), bj_ALLIANCE_UNALLIED)
            endif
            set j = j + 1
        endloop
        if GetPlayerCharacter(ConvertedPlayer(i)) != null then
            set udg_smode_jcu = GetPlayerCharacter(ConvertedPlayer(i))
            call SetPlayerAlliance(ConvertedPlayer(i), udg_PlayerA[0], ALLIANCE_SHARED_VISION, true)
            call SetPlayerAlliance(ConvertedPlayer(i), udg_PlayerB[0], ALLIANCE_SHARED_VISION, true)
            call UnitAddItem(GetPlayerCharacter(ConvertedPlayer(i)), CreateItem('crys', 0, 0))
            set t = GetRandomInt(1, 7)
            set caster = udg_smode_jcu
            if udg_GameMode / 100 != 3 then
                call SetHeroLevel(caster, 4, true)
            endif
            call JieCao_RandomWarp(caster)
            call THD_AddCredit(GetOwningPlayer(caster), 1000)
            set u = CreateUnit(ConvertedPlayer(i), 'h00I', GetUnitX(udg_smode_jcu), GetUnitY(udg_smode_jcu), 0)
            call SetUnitInvulnerable(u, true)
        endif
        call SetPlayerHandicapXP(ConvertedPlayer(i), 2)
        set i = i + 1
    endloop
    call DebugMsg("FirstPartTestOK")
    set j = 0
    call TimerStart(udg_smode_timer, 10, true, function Trig_JieCao)
    call DisplayTimedTextToForce(GetPlayersAll(), 20.0, "Experimental project: Utopia Mode successfully launched, please pay attention to the F9 taskbar for a detailed description of Utopia.|nI don’t know if such game mode is what you want.")
    set s = ""
    set s = s + "Explanation: In a world that has become a Utopia, girls often play games in which they fight against each other|n"
    set s = s + "If another girl defeats you, you lose 1/3 of the Integrity score|n"
    set s = s + "Defeating another girl gives 1/3 Integrity score and an additional 250 Integrity score. Additional reward: (Integrity score * 3) money points.|n"
    set s = s + "Every player will get 5 Integrity score every 10 seconds, the one who holds the Integrity score aura gets 35 Integrity score|n"
    set s = s + "In Utopia, each girl is assigned a different Integrity Level because of the number of Integrity score she holds.|n"
    set s = s + "Integrity Level: Affects all girl damage and her summons, and her movement speed.|n"
    set s = s + "LV1: Damage+30% Basic movement speed: 450     Integrity score: 0-699|n"
    set s = s + "LV2: Damage+15% Basic movement speed: 400     Integrity score: 700-999|n"
    set s = s + "LV3: Damage+0% Basic movement speed: 350       Integrity score: 1000-1999|n"
    set s = s + "LV4: Damage-15% Basic movement speed: 300      Integrity score: 2000-2699|n"
    set s = s + "LV5: Damage-30% Basic movement speed: 250      Integrity score: 2700+|n"
    set s = s + "LV6: Damage-40% Basic movement speed: 200|n"
    set s = s + "When a girl gets a 3200 Integrity score, that girl will become Player of the Game|n"
    set s = s + "When the game time reaches 30 minutes, the girl with the highest Integrity score will also become the Player of the Game|n"
    set s = s + "In Utopia mode, the neutral creep spawn cycle is halved, the girl's experience is doubled, and after death girls will rebirth at a random location.|n"
    call BroadcastMessage(s)
    set u = null
    set caster = null
endfunction

function InitTrig_SModeInit takes nothing returns nothing
endfunction 