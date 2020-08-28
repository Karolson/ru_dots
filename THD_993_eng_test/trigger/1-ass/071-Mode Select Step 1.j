function Trig_Mode_Select_Step_1_Actions takes nothing returns nothing
    local integer i
    set i = 0
    call DisplayTextToForce(GetPlayersAll(), "Team selection mode is:")
    loop
    exitwhen i >= 10
        if GetClickedButton() == udg_ModeSelectButtons[i] then
            call DisplayTextToForce(GetPlayersAll(), udg_GameModeName[i])
            set udg_GameMode = i
        exitwhen true
        endif
        set i = i + 1
    endloop
    call DestroyTrigger(GetTriggeringTrigger())
    call DialogDestroy(udg_ModeSelectDialog)
    set udg_ModeSelectDialog = DialogCreate()
    call DialogSetMessage(udg_ModeSelectDialog, "Character selection")
    set udg_ModeSelectButtons[10] = DialogAddButton(udg_ModeSelectDialog, udg_GameModeName[10], 49)
    set udg_ModeSelectButtons[20] = DialogAddButton(udg_ModeSelectDialog, udg_GameModeName[20], 50)
    set udg_ModeSelectButtons[30] = DialogAddButton(udg_ModeSelectDialog, udg_GameModeName[30], 51)
    set udg_ModeSelectButtons[40] = DialogAddButton(udg_ModeSelectDialog, udg_GameModeName[40], 52)
    set udg_ModeSelectButtons[50] = DialogAddButton(udg_ModeSelectDialog, udg_GameModeName[50], 53)
    if IsBanModeAvailable() then
        set udg_ModeSelectButtons[60] = DialogAddButton(udg_ModeSelectDialog, udg_GameModeName[60], 54)
    endif
    set udg_ModeSelectButtons[70] = DialogAddButton(udg_ModeSelectDialog, udg_GameModeName[70], 55)
    call DialogDisplay(udg_HostPlayer, udg_ModeSelectDialog, true)
    call TriggerRegisterDialogEventBJ(gg_trg_Mode_Select_Step_2, udg_ModeSelectDialog)
    call DestroyTrigger(GetTriggeringTrigger())
endfunction

function InitTrig_Mode_Select_Step_1 takes nothing returns nothing
    set gg_trg_Mode_Select_Step_1 = CreateTrigger()
    call TriggerRegisterDialogEventBJ(gg_trg_Mode_Select_Step_1, udg_ModeSelectDialog)
    call TriggerAddAction(gg_trg_Mode_Select_Step_1, function Trig_Mode_Select_Step_1_Actions)
endfunction