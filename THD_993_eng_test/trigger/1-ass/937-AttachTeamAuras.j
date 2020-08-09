function Trig_AttachTeamAuras_Actions takes nothing returns nothing
    local group g
    local unit v
    local integer i = 0
    local string s
    local boolean isInvulnerable
    loop
        set g = CreateGroup()
        call GroupEnumUnitsOfPlayer(g, Player(i), null)
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if (IsUnitType(v, UNIT_TYPE_HERO) or IsUnitIllusion(v)) and not IsUnitType(v, UNIT_TYPE_STRUCTURE) and not IsUnitDead(v) then
                set isInvulnerable = IsUnitInvulnerable(v)
                if LoadEffectHandle(udg_TimerSys, GetHandleId(v), 0) == null or LoadInteger(udg_TimerSys, GetHandleId(v), 1) != GetUnitTypeId(v) or isInvulnerable != LoadBoolean(udg_TimerSys, GetHandleId(v), 2) then
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
                    call SaveBoolean(udg_TimerSys, GetHandleId(v), 2, isInvulnerable)
                endif
            endif
        endloop
        call DestroyGroup(g)
        set i = i + 1
        if i == 5 then
            set i = 6
        endif
    exitwhen i > 10
    endloop
    set g = null
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
    local integer i = 0
    local group g
    local unit v
    set udg_AuraOff[pid] = not udg_AuraOff[pid]
    loop
        set g = CreateGroup()
        call GroupEnumUnitsOfPlayer(g, Player(i), null)
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if IsUnitType(v, UNIT_TYPE_HERO) or IsUnitIllusion(v) then
                call DestroyEffect(LoadEffectHandle(udg_TimerSys, GetHandleId(v), 0))
                call FlushChildHashtable(udg_TimerSys, GetHandleId(v))
            endif
        endloop
        call DestroyGroup(g)
        set i = i + 1
        if i == 5 then
            set i = 6
        endif
    exitwhen i > 10
    endloop
    call Trig_AttachTeamAuras_Actions()
    set g = null
endfunction

function InitTrig_AttachTeamAuras takes nothing returns nothing
    local timer t = CreateTimer()
    local trigger aurastoggle_trig = CreateTrigger()
    local integer i
    call TimerStart(t, 0.05, true, function Trig_AttachTeamAuras_Actions)
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
    set t = null
endfunction