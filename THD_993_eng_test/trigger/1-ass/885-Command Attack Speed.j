function Trig_Command_Attack_Speed_Actions takes nothing returns nothing
    local player p = GetTriggerPlayer()
    local unit h
    local integer i = 0
    if p == udg_PlayerA[0] or p == udg_PlayerB[0] then
        loop
            set h = udg_PlayerHeroes[i]
            if IsUnitAlly(h, p) then
                call DisplayTextToPlayer(p, 0, 0, GetHeroProperName(h) + " attack speed: " + R2SW((GetUnitAttackSpeed(h) - 1.0) * 100, 4, 2) + "%")
            endif
            set i = i + 1
        exitwhen i >= 12
        endloop
        set p = null
        set h = null
        return
    endif
    set h = null
    call DisplayTextToPlayer(p, 0, 0, "Attack speed: " + R2SW((GetUnitAttackSpeed(GetPlayerCharacter(p)) - 1.0) * 100, 4, 2) + "%")
    set p = null
endfunction

function InitTrig_Command_Attack_Speed takes nothing returns nothing
    set gg_trg_Command_Attack_Speed = CreateTrigger()
    call TriggerRegisterPlayerChatEvent(gg_trg_Command_Attack_Speed, Player(0), "-as", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Command_Attack_Speed, Player(1), "-as", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Command_Attack_Speed, Player(2), "-as", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Command_Attack_Speed, Player(3), "-as", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Command_Attack_Speed, Player(4), "-as", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Command_Attack_Speed, Player(6), "-as", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Command_Attack_Speed, Player(7), "-as", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Command_Attack_Speed, Player(8), "-as", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Command_Attack_Speed, Player(9), "-as", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Command_Attack_Speed, Player(10), "-as", true)
    call TriggerAddAction(gg_trg_Command_Attack_Speed, function Trig_Command_Attack_Speed_Actions)
endfunction