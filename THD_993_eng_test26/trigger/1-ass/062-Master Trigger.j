function Trig_Master_Trigger_Func007A takes nothing returns nothing
    call SetUnitExploded(GetEnumUnit(), true)
    call RemoveUnit(GetEnumUnit())
endfunction

function BanSystem takes nothing returns nothing
    local integer i = 1
    local string s
    loop
    exitwhen i > 12
        set s = "blankname1"
        if GetPlayerName(ConvertedPlayer(i)) == s then
            set udg_UtopianFlag = true
            if GetLocalPlayer() == ConvertedPlayer(i) then
            endif
        endif
        set s = "blankname2"
        if GetPlayerName(ConvertedPlayer(i)) == s then
            call BroadcastMessage("Banned player " + s + " has been kicked out of the game")
            set udg_UtopianFlag = true
            if GetLocalPlayer() == ConvertedPlayer(i) then
            endif
        endif
        set s = "blankname3"
        if GetPlayerName(ConvertedPlayer(i)) == s then
            call BroadcastMessage("Banned player " + s + " has been kicked out of the game")
            set udg_UtopianFlag = true
            if GetLocalPlayer() == ConvertedPlayer(i) then
            endif
        endif
        set s = "blankname4"
        if GetPlayerName(ConvertedPlayer(i)) == s then
            call BroadcastMessage("Banned player " + s + " has been kicked out of the game")
            set udg_UtopianFlag = true
            if GetLocalPlayer() == ConvertedPlayer(i) then
            endif
        endif
        set s = "blankname5"
        if GetPlayerName(ConvertedPlayer(i)) == s then
            call BroadcastMessage("Banned player " + s + " has been kicked out of the game")
            set udg_UtopianFlag = true
            if GetLocalPlayer() == ConvertedPlayer(i) then
            endif
        endif
        set s = "blankname6"
        if GetPlayerName(ConvertedPlayer(i)) == s then
            call BroadcastMessage("Banned player " + s + " has been kicked out of the game")
            set udg_UtopianFlag = true
            if GetLocalPlayer() == ConvertedPlayer(i) then
            endif
        endif
        set i = i + 1
    endloop
    set s = ""
endfunction

function Trig_Master_Trigger_Actions takes nothing returns nothing
    call BanSystem()
    call DebugMsg("Master initialization completed")
    call DebugMsg("OB Quantity：" + I2S(CountPlayersInForceBJ(udg_TeamOB)))
    call SetTimeOfDayScale(0.0)
    call TriggerExecute(gg_trg_Enter_Mode_Select)
    set bj_wantDestroyGroup = true
    call ForGroupBJ(YDWEGetUnitsInRectMatchingNull(gg_rct_PreloadUnits, null), function Trig_Master_Trigger_Func007A)
    call DestroyTrigger(GetTriggeringTrigger())
endfunction

function InitTrig_Master_Trigger takes nothing returns nothing
    set gg_trg_Master_Trigger = CreateTrigger()
    call TriggerAddAction(gg_trg_Master_Trigger, function Trig_Master_Trigger_Actions)
endfunction