function Trig_Str02_ExpensivePresent_Actions takes nothing returns nothing
    local integer i = 0
    local unit v
    loop
    exitwhen i >= 12
        set v = udg_PlayerHeroes[i]
        if YDWEUnitHasItemOfTypeBJNull(v, 'I032') then
            if udg_GameMode / 100 == 3 or udg_NewMid then
                call THD_AddCredit(GetOwningPlayer(v), 4)
            else
                call THD_AddCredit(GetOwningPlayer(v), 2)
            endif
        elseif YDWEUnitHasItemOfTypeBJNull(v, 'I04L') then
            if udg_GameMode / 100 == 3 or udg_NewMid then
                call THD_AddCredit(GetOwningPlayer(v), 2)
            else
                call THD_AddCredit(GetOwningPlayer(v), 1)
            endif
        elseif YDWEUnitHasItemOfTypeBJNull(v, 'I06V') then
            if udg_GameMode / 100 == 3 or udg_NewMid then
                call THD_AddCredit(GetOwningPlayer(v), 2)
            else
                call THD_AddCredit(GetOwningPlayer(v), 1)
            endif
        endif
        set i = i + 1
    endloop
    set v = null
endfunction

function InitTrig_Str02_ExpensivePresent takes nothing returns nothing
    set gg_trg_Str02_ExpensivePresent = CreateTrigger()
    call TriggerRegisterTimerEventPeriodic(gg_trg_Str02_ExpensivePresent, 2.0)
    call TriggerAddAction(gg_trg_Str02_ExpensivePresent, function Trig_Str02_ExpensivePresent_Actions)
endfunction