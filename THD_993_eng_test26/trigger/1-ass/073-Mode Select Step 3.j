function Trig_Mode_Select_Step_3_Actions takes nothing returns nothing
    local integer i
    call DisplayTextToForce(GetPlayersAll(), "Game mode is:")
    set i = 100
    loop
    exitwhen i >= 900
        if GetClickedButton() == udg_ModeSelectButtons[i] then
            call DisplayTextToForce(GetPlayersAll(), udg_GameModeName[i])
            set udg_GameMode = i + udg_GameMode
        exitwhen true
        endif
        set i = i + 100
    endloop
    call DestroyTrigger(GetTriggeringTrigger())
    if udg_GameMode / 100 == 6 then
        set udg_smodestat = true
        set udg_GameMode = udg_GameMode - 300
        set udg_smode_EndTime = 60 * 30
    endif
    if udg_GameMode / 100 == 7 then
        set udg_NewMid = true
    endif
    if udg_GameMode / 100 == 5 then
        set udg_smodestat = true
        set udg_smode_EndTime = 60 * 30
    endif
    if udg_GameMode / 100 == 3 then
        call DisplayTextToForce(GetPlayersAll(), "Narrow lane map initialization...")
        call TriggerExecute(gg_trg_NormalData_Deletion)
    endif
    call DialogDestroy(udg_ModeSelectDialog)
    set udg_ModeSelectDialog = DialogCreate()
    call DialogSetMessage(udg_ModeSelectDialog, "Turbo mode")
    call DialogAddButton(udg_ModeSelectDialog, "[1] Off", 49)
    set udg_GameModeIsTurboButton = DialogAddButton(udg_ModeSelectDialog, "[2] On", 50)
    call DialogDisplay(udg_HostPlayer, udg_ModeSelectDialog, true)
    call TriggerRegisterDialogEventBJ(gg_trg_Mode_Select_Step_4, udg_ModeSelectDialog)
    call DestroyTrigger(GetTriggeringTrigger())
endfunction

function InitTrig_Mode_Select_Step_3 takes nothing returns nothing
    set gg_trg_Mode_Select_Step_3 = CreateTrigger()
    call TriggerAddAction(gg_trg_Mode_Select_Step_3, function Trig_Mode_Select_Step_3_Actions)
endfunction