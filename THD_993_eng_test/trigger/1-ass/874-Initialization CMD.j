function Trig_Initialization_CMDFunc001A takes nothing returns nothing
    call TriggerRegisterPlayerChatEvent(gg_trg_TEST_MODE_OPEN, GetEnumPlayer(), "/biubiubiu", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_TEST_MODE_OFF, GetEnumPlayer(), "/*#dht#*/", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_TEST_MODE_OPEN, GetEnumPlayer(), "/test", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_TEST_MODE_OFF, GetEnumPlayer(), "/*#endtest#*/", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Debug_Fog, GetEnumPlayer(), "/fog", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Command_PS, GetEnumPlayer(), "/ps", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_PowerOpen, GetEnumPlayer(), "/PowerOpen", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_PointOpen, GetEnumPlayer(), "/PointOpen", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_PowerOff, GetEnumPlayer(), "/PowerOff", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_PointOff, GetEnumPlayer(), "/PointOff", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Debug_TOD, GetEnumPlayer(), "/tod", false)
    call TriggerRegisterPlayerChatEvent(gg_trg_Debug_TODMORE, GetEnumPlayer(), "/tod+", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Debug_Spirit, GetEnumPlayer(), "/spirit", false)
    call TriggerRegisterPlayerChatEvent(gg_trg_Command_CheckKill, GetEnumPlayer(), "-dev", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Command_Move_Speed, GetEnumPlayer(), "-ms", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Command_GetResist, GetEnumPlayer(), "-gr", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Command_Happy, GetEnumPlayer(), "-battledetect", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Command_WeatherInfo, GetEnumPlayer(), "-wi", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Command_VisualEffect, GetEnumPlayer(), "-veon", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Command_VisualEffect, GetEnumPlayer(), "-veoff", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Command_Fun, GetEnumPlayer(), "-custombgm", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Debug_Level_Up_All, GetEnumPlayer(), "/up", false)
endfunction

function Trig_Initialization_CMDFunc002A takes nothing returns nothing
    call TriggerRegisterPlayerChatEvent(gg_trg_AbilitySq, GetEnumPlayer(), "-abq", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Command_AreaShow, GetEnumPlayer(), "-areashow", false)
    call TriggerRegisterPlayerChatEvent(gg_trg_Command_AreaOff, GetEnumPlayer(), "-areaoff", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_AbilitySqOff, GetEnumPlayer(), "-abqoff", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Command_OnDamage, GetEnumPlayer(), "-onword", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Command_CrowdControlShow, GetEnumPlayer(), "-ccshow", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Command_OffDamage, GetEnumPlayer(), "-offword", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Command_Kill, GetEnumPlayer(), "-df", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Command_Sur, GetEnumPlayer(), "-urd", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Command_Dissur, GetEnumPlayer(), "-disurd", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Command_Cloth00, GetEnumPlayer(), "-cloth00", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Command_Cloth01, GetEnumPlayer(), "-cloth01", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Command_Cloth02, GetEnumPlayer(), "-cloth02", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Command_Cloth03, GetEnumPlayer(), "-caidan", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Command_BgmOn, GetEnumPlayer(), "-bgmon", false)
    call TriggerRegisterPlayerChatEvent(gg_trg_Command_BgmOff, GetEnumPlayer(), "-bgmoff", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Debug_Kill, GetEnumPlayer(), "/kill", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Debug_CD, GetEnumPlayer(), "/cd", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Debug_Level, GetEnumPlayer(), "/lvlup", false)
    call TriggerRegisterPlayerChatEvent(gg_trg_Debug_Gold, GetEnumPlayer(), "/gold", false)
    call TriggerRegisterPlayerChatEvent(gg_trg_Debug_Weather, GetEnumPlayer(), "/Weather", false)
    call TriggerRegisterPlayerChatEvent(gg_trg_Debug_Death, GetEnumPlayer(), "/death?", true)
endfunction

function Trig_Initialization_CMDActions takes nothing returns nothing
    call ForForce(bj_FORCE_ALL_PLAYERS, function Trig_Initialization_CMDFunc001A)
    call ForForce(udg_OnlinePlayers, function Trig_Initialization_CMDFunc002A)
endfunction

function InitTrig_Initialization_CMD takes nothing returns nothing
    set gg_trg_Initialization_CMD = CreateTrigger()
    call TriggerAddAction(gg_trg_Initialization_CMD, function Trig_Initialization_CMDActions)
endfunction