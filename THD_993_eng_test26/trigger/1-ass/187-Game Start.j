function TurboXP takes nothing returns nothing
    local integer i = 0
    loop
    exitwhen i == 65
        if udg_PlayerHeroes[i] != null then
            call AddHeroXP(udg_PlayerHeroes[i], 50, true)
        endif
        set i = i + 1
    endloop
endfunction

function Spawn_Start takes nothing returns nothing
    local timer t = GetExpiredTimer()
    call EnableTrigger(gg_trg_Spawn_A)
    call EnableTrigger(gg_trg_Spawn_B)
    call ReleaseTimer(t)
    if udg_GameModeIsTurbo then
        set t = CreateTimer()
        call TimerStart(t, 10.0, true, function TurboXP)
    endif
    set t = null
endfunction

function Utopian_Start takes nothing returns nothing
    local timer t = CreateTimer()
    call TimerStart(t, 10.0, false, function Trig_SModeInit)
    set t = null
endfunction

function Announce_Start takes nothing returns nothing
    local timer t = GetExpiredTimer()
    call Announce_Msg1()
    call TimerStart(t, 60.0, false, function Spawn_Start)
    set t = null
endfunction

function Trig_Game_Start_Actions takes nothing returns boolean
    local integer i = 0
    local timer t = CreateTimer()
    call CameraInit()
    call SetSkyModel("Environment\\Sky\\Sky\\SkyLight.mdl")
    call SetTimeOfDayScale(0.5)
    set udg_FlagFirst = true
    set udg_GameStart = true
    if udg_GameMode / 100 == 3 then
    endif
    loop
    exitwhen i > 5
        call SetPlayerState(udg_PlayerA[i], PLAYER_STATE_GIVES_BOUNTY, 1)
        call SetPlayerState(udg_PlayerB[i], PLAYER_STATE_GIVES_BOUNTY, 1)
        if i > 0 then
            set udg_PlayerPower[GetPlayerId(udg_PlayerA[i]) + 1] = udg_GameSetting_Power[0]
            set udg_PlayerPower[GetPlayerId(udg_PlayerB[i]) + 1] = udg_GameSetting_Power[0]
            call THD_AddCredit(udg_PlayerA[i], udg_GameSetting_Gold[0])
            call THD_AddCredit(udg_PlayerB[i], udg_GameSetting_Gold[0])
            call TriggerRegisterPlayerEvent(gg_trg_Player_Left, udg_PlayerA[i], EVENT_PLAYER_LEAVE)
            call TriggerRegisterPlayerEvent(gg_trg_Player_Left, udg_PlayerB[i], EVENT_PLAYER_LEAVE)
            call TriggerRegisterPlayerUnitEvent(gg_trg_Power_Get, udg_PlayerA[i], EVENT_PLAYER_UNIT_PICKUP_ITEM, null)
            call TriggerRegisterPlayerUnitEvent(gg_trg_Power_Lost, udg_PlayerA[i], EVENT_PLAYER_UNIT_DEATH, null)
            call TriggerRegisterPlayerUnitEvent(gg_trg_Hero_Event, udg_PlayerA[i], EVENT_PLAYER_UNIT_DEATH, null)
            call TriggerRegisterPlayerUnitEvent(gg_trg_Power_Get, udg_PlayerB[i], EVENT_PLAYER_UNIT_PICKUP_ITEM, null)
            call TriggerRegisterPlayerUnitEvent(gg_trg_Power_Lost, udg_PlayerB[i], EVENT_PLAYER_UNIT_DEATH, null)
            call TriggerRegisterPlayerUnitEvent(gg_trg_Hero_Event, udg_PlayerB[i], EVENT_PLAYER_UNIT_DEATH, null)
        endif
        set i = i + 1
    endloop
    call SetPlayerState(udg_SpawnPlayer[0], PLAYER_STATE_GIVES_BOUNTY, 1)
    call SetPlayerState(udg_SpawnPlayer[1], PLAYER_STATE_GIVES_BOUNTY, 1)
    set udg_ScoreSpirit[5] = udg_GameSetting_Spirit[0]
    set udg_ScoreSpirit[11] = udg_GameSetting_Spirit[0]
    call Trig_Setup_Game_Info_Board_Actions()
    call Trig_Spawn_Units_AI_Init()
    call TriggerRegisterTimerEvent(gg_trg_Time_Event, 1.0, true)
    if udg_smodestat then
        call TriggerRegisterTimerEvent(gg_trg_RuneBorn, 60.0, true)
    else
        call TriggerRegisterTimerEvent(gg_trg_RuneBorn, 120.0, true)
    endif
    call TriggerRegisterTimerEvent(gg_trg_Refresh_Order, 57.0, true)
    call TriggerRegisterTimerEvent(gg_trg_Spawn_A, 30.0, true)
    call TriggerRegisterTimerEvent(gg_trg_Spawn_B, 30.0, true)
    if udg_GameModeIsTurbo then
        call TriggerRegisterTimerEvent(gg_trg_Spawn_Levelup, 120.0, true)
    else
        call TriggerRegisterTimerEvent(gg_trg_Spawn_Levelup, 180.0, true)
    endif
    call TriggerExecute(gg_trg_Route_Order)
    call DisableTrigger(gg_trg_Spawn_B)
    call DisableTrigger(gg_trg_Spawn_A)
    call TriggerRegisterPlayerUnitEvent(gg_trg_Keep_Order_A, udg_SpawnPlayer[0], EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER, null)
    call TriggerRegisterPlayerUnitEvent(gg_trg_Keep_Order_B, udg_SpawnPlayer[1], EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER, null)
    call Trig_Neutral_System_Init()
    call TriggerRegisterPlayerUnitEvent(gg_trg_Point_Creat, udg_SpawnPlayer[0], EVENT_PLAYER_UNIT_DEATH, null)
    call TriggerRegisterPlayerUnitEvent(gg_trg_Point_Creat, udg_SpawnPlayer[1], EVENT_PLAYER_UNIT_DEATH, null)
    call TriggerRegisterUnitEvent(gg_trg_Victory, udg_BaseA[0], EVENT_UNIT_DEATH)
    call TriggerRegisterUnitEvent(gg_trg_Victory, udg_BaseB[0], EVENT_UNIT_DEATH)
    call ConditionalTriggerExecute(gg_trg_AI_Init)
    call EndThematicMusic()
    call ResumeMusic()
    call Trig_Regeneration_Actions()
    if udg_NewMid then
        set udg_GameSetting_Gold_A = 40
        set udg_GameSetting_Gold_B = 40
        set udg_SU_No_A[0] = 10
        set udg_SU_No_A[1] = 3
        set udg_SU_No_A[2] = 3
        set udg_SU_No_B[0] = 10
        set udg_SU_No_B[1] = 3
        set udg_SU_No_B[2] = 3
    endif
    if udg_GameMode / 100 == 3 then
        set udg_SU_No_A[0] = 4
        set udg_SU_No_A[1] = 1
        set udg_SU_No_A[2] = 1
        set udg_SU_No_B[0] = 4
        set udg_SU_No_B[1] = 1
        set udg_SU_No_B[2] = 1
        call Jump_Init(gg_rct_Jump9top, gg_rct_Jump9bot)
        call Jump_Init(gg_rct_Jump10top, gg_rct_Jump10bot)
        call Jump_Init(gg_rct_Jump11top, gg_rct_Jump11bot)
        call Jump_Init(gg_rct_Jump12top, gg_rct_Jump12bot)
        call Jump_Init(gg_rct_Jump13top, gg_rct_Jump13bot)
        call Jump_Init(gg_rct_Jump14top, gg_rct_Jump14bot)
        call AddUnitToStockBJ('e03E', udg_BaseA[0], 0, 1)
        call AddUnitToStockBJ('e03F', udg_BaseA[0], 0, 1)
        call AddUnitToStockBJ('e03E', udg_BaseB[0], 0, 1)
        call AddUnitToStockBJ('e03F', udg_BaseB[0], 0, 1)
        call AddUnitToStockBJ('n04X', udg_BaseA[0], 1, 1)
        call AddUnitToStockBJ('n04X', udg_BaseA[1], 1, 1)
        call AddUnitToStockBJ('n04X', udg_BaseA[2], 1, 1)
        call AddUnitToStockBJ('n04X', udg_BaseA[6], 1, 1)
        call AddUnitToStockBJ('n04X', udg_BaseA[8], 1, 1)
        call AddUnitToStockBJ('n04X', udg_BaseB[0], 1, 1)
        call AddUnitToStockBJ('n04X', udg_BaseB[1], 1, 1)
        call AddUnitToStockBJ('n04X', udg_BaseB[2], 1, 1)
        call AddUnitToStockBJ('n04X', udg_BaseB[6], 1, 1)
        call AddUnitToStockBJ('n04X', udg_BaseB[8], 1, 1)
        call TriggerExecute(gg_trg_TowerAbility)
    else
        call TriggerExecute(gg_trg_CenterData_Deletion)
    endif
    call TriggerExecute(gg_trg_Shanghai_Life)
    call TriggerExecute(gg_trg_Init_DamageUnit)
    call TriggerExecute(gg_trg_WeatherMain)
    call TriggerExecute(gg_trg_Initialization_Defence)
    if udg_GameMode / 100 == 3 or udg_NewMid then
        set udg_GameSetting_Spirit[3] = 100
        set udg_GameSetting_Spirit[4] = 100
        set udg_GameSetting_Spirit[5] = 100
    endif
    call TimerStart(t, 20.0, false, function Announce_Start)
    if udg_smodestat then
        call Utopian_Start()
    endif
    call ClearMapMusic()
    call SetMapMusicIndexedBJ(udg_DefaultBGM, 0)
    set t = null
    set i = 0
    loop
    exitwhen i > 15
        set udg_FlagFarm[i] = 0
        set i = i + 1
    endloop
    call Stat_Init()
    return false
endfunction

function InitTrig_Game_Start takes nothing returns nothing
    set gg_trg_Game_Start = CreateTrigger()
    call TriggerAddCondition(gg_trg_Game_Start, Condition(function Trig_Game_Start_Actions))
endfunction