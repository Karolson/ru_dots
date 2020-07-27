function Trig_Command_GetResist_Actions takes nothing returns nothing
    local integer i = GetPlayerId(GetTriggerPlayer())
    local real k = GetUnitMagicResist(udg_PlayerHeroes[i])
    local real m = GetMagicResistTrueValue(k)
    local player p = GetTriggerPlayer()
    local unit h
    if p == udg_PlayerA[0] or p == udg_PlayerB[0] then
        set i = 0
        loop
            set h = udg_PlayerHeroes[i]
            if IsUnitAlly(h, p) then
                set k = GetUnitMagicResist(h)
                set m = GetMagicResistTrueValue(k)
                call DisplayTextToPlayer(p, 0, 0, GetHeroProperName(h) + " magic resistance: " + R2S(k) + ", reduction: " + R2S(m * 100) + "%")
            endif
            set i = i + 1
        exitwhen i >= 12
        endloop
        set p = null
        set h = null
        return
    endif
    set p = null
    set h = null
    call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "Magic resistance: " + R2S(k) + ", reduction: " + R2S(m * 100) + "%")
endfunction

function InitTrig_Command_GetResist takes nothing returns nothing
    set gg_trg_Command_GetResist = CreateTrigger()
    call TriggerAddAction(gg_trg_Command_GetResist, function Trig_Command_GetResist_Actions)
endfunction