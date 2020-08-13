function Trig_AttachTeamAuras_Actions takes nothing returns nothing
    local group g = CreateGroup()
    local unit v
    local string s
    local integer task = GetHandleId(GetExpiredTimer())
    local integer i = LoadInteger(udg_TimerSys, task, 0)
    call GroupEnumUnitsOfPlayer(g, Player(i), null)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if (IsUnitType(v, UNIT_TYPE_HERO) or IsUnitIllusion(v)) and not IsUnitType(v, UNIT_TYPE_STRUCTURE) and not IsUnitDead(v) then
            if LoadBoolean(udg_TimerSys, task, 1) then
                call DestroyEffect(LoadEffectHandle(udg_TimerSys, GetHandleId(v), 0))
                call FlushChildHashtable(udg_TimerSys, GetHandleId(v))
            endif
            if LoadEffectHandle(udg_TimerSys, GetHandleId(v), 0) == null or LoadInteger(udg_TimerSys, GetHandleId(v), 1) != GetUnitTypeId(v) then
                call DestroyEffect(LoadEffectHandle(udg_TimerSys, GetHandleId(v), 0))
                if udg_AuraOff[GetPlayerId(GetLocalPlayer())] then
                    set s = ""
                elseif GetPlayerId(GetOwningPlayer(v)) < 5 then
                    set s = "team_aura_hakurei.mdx"
                else
                    set s = "team_aura_moriya.mdx"
                endif
                call SaveEffectHandle(udg_TimerSys, GetHandleId(v), 0, AddSpecialEffectTarget(s, v, "origin"))
                call SaveInteger(udg_TimerSys, GetHandleId(v), 1, GetUnitTypeId(v))
            endif
        endif
    endloop
    call SaveBoolean(udg_TimerSys, task, 1, false)
    call DestroyGroup(g)
    set g = null
endfunction

function Trig_AurasRefresh takes nothing returns nothing
    local timer t = LoadTimerHandle(udg_TimerSys, GetHandleId(GetExpiredTimer()), 0)
    call SaveBoolean(udg_TimerSys, GetHandleId(t), 1, true)
    set t = null
endfunction

function Trig_AttachTeamAuras_Death takes nothing returns nothing
    local unit u = GetDyingUnit()
    if IsUnitType(u, UNIT_TYPE_HERO) or IsUnitIllusion(u) then
        call DestroyEffect(LoadEffectHandle(udg_TimerSys, GetHandleId(u), 0))
        call FlushChildHashtable(udg_TimerSys, GetHandleId(u))
    endif
    set u = null
endfunction

function Trig_AurasToggle takes nothing returns nothing
    local integer pid = GetPlayerId(GetTriggerPlayer())
    local timer t
    local integer i = 0
    set udg_AuraOff[pid] = not udg_AuraOff[pid]
    loop
        set t = LoadTimerHandle(udg_TimerSys, GetHandleId(GetTriggeringTrigger()), i)
        call SaveBoolean(udg_TimerSys, GetHandleId(t), 1, true)
        set i = i + 1
        if i == 5 then
            set i = 6
        endif
    exitwhen i > 10
    endloop
    set t = null
endfunction

function InitTrig_AttachTeamAuras_InitTimer takes nothing returns nothing
    local timer expired = GetExpiredTimer()
    local integer pid = LoadInteger(udg_TimerSys, GetHandleId(expired), 0)
    local timer t = CreateTimer()
    local timer trefresh = CreateTimer()
    call SaveInteger(udg_TimerSys, GetHandleId(t), 0, pid)
    call TimerStart(t, 0.05, true, function Trig_AttachTeamAuras_Actions)
    call SaveTimerHandle(udg_TimerSys, GetHandleId(trefresh), 0, t)
    call TimerStart(trefresh, 1.267, true, function Trig_AurasRefresh)
    call SaveTimerHandle(udg_TimerSys, LoadInteger(udg_TimerSys, GetHandleId(expired), 1), pid, t)
    call FlushChildHashtable(udg_TimerSys, GetHandleId(expired))
    call ReleaseTimer(expired)
    set t = null
    set trefresh = null
    set expired = null
endfunction

function InitTrig_AttachTeamAuras takes nothing returns nothing
    local timer t
    local trigger aurastoggle_trig = CreateTrigger()
    local integer i
    set gg_trg_AttachTeamAuras = CreateTrigger()
    set i = 0
    loop
        call TriggerRegisterPlayerUnitEvent(gg_trg_AttachTeamAuras, Player(i), EVENT_PLAYER_UNIT_DEATH, null)
        set i = i + 1
        if i == 5 then
            set i = 6
        endif
    exitwhen i > 10
    endloop
    call TriggerAddAction(aurastoggle_trig, function Trig_AurasToggle)
    set i = 0
    loop
        call TriggerRegisterPlayerChatEvent(aurastoggle_trig, Player(i), "-auras", true)
        set i = i + 1
    exitwhen i > 11
    endloop
    set i = 0
    loop
        set t = CreateTimer()
        call SaveInteger(udg_TimerSys, GetHandleId(t), 0, i)
        call SaveInteger(udg_TimerSys, GetHandleId(t), 1, GetHandleId(aurastoggle_trig))
        call TimerStart(t, 0.02, false, function InitTrig_AttachTeamAuras_InitTimer)
        set i = i + 1
        if i == 5 then
            set i = 6
        endif
    exitwhen i > 10
    endloop
    set t = null
endfunction