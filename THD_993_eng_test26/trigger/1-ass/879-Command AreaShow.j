function Trig_Command_AreaShow_Actions takes nothing returns nothing
    local real i = S2I(SubString(GetEventPlayerChatString(), 10, 14))
    local unit u = GetPlayerCharacter(GetTriggerPlayer())
    if i > 0 then
        call DebugMsg("AreaShowCreate:Cnt=" + I2S(R2I(i * 3.1415 / 150)) + " i = " + R2S(i))
        call RegisterAreaShowPlayer(GetTriggerPlayer(), u, 'UTSB', i, R2I(i * 3.1415 / 150) + 1, 0, "EnergyHands.mdl", 0.02)
    else
        call UnRegisterAreaShow(u, 'UTSB')
        call SaveReal(udg_ht, GetHandleId(GetTriggerPlayer()), StringHash("AREASHOW"), 0)
    endif
    set u = null
endfunction

function InitTrig_Command_AreaShow takes nothing returns nothing
    set gg_trg_Command_AreaShow = CreateTrigger()
    call TriggerAddAction(gg_trg_Command_AreaShow, function Trig_Command_AreaShow_Actions)
endfunction