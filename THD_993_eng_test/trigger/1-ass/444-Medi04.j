function Trig_Medi04_Conditions takes nothing returns boolean
    if GetSpellAbilityId() != 'A04C' then
        return false
    elseif IsUnitIllusion(GetSpellTargetUnit()) then
        return false
    endif
    return true
endfunction

function stopattack takes nothing returns nothing
    local unit target = GetEnumUnit()
    if GetUnitTypeId(target) == 'h00B' or GetUnitTypeId(target) == 'h00I' then
        call SetUnitInvulnerable(target, false)
    endif
    call PauseUnit(target, true)
    call IssueImmediateOrder(target, "stop")
    call PauseUnit(target, false)
    set target = null
endfunction

function Yukkuri_Get takes nothing returns boolean
    return GetUnitTypeId(GetFilterUnit()) == 'h00B' or GetUnitTypeId(GetFilterUnit()) == 'h00I'
endfunction

function Medi04_Clear_Stage2 takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit target = LoadUnitHandle(udg_Hashtable, task, 0)
    call SetUnitInvulnerable(target, false)
    call FlushChildHashtable(udg_Hashtable, task)
    call ReleaseTimer(t)
    set t = null
    set target = null
endfunction

function Medi04_TimeOut takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit target = LoadUnitHandle(udg_Hashtable, task, 0)
    local player targetplayer = LoadPlayerHandle(udg_Hashtable, task, 1)
    local integer whichteam = LoadInteger(udg_Hashtable, task, 0)
    local real i = LoadReal(udg_Hashtable, task, 1)
    local unit caster = LoadUnitHandle(udg_Hashtable, task, 5)
    local group grp
    if i > 0 and GetWidgetLife(target) > 0.405 then
        call SaveReal(udg_Hashtable, task, 1, i - 1.0)
    else
        set grp = CreateGroup()
        call GroupEnumUnitsOfPlayer(grp, targetplayer, null)
        if udg_smodestat == false then
            if whichteam == 1 then
                call SetForceAllianceStateBJ(udg_SK_Medi_Team, udg_TeamA, bj_ALLIANCE_ALLIED_VISION)
                call SetForceAllianceStateBJ(udg_SK_Medi_Team, udg_TeamB, bj_ALLIANCE_UNALLIED)
                call SetForceAllianceStateBJ(udg_SK_Medi_Team, udg_TeamSpawnA, bj_ALLIANCE_ALLIED_VISION)
                call SetForceAllianceStateBJ(udg_SK_Medi_Team, udg_TeamSpawnB, bj_ALLIANCE_UNALLIED)
                call SetForceAllianceStateBJ(udg_TeamA, udg_SK_Medi_Team, bj_ALLIANCE_ALLIED_VISION)
                call SetForceAllianceStateBJ(udg_TeamB, udg_SK_Medi_Team, bj_ALLIANCE_UNALLIED)
                call SetForceAllianceStateBJ(udg_TeamSpawnA, udg_SK_Medi_Team, bj_ALLIANCE_ALLIED_VISION)
                call SetForceAllianceStateBJ(udg_TeamSpawnB, udg_SK_Medi_Team, bj_ALLIANCE_UNALLIED)
                call ForceRemovePlayer(udg_SK_Medi_Team, targetplayer)
            else
                call SetForceAllianceStateBJ(udg_SK_Medi_Team, udg_TeamA, bj_ALLIANCE_UNALLIED)
                call SetForceAllianceStateBJ(udg_SK_Medi_Team, udg_TeamB, bj_ALLIANCE_ALLIED_VISION)
                call SetForceAllianceStateBJ(udg_SK_Medi_Team, udg_TeamSpawnA, bj_ALLIANCE_UNALLIED)
                call SetForceAllianceStateBJ(udg_SK_Medi_Team, udg_TeamSpawnB, bj_ALLIANCE_ALLIED_VISION)
                call SetForceAllianceStateBJ(udg_TeamA, udg_SK_Medi_Team, bj_ALLIANCE_UNALLIED)
                call SetForceAllianceStateBJ(udg_TeamB, udg_SK_Medi_Team, bj_ALLIANCE_ALLIED_VISION)
                call SetForceAllianceStateBJ(udg_TeamSpawnA, udg_SK_Medi_Team, bj_ALLIANCE_UNALLIED)
                call SetForceAllianceStateBJ(udg_TeamSpawnB, udg_SK_Medi_Team, bj_ALLIANCE_ALLIED_VISION)
                call ForceRemovePlayer(udg_SK_Medi_Team, targetplayer)
            endif
        else
            call SetPlayerAllianceStateBJ(GetOwningPlayer(target), GetOwningPlayer(caster), bj_ALLIANCE_UNALLIED)
        endif
        call ForGroup(grp, function stopattack)
        call DestroyGroup(grp)
        call ForceClear(udg_SK_Medi_Team)
        call PauseTimer(t)
        call SetUnitInvulnerable(target, true)
        call TimerStart(t, 0.1, false, function Medi04_Clear_Stage2)
    endif
    set t = null
    set target = null
    set targetplayer = null
    set grp = null
    set caster = null
