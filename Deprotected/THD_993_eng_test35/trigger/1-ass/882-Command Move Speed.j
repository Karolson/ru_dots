function Trig_Command_Move_Speed_Actions takes nothing returns nothing
    local integer i = GetPlayerId(GetTriggerPlayer())
    local player p = GetTriggerPlayer()
    local unit h
    local integer n
    if p == udg_PlayerA[0] or p == udg_PlayerB[0] then
        set n = 0
        loop
            set h = udg_PlayerHeroes[n]
            if IsUnitAlly(h, p) then
                set n = GetPlayerId(GetOwningPlayer(h))
                call DisplayTextToPlayer(p, 0, 0, GetHeroProperName(h) + " movement speed: " + R2SW(GetUnitMoveSpeed(udg_PlayerHeroes[n]), 4, 2))
            endif
            set n = n + 1
        exitwhen n >= 12
        endloop
        set p = null
        set h = null
        return
    endif
    set p = null
    set h = null
    call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "Movement speed: " + R2SW(GetUnitMoveSpeed(udg_PlayerHeroes[i]), 4, 2))
endfunction

function InitTrig_Command_Move_Speed takes nothing returns nothing
    set gg_trg_Command_Move_Speed = CreateTrigger()
    call TriggerAddAction(gg_trg_Command_Move_Speed, function Trig_Command_Move_Speed_Actions)
endfunction