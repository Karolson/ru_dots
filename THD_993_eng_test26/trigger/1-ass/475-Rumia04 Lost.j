function Trig_Rumia04_Lost_Actions takes nothing returns nothing
    local integer lost
    local unit u = GetTriggerUnit()
    call TriggerSleepAction(0.3)
    set lost = R2I(udg_SK_Rumia04_Life * 0.2)
    set udg_SK_Rumia04_Life = udg_SK_Rumia04_Life - lost
    call UnitAddMaxLife(u, -lost)
    call UnitAddBonusDmg(u, -(lost / 20))
    set u = null
endfunction

function InitTrig_Rumia04_Lost takes nothing returns nothing
endfunction