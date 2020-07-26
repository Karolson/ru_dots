function Trig_Enter_Mode_Select_Func034C takes nothing returns boolean
    if not (GetPlayerController(udg_HostPlayer) == MAP_CONTROL_USER) then
        return false
    endif
    return true
endfunction

function Trig_Enter_Mode_Select_Actions takes nothing returns nothing
    call DestroyTrigger(GetTriggeringTrigger())
    call StopMusic(false)
    set udg_GameMode = 0
    set udg_GameModeName[1] = "[1] Normal teams"
    set udg_GameModeName[2] = "[2] Random teams"
    set udg_GameModeName[10] = "[1] Normal picks"
    set udg_GameModeName[20] = "[2] Random bans"
    set udg_GameModeName[30] = "[3] Select bans"
    set udg_GameModeName[40] = "[4] Draft mode (no bans)"
    set udg_GameModeName[50] = "[5] Draft mode (with bans)"
    set udg_GameModeName[60] = "[6] Captain mode"
    set udg_GameModeName[70] = "[7] All random"
    set udg_GameModeName[100] = "[1] Normal mode"
    set udg_GameModeName[200] = "[2] Showdown 1x1"
    set udg_GameModeName[300] = "[3] Narrow lane"
    set udg_GameModeName[500] = "[5] (Fun) Collect mode"
    set udg_GameModeName[600] = "[6] (Fun) Collect mode on narrow lane"
    set udg_GameModeName[700] = "[7] (Fun) Only mid (for new players)"
    call DecideHostPlayer()
    call DialogSetMessage(udg_ModeSelectDialog, "Team select")
    set udg_ModeSelectButtons[1] = DialogAddButton(udg_ModeSelectDialog, udg_GameModeName[1], 49)
    set udg_ModeSelectButtons[2] = DialogAddButton(udg_ModeSelectDialog, udg_GameModeName[2], 50)
    call DialogDisplay(udg_HostPlayer, udg_ModeSelectDialog, true)
    call DestroyTrigger(GetTriggeringTrigger())
    call TriggerRegisterTimerExpireEventBJ(gg_trg_Mode_Select_Time_Out, udg_MainTimer)
    if Trig_Enter_Mode_Select_Func034C() then
        call BroadcastMessage(PlayerColorText(GetPlayerName(udg_HostPlayer), udg_HostPlayer) + " is selecting...")
        call StartTimerBJ(udg_MainTimer, false, 25.0)
    else
        call StartTimerBJ(udg_MainTimer, false, 3.0)
    endif
endfunction

function InitTrig_Enter_Mode_Select takes nothing returns nothing
    set gg_trg_Enter_Mode_Select = CreateTrigger()
    call TriggerAddAction(gg_trg_Enter_Mode_Select, function Trig_Enter_Mode_Select_Actions)
endfunction