endfunction

function Trig_Medi04_Actions takes nothing returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local unit target = GetSpellTargetUnit()
    local player targetplayer = GetOwningPlayer(target)
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A04C')
    local integer whichteam = 0
    local group g = CreateGroup()
    local unit v
    call AbilityCoolDownResetion(caster, 'A04C', 170 - 30 * level)
    call VE_Spellcast(caster)
    call GroupEnumUnitsOfPlayer(g, targetplayer, null)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if GetUnitTypeId(v) == 'h00B' or GetUnitTypeId(v) == 'h00I' then
            call SetUnitInvulnerable(v, true)
        endif
    endloop
    call DestroyGroup(g)
    if udg_smodestat == false then
        if IsPlayerInForce(targetplayer, udg_TeamA) then
            set whichteam = 1
            call ForceAddPlayer(udg_SK_Medi_Team, targetplayer)
            call DebugMsg("Add A")
            call SetForceAllianceStateBJ(udg_SK_Medi_Team, udg_TeamA, bj_ALLIANCE_UNALLIED_VISION)
            call SetForceAllianceStateBJ(udg_SK_Medi_Team, udg_TeamB, bj_ALLIANCE_ALLIED)
            call SetForceAllianceStateBJ(udg_SK_Medi_Team, udg_TeamSpawnA, bj_ALLIANCE_UNALLIED_VISION)
            call SetForceAllianceStateBJ(udg_SK_Medi_Team, udg_TeamSpawnB, bj_ALLIANCE_ALLIED)
            call SetForceAllianceStateBJ(udg_TeamA, udg_SK_Medi_Team, bj_ALLIANCE_UNALLIED_VISION)
            call SetForceAllianceStateBJ(udg_TeamB, udg_SK_Medi_Team, bj_ALLIANCE_UNALLIED)
            call SetForceAllianceStateBJ(udg_TeamSpawnA, udg_SK_Medi_Team, bj_ALLIANCE_UNALLIED_VISION)
            call SetForceAllianceStateBJ(udg_TeamSpawnB, udg_SK_Medi_Team, bj_ALLIANCE_UNALLIED)
            call DebugMsg("Set A")
        else
            call ForceAddPlayer(udg_SK_Medi_Team, targetplayer)
            call DebugMsg("Add B")
            call SetForceAllianceStateBJ(udg_SK_Medi_Team, udg_TeamA, bj_ALLIANCE_ALLIED)
            call SetForceAllianceStateBJ(udg_SK_Medi_Team, udg_TeamB, bj_ALLIANCE_UNALLIED_VISION)
            call SetForceAllianceStateBJ(udg_SK_Medi_Team, udg_TeamSpawnA, bj_ALLIANCE_ALLIED)
            call SetForceAllianceStateBJ(udg_SK_Medi_Team, udg_TeamSpawnB, bj_ALLIANCE_UNALLIED_VISION)
            call SetForceAllianceStateBJ(udg_TeamA, udg_SK_Medi_Team, bj_ALLIANCE_UNALLIED)
            call SetForceAllianceStateBJ(udg_TeamB, udg_SK_Medi_Team, bj_ALLIANCE_UNALLIED_VISION)
            call SetForceAllianceStateBJ(udg_TeamSpawnA, udg_SK_Medi_Team, bj_ALLIANCE_UNALLIED)
            call SetForceAllianceStateBJ(udg_TeamSpawnB, udg_SK_Medi_Team, bj_ALLIANCE_UNALLIED_VISION)
            call DebugMsg("Set B")
        endif
    else
        call SetPlayerAllianceStateBJ(GetOwningPlayer(target), GetOwningPlayer(caster), bj_ALLIANCE_ALLIED)
    endif
    call UnitDebuffTarget(caster, target, 2.0 + I2R(level), 1, true, 'A081', level, 'B029', "bloodlust", 0, "")
    call SaveInteger(udg_Hashtable, task, 0, whichteam)
    call SaveReal(udg_Hashtable, task, 1, DebuffDuration(target, level + 2.0))
    call UnitBuffTarget(caster, target, 5, 'A17W', 0)
    call SaveUnitHandle(udg_Hashtable, task, 5, caster)
    call SaveUnitHandle(udg_Hashtable, task, 0, target)
    call SavePlayerHandle(udg_Hashtable, task, 1, targetplayer)
    call TimerStart(t, 1.0, true, function Medi04_TimeOut)
    set g = null
    set v = null
    set t = null
    set target = null
    set targetplayer = null
    set caster = null
endfunction

function InitTrig_Medi04 takes nothing returns nothing
endfunction