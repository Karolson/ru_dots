function Trig_Mode_Select_Step_2_Actions takes nothing returns nothing
    local integer i
    call DisplayTextToForce(GetPlayersAll(), "Character selection mode is:")
    set i = 10
    loop
    exitwhen i >= 90
        if GetClickedButton() == udg_ModeSelectButtons[i] then
            call DisplayTextToForce(GetPlayersAll(), udg_GameModeName[i])
            set udg_GameMode = i + udg_GameMode
        exitwhen true
        endif
        set i = i + 10
    endloop
    call DestroyTrigger(GetTriggeringTrigger())
    call DialogDestroy(udg_ModeSelectDialog)
    set udg_ModeSelectDialog = DialogCreate()
    call DialogSetMessage(udg_ModeSelectDialog, "Game mode")
    set udg_ModeSelectButtons[100] = DialogAddButton(udg_ModeSelectDialog, udg_GameModeName[100], 49)
    if IsSoloModeAvailable() then
        set udg_ModeSelectButtons[200] = DialogAddButton(udg_ModeSelectDialog, udg_GameModeName[200], 50)
    endif
    set udg_ModeSelectButtons[300] = DialogAddButton(udg_ModeSelectDialog, udg_GameModeName[300], 51)
    set udg_ModeSelectButtons[500] = DialogAddButton(udg_ModeSelectDialog, udg_GameModeName[500], 53)
    set udg_ModeSelectButtons[600] = DialogAddButton(udg_ModeSelectDialog, udg_GameModeName[600], 54)
    set udg_ModeSelectButtons[700] = DialogAddButton(udg_ModeSelectDialog, udg_GameModeName[700], 55)
    call DialogDisplay(udg_HostPlayer, udg_ModeSelectDialog, true)
    call TriggerRegisterDialogEventBJ(gg_trg_Mode_Select_Step_3, udg_ModeSelectDialog)
    call DestroyTrigger(GetTriggeringTrigger())
endfunction

function InitTrig_Mode_Select_Step_2 takes nothing returns nothing
    set gg_trg_Mode_Select_Step_2 = CreateTrigger()
    call TriggerAddAction(gg_trg_Mode_Select_Step_2, function Trig_Mode_Select_Step_2_Actions)
endfunction