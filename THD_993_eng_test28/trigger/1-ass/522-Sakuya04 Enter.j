function Trig_Sakuya04_Enter_Actions takes nothing returns nothing
    local unit caster = GetEnteringUnit()
    local integer k = GetPlayerId(GetOwningPlayer(caster)) + 1
    if LoadInteger(udg_sht, GetHandleId(caster), S2I("Sakuya04")) == 1 then
        set udg_SK_Sakuya04_Switch[k] = true
        call DisableTrigger(gg_trg_Sakuya04_Enter)
    endif
    set caster = null
endfunction

function InitTrig_Sakuya04_Enter takes nothing returns nothing
endfunction