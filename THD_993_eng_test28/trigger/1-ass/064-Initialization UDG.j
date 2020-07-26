function Trig_Initialization_UDG_Actions takes nothing returns nothing
    local integer i = 0
    local integer j = 0
    local unit u
    set udg_HeroDatabase = InitHashtable()
    set udg_ItemDatabase = InitHashtable()
    set udg_cssht = InitHashtable()
    set udg_Hashtable = InitHashtable()
    set udg_db = udg_HeroDatabase
    set udg_ht = udg_Hashtable
    set udg_Hashtable_CDInReimu = InitHashtable()
    set udg_Hashtable_CastSq = InitHashtable()
    set udg_Hashtable_CastSq_Id = InitHashtable()
    set udg_StatusSys = InitHashtable()
    set udg_StatusEffect = InitHashtable()
    set udg_TimerSys = InitHashtable()
    set udg_GroupSys = InitHashtable()
    call TimerSysInit()
    call GroupSysInit()
    set udg_sht = InitHashtable()
    set i = 0
    set j = 0
    loop
    exitwhen j > 11
        loop
        exitwhen i > 9
            set u = CreateUnit(Player(j), 'e02U', -5344.0, -3968.0, 0)
            call GroupAddUnit(udg_DummyCastersLeft[j], u)
            call GroupAddUnit(udg_DummyCastersAll[j], u)
            set i = i + 1
        endloop
        set j = j + 1
    endloop
    set i = 0
    set j = 0
    loop
    exitwhen j > 11
        loop
        exitwhen i > 9
            set u = CreateUnit(Player(j), 'e02X', -5344.0, -3968.0, 0)
            call GroupAddUnit(udg_SpecialDummyCastersLeft[j], u)
            call GroupAddUnit(udg_SpecialDummyCastersAll[j], u)
            set i = i + 1
        endloop
        set j = j + 1
    endloop
    set i = 0
    set j = 0
    loop
    exitwhen j > 11
        loop
        exitwhen i > 9
            set u = CreateUnit(Player(j), 'e035', -5344.0, -3968.0, 0)
            call GroupAddUnit(udg_DummyVisionCastersLeft[j], u)
            call GroupAddUnit(udg_DummyVisionCastersAll[j], u)
            set i = i + 1
        endloop
        set j = j + 1
    endloop
    set i = 0
    loop
    exitwhen i > 11
        set udg_BlinkEnableUnit[i] = CreateUnit(Player(i), 'e036', -5344.0, -3968.0, 0)
        set i = i + 1
    endloop
    set udg_SK_Soga01efgroup = null
    set udg_SK_Soga01efgroup = null
    set udg_SK_Soga01efgroup = null
    set udg_SK_Soga01efgroup = null
    call Initialize_Bonus()
    set udg_PerfectText[3] = "|c0000ff40Killing Spree|r"
    set udg_PerfectText[4] = "|c00400080Dominating|r"
    set udg_PerfectText[5] = "|c00ff0080Mega Kill|r"
    set udg_PerfectText[6] = "|c00ff8000Unstoppable|r"
    set udg_PerfectText[7] = "|c00808000Wicked Sick|r"
    set udg_PerfectText[8] = "|c00ff80ffMonster Kill|r"
    set udg_PerfectText[9] = "|c00ff0000GODLIKE!|r"
    set udg_PerfectText[10] = "|c00ff8000BEYOND GODLIKE!!!!|r"
    set udg_PlayerColors[0] = "|cFFFF0000"
    set udg_PlayerColors[1] = "|cFF0033FF"
    set udg_PlayerColors[2] = "|cFF33FFCC"
    set udg_PlayerColors[3] = "|cFF7036A0"
    set udg_PlayerColors[4] = "|cFFFFFF00"
    set udg_PlayerColors[5] = "|cFFFF9900"
    set udg_PlayerColors[6] = "|cFF33CC00"
    set udg_PlayerColors[7] = "|cFFCC6699"
    set udg_PlayerColors[8] = "|cFF999999"
    set udg_PlayerColors[9] = "|cFF66CCFF"
    set udg_PlayerColors[10] = "|cFF006633"
    set udg_PlayerColors[11] = "|cFF663300"
    set i = 0
    loop
        set udg_PN[i] = udg_PlayerColors[i] + GetPlayerName(Player(i)) + "|r"
        set i = i + 1
    exitwhen i > 11
    endloop
    set udg_FLIFF[0] = Filter(function FLIFF01)
    set udg_FLIFF[1] = Filter(function FLIFF02)
    set udg_FLIFF[2] = Filter(function FLIFF03)
    set udg_FLIFF[3] = Filter(function FLIFF04)
    set udg_FLIFF[4] = Filter(function FLIFF05)
    set udg_FLIFF[5] = Filter(function FLIFF06)
    set udg_FLIFF[6] = Filter(function FLIFF07)
    set udg_FLIFF[7] = Filter(function FLIFF08)
    set udg_FLIFF[8] = Filter(function FLIFF09)
    set udg_FLIFF[9] = Filter(function FLIFF10)
    set udg_FLIFF[10] = Filter(function FLIFF11)
    set udg_FLIFF[11] = Filter(function FLIFF12)
    set udg_FLIFF[12] = Filter(function FLIFF13)
    set udg_FLIFF[13] = Filter(function FLIFF14)
    set udg_FLIFF[14] = Filter(function FLIFF15)
    set i = 0
    loop
        set udg_Player_GoldRemnant[i] = 0
    exitwhen i >= 15
        set i = i + 1
    endloop
    call InitACSII()
    set i = 0
    loop
        set udg_PlayerHeroes[i] = null
        set i = i + 1
    exitwhen i >= 64
    endloop
    set u = null
endfunction

function InitTrig_Initialization_UDG takes nothing returns nothing
endfunction