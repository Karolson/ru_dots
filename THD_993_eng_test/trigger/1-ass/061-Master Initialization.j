function Trig_Master_InitializationFunc017A takes nothing returns nothing
    call SetCameraBoundsToRectForPlayerBJ(GetEnumPlayer(), udg_MapRegion)
endfunction

function Trig_Master_InitializationActions takes nothing returns nothing
    set udg_MapRegion = Rect(-2112.0, -18432.0, 14432.0, -2048.0)
    set udg_MapRegionScreen = Rect(-9000.0, -18432.0, -2304.0, -2048.0)
    set udg_DefaultBGM = "THDots\\music\\LoadingBgm.mp3"
    call SetMapFlag(MAP_OBSERVERS_ON_DEATH, true)
    call SetMapFlag(MAP_LOCK_ALLIANCE_CHANGES, true)
    call SetGameSpeed(MAP_SPEED_FASTEST)
    call LockGameSpeedBJ()
    call FogEnable(true)
    call FogMaskEnable(true)
    call MeleeStartingVisibility()
    call SetSkyModel("Environment\\Sky\\LordaeronFallSky\\LordaeronFallSky.mdl")
    set udg_DebugMode = false
    set udg_TestMode = false
    call ForForce(GetPlayersAll(), function Trig_Master_InitializationFunc017A)
    set udg_ShiftPlayer = true
    call TriggerExecute(gg_trg_Initialization_Players)
    call TriggerExecute(gg_trg_Initialization_Locations)
    call TriggerExecute(gg_trg_Initialization_Market)
    call TriggerExecute(gg_trg_Initialization_CE)
    call TriggerExecute(gg_trg_Setting_Balance)
    call TriggerExecute(gg_trg_Setting_Character_A)
    call TriggerExecute(gg_trg_Setting_Character_B)
    call TriggerExecute(gg_trg_Setting_Character_C)
    call TriggerExecute(gg_trg_Setting_Item_System_Table_1)
    call Trig_Setting_Item_Database_Actions()
    call TriggerExecute(gg_trg_Setting_Neutrals)
    call TriggerExecute(gg_trg_Setting_Spawn)
    call TriggerExecute(gg_trg_About_Map)
    call TriggerExecute(gg_trg_Initialization_CMD)
    call TriggerExecute(gg_trg_Initialization_Spawn)
    call TriggerExecute(gg_trg_Initialization_Base)
    call TriggerExecute(gg_trg_Initialization_AI)
    call System_Announce_OriginalAuthor()
    call TriggerRegisterTimerEventSingle(gg_trg_Master_Trigger, 0.5)
    call DestroyTrigger(GetTriggeringTrigger())
endfunction

function InitTrig_Master_Initialization takes nothing returns nothing
    set gg_trg_Master_Initialization = CreateTrigger()
    call TriggerAddAction(gg_trg_Master_Initialization, function Trig_Master_InitializationActions)
endfunction