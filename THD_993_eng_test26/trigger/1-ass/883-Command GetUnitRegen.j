function Trig_GetUnitRegen_Actions takes nothing returns nothing
    local unit u = GetPlayerCharacter(GetTriggerPlayer())
    local player p = GetTriggerPlayer()
    local unit h
    local integer i = 0
    if p == udg_PlayerA[0] or p == udg_PlayerB[0] then
        loop
            set h = udg_PlayerHeroes[i]
            if IsUnitAlly(h, p) then
                call DisplayTextToPlayer(p, 0, 0, GetHeroProperName(h) + " health regen (per second): " + R2S(GetUnitLifeRegen(h)))
                call DisplayTextToPlayer(p, 0, 0, GetHeroProperName(h) + " mana regen (per second): " + R2S(GetUnitMagicRegen(h)))
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
    call DisplayTextToPlayer(GetOwningPlayer(u), 0, 0, "Health regen (per second): " + R2S(GetUnitLifeRegen(u)))
    call DisplayTextToPlayer(GetOwningPlayer(u), 0, 0, "Mana regen (per second): " + R2S(GetUnitMagicRegen(u)))
    set u = null
endfunction

function InitTrig_Command_GetUnitRegen takes nothing returns nothing
    set gg_trg_Command_GetUnitRegen = CreateTrigger()
    call TriggerRegisterPlayerChatEvent(gg_trg_Command_GetUnitRegen, Player(0), "-regen", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Command_GetUnitRegen, Player(1), "-regen", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Command_GetUnitRegen, Player(2), "-regen", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Command_GetUnitRegen, Player(3), "-regen", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Command_GetUnitRegen, Player(4), "-regen", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Command_GetUnitRegen, Player(5), "-regen", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Command_GetUnitRegen, Player(6), "-regen", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Command_GetUnitRegen, Player(7), "-regen", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Command_GetUnitRegen, Player(8), "-regen", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Command_GetUnitRegen, Player(9), "-regen", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Command_GetUnitRegen, Player(10), "-regen", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Command_GetUnitRegen, Player(11), "-regen", true)
    call TriggerAddAction(gg_trg_Command_GetUnitRegen, function Trig_GetUnitRegen_Actions)
endfunction