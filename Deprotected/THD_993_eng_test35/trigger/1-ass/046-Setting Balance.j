function Trig_Setting_BalanceActions takes nothing returns nothing
    set udg_ReviveTime[0] = 5.0
    set udg_ReviveTime[1] = 4.0
    set udg_GameSetting_Gold[0] = 850
    set udg_GameSetting_Gold_A = 20
    set udg_GameSetting_Gold_B = 20
    set udg_GameSetting_Spirit[0] = 15
    set udg_GameSetting_Spirit[1] = 0
    set udg_GameSetting_Spirit[2] = 0
    set udg_GameSetting_Spirit[3] = 5
    set udg_GameSetting_Spirit[4] = 5
    set udg_GameSetting_Power[0] = 0
endfunction

function InitTrig_Setting_Balance takes nothing returns nothing
    set gg_trg_Setting_Balance = CreateTrigger()
    call TriggerAddAction(gg_trg_Setting_Balance, function Trig_Setting_BalanceActions)
endfunction