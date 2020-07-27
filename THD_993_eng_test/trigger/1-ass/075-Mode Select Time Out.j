function Trig_Mode_Select_Time_Out_Actions takes nothing returns nothing
    set udg_GameMode = 111
    call DestroyTimer(udg_MainTimer)
    set udg_MainTimer = null
    call DisplayTextToForce(GetPlayersAll(), "Team selection mode: ")
    call DisplayTextToForce(GetPlayersAll(), udg_GameModeName[0])
    call DisplayTextToForce(GetPlayersAll(), "Character selection mode: ")
    call DisplayTextToForce(GetPlayersAll(), udg_GameModeName[10])
    call DisplayTextToForce(GetPlayersAll(), "Game mode: ")
    call DisplayTextToForce(GetPlayersAll(), udg_GameModeName[100])
    call DestroyTrigger(gg_trg_Mode_Select_Step_1)
    call DestroyTrigger(gg_trg_Mode_Select_Step_2)
    call DestroyTrigger(gg_trg_Mode_Select_Step_3)
    call DestroyTrigger(GetTriggeringTrigger())
    call DialogDisplay(udg_HostPlayer, udg_ModeSelectDialog, false)
    call DialogDestroy(udg_ModeSelectDialog)
    call TriggerExecute(gg_trg_Enter_Character_Select_Screen)
endfunction

function InitTrig_Mode_Select_Time_Out takes nothing returns nothing
    set gg_trg_Mode_Select_Time_Out = CreateTrigger()
    call TriggerAddAction(gg_trg_Mode_Select_Time_Out, function Trig_Mode_Select_Time_Out_Actions)
endfunction