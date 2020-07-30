function Trig_Mana01_LunarClip_Actions takes nothing returns nothing
    local integer i = 0
    loop
    exitwhen i >= 12
        if YDWEUnitHasItemOfTypeBJNull(udg_PlayerHeroes[i], 'I083') and udg_GameTime >= 60 then
            if udg_GameMode / 100 == 3 or udg_NewMid then
                call AddHeroXP(udg_PlayerHeroes[i], 12, true)
            else
                call AddHeroXP(udg_PlayerHeroes[i], 6, true)
            endif
        endif
        set i = i + 1
    endloop
endfunction

function InitTrig_Mana01_LunarClip takes nothing returns nothing
    set gg_trg_Mana01_LunarClip = CreateTrigger()
    call TriggerRegisterTimerEventPeriodic(gg_trg_Mana01_LunarClip, 5.0)
    call TriggerAddAction(gg_trg_Mana01_LunarClip, function Trig_Mana01_LunarClip_Actions)
endfunction