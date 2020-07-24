function Trig_Command_AreaOff_Actions takes nothing returns nothing
    local unit u = GetPlayerCharacter(GetTriggerPlayer())
    call UnRegisterAreaShow(u, 'UTSB')
    set u = null
endfunction

function InitTrig_Command_AreaOff takes nothing returns nothing
    set gg_trg_Command_AreaOff = CreateTrigger()
    call TriggerAddAction(gg_trg_Command_AreaOff, function Trig_Command_AreaOff_Actions)
endfunction