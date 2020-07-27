function Trig_Captain04_Select_Actions takes nothing returns nothing
    local timer t = GetExpiredTimer()
    call DialogSetMessage(udg_Captain_Select, "Select ultimate ability")
    call DialogAddButtonBJ(udg_Captain_Select, "Harbor Sign [Titanic Destroyer]")
    set udg_Captain_Select_Button[0] = GetLastCreatedButtonBJ()
    call DialogAddButtonBJ(udg_Captain_Select, "Harbor Sign [Phantom Ship Harbor]")
    set udg_Captain_Select_Button[1] = GetLastCreatedButtonBJ()
    call DialogDisplay(GetOwningPlayer(udg_SK_Caption04_Hero), udg_Captain_Select, true)
    call ReleaseTimer(t)
endfunction

function InitTrig_Captain04_Select takes nothing returns nothing
endfunction