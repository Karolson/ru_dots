function Trig_AttachTeamAuras_Actions takes nothing returns nothing
    local group g
    local unit v
    local integer i = 0
    loop
        set g = CreateGroup()
        call GroupEnumUnitsOfPlayer(g, Player(i), null)
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if (IsUnitType(v, UNIT_TYPE_HERO) or IsUnitIllusion(v)) and not IsUnitType(v, UNIT_TYPE_STRUCTURE) and not IsUnitDead(v) and (LoadEffectHandle(udg_TimerSys, GetHandleId(v), 0) == null or LoadInteger(udg_TimerSys, GetHandleId(v), 1) != GetUnitTypeId(v)) then
                call DestroyEffect(LoadEffectHandle(udg_TimerSys, GetHandleId(v), 0))
                if GetPlayerId(GetOwningPlayer(v)) < 5 then
                    call SaveEffectHandle(udg_TimerSys, GetHandleId(v), 0, AddSpecialEffectTarget("team_aura_hakurei.mdx", v, "origin"))
                else
                    call SaveEffectHandle(udg_TimerSys, GetHandleId(v), 0, AddSpecialEffectTarget("team_aura_moriya.mdx", v, "origin"))
                endif
                call SaveInteger(udg_TimerSys, GetHandleId(v), 1, GetUnitTypeId(v))
            endif
        endloop
        call DestroyGroup(g)
        set i = i + 1
        if i == 5 then
            set i = 6
        endif
    exitwhen i > 11
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

function InitTrig_AttachTeamAuras takes nothing returns nothing
    local timer t = CreateTimer()
    local integer i = 0
    call TimerStart(t, 0.05, true, function Trig_AttachTeamAuras_Actions)
    set gg_trg_AttachTeamAuras = CreateTrigger()
    loop
        call TriggerRegisterPlayerUnitEvent(gg_trg_AttachTeamAuras, Player(i), EVENT_PLAYER_UNIT_DEATH, null)
        set i = i + 1
        if i == 5 then
            set i = 6
        endif
    exitwhen i > 11
    endloop
    set t = null
endfunction