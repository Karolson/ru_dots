function Trig_Defence_Control_1_Conditions takes nothing returns boolean
    return GetUnitTypeId(GetSoldUnit()) == 'n02I' or GetUnitTypeId(GetSoldUnit()) == 'n02W' or GetUnitTypeId(GetSoldUnit()) == 'n02X'
endfunction

function Trig_Defence_Control_1_Actions takes nothing returns nothing
    local unit caster = GetSellingUnit()
    local unit u = GetSoldUnit()
    local player PLY = GetOwningPlayer(u)
    local integer cost = 130
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
        call DisplayTextToPlayer(PLY, 0, 0, "Not enough faith, need " + I2S(cost) + " faith to summon Genji's Spirit.")
        call AddUnitToStock(caster, uid, 1, 1)
        set caster = null
        set u = null
        set PLY = null
        set t = null
        return
    endif
    call THD_AddSpirit(GetOwningPlayer(GetSellingUnit()), -cost)
    call BroadcastMessageFriend(udg_PN[GetPlayerId(PLY)] + " has summoned Genji's Spirit", PLY)
    call StartSound(gg_snd_SargerasRoar)
    set x = GetRectCenterX(gg_rct_Genji_Born)
    set y = GetRectCenterY(gg_rct_Genji_Born)
    call RemoveUnitFromStock(caster, 'n02I')
    call RemoveUnitFromStock(caster, 'n02W')
    call RemoveUnitFromStock(caster, 'n02X')
    call DisableTrigger(gg_trg_Defence_Control_1)
    set u = CreateUnit(udg_PlayerA[0], 'h015', x, y, 45.0)
    call UnitInitAddAttack(u)
    call UnitAddAttackDamage(u, GetPlayerTechCountSimple('R003', udg_PlayerA[0]) * 9)
    if uid == 'n02I' then
        set way = 0
    elseif uid == 'n02X' then
        set way = 1
    elseif uid == 'n02W' then
        set way = 2
    endif
    call SetUnitVertexColor(u, 255, 255, 255, 127)
    call UnitApplyTimedLife(u, 'BTLF', time + 5.0)
    call RemoveGuardPosition(u)
    call AddUnitWaypointRecord(u, way * 16)
    call SpawnIssueOrderA(u)
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
    call StartSound(gg_snd_SargerasRoar)
    call TriggerSleepAction(1.0)
    call AddUnitToStock(caster, 'n02I', 0, 1)
    call AddUnitToStock(caster, 'n02X', 0, 1)
    call AddUnitToStock(caster, 'n02W', 0, 1)
    call EnableTrigger(gg_trg_Defence_Control_1)
    set boss = null
    set caster = null
    set u = null
    set PLY = null
    set t = null
endfunction

function InitTrig_Defence_Control_1 takes nothing returns nothing
    set gg_trg_Defence_Control_1 = CreateTrigger()
    call TriggerAddCondition(gg_trg_Defence_Control_1, Condition(function Trig_Defence_Control_1_Conditions))
    call TriggerAddAction(gg_trg_Defence_Control_1, function Trig_Defence_Control_1_Actions)
endfunction