function NeutralSystem_CreateGroupAtCamp takes nothing returns nothing
    local integer i = 0
    local integer triggerHandle = GetHandleId(GetTriggeringTrigger())
    local integer campSerial = LoadInteger(udg_Hashtable, triggerHandle, StringHash("campSerial"))
    local integer maxTypes = LoadInteger(udg_Hashtable, triggerHandle, StringHash("maxTypes"))
    local integer randomGroup = GetRandomInt(1, maxTypes)
    local real campCenterX = GetRectCenterX(udg_NeutralCamps[campSerial])
    local real campCenterY = GetRectCenterY(udg_NeutralCamps[campSerial])
    local integer length
    local integer num = LoadInteger(udg_Hashtable, triggerHandle, StringHash("Type" + I2S(randomGroup)))
    local string groupType = udg_NeutralGroups[num]
    local group unitsInCamp = CreateGroup()
    local integer countUnitsInCamp
    local unit u
    local boolean k
    local unit v
    local real additionlife
    call GroupEnumUnitsInRect(unitsInCamp, udg_NeutralCamps[campSerial], null)
    set countUnitsInCamp = CountUnitsInGroup(unitsInCamp)
    set k = false
    loop
        set v = FirstOfGroup(unitsInCamp)
    exitwhen v == null
        call GroupRemoveUnit(unitsInCamp, v)
        if GetOwningPlayer(v) == Player(PLAYER_NEUTRAL_AGGRESSIVE) and IsUnitType(v, UNIT_TYPE_DEAD) == FALSE then
            set k = true
        endif
    exitwhen k
    endloop
    call DestroyGroup(unitsInCamp)
    set unitsInCamp = null
    if k then
        set groupType = null
        set unitsInCamp = null
        set u = null
        set v = null
        return
    endif
    if udg_GameMode / 100 == 2 then
        set groupType = null
        set unitsInCamp = null
        set u = null
        set v = null
        return
    endif
    if udg_GameMode / 100 == 3 or udg_NewMid then
        if udg_NeutralCamps[campSerial] != gg_rct_CreepsLv1AA and udg_NeutralCamps[campSerial] != gg_rct_CreepsLv1BB and udg_NeutralCamps[campSerial] != gg_rct_CreepsLv1AB and udg_NeutralCamps[campSerial] != gg_rct_CreepsLv1BA then
            set groupType = null
            set unitsInCamp = null
            set u = null
            set v = null
            return
        endif
    endif
    loop
        set length = StringLength(groupType)
    exitwhen i >= length or length == 0
        if SubString(groupType, i, i + 1) == "," then
            set u = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE), udg_NeutralTypes[S2I(SubString(groupType, 0, i))], campCenterX, campCenterY, bj_UNIT_FACING)
            set additionlife = GetUnitState(u, UNIT_STATE_MAX_LIFE) * 0.1 * R2I(udg_GameTime / 60 / 6)
            call UnitAddMaxLife(u, R2I(additionlife))
            if R2I(udg_GameTime / 60 / 6) > 0 then
                call UnitAddAbility(u, 'A0CY')
                call SetUnitAbilityLevel(u, 'A0CY', R2I(udg_GameTime / 60 / 6))
            endif
            call SetUnitAcquireRange(u, 200)
            set groupType = SubString(groupType, i + 1, length)
            set i = -1
        endif
        set i = i + 1
    endloop
    if length != 0 then
        set u = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE), udg_NeutralTypes[S2I(groupType)], campCenterX, campCenterY, bj_UNIT_FACING)
        set additionlife = GetUnitState(u, UNIT_STATE_MAX_LIFE) * 0.1 * R2I(udg_GameTime / 60 / 6)
        call UnitAddMaxLife(u, R2I(additionlife))
        if R2I(udg_GameTime / 60 / 6) > 0 then
            call UnitAddAbility(u, 'A0CY')
            call SetUnitAbilityLevel(u, 'A0CY', R2I(udg_GameTime / 60 / 6))
        endif
        call SetUnitAcquireRange(u, 200)
    endif
    set groupType = null
    set u = null
    set unitsInCamp = null
    set v = null
endfunction

function Trig_Neutral_System_First_Spawn_WW takes nothing returns nothing
    local integer i = 1
    loop
    exitwhen i > udg_NeutralCampsCount
        call TriggerAddAction(udg_neutralCreepsTriggers[i], function NeutralSystem_CreateGroupAtCamp)
        call TriggerExecute(udg_neutralCreepsTriggers[i])
        if udg_smodestat == false then
            call TriggerRegisterTimerEvent(udg_neutralCreepsTriggers[i], udg_NeutralCreatePeriod[i], true)
        else
            call TriggerRegisterTimerEvent(udg_neutralCreepsTriggers[i], udg_NeutralCreatePeriod[i] / 2, true)
        endif
        set i = i + 1
    endloop
    call ReleaseTimer(GetExpiredTimer())
    call DebugMsg("Neutral creep spawn system has finished loading")
endfunction

function Trig_Neutral_System_Init takes nothing returns nothing
    local integer campSerial = 1
    local integer i
    local integer triggerHandle
    local string campTypes
    local integer maxTypes
    local integer length
    loop
    exitwhen campSerial > udg_NeutralCampsCount
        set udg_neutralCreepsTriggers[campSerial] = CreateTrigger()
        set triggerHandle = GetHandleId(udg_neutralCreepsTriggers[campSerial])
        set i = 0
        set campTypes = udg_NeutralCampTypes[campSerial]
        set maxTypes = 0
        loop
            set length = StringLength(campTypes)
        exitwhen i >= length or length == 0
            if SubString(campTypes, i, i + 1) == "," then
                set maxTypes = maxTypes + 1
                call SaveInteger(udg_Hashtable, triggerHandle, StringHash("Type" + I2S(maxTypes)), S2I(SubString(campTypes, 0, i)))
                set campTypes = SubString(campTypes, i + 1, length)
                set i = -1
            endif
            set i = i + 1
        endloop
        if length != 0 then
            set maxTypes = maxTypes + 1
            call SaveInteger(udg_Hashtable, triggerHandle, StringHash("Type" + I2S(maxTypes)), S2I(campTypes))
        endif
        call SaveInteger(udg_Hashtable, triggerHandle, StringHash("maxTypes"), maxTypes)
        call SaveInteger(udg_Hashtable, triggerHandle, StringHash("campSerial"), campSerial)
        set campSerial = campSerial + 1
    endloop
    call FirstAbilityInit('A0CY')
    call DebugMsg("Neutral creep system is initialized")
    call TimerStart(CreateTimer(), udg_NeutralFirstSpawnTime, false, function Trig_Neutral_System_First_Spawn_WW)
    set campTypes = null
endfunction

function InitTrig_Neutral_System takes nothing returns nothing
    set gg_trg_Neutral_System = CreateTrigger()
    call TriggerAddAction(gg_trg_Neutral_System, function Trig_Neutral_System_Init)
endfunction