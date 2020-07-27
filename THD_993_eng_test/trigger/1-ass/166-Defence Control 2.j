function Trig_Defence_Control_2_Conditions takes nothing returns boolean
    return GetUnitTypeId(GetSoldUnit()) == 'n03U' or GetUnitTypeId(GetSoldUnit()) == 'n03V' or GetUnitTypeId(GetSoldUnit()) == 'n03W'
endfunction

function Trig_Defence_Control_2_Actions takes nothing returns nothing
    local unit caster = GetSellingUnit()
    local unit u = GetSoldUnit()
    local player PLY = GetOwningPlayer(u)
    local integer cost = 65
    local real time = 360.0
    local timer t
    local real x
    local real y
    local integer d
    local integer uid = GetUnitTypeId(u)
    local integer way
    local unit boss
    call RemoveUnit(u)
    if THD_GetSpirit(PLY) < cost then
        call DisplayTextToPlayer(PLY, 0, 0, "Not enough faith, need " + I2S(cost) + " faith to summon Hisotensoku.")
        call AddUnitToStock(caster, uid, 1, 1)
        set caster = null
        set u = null
        set PLY = null
        set t = null
        return
    endif
    call THD_AddSpirit(GetOwningPlayer(GetSellingUnit()), -cost)
    call BroadcastMessageFriend(udg_PN[GetPlayerId(PLY)] + " has summoned Hisotensoku", PLY)
    call StartSound(gg_snd_TinkerMorph1)
    set x = GetRectCenterX(gg_rct_FXTZ_Born)
    set y = GetRectCenterY(gg_rct_FXTZ_Born)
    call RemoveUnitFromStock(caster, 'n03U')
    call RemoveUnitFromStock(caster, 'n03V')
    call RemoveUnitFromStock(caster, 'n03W')
    set u = CreateUnit(udg_PlayerB[0], 'h01O', x, y, 45.0)
    call UnitInitAddAttack(u)
    call UnitAddAttackDamage(u, GetPlayerTechCountSimple('R003', udg_PlayerB[0]) * 9)
    if uid == 'n03U' then
        set way = 0
    elseif uid == 'n03V' then
        set way = 1
    elseif uid == 'n03W' then
        set way = 2
    endif
    call SetUnitVertexColor(u, 255, 255, 255, 127)
    call UnitApplyTimedLife(u, 'BTLF', time + 5.0)
    call RemoveGuardPosition(u)
    call AddUnitWaypointRecord(u, way * 16)
    call SpawnIssueOrderB(u)
    set boss = u
    set u = CreateUnit(PLY, 'n00X', GetUnitX(caster), GetUnitY(caster), 0.0)
    call UnitAddAbility(u, 'A0GS')
    call UnitApplyTimedLife(u, 'BTLF', time + 5.0)
    set d = OrderId("cloudoffog")
    set t = CreateTimer()
    call TimerStart(t, time, false, null)
    loop
        set time = TimerGetRemaining(t)
    exitwhen time <= 0
    exitwhen IsUnitDead(boss)
        if GetUnitCurrentOrder(u) != d then
            call DebugMsg("X")
        endif
        call TriggerSleepAction(1.0)
    endloop
    call ReleaseTimer(t)
    call RemoveUnit(u)
    call RemoveUnit(boss)
    call DebugMsg(GetUnitName(caster) + " dissipated")
    call StartSound(gg_snd_SteamTankYes1)
    call TriggerSleepAction(1.0)
    call AddUnitToStock(caster, 'n03U', 0, 1)
    call AddUnitToStock(caster, 'n03V', 0, 1)
    call AddUnitToStock(caster, 'n03W', 0, 1)
    set boss = null
    set caster = null
    set u = null
    set PLY = null
    set t = null
endfunction

function InitTrig_Defence_Control_2 takes nothing returns nothing
    set gg_trg_Defence_Control_2 = CreateTrigger()
    call TriggerAddCondition(gg_trg_Defence_Control_2, Condition(function Trig_Defence_Control_2_Conditions))
    call TriggerAddAction(gg_trg_Defence_Control_2, function Trig_Defence_Control_2_Actions)
endfunction